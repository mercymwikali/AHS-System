pageextension 85018 "Posted Sales Invoice Ext" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Patient No."; Rec."Patient No.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Patient No. field.';
            }
            field("Patient Name"; Rec."Patient Name")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Patient Name field.';
            }
        }
        addafter("Pre-Assigned No.")
        {
            field(Reversed; Rec.Reversed)
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Reversed field.';
            }
            field("Reversed By"; Rec."Reversed By")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Reversed By field.';
            }
        }
    }

    actions
    {
        modify(Print)
        {
            Visible = true;
            Caption = 'Print Customer Invoice';
        }
        addfirst(Correct)
        {
            action("PrintHMS")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Invoice';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the Print Invoice action.';
                trigger OnAction()
                var
                    HMSPatCharges: Record "HMS Patient Charges";
                begin
                    HMSPatCharges.RESET();
                    HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.", Rec."Patient No.");
                    HMSPatCharges.SETFILTER(HMSPatCharges."Posted Invoice No.", Rec."No.");
                    IF HMSPatCharges.FIND('-') THEN
                        REPORT.RUN(Report::"Final Patient Invoice", TRUE, TRUE, HMSPatCharges);
                end;
            }
            action("PrintHMSNHIF")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Invoice-NHIF';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'Executes the Print Invoice-NHIF action.';
                trigger OnAction()
                var
                    HMSPatCharges: Record "HMS Patient Charges";
                begin
                    HMSPatCharges.RESET();
                    HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.", Rec."Patient No.");
                    HMSPatCharges.SETFILTER(HMSPatCharges."Posted Invoice No.", Rec."No.");
                    IF HMSPatCharges.FIND('-') THEN
                        REPORT.RUN(Report::"Final Patient Invoice-NHIF", TRUE, TRUE, HMSPatCharges);
                end;
            }
            group(Reversal)
            {
                Caption = 'Reversal';

                action("Reverse Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Reserve;
                    Promoted = true;
                    ToolTip = 'Executes the Reverse Invoice action.';

                    trigger OnAction()
                    var
                        PatientCharges: Record "HMS Patient Charges";
                    begin
                        // if UserRec.Get(UserId) then begin
                        //     if UserRec."Can Reverse Sales Invoice" = false then
                        //         Error('Please note that you dont have the rights to reverse the Invoice');
                        // end else
                        //     Error('Please note that you dont have the rights to reverse the Invoice');

                        if Rec.Reversed = true then
                            Error('This invoice has already been reversed');

                        if Confirm('Do you really want to reverse the selected invoice?', false) then begin

                            PostSales.Post_Reverse_Charge(Rec."No.", Rec."Sell-to Customer No.");
                            PostSales.Post_Reverse_CustD(Rec."No.", Rec."Sell-to Customer No.");
                            PostSales.Post_Reverse_GLE(Rec."No.");

                            SaleH.Init();
                            SaleH."Document Type" := SaleH."document type"::Invoice;
                            SaleH."No." := Rec."Pre-Assigned No.";
                            SaleH."Posting Date" := Rec."Posting Date";
                            SaleH."Document Date" := Rec."Posting Date";
                            SaleH."Sell-to Customer No." := Rec."Sell-to Customer No.";
                            SaleH."Bill-to Customer No." := Rec."Sell-to Customer No.";
                            SaleH."Bill-to Name" := Rec."Bill-to Name";
                            SaleH."Sell-to Customer Name" := Rec."Sell-to Customer Name";
                            SaleH."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                            SaleH."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
                            SaleH."Patient No." := Rec."Patient No.";
                            SaleH."Opportunity No." := Rec."No.";
                            SaleH.Insert();

                            SalesInvLine.Reset();
                            SalesInvLine.SetRange(SalesInvLine."Document No.", Rec."No.");
                            if SalesInvLine.Find('-') then
                                repeat
                                    SLine.Init();
                                    SLine."Line No." := SalesInvLine."Line No.";
                                    SLine."Document No." := Rec."Pre-Assigned No.";
                                    SLine."Bill-to Customer No." := Rec."Sell-to Customer No.";
                                    SLine."Document Type" := SaleH."document type"::Invoice;
                                    SLine."Description 2" := SalesInvLine."Description 2";
                                    SLine."Sell-to Customer No." := SalesInvLine."Sell-to Customer No.";
                                    SLine.Type := SLine.Type::"G/L Account";
                                    SLine."No." := SalesInvLine."No.";
                                    SLine.Description := SalesInvLine.Description;
                                    SLine.Quantity := SalesInvLine.Quantity;
                                    SLine.Validate(SLine.Quantity);
                                    SLine."Unit Price" := SalesInvLine."Unit Price";
                                    SLine.Amount := SalesInvLine.Amount;
                                    SLine."Unit Price" := SalesInvLine."Unit Price";
                                    SLine.Validate("Unit Price");
                                    SLine."Gen. Bus. Posting Group" := 'LOCAL';
                                    SLine."Gen. Prod. Posting Group" := 'SERVICES';
                                    // SLine."Charge Code":=;
                                    SLine."Shortcut Dimension 1 Code" := SalesInvLine."Shortcut Dimension 1 Code";
                                    SLine."Shortcut Dimension 2 Code" := SalesInvLine."Shortcut Dimension 2 Code";
                                    SLine.Insert();
                                until SalesInvLine.Next() = 0;

                            Message('Invoice Reversed Successfuly');
                            if SaleH.Get(SaleH."document type"::Invoice, Rec."Pre-Assigned No.") then
                                Page.Run(43, SaleH);

                            // Update Patient Charges
                            PatientCharges.reset();
                            PatientCharges.setrange("Patient No.", Rec."Patient No.");
                            PatientCharges.setrange("Visit No", Rec."Appointment No");
                            PatientCharges.setfilter("Posted Invoice No.", '%1', Rec."No.");
                            if PatientCharges.find('-') then
                                repeat
                                    PatientCharges."Invoice ID" := '';
                                    PatientCharges.modify();
                                until PatientCharges.next() = 0;
                            // Delete the Posted Invoice
                            PostSales2.DeleteReversedSalesInvoice(Rec."No.");
                        end;
                    end;
                }
                action("Mark As Return")
                {
                    ApplicationArea = Basic, Suite;
                    Image = TransferFunds;
                    ToolTip = 'Executes the Mark As Return action.';
                    trigger OnAction()
                    begin
                        if Confirm('Do you really want to Return the Invoice for Dispatch?') then begin
                            Rec.Dispatched := false;
                            Rec.modify();
                        end;
                    end;
                }
            }
            group("SmartLink")
            {
                Caption = 'SmartLink Integration';
                action("Post to Smart")
                {
                    ApplicationArea = Basic, Suite;
                    Image = PostApplication;
                    Promoted = true;
                    ToolTip = 'Executes the Post to Smart action.';

                    trigger OnAction()
                    var
                        SalesLine: Record "Sales Invoice Line";
                        Window: Dialog;
                    begin
                        Window.Open('Copying Invoice Details...');
                        SalesLine.reset();
                        SalesLine.setrange("Document No.", Rec."No.");
                        if SalesLine.find('-') then
                            repeat
                                //send data to smartlink
                                InsertSmartInvoices(Rec."Patient No.", Rec."No.");
                            until SalesLine.Next() = 0;
                        Window.Close();
                        // PostSmartInvoice(Rec."Patient No.", Rec."No.")
                    end;
                }
            }
        }
    }

    var
        SaleH: Record "Sales Header";

        SalesInvLine: Record "Sales Invoice Line";
        SLine: Record "Sales Line";
        UserRec: Record "User Setup";
        PostSales: Codeunit "HMS Patient-integration";
        PostSales2: Codeunit "HMS Patient-integration";
        JsonObject: JsonObject;
        HttpHeaders: HttpHeaders;

    local procedure InsertSmartInvoices(PatientNo: Code[20]; InvoiceNo: Code[20])
    var
        HMSPatCharges: Record "HMS Patient Charges";
        SmartInvoices: Record "Smart Invoices";
        LineNo: Integer;
    begin
        SmartInvoices.RESET();
        SmartInvoices.SETRANGE(SmartInvoices."Document No", InvoiceNo);
        SmartInvoices.SETRANGE(SmartInvoices."Patient No", PatientNo);
        SmartInvoices.SETRANGE(SmartInvoices.Posted, FALSE);
        IF SmartInvoices.FIND('-') THEN
            SmartInvoices.DELETEALL();

        SmartInvoices.RESET();
        IF SmartInvoices.FIND('+') THEN
            LineNo := SmartInvoices.EntryNo;

        HMSPatCharges.RESET();
        HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.", PatientNo);
        HMSPatCharges.SETRANGE(HMSPatCharges."Invoice Number", InvoiceNo);
        IF HMSPatCharges.FIND('-') THEN
            REPEAT
                LineNo := LineNo + 1;
                SmartInvoices.INIT();
                SmartInvoices.EntryNo := LineNo;
                SmartInvoices."Document No" := InvoiceNo;
                SmartInvoices."Patient No" := PatientNo;
                SmartInvoices."Invoice Date" := HMSPatCharges.Date;
                SmartInvoices."Invoice Time" := TIME;
                IF HMSPatCharges.Quantity > 0 THEN
                    SmartInvoices.Quantity := HMSPatCharges.Quantity
                ELSE
                    SmartInvoices.Quantity := 1;
                SmartInvoices."Encounter Type" := HMSPatCharges."Transaction Type";
                SmartInvoices.Code := HMSPatCharges.Code;
                SmartInvoices."Code Description" := HMSPatCharges.Description;
                SmartInvoices."Line Amount" := HMSPatCharges.Amount;
                SmartInvoices.INSERT(TRUE);
            UNTIL HMSPatCharges.NEXT() = 0;
    end;

    procedure ClearObjects()
    begin
        Clear(JsonObject);
        Clear(HttpHeaders);
    end;

    // local procedure PostSmartInvoice(PatientNo: Code[20]; InvoiceNo: Code[20]) Ret: Boolean
    // var
    //     HmsSetup: Record "HMS Setup";
    //     RESTWSManagement: Codeunit "REST WS Management";
    //     ReturnValue: Boolean;
    //     Window: Dialog;
    //     encoding: DotNet Encoding;
    //     HttpResponseMessage: HttpResponseMessage;
    //     httpUtility: DotNet HttpUtility;
    //     stringContent: DotNet StringContent;
    //     data: Text;
    //     HttpContent: HttpContent;
    //     HttpClient: HttpClient;
    //     Resp: Text;



    // begin
    //     ClearObjects();
    //     Ret := false;
    //     Window.OPEN('Posting to Smart...');
    //     JsonObject.add('patient', PatientNo);
    //     JsonObject.add('invoiceno', InvoiceNo);

    //     // data += 'patient=' + httpUtility.UrlEncode(PatientNo, encoding.GetEncoding('ISO-8859-1'));
    //     // data += 'invoiceno=' + httpUtility.UrlEncode(InvoiceNo, encoding.GetEncoding('ISO-8859-1'));

    //     // stringContent := stringContent.StringContent(data, encoding.UTF8, 'application/x-www-form-urlencoded');
    //     HmsSetup.Get();

    //     JsonObject.WriteTo(data);

    //     HttpContent.WriteFrom(Data);

    //     HttpHeaders.Remove('Content-Headers');
    //     HttpHeaders.Add('Content-Headers', 'application/x-www-form-urlencoded');


    //     HttpClient.Post('http://192.168.88.62:881/smart/invoice.php', HttpContent, HttpResponseMessage);
    //     if not HttpResponseMessage.IsSuccessStatusCode then
    //         Error('Error occured %1', HttpResponseMessage.Content.ReadAs(Resp))
    //     else
    //         ReturnValue := true;

    //     // ReturnValue := RESTWSManagement.CallRESTWebService('http://192.168.88.62:881/smart/invoice.php',
    //     //                                                    '',
    //     //                                                    'POST',
    //     //                                                    stringContent,
    //     //                                                    HttpResponseMessage);

    //     Window.Close();
    //     Ret := true;
    //     Message('Success');
    // end;

}