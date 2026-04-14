codeunit 85045 "DSL Integrations"
{
    trigger OnRun()
    begin
    end;

    var
        HMSSetup: Record "HMS Setup";
        SmartBenefits: Record "Smart Benefits";
        SmartInvoices: Record "Smart Invoices";

    procedure StoreBenefits(policyid: Code[50]; globalid: Code[100]; benefitdescription: Code[250]; patientid: Code[20]; amount: Decimal; authneeded: Boolean; claimable: Boolean; membershipcode: Code[50]; membershipplan: Code[50]; membershipno: Code[50]; poolid: Code[10]) ret: Boolean
    begin
        ret := FALSE;
        SmartBenefits.RESET();
        SmartBenefits.SETRANGE("Patient No", patientid);
        SmartBenefits.SETRANGE("Policy ID", policyid);
        IF SmartBenefits.FIND('-') THEN
            SmartBenefits.DELETEALL();

        SmartBenefits.INIT();
        SmartBenefits.Amount := amount;
        SmartBenefits.Benefit := benefitdescription;
        SmartBenefits.Claimable := claimable;
        SmartBenefits."Global ID" := globalid;
        SmartBenefits."Patient No" := patientid;
        SmartBenefits."Policy ID" := policyid;
        SmartBenefits.PreAuthNeeded := authneeded;
        SmartBenefits."DateTime Retrieved" := CREATEDATETIME(TODAY, TIME);
        SmartBenefits."Membership Code" := membershipcode;
        SmartBenefits."Membership No" := membershipno;
        SmartBenefits."Membership Plan" := membershipplan;
        SmartBenefits."Pool No" := poolid;
        SmartBenefits.INSERT();
        ret := TRUE;
    end;

    procedure GetSmartData(PatientNo: Code[20])
    var
        RESTWSManagement: Codeunit "REST WS Management";
        ReturnValue: Boolean;
        Window: Dialog;
        encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        httpUtility: DotNet PTLHttpUtility;
        stringContent: DotNet StringContent;
        data: Text;
    begin

        Window.OPEN('Getting Details...');
        HMSSetup.Get();

        data += 'patient=' + httpUtility.UrlEncode(PatientNo, encoding.GetEncoding('ISO-8859-1'));

        stringContent := stringContent.StringContent(data, encoding.UTF8, 'application/x-www-form-urlencoded');

        ReturnValue := RESTWSManagement.CallRESTWebService('http://192.168.88.62:881/smart/balance.php',
                                                           '',
                                                           'POST',
                                                           stringContent,
                                                           HttpResponseMessage);
        Window.CLOSE();
        //IF NOT ReturnValue THEN
        //    EXIT;

        //result := HttpResponseMessage.Content.ReadAsStringAsync.Result;
        //data := '';
        //MESSAGE(result);
        SmartBenefits.reset();
        SmartBenefits.SETRANGE("Patient No", PatientNo);
        PAGE.RUN(70135224, SmartBenefits);
    end;

    procedure UpdateInvoices(patientid: Code[20]; invoiceid: Code[20])
    begin
        SmartInvoices.RESET();
        SmartInvoices.SETRANGE("Patient No", patientid);
        SmartInvoices.SETRANGE("Document No", invoiceid);
        SmartInvoices.SETRANGE(Posted, FALSE);
        IF SmartInvoices.FIND('-') THEN
            REPEAT
                SmartInvoices.Posted := TRUE;
                SmartInvoices.MODIFY();
            UNTIL SmartInvoices.NEXT() = 0;
    end;

    procedure PostInvoice(PatientNo: Code[20]; InvoiceNo: Code[20])
    var
        RESTWSManagement: Codeunit "REST WS Management";
        ReturnValue: Boolean;
        encoding: DotNet Encoding;
        HttpResponseMessage: DotNet HttpResponseMessage;
        httpUtility: DotNet HttpUtility;
        stringContent: DotNet StringContent;
        data: Text;
    begin
        data += httpUtility.UrlEncode(PatientNo, encoding.GetEncoding('ISO-8859-1'));
        data += 'invoiceno=' + httpUtility.UrlEncode(InvoiceNo, encoding.GetEncoding('ISO-8859-1'));
        HMSSetup.Get();

        stringContent := stringContent.StringContent(data, encoding.UTF8, 'application/x-www-form-urlencoded');

        ReturnValue := RESTWSManagement.CallRESTWebService('http://192.168.88.62:881/smart/',
                                                           'invoice.php',
                                                           'POST',
                                                           stringContent,
                                                           HttpResponseMessage);

        Message(data);
    end;
}
