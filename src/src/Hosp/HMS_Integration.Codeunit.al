Codeunit 52202445 "HMS Patient-integration"
{
    trigger OnRun()
    begin
        PatientBalance();
    end;

    var
        //ADOStream: Automation ;
        //ADComm:
        DimSetID: Record "Dimension Set Entry";
        PatientRec: Record "HMS Patient";
        PatRec: Record "HMS Patient";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextDay: Date;
        dayOfWeek: Integer;

    procedure CalculateReccuringCharges(PatientNo: Code[20])
    var
        ChargeRec: Record "HMS Charges";
        PatRec: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        HMSPatientCharges1: Record "HMS Patient Charges";
        HMSPatientCharges2: Record "HMS Patient Charges";
        HMSPatientCharges3: Record "HMS Patient Charges";
        TransType: Record "HMS Transactions code";
        LastBillDate: Date;
        LastChargeBillDate: Date;
        BillDays: Integer;
        i: Integer;
        Ln: Integer;
    begin
        Patrec.get(PatientNo);
        if PatRec.Inpatient = true then begin
            LastBillDate := Patrec."Last Billing Date";
            // if GuiAllowed then Message(PatRec.Surname);

            HMSPatientCharges3.Reset();
            HMSPatientCharges3.SetCurrentKey("Line No");
            if HMSPatientCharges3.FindLast() then
                Ln := HMSPatientCharges3."Line No";

            HMSPatientCharges.Reset();
            HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", PatientNo);
            HMSPatientCharges.SetRange(HMSPatientCharges."Billing Type", HMSPatientCharges."Billing Type"::Reccuring);
            HMSPatientCharges.SetRange(HMSPatientCharges."Visit No", PatRec."Active Visit No");
            HMSPatientCharges.SetRange(HMSPatientCharges."System Created", false);
            //  HMSPatientCharges.SetCurrentkey(HMSPatientCharges."Patient No.", HMSPatientCharges."Billing Type", HMSPatientCharges."Reccuring Type", HMSPatientCharges.Date, HMSPatientCharges."Creation Time");
            // HMSPatientCharges.Ascending := false;
            if HMSPatientCharges.FindSet() then
                repeat
                    if HMSPatientCharges."Reccuring Type" = HMSPatientCharges."Reccuring Type"::Daily then begin

                        ChargeRec.get(HMSPatientCharges.Code);
                        TransType.get(ChargeRec."Transaction Type");
                        if LastBillDate = 0D then
                            LastBillDate := HMSPatientCharges.date;
                        LastChargeBillDate := LastBillDate;
                        if Today <> LastBillDate then begin

                            BillDays := Today - LastBillDate;
                            for i := 1 to BillDays do begin
                                Ln := Ln + i;
                                LastChargeBillDate := LastChargeBillDate + 1;
                                HMSPatientCharges1.Init();
                                HMSPatientCharges1."Line No" := Ln;
                                HMSPatientCharges1."Patient No." := PatientNo;
                                HMSPatientCharges1."Link No" := HMSPatientCharges."Link No";
                                HMSPatientCharges1."Treatment No." := HMSPatientCharges."Treatment No.";
                                HMSPatientCharges1."Shortcut Dimension 1 Code" := PatRec."Global Dimension 1 Code";
                                HMSPatientCharges1."Transaction Type" := ChargeRec."Transaction Type";
                                HMSPatientCharges1.Code := ChargeRec.Code;
                                HMSPatientCharges1.validate(Code);
                                HMSPatientCharges1.Validate(Amount);
                                HMSPatientCharges1.Date := LastChargeBillDate;
                                HMSPatientCharges1."Billing Start Date" := HMSPatientCharges.Date;
                                HMSPatientCharges1."Billing Type" := HMSPatientCharges."Billing Type";
                                HMSPatientCharges1."Reccuring Type" := HMSPatientCharges."Reccuring Type";
                                HMSPatientCharges1."Bill Section" := HMSPatientCharges."Bill Section";
                                HMSPatientCharges1.Quantity := 1;
                                HMSPatientCharges1."User ID" := UserId;
                                HMSPatientCharges1."Creation Time" := Time;
                                HMSPatientCharges1."System Created" := true;
                                HMSPatientCharges1."Shortcut Dimension 2 Code" := TransType."Department Code";

                                if PatRec.Get(PatientNo) then begin
                                    HMSPatientCharges1."Admission No" := PatRec."Adm No.";
                                    HMSPatientCharges1."Visit No" := PatRec."Active Visit No";
                                    HMSPatientCharges1."Shortcut Dimension 3 Code" := 'IP';
                                    if PatRec."Patient Type" = PatRec."Patient Type"::Cash then
                                        HMSPatientCharges1."Shortcut Dimension 4 Code" := 'Cash';
                                    if PatRec."Patient Type" = PatRec."Patient Type"::Corporate then
                                        HMSPatientCharges1."Shortcut Dimension 4 Code" := 'Corporate';
                                end;

                                HMSPatientCharges2.Reset();
                                HMSPatientCharges2.SetRange(HMSPatientCharges2."Patient No.", PatientNo);
                                HMSPatientCharges2.Setfilter(HMSPatientCharges2."Is Bed", '%1', true);
                                HMSPatientCharges2.SetRange(HMSPatientCharges2."Visit No", PatRec."Active Visit No");
                                HMSPatientCharges2.SetRange(HMSPatientCharges2.date, LastChargeBillDate);
                                if HMSPatientCharges2.IsEmpty() then begin

                                    HMSPatientCharges2.Reset();
                                    HMSPatientCharges2.SetRange(HMSPatientCharges2."Patient No.", PatientNo);
                                    HMSPatientCharges2.SetRange(HMSPatientCharges2.code, ChargeRec.Code);
                                    HMSPatientCharges2.SetRange(HMSPatientCharges2."Visit No", PatRec."Active Visit No");
                                    HMSPatientCharges2.SetRange(HMSPatientCharges2.date, LastChargeBillDate);
                                    if HMSPatientCharges2.IsEmpty() then
                                        HMSPatientCharges1.Insert();
                                end;

                                HMSPatientCharges3.Reset();
                                HMSPatientCharges3.SetCurrentKey("Line No");
                                if HMSPatientCharges3.FindLast() then
                                    Ln := HMSPatientCharges3."Line No";
                            end;
                        end;
                    end;
                until HMSPatientCharges.Next() = 0;
            Patrec."Last Billing Date" := today;
            PatRec.modify();
        end;
    end;

    local procedure RunReccuringCharges()
    var
        PatientRec: Record "HMS Patient";
    begin
        PatientRec.Reset();
        PatientRec.SetRange(PatientRec.Activated, true);
        PatientRec.SetRange(PatientRec.Inpatient, true);
        if PatientRec.Find('-') then
            repeat
                CalculateReccuringCharges(PatientRec."Patient No.");
                CalculateTotalCharges(PatientRec."Patient No.");
            until PatientRec.Next() = 0;
    end;

    procedure CalculateTotalCharges(PatientNo: Code[20])
    var
        HMSCharges: Record "HMS Patient Charges";
        Amt: Decimal;
        Qty: Decimal;
    begin
        HMSCharges.Reset();
        HMSCharges.SetFilter(HMSCharges."Patient No.", PatientNo);
        HMSCharges.SetRange(HMSCharges.Imported, false);
        if HMSCharges.Find('-') then
            repeat
                HMSCharges.CalcFields("Posted Invoice No.");
                if (HMSCharges."Posted Invoice No." <> HMSCharges."Invoice ID") then
                    HMSCharges."Invoice ID" := HMSCharges."Posted Invoice No.";

                if HMSCharges.Quantity = 0 then
                    Qty := 1
                else
                    Qty := HMSCharges.Quantity;
                Amt := 0;
                if HMSCharges."Insurance Amount" > 0 then
                    Amt := HMSCharges."Insurance Amount"//* Qty
                else
                    Amt := HMSCharges.Amount * Qty;
                HMSCharges.Quantity := Qty;
                HMSCharges."Total Amount" := Amt;

                HMSCharges.Modify();
                Commit();
            until HMSCharges.Next() = 0;
    end;

    procedure GetNewInvoiceNumber(BranchNo: code[30]; VisitType: Code[10]): Code[20]
    var
        DimRec: Record "Dimension Value";
        SalesSetup: Record "Sales & Receivables Setup";
        NewCode: code[20];
    begin
        SalesSetup.get(); //TODO: Insert IP/OP Invoice numbers. Update Admission Form Header with Invoice NUmber

        dimrec.reset();
        dimrec.setrange(Code, BranchNo);
        if DimRec.find('-') then begin
            if dimrec."Invoice No. Series" <> '' then
                NewCode := NoSeriesMgt.GetNextNo(dimrec."Invoice No. Series", 0D, TRUE)
            else
                NewCode := NoSeriesMgt.GetNextNo(SalesSetup."Invoice Nos.", 0D, TRUE);
        end
        else
            NewCode := NoSeriesMgt.GetNextNo(SalesSetup."Invoice Nos.", 0D, TRUE);


        if VisitType <> '' then
            NewCode := VisitType + NewCode;

        exit(NewCode);
    end;

    procedure GenerateInvoice(PatientNo: Code[20]; VisitNo: Code[20]; OwnDebtor: Boolean; StaffNo: Code[30])
    var
        Cust: Record customer;
        GenJnlLine: Record "Gen. Journal Line";
        HmsAppointmentFormHeader: Record "HMS Appointment Form Header";
        Patients: Record "HMS Patient";
        PatientCharges: Record "HMS Patient Charges";
        PatientChargesReb: Record "HMS Patient Charges";
        HMSPatIns: Record "HMS Patient Insuarance";
        HMSSetup: Record "HMS Setup";
        HMSTransCode: Record "HMS Transactions code";
        SalesSetup: Record "Sales & Receivables Setup";
        SaleH: Record "Sales Header";
        SalesInv: Record "Sales Invoice Header";
        SLine: Record "Sales Line";
        UserRec: Record "User Setup";
        SalesInvoicePerUserBuffer: Record "Invoice Per User Buffer";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        unbilledChargeExists: Boolean;
        DocNo: Code[20];
        JBatch: Code[20];
        JTemplate: Code[20];
        NewNo: Code[20];
        UserBranch: code[20];
        UserDept: code[20];
        LineNo: Integer;
        CustNo: Code[20];
    begin
        // Initialize Variables 
        unbilledChargeExists := false;

        PostCharges(PatientNo, VisitNo, OwnDebtor);
        // Get General Details. Patient Details, HMS Module Setup Details
        Patients.Get(PatientNo);
        HMSSetup.Get();

        if UserRec.get(StaffNo) then begin // REFACTOR: When Changing Auth implementation MOdify this to always get the correct branch the user is at.
            UserDept := Userrec.Department;
            UserBranch := UserRec."Branch Code";
        end;

        if UserBranch = '' then
            UserBranch := Patients."Global Dimension 1 Code";

        /* 
            **************Select the Patient's Current Insurance*******************
            * If the Patient is on credit terms, then they are classified as own debtors and a customer account linked to them is created
            * In that case select the Debtor (Customer) account.
            * Else Select the Current Insurance in patient detials page.
         */

        if OwnDebtor then
            CustNo := Patients."Debtor Account"
        else
            CustNo := Patients."Insurance No.";

        // Check if the selected Customer is classified as and NHIF Capitation Account
        if cust.get(CustNo) then
            if cust."NHIF Capitation" = true then begin
                Patients.Activated := false;
                Patients.modify();
            end;


        /* 
            **********Delete any Existing Sales Lines*************
        */
        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
        PatientCharges.SetRange(PatientCharges."Insurance No", CustNo);
        PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
        PatientCharges.SetRange(PatientCharges.Closed, false);
        PatientCharges.SetRange(PatientCharges.Posted, false);
        PatientCharges.SetFilter(PatientCharges."Invoice Number", '<>%1', '');
        if PatientCharges.Find('-') then begin
            SLine.Reset();
            SLine.SetRange("Document No.", PatientCharges."Invoice Number");
            if SLine.Find('-') then
                SLine.DeleteAll();
        end;

        /* **Check For Un Billed Charges** */
        // Un-billed charges are those un-closed charges linked to the insurance/customer selected.
        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
        PatientCharges.SetRange(PatientCharges."Insurance No", CustNo); // Comment if problems arise on generating invoice
        PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
        // PatientCharges.SetRange(PatientCharges.Closed, false); // REFACTOR: Check on the impact of closed vs Posted Charges
        // PatientCharges.SETRANGE(PatientCharges.Posted,FALSE);
        if PatientCharges.Find('-') then
            repeat
                unbilledChargeExists := true;
            until PatientCharges.Next() = 0;

        // If all charges linked to the current insurance are closed then it means the visit invoice has already been generated and is fully updated.
        if unbilledChargeExists = false then
            Error('All charges been posted');

        //Confirm all Transaction Codes have been keyed in-----
        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
        PatientCharges.SetRange(PatientCharges."Insurance No", CustNo);
        PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
        // PatientCharges.SETRANGE(PatientCharges.Posted,FALSE);
        PatientCharges.SetRange(PatientCharges.Closed, false);
        if PatientCharges.Find('-') then
            repeat
                //  PatientCharges.CalcFields(PatientCharges."G/L Account");
                //if PatientCharges."G/L Account No" = '' then Error('Please enter the G/l Account code to the charge %1 to continue', PatientCharges.Description);

                /*  
                **************Check if invoice had been posted****************
                * If the Invoice is posted, Finance Should Reverse the invoice and a new Invoice is generated.
                * Here we notifiy the user that the Invoice is already posted and give instructions
                // REFACTOR: The Posted Invoice Field on the patient charges table will have a value when the slaes invoice pre assigned no is blank.
                    // lookup("Sales Invoice Header"."No." where("Pre-Assigned No." = field("Invoice Number")));
                    // This Will cause this check to be true whereas the calculated value is wrong since the charge did not have an invoice number
                */
                PatientCharges.CalcFields("Posted Invoice No.");
                if PatientCharges."Posted Invoice No." <> '' then begin
                    SalesInv.Reset();
                    SalesInv.SetRange(SalesInv."No.", PatientCharges."Posted Invoice No.");
                    if SalesInv.FindFirst() then
                        Error('Please note that Invoice No ' + PatientCharges."Posted Invoice No." + ' has aready been posted for the selected visit,Reverse the invoice before generating again');
                    // if GuiAllowed then // REFACTOR: Fix The Flowfield the

                end;
                // This will insert a new insrance record for the patient if the linked insurance does not exist
                if (PatientCharges."Insurance No" <> CustNo) and (PatientCharges."Insurance No" <> '') then
                    if not HMSPatIns.Get(PatientCharges."Patient No.", PatientCharges."Insurance No") then begin
                        HMSPatIns.init();
                        HMSPatIns."Patient No" := PatientCharges."Patient No.";
                        HMSPatIns."Insurance No" := PatientCharges."Insurance No";
                        HMSPatIns.Validate("Insurance No");
                        HMSPatIns."Member No" := Patients."Membership No";
                        HMSPatIns."Scheme Name" := Patients."Scheme Name";
                        HMSPatIns.insert();
                    end;
            until PatientCharges.Next() = 0;

        /* 
        ***********Generate Default insurance invoice********************
        * Invoices are generated for only Corporate Patients
        * If the Invoice was already generated, Delete then Re Insert 
        * First we try to get an existing invoice number linked ot the encounter, if none then we generate a new one
        */
        if Patients."Patient Type" = Patients."patient type"::Corporate then begin
            if GuiAllowed then
                Message('here 2 %1', CustNo);

            Cust.get(CustNo);
            if Cust."NHIF Capitation" = false then begin
                // * Get the Current invoice number in patient Charges
                SalesSetup.Get();
                if PatientCharges."Invoice Number" <> '' then begin
                    NewNo := PatientCharges."Invoice Number";
                    // * Delete Sales Header and Sales Lines associated with the invoice number
                    if SaleH.GET(SaleH."Document Type"::Invoice, PatientCharges."Invoice Number") then begin
                        SaleH.DELETE();
                        SLine.RESET();
                        SLine.SETRANGE("Document No.", PatientCharges."Invoice Number");
                        if SLine.FIND('-') then
                            SLine.DELETEALL();
                    end;
                end else begin // Get the Invoice number from the Appointment (OutPatient) or Admission Header (InPatient) << Not Implemented
                    HmsAppointmentFormHeader.Reset();
                    HmsAppointmentFormHeader.SetRange("Appointment No.", VisitNo);
                    if HmsAppointmentFormHeader.FindFirst() then
                        NewNo := HmsAppointmentFormHeader."Invoice No";

                end;

                // If the Invoice number was not already generated then we generate a new number and update the charges accordingly

                if NewNo = '' then
                    if PatientCharges.InPatient then
                        NewNo := GetNewInvoiceNumber(Patients."Global Dimension 1 Code", 'IP')
                    else
                        NewNo := GetNewInvoiceNumber(Patients."Global Dimension 1 Code", 'OP');

                if NewNo = '' then
                    Error('Invoice Number generation error');

                if GuiAllowed then
                    Message('here %1', CustNo);

                /* *****Re insert the Sales Header and Lines****** */
                // Insert Sales Header
                SaleH.Init();
                SaleH."Document Type" := SaleH."document type"::Invoice;
                SaleH."No." := NewNo;
                SaleH."Posting Date" := Today;
                SaleH."Due Date" := CalcDate('<3M>', Today);
                SaleH."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
                SaleH."Document Date" := Today;
                SaleH."Sell-to Customer No." := CustNo;
                SaleH."Bill-to Customer No." := CustNo;
                SaleH."Shortcut Dimension 1 Code" := UserBranch;
                SaleH."Shortcut Dimension 2 Code" := UserDept;
                SaleH."Shortcut Dimension 3 Code" := PatientCharges."Shortcut Dimension 3 Code";
                SaleH."Shortcut Dimension 4 Code" := PatientCharges."Shortcut Dimension 4 Code";
                SaleH."Patient Name" := Format(Patients."Search Name");
                SaleH."Patient No." := PatientNo;
                SaleH."Treatment No" := VisitNo;
                SaleH."Appointment No" := VisitNo;
                SaleH."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
                SaleH."Assigned User ID" := StaffNo;
                SaleH."Posted By" := StaffNo;
                SaleH.Insert();

                // Insert Sales Lines
                if SaleH.Get(SaleH."Document type"::Invoice, NewNo) then begin
                    SaleH.Validate("Sell-to Customer No.");
                    SaleH."Shortcut Dimension 1 Code" := UserBranch;
                    SaleH."Shortcut Dimension 2 Code" := UserDept;
                    SaleH."Shortcut Dimension 3 Code" := PatientCharges."Shortcut Dimension 3 Code";
                    SaleH."Shortcut Dimension 4 Code" := PatientCharges."Shortcut Dimension 4 Code";

                    SaleH.Validate("Shortcut Dimension 1 Code");
                    SaleH.Validate("Shortcut Dimension 2 Code");
                    //SaleH.Status := SaleH.Status::Released;
                    SaleH.modify();

                    if SLine.FindLast() then
                        LineNo := SLine."Line No." + 1;

                    PatientCharges.Reset();
                    PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
                    PatientCharges.SetRange(PatientCharges."Insurance No", CustNo);
                    PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
                    PatientCharges.SetRange(PatientCharges.Closed, false);
                    // PatientCharges.SETRANGE(PatientCharges.Posted,FALSE); //Commented to allow receipts for Corporate patient
                    if PatientCharges.Find('-') then begin
                        repeat
                            // if (PatientCharges.Amount>0) OR (PatientCharges."Own Debtor"=TRUE) then begin
                            PatientCharges.CalcFields(PatientCharges."Charge Balance");
                            //  if (PatientCharges.Posted=FALSE) OR (PatientCharges."Own Debtor"=TRUE) then begin // Added for Patient debtors
                            if (PatientCharges.Code <> 'REBATES') and (PatientCharges.Code <> 'DISCOUNT') then begin

                                SLine.Init();
                                SLine."Line No." := LineNo;
                                SLine."Document No." := SaleH."No.";
                                SLine."Bill-to Customer No." := SaleH."Bill-to Customer No.";
                                SLine."Document Type" := SaleH."Document Type";
                                SLine."Description 2" := Format(PatientCharges.Date);
                                SLine."Patient No." := PatientNo;
                                SLine."Sell-to Customer No." := CustNo;
                                SLine.Type := SLine.Type::"G/L Account";
                                // PatientCharges.CalcFields("G/L Account");
                                SLine."No." := HMSSetup."Cash Control Account";
                                SLine.Description := CopyStr(PatientCharges.Description, 1, MaxStrLen(SLine.Description));
                                if PatientCharges.Quantity > 0 then
                                    SLine.Quantity := PatientCharges.Quantity
                                else
                                    SLine.Quantity := 1;
                                SLine.Validate(SLine.Quantity);
                                SLine."Unit Price" := PatientCharges.Amount;
                                if PatientCharges."Insurance Amount" > 0 then begin
                                    SLine.Amount := PatientCharges."Insurance Amount"; //REFACTOR: This works for Insurance that have a percentage and a copay amount that is a must. Check on implementation in invoice reports
                                    SLine."Unit Price" := PatientCharges."Insurance Amount";
                                end else begin
                                    SLine.Amount := Round(PatientCharges.Amount, 1, '=');
                                    SLine."Unit Price" := Round(PatientCharges.Amount, 1, '=');
                                end;
                                SLine.Validate("Unit Price");
                                SLine."Gen. Bus. Posting Group" := 'LOCAL';
                                SLine."Gen. Prod. Posting Group" := 'SERVICES';
                                SLine."Charge Code" := PatientCharges.Code;
                                SLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                                SLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                                SLine.Validate("Shortcut Dimension 1 Code");
                                SLine.Validate("Shortcut Dimension 2 Code");
                                DimSetID.SetRange(DimSetID."Dimension Code", 'Branch');
                                DimSetID.SetRange(DimSetID."Dimension Value Code", PatientCharges."Shortcut Dimension 1 Code");
                                if DimSetID.Find('-') then
                                    SLine."Dimension Set ID" := DimSetID."Dimension Set ID";
                                SLine.Insert();
                                LineNo := LineNo + 1;

                                PatientCharges."Invoice Number" := SaleH."No.";
                                // PatientCharges.Posted := true;
                                PatientCharges.Modify();
                            end;
                        // end;
                        until PatientCharges.Next() = 0;

                        // Less SHIF Rebates
                        PatientChargesReb.Reset();
                        PatientChargesReb.SetRange(PatientChargesReb."Patient No.", PatientNo);
                        PatientChargesReb.SetRange(PatientChargesReb."Visit No", VisitNo);
                        PatientChargesReb.SetRange(PatientChargesReb.Code, 'Rebates');
                        //PatientChargesReb.SETRANGE(PatientChargesReb.Posted,FALSE);
                        PatientCharges.SetRange(PatientCharges.Closed, false);
                        if PatientChargesReb.Find('-') then
                            repeat
                                SLine.Init();
                                SLine."Line No." := LineNo;
                                SLine."Document No." := SaleH."No.";
                                SLine."Document Type" := SaleH."Document Type";
                                SLine."Sell-to Customer No." := CustNo;
                                SLine."Patient No." := PatientNo;
                                SLine.Type := SLine.Type::"G/L Account";
                                //  PatientCharges.CalcFields("G/L Account");
                                SLine."No." := HMSSetup."Cash Control Account";
                                SLine.Description := 'Insuarance Rebates';
                                if PatientChargesReb.Quantity > 0 then
                                    SLine.Quantity := PatientChargesReb.Quantity
                                else
                                    SLine.Quantity := 1;
                                SLine.Validate(SLine.Quantity);
                                SLine."Unit Price" := PatientChargesReb.Amount;
                                if PatientChargesReb."Insurance Amount" > 0 then begin
                                    SLine.Amount := PatientChargesReb."Insurance Amount";
                                    SLine."Unit Price" := PatientChargesReb."Insurance Amount";
                                end else
                                    if PatientChargesReb.Amount > 0 then begin
                                        SLine.Amount := PatientChargesReb.Amount * -1;//Round(PatientChargesReb.Amount, 1, '=') * -1;
                                        SLine."Unit Price" := PatientChargesReb.Amount * -1;// Round(PatientCharges.Amount, 1, '=') * -1;
                                    end else begin
                                        SLine.Amount := PatientChargesReb.Amount;// Round(PatientChargesReb.Amount, 1, '=');
                                        SLine."Unit Price" := PatientChargesReb.Amount;// Round(PatientChargesReb.Amount, 1, '=');
                                    end;
                                SLine.Validate("Unit Price");
                                SLine."Gen. Bus. Posting Group" := 'LOCAL';
                                SLine."Gen. Prod. Posting Group" := 'SERVICES';
                                SLine."Charge Code" := PatientChargesReb.Code;
                                SLine."Shortcut Dimension 1 Code" := PatientChargesReb."Shortcut Dimension 1 Code";
                                SLine."Shortcut Dimension 2 Code" := PatientChargesReb."Shortcut Dimension 2 Code";
                                SLine.Insert();
                                LineNo := LineNo + 1;
                            until PatientChargesReb.Next() = 0;
                    end;
                    // Less Discounts
                    PatientChargesReb.Reset();
                    PatientChargesReb.SetRange(PatientChargesReb."Patient No.", PatientNo);
                    PatientChargesReb.SetRange(PatientChargesReb.Code, 'Discount');
                    PatientChargesReb.SetRange(PatientChargesReb."Visit No", VisitNo);
                    PatientCharges.SetRange(PatientCharges.Closed, false);
                    // PatientChargesReb.SETRANGE(PatientChargesReb.Posted,FALSE);
                    if PatientChargesReb.Find('-') then begin
                        HMSSetup.get();
                        HMSSetup.TestField("Cash Control Account");
                        SLine.Init();
                        SLine."Line No." := LineNo;
                        SLine."Document No." := SaleH."No.";
                        SLine."Document Type" := SaleH."Document Type";
                        SLine."Sell-to Customer No." := CustNo;
                        SLine.Type := SLine.Type::"G/L Account";
                        SLine."No." := HMSSetup."Cash Control Account";
                        SLine.Description := 'Insuarance Discounts';
                        SLine.Quantity := 1;
                        SLine.Validate(SLine.Quantity);
                        SLine."Unit Price" := PatientChargesReb.Amount;
                        SLine.Amount := PatientChargesReb.Amount;//Round(PatientChargesReb."Insurance Amount", 1, '=');
                        SLine."Unit Price" := PatientChargesReb.Amount;//Round(PatientChargesReb."Insurance Amount", 1, '=');
                        SLine.Validate("Unit Price");
                        SLine."Gen. Bus. Posting Group" := 'LOCAL';
                        SLine."Gen. Prod. Posting Group" := 'SERVICES';
                        SLine."Charge Code" := PatientChargesReb.Code;
                        SLine."Patient No." := PatientNo;
                        SLine."Shortcut Dimension 1 Code" := PatientChargesReb."Shortcut Dimension 1 Code";
                        SLine."Shortcut Dimension 2 Code" := PatientChargesReb."Shortcut Dimension 2 Code";
                        SLine.Insert();
                        LineNo := LineNo + 1;
                    end;
                end;

                /*  
                    ********Insert Invoice Generated Buffer and Select User********
                */
                SalesInvoicePerUserBuffer.Reset();
                SalesInvoicePerUserBuffer.SetRange("Sales Invoice No", NewNo);
                if SalesInvoicePerUserBuffer.FindFirst() then begin
                    SalesInvoicePerUserBuffer."Generated By" := StaffNo;
                    SalesInvoicePerUserBuffer.Modify();
                end else begin
                    SalesInvoicePerUserBuffer.Init();
                    SalesInvoicePerUserBuffer."Sales Invoice No" := NewNo;
                    SalesInvoicePerUserBuffer."Generated By" := StaffNo;
                    SalesInvoicePerUserBuffer.Insert();
                end;
                /* 
                    *************Generate Other Insurance Invoices **********************
                    * In the case of Multiple Insurances, Check if the patient has charges linked to their additional insurances
                    * Generate invoice for that specific insurance that was not the current insurance number of the patient.
                    * This Function Generates invoices for SHA if the Patient has Rebates Assigned.
                    * This Calls for Posting SHA Invoices too.
                */
                HMSPatIns.Reset();
                HMSPatIns.SetRange(HMSPatIns."Patient No", PatientNo);
                HMSPatIns.SETFILTER(HMSPatIns."Insurance No", '<>%1', '');
                HMSPatIns.SETFILTER(HMSPatIns."Open Invoices",'>%1',0);
                if HMSPatIns.FindSet() then
                    repeat
                        if HMSPatIns."Insurance No" <> CustNo then begin

                            if PatientCharges.InPatient then
                                NewNo := GetNewInvoiceNumber(Patients."Global Dimension 1 Code", 'IP')
                            else
                                NewNo := GetNewInvoiceNumber(Patients."Global Dimension 1 Code", 'OP');

                            SaleH.Init();
                            SaleH."Document Type" := SaleH."document type"::Invoice;
                            SaleH."No." := NewNo;
                            SaleH."Sell-to Customer No." := HMSPatIns."Insurance No";
                            SaleH."Shortcut Dimension 1 Code" := UserBranch;
                            SaleH."Shortcut Dimension 2 Code" := UserDept;
                            SaleH."Shortcut Dimension 3 Code" := PatientCharges."Shortcut Dimension 3 Code";
                            SaleH."Shortcut Dimension 4 Code" := PatientCharges."Shortcut Dimension 4 Code";
                            SaleH."Patient No." := PatientNo;
                            SaleH."Patient Name" := Patients."Search Name";
                            SaleH."Treatment No" := VisitNo;
                            SaleH."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
                            SaleH.Insert();
                            if SaleH.Get(SaleH."document type"::Invoice, NewNo) then begin
                                SaleH.Validate("Sell-to Customer No.");
                                SaleH."Shortcut Dimension 1 Code" := UserBranch;
                                SaleH."Shortcut Dimension 2 Code" := UserDept;

                                SaleH.Validate("Shortcut Dimension 1 Code");
                                SaleH.Validate("Shortcut Dimension 2 Code");
                                //SaleH.Status := SaleH.Status::Released;
                                SaleH.modify();
                                SLine.Reset();
                                SLine.SetRange("Document No.", NewNo);
                                if SLine.Find('-') then
                                    SLine.DeleteAll();
                            end;
                            if SLine.FindLast() then
                                LineNo := SLine."Line No." + 1;
                            PatientCharges.Reset();
                            PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
                            PatientCharges.SetRange(PatientCharges."Insurance No", HMSPatIns."Insurance No");
                            PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
                            PatientCharges.SetRange(PatientCharges.Closed, false);
                            // PatientCharges.SETRANGE(PatientCharges.Posted,FALSE);
                            if PatientCharges.Find('-') then
                                repeat
                                    if PatientCharges.Amount <> 0 then begin
                                        SLine.Init();
                                        SLine."Line No." := LineNo;
                                        SLine."Document No." := NewNo;
                                        SLine."Document Type" := SaleH."Document Type";
                                        SLine."Sell-to Customer No." := CustNo;
                                        SLine.Type := SLine.Type::"G/L Account";
                                        // PatientCharges.CalcFields("G/L Account");
                                        SLine."No." := HMSSetup."Cash Control Account";
                                        SLine.Description := PatientCharges.Description;
                                        SLine.Quantity := 1;
                                        SLine.Validate(SLine.Quantity);

                                        if PatientCharges."Insurance Amount" > 0 then begin
                                            SLine.Amount := PatientCharges."Insurance Amount";// Round(PatientCharges."Insurance Amount", 1, '=');
                                            SLine."Unit Price" := PatientCharges."Insurance Amount";//Round(PatientCharges."Insurance Amount", 1, '=');
                                        end else
                                            if PatientCharges."Insurance Amount" < 0 then begin
                                                SLine.Amount := PatientCharges.Amount * -1;//Round(PatientCharges.Amount, 1, '=') * -1;
                                                SLine."Unit Price" := PatientCharges.Amount * -1;//Round(PatientCharges.Amount, 1, '=') * -1;
                                            end else begin
                                                SLine.Amount := PatientCharges.Amount;// Round(PatientCharges.Amount, 1, '=');
                                                ;
                                                SLine."Unit Price" := PatientCharges.Amount;// Round(PatientCharges.Amount, 1, '=');
                                                ;
                                            end;
                                        if PatientCharges.Amount < 0 then
                                            SLine."Unit Price" := PatientCharges.Amount * -1;//Round(PatientCharges.Amount, 1, '=') * -1;
                                        SLine.Validate("Unit Price");
                                        SLine."Gen. Bus. Posting Group" := 'LOCAL';
                                        SLine."Gen. Prod. Posting Group" := 'SERVICES';
                                        SLine."Charge Code" := PatientCharges.Code;
                                        SLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                                        SLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                                        SLine.validate("Shortcut Dimension 1 Code");
                                        SLine.validate("Shortcut Dimension 2 Code");
                                        if SLine.Amount <> 0 then
                                            SLine.Insert();
                                        LineNo := LineNo + 1;

                                        PatientCharges."Invoice Number" := NewNo;
                                        PatientCharges.Posted := true;
                                        PatientCharges.Modify();
                                    end;
                                until PatientCharges.Next() = 0;

                            // Insert the Generated Invoice 
                            SalesInvoicePerUserBuffer.Reset();
                            SalesInvoicePerUserBuffer.SetRange("Sales Invoice No", NewNo);
                            if SalesInvoicePerUserBuffer.FindFirst() then begin
                                SalesInvoicePerUserBuffer."Generated By" := StaffNo;
                                SalesInvoicePerUserBuffer.Modify();
                            end else begin
                                SalesInvoicePerUserBuffer.Init();
                                SalesInvoicePerUserBuffer."Sales Invoice No" := NewNo;
                                SalesInvoicePerUserBuffer."Generated By" := StaffNo;
                                SalesInvoicePerUserBuffer.Insert(true);
                            end;
                        end;
                    until HMSPatIns.Next() = 0;

            end else begin
                /// Post to capitation GLs// --
                JTemplate := 'General';
                JBatch := 'Capitation';
                GenJnlLine.RESET();
                GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
                GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
                if GenJnlLine.FIND('-') then
                    GenJnlLine.DELETEALL();

                PatientCharges.RESET();
                PatientCharges.SETRANGE(PatientCharges."Patient No.", PatientNo);
                PatientCharges.SETRANGE(PatientCharges."Insurance No", CustNo);
                PatientCharges.SETRANGE(PatientCharges."Visit No", VisitNo);
                PatientCharges.SETRANGE(PatientCharges.Closed, FALSE);
                // PatientCharges.SETRANGE(PatientCharges.Posted,FALSE); //Commented to allow receipts for debtor patient
                if PatientCharges.FIND('-') then begin
                    REPEAT
                        if HMSTransCode.GET(PatientCharges."Transaction Type") then begin
                            DocNo := NoSeriesMgt.GetNextNo(HMSSetup."Charges Posting Nos", 0D, true);
                            LineNo := LineNo + 100;
                            HMSTransCode.TESTFIELD(HMSTransCode."Capitation Cost G/L Account");
                            GenJnlLine.INIT();
                            GenJnlLine."Journal Template Name" := JTemplate;
                            GenJnlLine."Journal Batch Name" := JBatch;
                            GenJnlLine."Source Code" := 'CASHRECJNL';
                            GenJnlLine."Line No." := LineNo;
                            GenJnlLine."Posting Date" := TODAY;
                            GenJnlLine."Document No." := DocNo;
                            // GenJnlLine."Document Date":="Document Date";
                            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine."Account No." := PatientCharges."G/L Account No";///HMSTransCode."Capitation Cost G/L Account";
                            GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                            GenJnlLine."External Document No." := PatientCharges."Visit No";
                            // GenJnlLine."Currency Code":="Currency Code";
                            GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                            GenJnlLine.Amount := PatientCharges."Total Amount";
                            GenJnlLine.VALIDATE(GenJnlLine.Amount);
                            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                            GenJnlLine."Bal. Account No." := HMSSetup."Cash Control Account";
                            GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                            GenJnlLine.Description := CopyStr(PatientCharges."Patient No." + ' -  ' + Patients.Surname + ' ' + Patients."Last Name", 1, MaxStrLen(GenJnlLine.Description));
                            GenJnlLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                            GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                            GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                            // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                            //  GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                            DimSetID.RESET();
                            DimSetID.SETRANGE("Dimension Code", 'BRANCH');
                            DimSetID.SETRANGE("Dimension Value Code", PatientCharges."Shortcut Dimension 1 Code");
                            if DimSetID.FIND('-') then
                                GenJnlLine."Dimension Set ID" := DimSetID."Dimension Set ID";

                            if GenJnlLine.Amount <> 0 then
                                GenJnlLine.INSERT();
                        end;
                        PatientCharges."Posting Document No" := DocNo;
                    // PatientCharges.Modify();
                    UNTIL PatientCharges.NEXT() = 0;
                    GenJnlLine.RESET();
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
                    if GenJnlLine.FIND('-') then
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnlLine);
                end;
            end;
            if GuiAllowed then
                MESSAGE('Invoice No ' + NewNo + ' has been successfuly created');
        end;
        if SaleH.Get(SaleH."Document Type"::Invoice, NewNo) then
            if GuiAllowed then
                Page.Run(43, SaleH);
        // MESSAGE('Invoice No ' + NewNo + ' has been successfuly created');
    end;

    procedure GenerateNHIF_Rebates_Invoice(PatientNo: Code[20]; VisitNo: Code[20]; InsuranceNo: Code[20]) returnValue: Code[30]
    var
        Patients: Record "HMS Patient";
        PatientCharges: Record "HMS Patient Charges";
        SalesSetup: Record "Sales & Receivables Setup";
        SaleH: Record "Sales Header";
        SalesInv: Record "Sales Invoice Header";
        SLine: Record "Sales Line";
        unbilledChargeExists: Boolean;
        NewNo: Code[20];
        LineNo: Integer;
    begin
        returnValue := '';
        Patients.Get(PatientNo);
        unbilledChargeExists := false;


        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
        PatientCharges.SetRange(PatientCharges."Insurance No", InsuranceNo);
        PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
        PatientCharges.SetRange(PatientCharges.Closed, false);
        PatientCharges.SetRange(PatientCharges.Posted, false);
        PatientCharges.SetFilter(PatientCharges."Invoice Number", '%1', '');
        if PatientCharges.Find('-') then begin
            SLine.Reset();
            SLine.SetRange("Document No.", PatientCharges."Invoice Number");
            if SLine.Find('-') then
                SLine.DeleteAll();
        end;

        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
        PatientCharges.SetRange(PatientCharges."Insurance No", InsuranceNo);
        PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
        PatientCharges.SetRange(PatientCharges.Closed, false);
        // PatientCharges.SetRange(PatientCharges."Cash Rebates Posted", false);
        if PatientCharges.Find('-') then
            repeat
                unbilledChargeExists := true;
            until PatientCharges.Next() = 0;

        if unbilledChargeExists = false then
            Error('All charges been posted');

        //Confirm all Transaction Codes have been kenyed in-----
        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
        PatientCharges.SetRange(PatientCharges."Insurance No", InsuranceNo);
        PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
        PatientCharges.SetRange(PatientCharges.Posted, false);
        // PatientCharges.SetRange(PatientCharges."Cash Rebates Posted", false);
        if PatientCharges.Find('-') then
            repeat
                PatientCharges.CalcFields(PatientCharges."G/L Account");
                if PatientCharges."G/L Account No" = '' then
                    Error('Please enter the G/l Account code to the charge %1 to continue', PatientCharges.Description);
                // Check if invoice had been posted
                PatientCharges.CalcFields("Posted Invoice No.");
                if PatientCharges."Posted Invoice No." <> '' then begin
                    SalesInv.Reset();
                    SalesInv.SetRange(SalesInv."No.", PatientCharges."Posted Invoice No.");
                    if SalesInv.Find('-') then
                        Error('Please note that Invoice No ' + PatientCharges."Posted Invoice No." + ' has aready been posted for the selected visit,Reverse the invoice before generating again');
                end;
            until PatientCharges.Next() = 0;

        // Generate NHIF insurance invoice

        SalesSetup.Get();
        if PatientCharges."Invoice Number" <> '' then
            if SaleH.GET(SaleH."Document Type"::Invoice, PatientCharges."Invoice Number") then begin
                NewNo := PatientCharges."Invoice Number";
                SaleH.DELETE();
                SLine.RESET();
                SLine.SETRANGE("Document No.", PatientCharges."Invoice Number");
                if SLine.FIND('-') then
                    SLine.DELETEALL();
            end;
        if NewNo = '' then begin
            if PatientCharges.InPatient then
                NewNo := GetNewInvoiceNumber(Patients."Global Dimension 1 Code", 'IP')
            else
                NewNo := GetNewInvoiceNumber(Patients."Global Dimension 1 Code", 'OP');

        end;
        SaleH.Init();
        SaleH."Document Type" := SaleH."document type"::Invoice;
        SaleH."No." := NewNo;
        SaleH."Posting Date" := Today;
        SaleH."Document Date" := Today;
        SaleH."Sell-to Customer No." := InsuranceNo;
        SaleH."Bill-to Customer No." := InsuranceNo;
        SaleH."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
        SaleH."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
        SaleH."Patient No." := PatientNo;
        SaleH."Treatment No" := VisitNo;
        SaleH."Appointment No" := VisitNo;
        SaleH."Patient Name" := Patients."Search Name";
        SaleH."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
        SaleH."Shortcut Dimension 1 Code" := Patients."Global Dimension 1 Code";
        // SaleH."Shortcut Dimension 2 Code" := UserDept;
        SaleH."Shortcut Dimension 3 Code" := PatientCharges."Shortcut Dimension 3 Code";
        SaleH."Shortcut Dimension 4 Code" := PatientCharges."Shortcut Dimension 4 Code";
        SaleH.Insert();
        //end;

        if SaleH.Get(SaleH."document type"::Invoice, NewNo) then begin
            SaleH."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
            SaleH."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
            SaleH.Validate("Sell-to Customer No.");
            SaleH.Validate("Shortcut Dimension 1 Code");
            SaleH.Validate("Shortcut Dimension 2 Code");
            SaleH.modify();
            //SaleH.Status := SaleH.Status::Released;
            if SLine.FindLast() then
                LineNo := SLine."Line No." + 1;

            PatientCharges.Reset();
            PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
            PatientCharges.SetRange(PatientCharges."Insurance No", InsuranceNo);
            PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
            PatientCharges.SetRange(PatientCharges.Closed, false);
            // PatientCharges.SetRange(PatientCharges."Cash Rebates Posted", false);
            if PatientCharges.Find('-') then
                repeat

                    SLine.Init();
                    SLine."Line No." := LineNo;
                    SLine."Document No." := SaleH."No.";
                    SLine."Bill-to Customer No." := SaleH."Bill-to Customer No.";
                    SLine."Document Type" := SaleH."Document Type";
                    SLine."Description 2" := Format(PatientCharges.Date);
                    SLine."Sell-to Customer No." := InsuranceNo;
                    SLine.Type := SLine.Type::"G/L Account";
                    PatientCharges.CalcFields("G/L Account");

                    SLine."No." := PatientCharges."G/L Account No";

                    SLine.Description := PatientCharges.Description;
                    if PatientCharges.Quantity > 0 then
                        SLine.Quantity := PatientCharges.Quantity
                    else
                        SLine.Quantity := 1;
                    SLine.Validate(SLine.Quantity);
                    SLine."Unit Price" := PatientCharges.Amount;
                    if PatientCharges."Insurance Amount" > 0 then begin
                        SLine.Amount := PatientCharges."Insurance Amount";
                        SLine."Unit Price" := PatientCharges."Insurance Amount";
                    end else begin
                        SLine.Amount := PatientCharges.Amount * -1;
                        SLine."Unit Price" := PatientCharges.Amount * -1;
                    end;
                    SLine.Validate("Unit Price");
                    SLine."Gen. Bus. Posting Group" := 'LOCAL';
                    SLine."Gen. Prod. Posting Group" := 'SERVICES';
                    SLine."Charge Code" := PatientCharges.Code;
                    SLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                    SLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                    SLine.Insert();
                    LineNo := LineNo + 1;

                    PatientCharges."Invoice Number" := SaleH."No.";
                    PatientCharges.Posted := true;
                    PatientCharges."Cash Rebates Posted" := true;
                    PatientCharges.Modify();

                //end;
                // end;
                until PatientCharges.Next() = 0;
            if GuiAllowed then
                if SaleH.Get(SaleH."document type"::Invoice, NewNo) then
                    Page.Run(43, SaleH);

            returnValue := NewNo;
            // MESSAGE('Invoice No '+NewNo+' has been successfuly created');
        end;
    end;

    procedure cdAppointmentNo(linkNo: Code[20]) mAppointmentNo: Code[20]
    var
        HMSADM: Record "HMS Admission Form Header";
        HMSApp: Record "HMS Appointment Form Header";
        HMSLab: Record "HMS Laboratory Form Header";
        HMSObs: Record "HMS Observation Form Header";
        HMSPatientCharges: Record "HMS Patient Charges";
        HMSTret: Record "HMS Treatment Form Header";
    begin

        HMSPatientCharges.Reset();
        HMSPatientCharges.SetRange(HMSPatientCharges."Link No", linkNo);
        if HMSPatientCharges.Find('-') then begin

            if HMSApp.Get(HMSPatientCharges."Link No") then
                mAppointmentNo := HMSApp."Appointment No.";

            if HMSObs.Get(HMSPatientCharges."Link No") then
                if HMSApp.Get(HMSObs."Link No.") then
                    mAppointmentNo := HMSApp."Appointment No.";

            if HMSTret.Get(HMSPatientCharges."Link No") then
                if HMSApp.Get(HMSObs."Link No.") then
                    mAppointmentNo := HMSApp."Appointment No.";

            if HMSADM.Get(HMSPatientCharges."Link No") then
                if HMSApp.Get(HMSADM."Link No.") then
                    mAppointmentNo := HMSApp."Appointment No.";

            if HMSLab.Get(HMSPatientCharges."Link No") then
                if HMSApp.Get(HMSLab."Link No.") then
                    mAppointmentNo := HMSApp."Appointment No.";
            /*
            if HMSPharm.GET(HMSPatientCharges."Link No") then
              if HMSApp.GET(HMSPharm."Link No.") then
              mAppointmentNo :=HMSApp."Appointment No.";

            HMSPatientCharges.CALCFIELDS("Appointment No Lk");
              if HMSApp.GET("Appointment No Lk") then
              mAppointmentNo :=HMSApp."Appointment No.";

            HMSPatientCharges.CALCFIELDS(HMSPatientCharges."Link No Lk");
              if HMSApp.GET(HMSPatientCharges."Link No Lk") then
              mAppointmentNo :=HMSApp."Appointment No.";
              */
        end;
    end;

    procedure DetermineAge(DateOfBirth: Date; DateOfJoin: Date) AgeString: Text[45]
    var
        DateCat: Integer;
        Day: Integer;
        dayB: Integer;
        dayJ: Integer;
        Month: Integer;
        monthB: Integer;
        monthJ: Integer;
        Year: Integer;
        yearB: Integer;
        yearJ: Integer;
    begin
        if ((DateOfBirth <> 0D) and (DateOfJoin <> 0D)) then begin
            dayB := Date2dmy(DateOfBirth, 1);
            monthB := Date2dmy(DateOfBirth, 2);
            yearB := Date2dmy(DateOfBirth, 3);
            dayJ := Date2dmy(DateOfJoin, 1);
            monthJ := Date2dmy(DateOfJoin, 2);
            yearJ := Date2dmy(DateOfJoin, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            DateCat := DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            case (DateCat) of
                1:
                    begin
                        Year := yearJ - yearB;
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        end;

                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            end;

                        AgeString := '%1  Years, %2  Months and #3## Days';
                        AgeString := StrSubstNo(AgeString, Year, Month, Day);
                    end;

                2, 3, 7:
                    begin
                        if (monthJ <> monthB) then
                            if monthJ >= monthB then
                                Month := monthJ - monthB;
                        // ELSE ERROR('The wrong date category!');

                        if (dayJ <> dayB) then
                            if (dayJ >= dayB) then
                                Day := dayJ - dayB
                            else
                                if (dayJ < dayB) then begin
                                    Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                    Month := Month - 1;
                                end;

                        AgeString := '%1  Months %2 Days';
                        AgeString := StrSubstNo(AgeString, Month, Day);
                    end;
                4:
                    begin
                        Year := yearJ - yearB;
                        AgeString := '#1## Years';
                        AgeString := StrSubstNo(AgeString, Year);
                    end;
                5:
                    begin
                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                monthJ := monthJ - 1;
                                Month := (monthJ + 12) - monthB;
                                yearJ := yearJ - 1;
                            end;

                        Year := yearJ - yearB;
                        AgeString := '%1  Years, %2 Months and #3## Days';
                        AgeString := StrSubstNo(AgeString, Year, Month, Day);
                    end;
                6:
                    begin
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;
                        Year := yearJ - yearB;
                        AgeString := '%1  Years and #2## Months';
                        AgeString := StrSubstNo(AgeString, Year, Month);
                    end;
                else
                    AgeString := '';
            end;
        end else
            Message('For Date Calculation Enter All Applicable Dates!');
        exit;
    end;

    procedure DifferenceStartEnd(StartDate: Date; EndDate: Date) DaysValue: Integer
    var
        DateCat: Integer;
        Day: Integer;
        dayEnd: Integer;
        daysInYears: Integer;
        dayStart: Integer;
        Holidays: Integer;
        i: Integer;
        j: Integer;
        l: Integer;
        m: Integer;
        monthE: Integer;
        monthS: Integer;
        monthValue: Integer;
        p: Integer;
        q: Integer;
        s: Integer;
        t: Integer;
        WeekendDays: Integer;
        Year: Integer;
        yearE: Integer;
        yearS: Integer;
        yearStart: Integer;
    begin
        if ((StartDate <> 0D) and (EndDate <> 0D)) then begin
            Day := 0;
            monthValue := 0;
            p := 0;
            q := 0;
            l := 0;
            Year := 0;
            daysInYears := 0;
            DaysValue := 0;
            dayStart := Date2dmy(StartDate, 1);
            monthS := Date2dmy(StartDate, 2);
            yearS := Date2dmy(StartDate, 3);
            dayEnd := Date2dmy(EndDate, 1);
            monthE := Date2dmy(EndDate, 2);
            yearE := Date2dmy(EndDate, 3);

            WeekendDays := 0;
            //AbsencePreferences.FIND('-');
            //if (AbsencePreferences."Include Weekends" = TRUE) then
            //   WeekendDays:= DetermineWeekends(StartDate,EndDate);

            Holidays := 0;
            // AbsencePreferences.FIND('-');
            // if (AbsencePreferences."Include Holidays" = TRUE) then
            //   Holidays:= DetermineHolidays(StartDate,EndDate);

            DateCat := DateCategory(dayStart, dayEnd, monthS, monthE, yearS, yearE);
            case (DateCat) of
                1:
                    begin
                        p := 0;
                        q := 0;
                        Year := yearE - yearS;
                        yearStart := yearS;
                        t := 1;
                        s := 1;
                        if (monthE <> monthS) then begin

                            for j := 1 to (monthS - 1) do begin
                                q := q + DetermineDaysInMonth(t, yearS);
                                t := t + 1;
                            end;
                            q := q + dayStart;

                            for i := 1 to (monthE - 1) do begin
                                p := p + DetermineDaysInMonth(s, yearE);
                                s := s + 1;
                            end;
                            p := p + dayEnd;

                            for m := 1 to Year do begin
                                if LeapYear(yearStart) then
                                    daysInYears := daysInYears + 366
                                else
                                    daysInYears := daysInYears + 365;
                                yearStart := yearStart + 1;
                            end;
                            DaysValue := (((daysInYears - q) + p) - WeekendDays) - Holidays;
                        end;
                    end;

                2, 7:
                    begin
                        for l := (monthS + 1) to (monthE - 1) do
                            DaysValue := DaysValue + DetermineDaysInMonth(l, yearS);
                        DaysValue := ((DaysValue + (DetermineDaysInMonth(monthS, yearS) - dayStart) + dayEnd) - WeekendDays) - Holidays;
                    end;

                3:

                    if (dayEnd >= dayStart) then
                        DaysValue := dayEnd - dayStart - WeekendDays - Holidays
                    else
                        if (dayEnd = dayStart) then
                            DaysValue := 0
                        else
                            DaysValue := ((dayStart - dayEnd) - WeekendDays) - Holidays;

                4:
                    begin
                        DaysValue := 0;
                        Year := yearE - yearS;
                        yearStart := yearS;
                        for m := 1 to Year do begin
                            if (LeapYear(yearStart)) then
                                daysInYears := 366
                            else
                                daysInYears := 365;
                            DaysValue := DaysValue + daysInYears;
                            yearStart := yearStart + 1;
                        end;
                        DaysValue := (DaysValue - WeekendDays) - Holidays;
                    end;

                5:
                    begin
                        Year := yearE - yearS;
                        yearStart := yearS;
                        for m := 1 to Year do begin
                            if LeapYear(yearStart) then
                                daysInYears := daysInYears + 366
                            else
                                daysInYears := daysInYears + 365;
                            yearStart := yearStart + 1;
                        end;
                        DaysValue := daysInYears;
                        if dayEnd > dayStart then
                            DaysValue := (DaysValue + (dayEnd - dayStart) - WeekendDays) - Holidays
                        else
                            if dayStart > dayEnd then
                                DaysValue := (DaysValue - (dayStart - dayEnd) - WeekendDays) - Holidays;
                    end;

                6:
                    begin
                        q := 0;
                        p := 0;
                        Year := yearE - yearS;
                        yearStart := yearS;
                        t := 1;
                        s := 1;

                        for j := 1 to monthS do begin
                            q := q + DetermineDaysInMonth(t, yearS);
                            t := t + 1;
                        end;

                        for i := 1 to monthE do begin
                            p := p + DetermineDaysInMonth(s, yearE);
                            s := s + 1;
                        end;

                        for m := 1 to Year do begin
                            if LeapYear(yearStart) then
                                daysInYears := daysInYears + 366
                            else
                                daysInYears := daysInYears + 365;
                            yearStart := yearStart + 1;
                        end;

                        DaysValue := ((daysInYears - q) + p) - WeekendDays - Holidays;
                    end;
                else
                    DaysValue := 0;
            end;
        end else
            Message('Enter all applicable dates for calculation!');
        DaysValue += 1;
        exit;
    end;

    procedure DetermineDaysInMonth(Month: Integer; Year: Integer) DaysInMonth: Integer
    begin
        case (Month) of
            1:
                DaysInMonth := 31;
            2:

                if (LeapYear(Year)) then
                    DaysInMonth := 29
                else
                    DaysInMonth := 28;
            3:
                DaysInMonth := 31;
            4:
                DaysInMonth := 30;
            5:
                DaysInMonth := 31;
            6:
                DaysInMonth := 30;
            7:
                DaysInMonth := 31;
            8:
                DaysInMonth := 31;
            9:
                DaysInMonth := 30;
            10:
                DaysInMonth := 31;
            11:
                DaysInMonth := 30;
            12:
                DaysInMonth := 31;
            else
                Message('Not valid date. The month must be between 1 and 12');
        end;

        exit;
    end;

    procedure DateCategory(BDay: Integer; EDay: Integer; BMonth: Integer; EMonth: Integer; BYear: Integer; EYear: Integer) Category: Integer
    begin
        if ((EYear > BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
            Category := 1
        else
            if ((EYear = BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
                Category := 2
            else
                if ((EYear = BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
                    Category := 3
                else
                    if ((EYear > BYear) and (EMonth = BMonth) and (EDay = BDay)) then
                        Category := 4
                    else
                        if ((EYear > BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
                            Category := 5
                        else
                            if ((EYear > BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
                                Category := 6
                            else
                                if ((EYear = BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
                                    Category := 7
                                else
                                    if ((EYear = BYear) and (EMonth = BMonth) and (EDay = BDay)) then
                                        Category := 3
                                    else
                                        Category := 0;
        //ERROR('The start date cannot be after the end date.');
        exit;
    end;

    procedure LeapYear(Year: Integer) LY: Boolean
    var
        CenturyYear: Boolean;
        DivByFour: Boolean;
    begin
        CenturyYear := Year MOD 100 = 0;
        DivByFour := Year MOD 4 = 0;
        if ((not CenturyYear and DivByFour) or (Year MOD 400 = 0)) then
            LY := true
        else
            LY := false;
    end;

    procedure ReservedDates(NewStartDate: Date; NewEndDate: Date; EmployeeNumber: Code[20]) Reserved: Boolean
    begin
        //AbsenceHoliday.SETFILTER("Employee No.",EmployeeNumber);
        //  OK:= AbsenceHoliday.FIND('-');
        /*  REPEAT
              if (NewStartDate > AbsenceHoliday."Start Date") AND (NewStartDate < AbsenceHoliday."End Date") then
                 Reserved := TRUE
              ELSE
              if (NewEndDate < AbsenceHoliday."End Date") AND (NewEndDate > AbsenceHoliday."Start Date") then
                 Reserved := TRUE
              ELSE
              if (NewStartDate > AbsenceHoliday."Start Date") AND (NewEndDate < AbsenceHoliday."End Date") then
                 Reserved := TRUE
              ELSE Reserved := FALSE;
          UNTIL AbsenceHoliday.NEXT = 0;*/
    end;

    procedure DetermineWeekends(DateStart: Date; DateEnd: Date) Weekends: Integer
    begin
        Weekends := 0;
        while (DateStart <= DateEnd) do begin
            dayOfWeek := Date2dwy(DateStart, 1);
            if (dayOfWeek = 6) or (dayOfWeek = 7) then
                Weekends := Weekends + 1;
            NextDay := CalculateNextDay(DateStart);
            DateStart := NextDay;
        end;
    end;

    procedure CalculateNextDay(Date: Date) NextDate: Date
    var
        daysInMonth: Integer;
        month: Integer;
        nextDay: Integer;
        today: Integer;
        year: Integer;
    begin
        today := Date2dmy(Date, 1);
        month := Date2dmy(Date, 2);
        year := Date2dmy(Date, 3);
        daysInMonth := DetermineDaysInMonth(month, year);
        nextDay := today + 1;
        if (nextDay > daysInMonth) then begin
            nextDay := 1;
            month := month + 1;
            if (month > 12) then begin
                month := 1;
                year := year + 1;
            end;
        end;
        NextDate := Dmy2date(nextDay, month, year);
    end;

    procedure DetermineHolidays(DateStart: Date; DateEnd: Date) Holiday: Integer
    begin
        /*  Holiday:= 0;
          WHILE (DateStart <= DateEnd) DO begin
            dayOfWeek:= DATE2DWY(DateStart,1);
            StatutoryHoliday.FIND('-');
            REPEAT
             if (DateStart = StatutoryHoliday."Holiday Date") then
                Holiday:= Holiday + StatutoryHoliday."Duration Of Holiday";
            UNTIL StatutoryHoliday.NEXT = 0;
            NextDay:= CalculateNextDay(DateStart);
            DateStart:= NextDay;
         end;   */
    end;

    procedure ConvertDate(nDate: Date) strDate: Text[30]
    var
        lDay: Integer;
        lMonth: Integer;
        lYear: Integer;
        strDay: Text[4];
        strYear: Text[6];
        StrMonth: Text[20];
    begin
        //this function converts the date to the format required by ksps
        lDay := Date2dmy(nDate, 1);
        lMonth := Date2dmy(nDate, 2);
        lYear := Date2dmy(nDate, 3);

        if lDay = 1 then
            strDay := '1st';
        if lDay = 2 then
            strDay := '2nd';
        if lDay = 3 then
            strDay := '3rd';
        if lDay = 4 then
            strDay := '4th';
        if lDay = 5 then
            strDay := '5th';
        if lDay = 6 then
            strDay := '6th';
        if lDay = 7 then
            strDay := '7th';
        if lDay = 8 then
            strDay := '8th';
        if lDay = 9 then
            strDay := '9th';
        if lDay = 10 then
            strDay := '10th';
        if lDay = 11 then
            strDay := '11th';
        if lDay = 12 then
            strDay := '12th';
        if lDay = 13 then
            strDay := '13th';
        if lDay = 14 then
            strDay := '14th';
        if lDay = 15 then
            strDay := '15th';
        if lDay = 16 then
            strDay := '16th';
        if lDay = 17 then
            strDay := '17th';
        if lDay = 18 then
            strDay := '18th';
        if lDay = 19 then
            strDay := '19th';
        if lDay = 20 then
            strDay := '20th';
        if lDay = 21 then
            strDay := '21st';
        if lDay = 22 then
            strDay := '22nd';
        if lDay = 23 then
            strDay := '23rd';
        if lDay = 24 then
            strDay := '24th';
        if lDay = 25 then
            strDay := '25th';
        if lDay = 26 then
            strDay := '26th';
        if lDay = 27 then
            strDay := '27th';
        if lDay = 28 then
            strDay := '28th';
        if lDay = 29 then
            strDay := '29th';
        if lDay = 30 then
            strDay := '30th';
        if lDay = 31 then
            strDay := '31st';

        if lMonth = 1 then
            StrMonth := ' January ';
        if lMonth = 2 then
            StrMonth := ' February ';
        if lMonth = 3 then
            StrMonth := ' March ';
        if lMonth = 4 then
            StrMonth := ' April ';
        if lMonth = 5 then
            StrMonth := ' May ';
        if lMonth = 6 then
            StrMonth := ' June ';
        if lMonth = 7 then
            StrMonth := ' July ';
        if lMonth = 8 then
            StrMonth := ' August ';
        if lMonth = 9 then
            StrMonth := ' September ';
        if lMonth = 10 then
            StrMonth := ' October ';
        if lMonth = 11 then
            StrMonth := ' November ';
        if lMonth = 12 then
            StrMonth := ' December ';

        strYear := Format(lYear);
        //return the date
        strDate := strDay + StrMonth + strYear;
    end;

    procedure DetermineAge_Years(DateOfBirth: Date; DateOfJoin: Date) AgeString: Text[45]
    var
        DateCat: Integer;
        Day: Integer;
        dayB: Integer;
        dayJ: Integer;
        Month: Integer;
        monthB: Integer;
        monthJ: Integer;
        Year: Integer;
        yearB: Integer;
        yearJ: Integer;
    begin
        if ((DateOfBirth <> 0D) and (DateOfJoin <> 0D)) then begin
            dayB := Date2dmy(DateOfBirth, 1);
            monthB := Date2dmy(DateOfBirth, 2);
            yearB := Date2dmy(DateOfBirth, 3);
            dayJ := Date2dmy(DateOfJoin, 1);
            monthJ := Date2dmy(DateOfJoin, 2);
            yearJ := Date2dmy(DateOfJoin, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            DateCat := DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            case (DateCat) of
                1:
                    begin
                        Year := yearJ - yearB;
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        end;

                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            end;

                        AgeString := '%1';
                        AgeString := StrSubstNo(AgeString, Year);
                    end;

                2, 3, 7:
                    begin
                        if (monthJ <> monthB) then
                            if monthJ >= monthB then
                                Month := monthJ - monthB;
                        // ELSE ERROR('The wrong date category!');

                        if (dayJ <> dayB) then
                            if (dayJ >= dayB) then
                                Day := dayJ - dayB
                            else
                                if (dayJ < dayB) then begin
                                    Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                    Month := Month - 1;
                                end;

                        AgeString := '%1  Months %2 Days';
                        AgeString := StrSubstNo(AgeString, Month, Day);
                    end;
                4:
                    begin
                        Year := yearJ - yearB;
                        AgeString := '#1##';
                        AgeString := StrSubstNo(AgeString, Year);
                    end;
                5:
                    begin
                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                monthJ := monthJ - 1;
                                Month := (monthJ + 12) - monthB;
                                yearJ := yearJ - 1;
                            end;

                        Year := yearJ - yearB;
                        AgeString := '%1';
                        AgeString := StrSubstNo(AgeString, Year);
                    end;
                6:
                    begin
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;
                        Year := yearJ - yearB;
                        AgeString := '%1';
                        AgeString := StrSubstNo(AgeString, Year, Month);
                    end;
                else
                    AgeString := '';
            end;
        end else
            Message('For Date Calculation Enter All Applicable Dates!');
        exit;
    end;

    procedure PostLeave()
    var
        HrEmployee: Record "HR-Employee";
        hrLeaveJournal: Record "HR Employee Leave Journal";
        leaveLedger: Record "HR Leave Ledger";
        Var1: Code[10];
        progre: Dialog;
        counts: Integer;
        lastNo: Integer;
        RecCount1: Text[120];
        RecCount2: Text[120];
        RecCount3: Text[120];
        RecCount4: Text[120];
        RecCount5: Text[120];
        RecCount6: Text[120];
        RecCount7: Text[120];
        RecCount8: Text[120];
        RecCount9: Text[120];
        RecCount10: Text[120];
        BufferString: Text[1024];
    begin
        if Confirm('Post Leave Journal Lines?', false) = false then
            exit;

        hrLeaveJournal.Reset();
        if hrLeaveJournal.Find('-') then begin

            Clear(RecCount1);
            Clear(RecCount2);
            Clear(RecCount3);
            Clear(RecCount4);
            Clear(RecCount5);
            Clear(RecCount6);
            Clear(RecCount7);
            Clear(RecCount8);
            Clear(RecCount9);
            Clear(RecCount10);
            Clear(counts);
            progre.Open('Processing Please wait..............\#1###############################################################' +
            '\#2###############################################################' +
            '\#3###############################################################' +
            '\#4###############################################################' +
            '\#5###############################################################' +
            '\#6###############################################################' +
            '\#7###############################################################' +
            '\#8###############################################################' +
            '\#9###############################################################' +
            '\#10###############################################################' +
            '\#11###############################################################' +
            '\#12###############################################################' +
            '\#13###############################################################',
                RecCount1,
                RecCount2,
                RecCount3,
                RecCount4,
                RecCount5,
                RecCount6,
                RecCount7,
                RecCount8,
                RecCount9,
                RecCount10,
                Var1,
                Var1,
                BufferString
            );
            Clear(lastNo);
            leaveLedger.Reset();
            //  leaveLedger.SETFILTER(leaveLedger."Leave Approval Date",'<>%1',0);
            if leaveLedger.FindLast() then begin
                //  lastNo:=leaveLedger."Leave Approval Date"+10;
            end else
                lastNo := 10;
            repeat
                //Post Leave Journals
                leaveLedger.Init();
                // leaveLedger."Leave Approval Date":=Today;
                leaveLedger."Entry No." := leaveLedger."Entry No." + 1;
                //leaveLedger."Document No.":=hrLeaveJournal."Posting Date";
                //     leaveLedger."External Document No.":=hrLeaveJournal."Leave Type";
                //     leaveLedger."Job ID":=hrLeaveJournal."Leave Entry Type";
                //     leaveLedger."Job Group":=hrLeaveJournal."Staff Name";
                //     if ((hrLeaveJournal."Staff Name"=hrLeaveJournal."Staff Name"::"3") OR
                //     (hrLeaveJournal."Staff Name"=hrLeaveJournal."Staff Name"::"1")) then
                //     leaveLedger."Contract Type":=hrLeaveJournal."Staff No."
                //     ELSE
                //     if ((hrLeaveJournal."Staff Name"=hrLeaveJournal."Staff Name"::"4") OR
                //     (hrLeaveJournal."Staff Name"=hrLeaveJournal."Staff Name"::"2")) then
                //     leaveLedger."Contract Type":=((hrLeaveJournal."Staff No.")*(-1));
                //
                //     leaveLedger."No. of days":=hrLeaveJournal."Leave Period";
                //     leaveLedger."Leave Start Date":=DATE2DWY(TODAY,3);
                //    leaveLedger.INSERT;
                lastNo := lastNo + 10;
                // Insert into the ledger entry table
                if HrEmployee.Get(hrLeaveJournal."Staff No.") then;
                Clear(Var1);
                counts := counts + 1;
                if counts = 1 then
                    RecCount1 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                else
                    if counts = 2 then
                        RecCount2 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                    else
                        if counts = 3 then
                            RecCount3 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                        else
                            if counts = 4 then
                                RecCount4 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                            HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                            else
                                if counts = 5 then
                                    RecCount5 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                else
                                    if counts = 6 then
                                        RecCount6 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                    else
                                        if counts = 7 then
                                            RecCount7 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                        else
                                            if counts = 8 then
                                                RecCount8 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                            HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                            else
                                                if counts = 9 then
                                                    RecCount9 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                else
                                                    if counts = 10 then
                                                        RecCount10 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                    else
                                                        if counts > 10 then begin
                                                            RecCount1 := RecCount2;
                                                            RecCount2 := RecCount3;
                                                            RecCount3 := RecCount4;
                                                            RecCount4 := RecCount5;
                                                            RecCount5 := RecCount6;
                                                            RecCount6 := RecCount7;
                                                            RecCount7 := RecCount8;
                                                            RecCount8 := RecCount9;
                                                            RecCount9 := RecCount10;
                                                            RecCount10 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
                                                        end;
                Clear(BufferString);
                BufferString := 'Total Records processed = ' + Format(counts);

                progre.Update();
            until hrLeaveJournal.Next() = 0;
            ////Progress Window
            progre.Close();
        end;
        hrLeaveJournal.DeleteAll();
        Message('Leave Journal posted successfully!');
    end;

    procedure AssignCurrentAdmNo(PatNo: Code[20]; NewNo: Code[20])
    var
        Patient: Record "HMS Patient";
    begin
        Patient.Reset();
        Patient.SetRange(Patient."Patient No.", PatNo);
        if Patient.Find('-') then begin
            Patient."Current Adm No" := NewNo;
            Patient.Inpatient := true;
            Patient.Activated := true;
            Patient.Modify();
        end;
    end;

    procedure CloseBill(PatientNo: Code[20]): Boolean
    var
        objPatientCharges: Record "HMS Patient Charges";
    begin
        objPatientCharges.Reset();
        objPatientCharges.SetRange(objPatientCharges."Patient No.", PatientNo);
        objPatientCharges.SetRange(objPatientCharges.Posted, false);
        if objPatientCharges.FindSet() then begin
            repeat
                objPatientCharges.Recognized := true;
                objPatientCharges.Posted := true;
                objPatientCharges.closed := true;
                objPatientCharges.Modify();
            until objPatientCharges.Next() = 0;

            exit(true);
        end;
        exit(false);
    end;

    procedure GetPatientName(PatientNo: Code[20]) panNames: Text[200]
    var
        hmsPAt: Record "HMS Patient";
    begin
        if hmsPAt.Get(PatientNo) then
            panNames := hmsPAt.Surname + ' ' + hmsPAt."Middle Name" + ' ' + hmsPAt."Last Name";
    end;

    procedure GetPatientDOB(PatientNo: Code[20]) panNames: Text[200]
    var
        hmsPAt: Record "HMS Patient";
    begin
        if hmsPAt.Get(PatientNo) then
            panNames := Format(hmsPAt."Date Of Birth");
    end;

    procedure GetPatientGender(PatientNo: Code[20]) panNames: Text[200]
    var
        hmsPAt: Record "HMS Patient";
    begin
        if hmsPAt.Get(PatientNo) then
            panNames := Format(hmsPAt.Gender);
    end;

    procedure GetPatientResidence(PatientNo: Code[20]) panNames: Text[200]
    var
        hmsPAt: Record "HMS Patient";
    begin
        if hmsPAt.Get(PatientNo) then
            panNames := hmsPAt."Correspondence Address 1";
    end;

    procedure GetPatientAddress(PatientNo: Code[20]) panNames: Text[200]
    var
        hmsPAt: Record "HMS Patient";
    begin
        if hmsPAt.Get(PatientNo) then
            panNames := hmsPAt."Correspondence Address 2";
    end;

    procedure GetPatientTel(PatientNo: Code[20]) panNames: Text[200]
    var
        hmsPAt: Record "HMS Patient";
    begin
        if hmsPAt.Get(PatientNo) then
            panNames := hmsPAt."Telephone No. 1";
    end;

    procedure GetPatientAge(PatientNo: Code[20]) panNames: Text[200]
    var
        hmsPAt: Record "HMS Patient";
    begin
        if hmsPAt.Get(PatientNo) then
            panNames := DetermineAge(hmsPAt."Date Of Birth", Today);
    end;

    procedure UserShortcutDim1(UserID: Code[20]) dim1: Code[20]
    var
        USetup: Record "User Setup";
    begin
        dim1 := '';

        USetup.Reset();
        USetup.SetRange(USetup."User ID", UserID);
        if USetup.Find('-') then
            dim1 := USetup."Global Dimension 1 Code";
        if dim1 = '' then
            dim1 := 'ACCOUNTS';
    end;

    procedure UserShortcutDim2(UserID: Code[20]) dim2: Code[20]
    var
        USetup: Record "User Setup";
    begin
        dim2 := '';

        USetup.Reset();
        USetup.SetRange(USetup."User ID", UserID);
        if USetup.Find('-') then
            dim2 := USetup."Global Dimension 2 Code";
        if dim2 = '' then
            dim2 := 'ACCOUNTS';
    end;

    procedure PostCharges(PatientNo: Code[20]; VisitNo: Code[20]; OwnDebtor: Boolean)
    var
        Cust: Record Customer;
        GenJnlLine: Record "Gen. Journal Line";
        HMSCharges: Record "HMS Charges";
        Patients: Record "HMS Patient";
        PatientCharges: Record "HMS Patient Charges";
        HMSSetup: Record "HMS Setup";
        HMSTransCode: Record "HMS Transactions code";
        DocNo: code[20];
        JBatch: Code[20];
        JTemplate: Code[20];
        LineNo: Integer;
    begin

        JTemplate := 'General';
        JBatch := 'PCharges';
        GenJnlLine.Reset();
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
        if GenJnlLine.Find('-') then
            GenJnlLine.DeleteAll();

        HMSSetup.Get();
        HMSSetup.TestField("Cash Control Account");
        HMSSetup.TestField("Charges Posting Nos");

        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
        // PatientCharges.SETRANGE(PatientCharges."Insurance No",Patients."Insurance No.");
        PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
        PatientCharges.SetRange(PatientCharges.Closed, false);
        // PatientCharges.SetRange(PatientCharges.Posted, false); //Commented to allow receipts for debtor patient
        PatientCharges.SetFilter(PatientCharges."Transaction Type", '<>%1', 'ZRECEIPT');
        PatientCharges.SetFilter(PatientCharges.Amount, '<>%1', 0);
        if PatientCharges.Find('-') then begin
            repeat
                Patients.Get(PatientCharges."Patient No.");
                PatientCharges.CalcFields("Exist In GL");
                // if PatientCharges."Insurance No"<>'' then begin
                // if HMSCharges.Get(PatientCharges.Code) then
                // HMSCharges.TestField("Income G/L Account No");

                PatientCharges.TestField("G/L Account No");
                if (PatientCharges."Exist In GL" = false) or (PatientCharges."Posting Document No" = '') then begin
                    LineNo := LineNo + 100;
                    if OwnDebtor then begin
                        Patients.TestField("Debtor Account");
                        Cust.get(Patients."Debtor Account");
                    end else
                        if Cust.get(PatientCharges."Insurance No") then;
                    DocNo := NoSeriesMgt.GetNextNo(HMSSetup."Charges Posting Nos", 0D, true);
                    GenJnlLine.Init();
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine."Source Code" := 'CASHRECJNL';
                    GenJnlLine."Line No." := LineNo;
                    if PatientCharges.Date = 0D then
                        GenJnlLine."Posting Date" := Today
                    else
                        GenJnlLine."Posting Date" := PatientCharges.date;
                    // GenJnlLine."Document No." := PatientCharges."Visit No" + '-' + format(PatientCharges."Line No");
                    // GenJnlLine."Document Date":="Document Date";
                    GenJnlLine."Document No." := DocNo;
                    GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                    if HMSTransCode.GET(PatientCharges."Transaction Type") then
                        if ((Cust."NHIF Capitation" = true) AND (HMSTransCode."Capitation Cost G/L Account" <> '')) then begin
                            HMSSetup.TestField("NHIF Capitation Cost G/L");
                            HMSSetup.TestField("NHIF Capitation Control G/L");

                            HMSTransCode.TESTFIELD(HMSTransCode."Capitation Cost G/L Account");
                            GenJnlLine."Account No." := HMSTransCode."Capitation Cost G/L Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine."Bal. Account No." := HMSSetup."NHIF Capitation Control G/L";
                        end else
                            if Cust."NHIF Package" = true then begin
                                HMSSetup.TestField("NHIF Package Cost G/L");
                                HMSSetup.TestField("NHIF Capitation Control G/L");
                                // HMSCharges.TestField("Expense G/L Account No");
                                GenJnlLine."Account No." := HMSSetup."NHIF Package Cost G/L";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                //  GenJnlLine."Bal. Account No." := HMSCharges."Expense G/L Account No";
                                GenJnlLine."Bal. Account No." := HMSSetup."NHIF Capitation Control G/L";
                                if HMSCharges.get(PatientCharges.Code) then;
                                // HMSCharges.TestField("Expense G/L Account No");
                                //  GenJnlLine."Bal. Account No." := HMSCharges."Expense G/L Account No";
                            end else begin
                                GenJnlLine."Account No." := HMSSetup."Cash Control Account";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine."Bal. Account Type" := GenJnlLine."bal. account type"::"G/L Account";
                                GenJnlLine."Bal. Account No." := PatientCharges."G/L Account No";
                            end;

                    GenJnlLine.Description := PatientCharges.Description;
                    GenJnlLine."External Document No." := VisitNo;
                    // GenJnlLine."Currency Code":="Currency Code";
                    GenJnlLine.Validate(GenJnlLine."Currency Code");
                    GenJnlLine.Amount := PatientCharges."Total Amount";
                    GenJnlLine.Validate(GenJnlLine.Amount);

                    GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := copystr(PatientCharges."Patient No." + ' -  ' + Patients.Surname + ' ' + Patients."Last Name", 1, 100);
                    GenJnlLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                    GenJnlLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine."Source Code" := PatientNo;
                    GenJnlLine."Source No." := PatientCharges."Insurance No";
                    // PatientCharges."Posting Document No" := PatientCharges."Visit No" + '-' + format(PatientCharges."Line No");
                    PatientCharges."Posting Document No" := DocNo;
                    GenJnlLine.ValidateShortcutDimCode(3, PatientCharges."Shortcut Dimension 3 Code");
                    GenJnlLine.ValidateShortcutDimCode(4, PatientCharges."Shortcut Dimension 4 Code");
                    if GenJnlLine.Amount <> 0 then
                        GenJnlLine.Insert();

                    /* if Cust."NHIF Capitation" = true then begin
                        LineNo := LineNo + 10;
                        GenJnlLine.Init;
                        GenJnlLine."Journal Template Name" := JTemplate;
                        GenJnlLine."Journal Batch Name" := JBatch;
                        GenJnlLine."Source Code" := 'CASHRECJNL';
                        GenJnlLine."Line No." := LineNo;
                        GenJnlLine."Posting Date" := Today;
                        GenJnlLine."Document No." := PatientCharges."Visit No" + '-' + format(PatientCharges."Line No");
                        // GenJnlLine."Document Date":="Document Date";
                        GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                        HMSSetup.TestField("NHIF Capitation Cost G/L");
                        GenJnlLine."Account No." := HMSSetup."Cash Control Account";
                        GenJnlLine.Validate(GenJnlLine."Account No.");
                        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::Customer;
                        GenJnlLine."Bal. Account No." := Cust."No.";
                        GenJnlLine.Description := PatientCharges.Description;
                        GenJnlLine."External Document No." := VisitNo;
                        // GenJnlLine."Currency Code":="Currency Code";
                        GenJnlLine.Validate(GenJnlLine."Currency Code");
                        GenJnlLine.Amount := PatientCharges."Total Amount";
                        GenJnlLine.Validate(GenJnlLine.Amount);
                        GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                        GenJnlLine.Description := PatientCharges."Patient No." + ' -  ' + Patients.Surname + ' ' + Patients."Last Name";
                        GenJnlLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
                        GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                        GenJnlLine."Source Code" := PatientNo;
                        GenJnlLine."Source No." := PatientCharges."Insurance No";
                        PatientCharges."Posting Document No" := PatientCharges."Visit No" + '-' + format(PatientCharges."Line No");
                        // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
                        //  GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
                        if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                    end; */
                    PatientCharges.Modify();
                    Commit();
                end;
            //end;
            until PatientCharges.Next() = 0;
            GenJnlLine.Reset();
            GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
            if GenJnlLine.Find('-') then
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Bill", GenJnlLine);
        end;

        /* 
            * Update Charges with invoice number to be marked as Posted
        */
        PatientCharges.Reset();
        PatientCharges.SetRange(PatientCharges."Patient No.", PatientNo);
        PatientCharges.SetRange(PatientCharges."Visit No", VisitNo);
        PatientCharges.SetRange(PatientCharges.Posted, false);
        PatientCharges.SetFilter(PatientCharges."Transaction Type", '<>%1', 'ZRECEIPT');
        if PatientCharges.Find('-') then
            repeat
                PatientCharges.CalcFields("Exist In GL");
                if PatientCharges."Exist In GL" = true then begin
                    PatientCharges.Posted := true;
                    PatientCharges."Receipt posted" := true;
                    PatientCharges.Modify();
                end;
            until PatientCharges.next() = 0;
    end;

    procedure GetPatientBalance(PatientNo: Code[20]; VisitNo: Code[20]) Bal: Decimal
    var
        GLEntry: Record "G/L Entry";
        HMSSetup: Record "HMS Setup";
    begin

        HMSSetup.Get();
        HMSSetup.TestField("Cash Control Account");
        GLEntry.Reset();
        GLEntry.SetRange(GLEntry."G/L Account No.", HMSSetup."Cash Control Account");
        //CustL.SETRANGE(CustL."Document No.",VisitNo);
        GLEntry.SetRange(GLEntry."External Document No.", VisitNo);
        if GLEntry.Find('-') then
            repeat
                Bal := Bal + GLEntry.Amount;
            until GLEntry.Next() = 0;
    end;

    local procedure "****************************************8"()
    begin
    end;

    procedure PatientBalance() PatBal: Decimal
    begin
        /*
          OpenSQLConn();

          SQLString := 'SELECT ExtractValue(Smart_File, ''AdmissionInformation/Benefits/Benefit/Amount'') as patBalance '+
                       'FROM smartlink.exchange_files LIMIT 1 ';

          ADComm.ActiveConnection:=ADOConnection;
          ADComm.CommandText:=SQLString;
          ADComm.CommandType := 1;
          ADComm.CommandTimeout := 0;
          ADComm.Execute;

          ADORecordSet.CursorLocation:=3;
          ADORecordSet.Open(ADComm);
          if ADORecordSet.BOF<>true then begin
            ADORecordSet.MoveFirst;
            repeat
               if ADORecordSet.EOF=false then begin
                Evaluate(PatBal,Format(ADORecordSet.Fields.Item(0).Value));
               end;
            until ADORecordSet.EOF=true;
          end;

          CloseSQLConn();
          */
    end;

    procedure OpenSQLConn()
    begin
        /*
          Create(ADOStream,false,true);
          Create(ADORecordSet,false,true);
          Create(ADComm,false,true);
          Create(ADOConnection,false,true);

          ConnectionString:='DSN=ismartlink;Uid=integ_user;Pwd=integ123;';// server=192.168.1.230;PORT=3307';
          ADOConnection.ConnectionString(ConnectionString);
          ADOConnection.Open;
      end;

          procedure CloseSQLConn()
      begin
          ADORecordSet.Close;
          ADOConnection.Close;
          */
    end;

    local procedure Smart()
    begin
    end;

    local procedure CreateJSON(PatNo: Code[20]; VisitNo: Code[20])
    var
        AdmissionFormHD: Record "HMS Admission Form Header";
        PatRec: Record "HMS Patient";
        PatCharges: Record "HMS Patient Charges";
        TxFormDiagnosis: Record "HMS Treatment Form Diagnosis";
        ServiceType: Code[10];
        JSONFile: File;
        myOutstream: OutStream;
        CRLFString: Text[2];
    begin
        //xLF := 13;
        //xCR := 10;
        CRLFString[1] := 13;
        CRLFString[2] := 10;

        JSONFile.Create('C:\COOP BANK\EDI.json');
        JSONFile.CreateOutstream(myOutstream);

        PatientRec.Reset();
        PatientRec.SetRange(PatientRec."Patient No.", PatNo);
        if PatientRec.Find('-') then begin
            PatCharges.Reset();
            PatCharges.SetRange(PatCharges."Patient No.", PatientRec."Patient No.");
            PatCharges.SetRange(PatCharges."Visit No", VisitNo);
            if PatCharges.Find('-') then begin

                PatCharges.CalcFields("Insurance Name");
                PatCharges.CalcFields("Total Amount");
                PatCharges.CalcFields("Doctors Name");

                ServiceType := 'OUTPATIENT';
                AdmissionFormHD.Reset();
                AdmissionFormHD.SetRange(AdmissionFormHD."Patient No.", PatNo);
                AdmissionFormHD.SetFilter(AdmissionFormHD.Status, '<>%1', AdmissionFormHD.Status::Cancelled);
                if AdmissionFormHD.Find('-') then
                    ServiceType := 'INPATIENT';

                TxFormDiagnosis.Reset();
                TxFormDiagnosis.SetRange(TxFormDiagnosis."Patient No", PatNo);
                TxFormDiagnosis.SetRange(TxFormDiagnosis."Treatment No.", VisitNo);
                if TxFormDiagnosis.Find('-') then
                    TxFormDiagnosis.CalcFields("Diagnosis Name");

                myOutstream.WriteText('{' + CRLFString);
                myOutstream.WriteText('   "claim_code":"MMCC00030",' + CRLFString);          //Not Clear ???????????????????????
                myOutstream.WriteText('   "payer_code":"' + PatCharges."Insurance No" + '",' + CRLFString);
                myOutstream.WriteText('   "payer_name":"' + PatCharges."Insurance Name" + '",' + CRLFString);
                myOutstream.WriteText('   "amount":' + Format(PatCharges."Total Amount") + ',' + CRLFString);
                myOutstream.WriteText('   "gross_amount":' + Format(PatCharges."Total Amount") + ',' + CRLFString);
                myOutstream.WriteText('   "batch_number":"batch4",' + CRLFString);
                myOutstream.WriteText('   "dispatch_date":"' + Format(PatCharges.Date) + '",' + CRLFString);  //Unfinished - Get the Dispatch date *********
                myOutstream.WriteText('   "patient_number":"' + PatRec."Patient No." + '",' + CRLFString);
                myOutstream.WriteText('   "patient_name":"' + PatRec.Names + '",' + CRLFString);
                myOutstream.WriteText('   "location_code":"ELDORET",' + CRLFString);
                myOutstream.WriteText('   "location_name":"Eldoret",' + CRLFString);
                myOutstream.WriteText('   "scheme_code":"' + PatRec."Insurance No." + '",' + CRLFString);
                myOutstream.WriteText('   "scheme_name":"' + PatRec."Insurance Name" + '",' + CRLFString);
                myOutstream.WriteText('   "member_number":"' + PatRec."Membership No" + '",' + CRLFString);
                myOutstream.WriteText('   "visit_number":"' + VisitNo + '",' + CRLFString);
                myOutstream.WriteText('   "visit_start":"2018-01-03T00:00:00Z",' + CRLFString);  //Should this format be retained?????
                myOutstream.WriteText('   "visit_end":"2018-01-03T00:00:00Z",' + CRLFString);    //Should this format be retained?????
                myOutstream.WriteText('   "currency":"KES",' + CRLFString);
                myOutstream.WriteText('   "doctor_name":"' + PatCharges."Doctors Name" + '",' + CRLFString);
                myOutstream.WriteText('   "file_version":"0.2",' + CRLFString);                 //Not Clear ???????????????????????
                myOutstream.WriteText('   "diagnosis":[' + CRLFString);
                myOutstream.WriteText('      {' + CRLFString);
                myOutstream.WriteText('         "coding_standard":"icd10",' + CRLFString);
                myOutstream.WriteText('         "code":"' + TxFormDiagnosis."Diagnosis Code" + '",' + CRLFString);
                myOutstream.WriteText('         "name":"' + TxFormDiagnosis."Diagnosis Name" + '",' + CRLFString);
                myOutstream.WriteText('         "is_primary":true' + CRLFString);
                myOutstream.WriteText('      },' + CRLFString);
                myOutstream.WriteText('      {' + CRLFString);
                myOutstream.WriteText('         "coding_standard":"dsmv",' + CRLFString);         //Not Clear ???????????????????????
                myOutstream.WriteText('         "code":"123",' + CRLFString);                     //Not Clear ???????????????????????
                myOutstream.WriteText('         "name":"",' + CRLFString);                        //Not Clear ???????????????????????
                myOutstream.WriteText('         "is_primary":false' + CRLFString);                //Not Clear ???????????????????????
                myOutstream.WriteText('      }' + CRLFString);
                myOutstream.WriteText('   ],' + CRLFString);
                myOutstream.WriteText('   "pre_authorization":[' + CRLFString);
                myOutstream.WriteText('      {' + CRLFString);
                myOutstream.WriteText('         "code":"P150",' + CRLFString);                    //Not Clear ???????????????????????
                myOutstream.WriteText('         "amount":5000,' + CRLFString);                    //Not Clear ???????????????????????
                myOutstream.WriteText('         "authorized_by":"Esther",' + CRLFString);
                myOutstream.WriteText('         "message":"Authorized up to 5000 by Esther"' + CRLFString);
                myOutstream.WriteText('      }' + CRLFString);
                myOutstream.WriteText('   ],' + CRLFString);
                myOutstream.WriteText('   "admission":[' + CRLFString);
                myOutstream.WriteText('      {' + CRLFString);
                myOutstream.WriteText('         "admit_date":"2018-01-03T00:00:00Z",' + CRLFString);
                myOutstream.WriteText('         "discharge_date":"2018-01-03T00:00:00Z",' + CRLFString);
                myOutstream.WriteText('         "discharge_summary":"discharge summary goes here"' + CRLFString);
                myOutstream.WriteText('      }' + CRLFString);
                myOutstream.WriteText('   ],' + CRLFString);
                myOutstream.WriteText('   "invoices":[' + CRLFString);
                myOutstream.WriteText('      {' + CRLFString);
                myOutstream.WriteText('         "amount":' + Format(PatCharges."Total Amount") + ',' + CRLFString);
                myOutstream.WriteText('         "gross_amount":' + Format(PatCharges."Total Amount") + ',' + CRLFString);
                myOutstream.WriteText('         "invoice_date":"2017-07-03T23:59:59",' + CRLFString);
                myOutstream.WriteText('         "invoice_number":"' + PatCharges."Invoice Number" + '",' + CRLFString);
                myOutstream.WriteText('         "service_type":"' + ServiceType + '",' + CRLFString);
            end;
        end;

        Message('Success');
    end;

    local procedure FormateedDate() cdOutDate: Code[10]
    begin
        //2018-01-03T00:00:00Z

        cdOutDate := Format('');
    end;

    local procedure UpdateSmartTable()
    begin
        /*
          OpenSQLConn();

          SQLString := 'Update ExtractValue(Smart_File, ''AdmissionInformation/Benefits/Benefit/Amount'') as patBalance '+
                       'FROM smartlink.exchange_files LIMIT 1 ';

          ADComm.ActiveConnection:=ADOConnection;
          ADComm.CommandText:=SQLString;
          ADComm.CommandType := 1;
          ADComm.CommandTimeout := 0;
          ADComm.Execute;

          CloseSQLConn();
          */
    end;

    procedure CreateHospitalClaimsFileXML(PatNo: Code[20]; VisitNo: Code[20]; SalesNo: Code[20])
    var
        DischargeHD: Record "HMS Admission Discharge Header";
        AdmissionFormHD: Record "HMS Admission Form Header";
        TxFormDiagnosis: Record "HMS Treatment Form Diagnosis";
        txformHD: Record "HMS Treatment Form Header";
        SalesHD: Record "Sales Invoice Header";
        SalesLine: Record "Sales Invoice Line";
        strGender: Code[1];
        ServiceType: Code[10];
        AdmitE_Date: Date;
        AdmitS_Date: Date;
        XML_File: File;
        No_of_Days: Integer;
        ServiceNo: Integer;
        myOutstream: OutStream;
        DCode: Text;
        strAmount: Text;
        Where: Text;
        Which: Text;
        CRLFString: Text[2];
    begin
        //xLF := 13;
        //xCR := 10;
        CRLFString[1] := 13;
        CRLFString[2] := 10;

        //JSONFile.CREATE('C:\COOP BANK\EDI.json');
        XML_File.Create('C:\smart\HospitalClaimsFile.xml');
        //XML_File.CREATE('\\192.168.1.230\Smart2\HospitalClaimsFile.xml');
        XML_File.CreateOutstream(myOutstream);

        SalesHD.Reset();
        SalesHD.SetRange(SalesHD."No.", SalesNo);
        SalesHD.SetRange(SalesHD."Patient No.", PatNo);
        if SalesHD.Find('-') then begin
            PatientRec.Reset();
            PatientRec.SetRange(PatientRec."Patient No.", PatNo);

            if PatientRec.Find('-') then begin
                myOutstream.WriteText('<?xml version="1.0" encoding="UTF-8"?> ' + CRLFString);
                myOutstream.WriteText('<Claim>  ' + CRLFString);
                myOutstream.WriteText('<Claim_Header>   ' + CRLFString);
                myOutstream.WriteText('<Invoice_Number >' + SalesHD."No." + '</Invoice_Number>' + CRLFString);
                myOutstream.WriteText('   <Claim_Date>' + Format(SalesHD."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>') + '</Claim_Date>' + CRLFString);
                myOutstream.WriteText('   <Claim_Time>' + Format(Time, 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>') + '</Claim_Time>' + CRLFString);
                myOutstream.WriteText('   <Pool_Number>1</Pool_Number> ' + CRLFString);  //get serial no
                SalesHD.CalcFields("No of Services");
                myOutstream.WriteText('   <Total_Services>' + Format(SalesHD."No of Services") + '</Total_Services> ' + CRLFString);
                SalesHD.CalcFields("Amount Including VAT");
                myOutstream.WriteText('   <Gross_Amount>0</Gross_Amount> ' + CRLFString);
                myOutstream.WriteText('   <Provider>   ' + CRLFString);
                myOutstream.WriteText('  <Role>SP</Role> ' + CRLFString);
                myOutstream.WriteText('    <Country_Code>KEN</Country_Code> ' + CRLFString);
                myOutstream.WriteText('  <Group_Practice_Number>SKSP_1743</Group_Practice_Number>' + CRLFString);
                myOutstream.WriteText('  <Group_Practice_Name>St. Luke''s Orthopaedic & Trauma Hospital </Group_Practice_Name>' + CRLFString);
                myOutstream.WriteText(' </Provider> ' + CRLFString);
                myOutstream.WriteText('<Authorization> ' + CRLFString);
                myOutstream.WriteText('  <Pre_Authorization_Number>12</Pre_Authorization_Number>' + CRLFString);
                myOutstream.WriteText('  <Pre_Authorization_Amount>0</Pre_Authorization_Amount> ' + CRLFString);
                myOutstream.WriteText(' </Authorization>  ' + CRLFString);
                myOutstream.WriteText('<Payment_Modifiers>' + CRLFString);
                myOutstream.WriteText('  <Payment_Modifier>  ' + CRLFString);
                myOutstream.WriteText('<Type>1</Type> ' + CRLFString);
                myOutstream.WriteText(' <Amount>0</Amount>  ' + CRLFString);
                myOutstream.WriteText('<Receipt>0</Receipt>  ' + CRLFString);
                myOutstream.WriteText('</Payment_Modifier> ' + CRLFString);
                myOutstream.WriteText(' <PaymentModifier>  ' + CRLFString);
                myOutstream.WriteText('<Type>0</Type>' + CRLFString);
                //myOutstream.WRITETEXT('  <NHIF_Member_Nr>0</NHIF_Member_Nr>'+CRLFString);
                myOutstream.WriteText('  <NHIF_Contributor_Nr>0</NHIF_Contributor_Nr>  ' + CRLFString);
                myOutstream.WriteText('<NHIF_Employer_Code>0</NHIF_Employer_Code>  ' + CRLFString);
                myOutstream.WriteText('<NHIF_Site_Nr>0</NHIF_Site_Nr>  ' + CRLFString);
                myOutstream.WriteText('<NHIF_Patient_Relation>MAIN</NHIF_Patient_Relation> ' + CRLFString);

                //---Treatment Form HD -------------------------------------------------------------------------------------------
                txformHD.Reset();
                //txformHD.SETRANGE(txformHD."Treatment No.",VisitNo);
                txformHD.SetRange(txformHD."Patient No.", PatNo);
                if txformHD.Find('-') then begin
                    //---Treatment form Diagnosis ------------------------------------------------------------------------------------
                    TxFormDiagnosis.Reset();
                    TxFormDiagnosis.SetRange(TxFormDiagnosis."Patient No", PatNo);
                    TxFormDiagnosis.SetRange(TxFormDiagnosis."Treatment No.", txformHD."Treatment No.");
                    if TxFormDiagnosis.Find('-') then
                        DCode := TxFormDiagnosis."Diagnosis No.";
                end;

                //Admissions------
                ServiceType := 'OUTPATIENT';
                AdmissionFormHD.Reset();
                AdmissionFormHD.SetRange(AdmissionFormHD."Patient No.", PatNo);
                AdmissionFormHD.SetFilter(AdmissionFormHD.Status, '<>%1', AdmissionFormHD.Status::Cancelled);
                AdmissionFormHD.SetRange(AdmissionFormHD."Link No.", VisitNo);
                if AdmissionFormHD.Find('-') then
                    ServiceType := 'INPATIENT';

                DischargeHD.Reset();
                DischargeHD.SetRange(DischargeHD."Admission No.", AdmissionFormHD."Admission No.");
                DischargeHD.SetRange(DischargeHD."Patient No.", PatNo);
                if DischargeHD.Find('-') then;

                //No of days
                if ServiceType = 'INPATIENT' then begin
                    AdmitS_Date := DischargeHD."Date of Admission";
                    AdmitE_Date := DischargeHD."Discharge Date";
                end else begin
                    AdmitS_Date := SalesHD."Posting Date";
                    AdmitE_Date := SalesHD."Posting Date";
                end;

                No_of_Days := AdmitE_Date - AdmitS_Date;

                myOutstream.WriteText('<Diagnosis_Code>' + DCode + '</Diagnosis_Code>' + CRLFString);
                myOutstream.WriteText('  <Admit_Date>' + Format(AdmitS_Date, 0, '<Year4>-<Month,2>-<Day,2>') + '</Admit_Date>' + CRLFString);
                myOutstream.WriteText('  <Discharge_Date>' + Format(AdmitE_Date, 0, '<Year4>-<Month,2>-<Day,2>') + '</Discharge_Date>' + CRLFString);
                myOutstream.WriteText('  <Days_Used>' + Format(No_of_Days) + '</Days_Used>' + CRLFString);
                myOutstream.WriteText('  <Amount>0</Amount>' + CRLFString);
                myOutstream.WriteText('  </PaymentModifier>  </Payment_Modifiers>  ' + CRLFString);
                myOutstream.WriteText('</Claim_Header> ' + CRLFString);
                myOutstream.WriteText('<Member>  ' + CRLFString);
                //  myOutstream.WriteText('<Membership_Number>'+fnMembershipNo+'</Membership_Number>'+CRLFString);
                myOutstream.WriteText('  <card_serialnumber>' + fnSmartCardNo() + '</card_serialnumber>  ' + CRLFString);
                myOutstream.WriteText(' <Scheme_Code>' + fnmedicalaidnumber() + '</Scheme_Code>' + CRLFString);
                myOutstream.WriteText('  <Scheme_Plan>UAPFINAB</Scheme_Plan>' + CRLFString);
                myOutstream.WriteText('  </Member>  ' + CRLFString);
                myOutstream.WriteText('<Patient>  ' + CRLFString);
                myOutstream.WriteText('<Dependant>N</Dependant>' + CRLFString);
                myOutstream.WriteText('  <First_Name>' + PatientRec.Surname + '</First_Name>' + CRLFString);
                myOutstream.WriteText('  <Middle_Name>' + PatientRec."Middle Name" + '</Middle_Name>' + CRLFString);
                myOutstream.WriteText('  <Surname>' + PatientRec."Last Name" + '</Surname>' + CRLFString);
                myOutstream.WriteText('  <Date_Of_Birth>' + Format(PatientRec."Date Of Birth", 0, '<Year4>-<Month,2>-<Day,2>') + '</Date_Of_Birth>' + CRLFString);
                if PatientRec.Gender = PatientRec.Gender::Male then
                    strGender := 'M'
                else
                    strGender := 'F';
                myOutstream.WriteText('  <Gender>' + strGender + '</Gender>' + CRLFString);
                myOutstream.WriteText('   </Patient>  ' + CRLFString);
            end;
        end;
        //Lines-------------------------------------------------------------------------------------------
        ServiceNo := 0;
        SalesLine.Reset();
        SalesLine.SetRange(SalesLine."Document No.", SalesNo);
        SalesLine.SetRange(SalesLine.PatientNo, PatNo);
        if SalesLine.Find('-') then
            repeat begin
                ServiceNo := ServiceNo + 1;
                myOutstream.WriteText('<Claim_Data>  ' + CRLFString);
                myOutstream.WriteText('<Discharge_Notes>' + DischargeHD.Remarks + '</Discharge_Notes>  ' + CRLFString);
                myOutstream.WriteText('<Service> ' + CRLFString);
                myOutstream.WriteText('  <Number>' + Format(ServiceNo) + '</Number> ' + CRLFString);
                myOutstream.WriteText('  <Invoice_Number>' + Format(SalesNo) + '</Invoice_Number>' + CRLFString);
                myOutstream.WriteText('  <Global_Invoice_Nr>' + Format(SalesNo) + '</Global_Invoice_Nr>' + CRLFString);
                myOutstream.WriteText('  <Start_Date>' + Format(SalesHD."Document Date", 0, '<Year4>-<Month,2>-<Day,2>') + '</Start_Date>  ' + CRLFString);  //Denno
                myOutstream.WriteText('<Start_Time>' + Format(Time, 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>') + '</Start_Time>' + CRLFString);
                myOutstream.WriteText('  <Provider>  ' + CRLFString);
                myOutstream.WriteText('<Role>SP</Role> ' + CRLFString);
                myOutstream.WriteText(' </Provider>   ' + CRLFString);
                myOutstream.WriteText('<Diagnosis>' + CRLFString);
                myOutstream.WriteText('<Stage>P</Stage> ' + CRLFString);
                myOutstream.WriteText('  <Code_Type>ICD10</Code_Type> ' + CRLFString);
                myOutstream.WriteText('  <Code>' + DCode + '</Code> ' + CRLFString);
                myOutstream.WriteText('  </Diagnosis>  ' + CRLFString);
                myOutstream.WriteText('<Encounter_Type>' + SalesHD."Shortcut Dimension 2 Code" + '</Encounter_Type> ' + CRLFString);
                myOutstream.WriteText('   <Code_Type>INTERNAL</Code_Type> ' + CRLFString);
                myOutstream.WriteText('         <Code>' + SalesLine."No." + '</Code>' + CRLFString);
                myOutstream.WriteText('    <Code_Description>' + SalesLine.Description + '</Code_Description> ' + CRLFString);
                myOutstream.WriteText('   <Quantity>' + Format(SalesLine.Quantity) + '</Quantity>  ' + CRLFString);
                strAmount := Format(SalesLine."Amount Including VAT");
                Where := '=';
                Which := ',';
                strAmount := DelChr(strAmount, Where, Which);
                //strAmount := DELSTR(strAmount,'<>',',');
                myOutstream.WriteText('<Total_Amount>' + strAmount + '</Total_Amount>  ' + CRLFString);
                myOutstream.WriteText('<Reason></Reason>  ' + CRLFString);
                myOutstream.WriteText('</Service>  ' + CRLFString);
            end;
            //Lines-------------------------------------------------------------------------------------------
            until SalesLine.Next() = 0;
        myOutstream.WriteText('</Claim_Data>  ' + CRLFString);
        myOutstream.WriteText('</Claim> ' + CRLFString);

        //Move the file
        //XML_File.CREATE('C:\smart\HospitalClaimsFile.xml');
        //XML_File.CREATE('\\192.168.1.230\Smart2\HospitalClaimsFile.xml');

        /*FileName := 'C:\smart\HospitalClaimsFile.xml';
        if FileMgt.ServerFileExists(FileName) then begin
          TempFileName := FileMgt.ServerTempFileName('');
          FileMgt.CopyServerFile(FileName,TempFileName,TRUE);
          */
        Message('Success');
    end;

    procedure fnSmartCardNo() CardSerialNo: Code[100]
    begin
        /*
          OpenSQLConn();

          SQLString := 'SELECT ExtractValue(tttcol, ''AdmissionInformation/A1/card_serialnumber'') as CardSerialNo '+
                       'FROM test.ttt LIMIT 1 ';

          ADComm.ActiveConnection:=ADOConnection;
          ADComm.CommandText:=SQLString;
          ADComm.CommandType := 1;
          ADComm.CommandTimeout := 0;
          ADComm.Execute;

          ADORecordSet.CursorLocation:=3;
          ADORecordSet.Open(ADComm);
          if ADORecordSet.BOF<>true then begin
            ADORecordSet.MoveFirst;
            repeat
               if ADORecordSet.EOF=false then begin
                Evaluate(CardSerialNo,Format(ADORecordSet.Fields.Item(0).Value));
               end;
            until ADORecordSet.EOF=true;
          end;

          CloseSQLConn();
      end;

          procedure fnMembershipNo() MembershipNo: Code[100]
      begin
          OpenSQLConn();

          SQLString := 'SELECT ExtractValue(tttcol, ''AdmissionInformation/A1/card_serialnumber'') as MembershipNo '+
                       'FROM test.ttt LIMIT 1 ';

          ADComm.ActiveConnection:=ADOConnection;
          ADComm.CommandText:=SQLString;
          ADComm.CommandType := 1;
          ADComm.CommandTimeout := 0;
          ADComm.Execute;

          ADORecordSet.CursorLocation:=3;
          ADORecordSet.Open(ADComm);
          if ADORecordSet.BOF<>true then begin
            ADORecordSet.MoveFirst;
            repeat
               if ADORecordSet.EOF=false then begin
                Evaluate(MembershipNo,Format(ADORecordSet.Fields.Item('MembershipNo').Value));
               end;
            until ADORecordSet.EOF=true;
          end;

          CloseSQLConn();
          */
    end;

    procedure fnmedicalaidnumber() SchemNr: Code[100]
    begin
        /*
          OpenSQLConn();

          SQLString := 'SELECT ExtractValue(tttcol, ''AdmissionInformation/A1/card_serialnumber'') as CardSerialNo '+
                       'FROM test.ttt LIMIT 1 ';

          ADComm.ActiveConnection:=ADOConnection;
          ADComm.CommandText:=SQLString;
          ADComm.CommandType := 1;
          ADComm.CommandTimeout := 0;
          ADComm.Execute;

          ADORecordSet.CursorLocation:=3;
          ADORecordSet.Open(ADComm);
          if ADORecordSet.BOF<>true then begin
            ADORecordSet.MoveFirst;
            repeat
               if ADORecordSet.EOF=false then begin
                Evaluate(SchemNr,Format(ADORecordSet.Fields.Item(0).Value));
               end;
            until ADORecordSet.EOF=true;
          end;

          CloseSQLConn();
          */
    end;

    procedure PostChargesDiscount(PatientNo: Code[20]; VisitNo: Code[20]; Amt: Decimal)
    var
        GenJnlLine: Record "Gen. Journal Line";
        Patients: Record "HMS Patient";
        PatientCharges: Record "HMS Patient Charges";
        HMSSetup: Record "HMS Setup";
        JBatch: Code[20];
        JTemplate: Code[20];
        LineNo: Integer;
    begin
        JTemplate := 'General';
        JBatch := 'PCharges';
        GenJnlLine.RESET();
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        if GenJnlLine.FIND('-') then
            GenJnlLine.DELETEALL();

        HMSSetup.GET();
        HMSSetup.TESTFIELD("Cash Control Account");
        HMSSetup.TESTFIELD("Discount Exp. Account");

        Patients.GET(PatientNo);

        LineNo := LineNo + 100;

        GenJnlLine.INIT();
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine."Source Code" := 'CASHRECJNL';
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Posting Date" := TODAY;
        GenJnlLine."Document No." := PatientNo;
        // GenJnlLine."Document Date":="Document Date";
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"G/L Account";
        // if PatientCharges."Insurance No"='' then
        GenJnlLine."Account No." := HMSSetup."Discount Exp. Account";
        // ELSE
        // GenJnlLine."Account No.":=PatientCharges."Insurance No";
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
        GenJnlLine.Description := 'PatientBalance Discount';
        GenJnlLine."External Document No." := VisitNo;
        // GenJnlLine."Currency Code":="Currency Code";
        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
        GenJnlLine.Amount := Amt;
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := HMSSetup."Cash Control Account";
        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        GenJnlLine.Description := PatientCharges."Patient No." + ' -  ' + Patients.Surname + ' ' + Patients."Last Name";
        GenJnlLine."Shortcut Dimension 1 Code" := PatientCharges."Shortcut Dimension 1 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PatientCharges."Shortcut Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        GenJnlLine."Source Code" := PatientNo;
        // GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
        //  GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
        if GenJnlLine.Amount <> 0 then
            GenJnlLine.INSERT();

        // end;

        GenJnlLine.RESET();
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
        if GenJnlLine.FIND('-') then
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Bill", GenJnlLine);
    end;

    procedure Post_Reverse_Charge(DocNo: Code[20]; ExDocNo: Code[20])
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.RESET();
        GLEntry.SETRANGE(GLEntry."Document No.", DocNo);
        GLEntry.SETRANGE(GLEntry."External Document No.", ExDocNo);
        if GLEntry.FIND('-') then
            GLEntry.DELETEALL();
    end;

    procedure Post_Reverse_CustD(DocNo: Code[20]; CustNo: Code[20])

    var
        CustL: Record "Cust. Ledger Entry";
        CustD: Record "Detailed Cust. Ledg. Entry";
    begin
        CustD.RESET();
        CustD.SETRANGE(CustD."Document No.", DocNo);
        CustD.SETRANGE(CustD."Customer No.", CustNo);
        if CustD.FIND('-') then
            CustD.DELETEALL();

        CustL.RESET();
        CustL.SETRANGE(CustL."Document No.", DocNo);
        CustL.SETRANGE(CustL."Customer No.", CustNo);
        if CustL.FIND('-') then
            CustL.DELETEALL();
    end;

    procedure Post_Reverse_GLE(DocNo: Code[20])
    var
        GLEntry: Record "G/L Entry";
    begin
        GLEntry.RESET();
        GLEntry.SETRANGE(GLEntry."Document No.", DocNo);
        if GLEntry.FIND('-') then
            GLEntry.DELETEALL();
    end;

    procedure DeleteReversedSalesInvoice(DocNo: Code[20])
    var
        SalesInvH: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
    begin
        SalesInvLine.RESET();
        SalesInvLine.SETRANGE(SalesInvLine."Document No.", DocNo);
        if SalesInvLine.FIND('-') then
            SalesInvLine.DELETEALL();

        SalesInvH.RESET();
        SalesInvH.SETRANGE(SalesInvH."No.", DocNo);
        if SalesInvH.FIND('-') then
            SalesInvH.DELETE();
    end;

    procedure CreateReceipt(PatientNo: code[20]; VisitNo: code[20])
    var
        CashOfficeSetup: Record "Cash Office Setup";
        DimRec: Record "Dimension Value";
        RecHeader: Record "Receipts Header";
        UserSetup: Record "User Setup";
        NoSeries: Code[20];
        ReceiptNo: code[20];
    begin
        PatRec.get(PatientNo);
        // Check for unused receipt
        RecHeader.reset();
        RecHeader.setrange(Cashier, Database.UserId);
        RecHeader.setrange(Date, Today);
        RecHeader.setrange(Posted, false);
        RecHeader.setfilter("Posted Count", '%1', 0);

        if RecHeader.find('-') then
            ReceiptNo := RecHeader."No.";
        Usersetup.get(Database.UserId);
        if ReceiptNo = '' then begin

            if UserSetup."Branch Code" <> '' then begin
                Dimrec.reset();
                dimrec.setrange(Code, UserSetup."Branch Code");
                if dimrec.find('-') Then
                    NoSeries := Dimrec."Receipt No. Series";
            end;
            if NoSeries = '' then begin
                CashOfficeSetup.get();
                CashOfficeSetup.TestField("Receipts No");
                NoSeries := CashOfficeSetup."Receipts No";
            end;
            ReceiptNo := NoSeriesMgt.GetNextNo(NoSeries, 0D, true);
        end;
        if RecHeader.get(ReceiptNo) then
            RecHeader.DeleteAll();

        RecHeader.init();
        RecHeader."No." := ReceiptNo;
        RecHeader.Date := today;
        RecHeader.Cashier := database."UserID";
        RecHeader."Global Dimension 1 Code" := userSetup."Branch Code";
        RecHeader.validate("Global Dimension 1 Code");
        RecHeader."Shortcut Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
        RecHeader."Patient No." := PatientNo;
        RecHeader.Validate("Patient No.");
        RecHeader."Patient Appointment No" := VisitNo;
        RecHeader.Validate("Patient Appointment No");
        RecHeader."Received From" := PatRec."Search Name";
        RecHeader."On Behalf Of" := PatRec."Search Name";
        RecHeader."Document Date" := today;
        RecHeader."Co-Pay" := false;
        RecHeader.insert();
        if RecHeader.get(ReceiptNo) then begin
            RecHeader.validate("Patient Appointment No");
            page.run(Page::"Receipt Header UP", RecHeader);
        end;
    end;

    procedure ApplyReceiptToCharges(ReceiptNo: Code[20]; PatientNo: Code[20]; VisitNo: Code[20])
    var
        HMSPatientCharges: Record "HMS Patient Charges";
        ReceiptLineq: Record "Receipt Line q";
        HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
        ReceiptsAmount: Decimal;
    begin
        HMSPatientCharges.Reset();
        HMSPatientCharges.SetRange("Patient No.", PatientNo);
        HMSPatientCharges.SetRange("Visit No", VisitNo);
        HMSPatientCharges.SetRange("Transaction Type", 'ZRECEIPT');
        if HMSPatientCharges.FindSet() then begin
            HMSPatientCharges.CalcSums("Total Amount");
        end;

        // HMSPatientCharges.SetFilter(amount);

    end;
}
