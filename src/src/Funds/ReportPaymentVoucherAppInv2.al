report 52202606 "Payment Voucher App Inv2"
{
    // version FUNDS

    DefaultLayout = RDLC;
    RDLCLayout = './Payment Voucher App Inv2.rdl';

    dataset
    {
        dataitem("Payments Header"; "Payments Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(BankCriteria_PaymentsHeader; "Payments Header"."Pay Mode")
            {
            }
            column(DOCNAME; DOCNAME)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress2; CompInfo."Address 2")
            {
            }
            column(CompInfoPostCode; CompInfo."Post Code")
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPhoneNo; CompInfo."Phone No.")
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(CompInfoHomePage; CompInfo."Home Page")
            {
            }
            column(Payments_Header__No__; "No.")
            {
            }
            column(CurrCode; CurrCode)
            {
            }
            column(StrCopyText; StrCopyText)
            {
            }
            column(Payments_Header__Cheque_No__; "Cheque No.")
            {
            }
            column(Payments_Header_Payee; "Payments Header".Payee)
            {
            }
            column(Payments_Header__Payments_Header__Date; "Payments Header".Date)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(Payments_Header__Shortcut_Dimenssion_2_Code_; "Shortcut Dimension 2 Code")
            {
            }
            column(BankName_PaymentsHeader; "Bank Name")
            {
            }
            column(USERID; USERID)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(TTotal; TTotal)
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + FORMAT(TIME))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + FORMAT(TODAY, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(CurrCode_Control1102756010; CurrCode)
            {
            }
            column(CurrCode_Control1102756012; CurrCode)
            {
            }
            column(Approved_; 'Approved')
            {
                AutoFormatType = 1;
            }
            column(cashier; Cashier)
            {
            }
            column(Approval_Status_____; 'Approval Status' + ':')
            {
                AutoFormatType = 1;
            }
            column(TIME_PRINTED_____FORMAT_TIME__Control1102755003; 'TIME PRINTED:' + FORMAT(TIME))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4__Control1102755004; 'DATE PRINTED:' + FORMAT(TODAY, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(USERID_Control1102755012; USERID)
            {
            }
            column(NumberText_1__Control1102755016; NumberText[1])
            {
            }
            column(TTotal_Control1102755034; TTotal)
            {
            }
            column(CurrCode_Control1102755035; CurrCode)
            {
            }
            column(CurrCode_Control1102755037; CurrCode)
            {
            }
            column(VATCaption; VATCaptionLbl)
            {
            }
            column(PAYMENT_DETAILSCaption; PAYMENT_DETAILSCaptionLbl)
            {
            }
            column(AMOUNTCaption; AMOUNTCaptionLbl)
            {
            }
            column(NET_AMOUNTCaption; NET_AMOUNTCaptionLbl)
            {
            }
            column(W_TAXCaption; W_TAXCaptionLbl)
            {
            }
            column(Document_No___Caption; Document_No___CaptionLbl)
            {
            }
            column(Currency_Caption; Currency_CaptionLbl)
            {
            }
            column(Payment_To_Caption; Payment_To_CaptionLbl)
            {
            }
            column(Document_Date_Caption; Document_Date_CaptionLbl)
            {
            }
            column(Cheque_No__Caption; Cheque_No__CaptionLbl)
            {
            }
            column(Payments_Header__Global_Dimension_1_Code_Caption; FIELDCAPTION("Global Dimension 1 Code"))
            {
            }
            column(Payments_Header__Shortcut_Dimension_2_Code_Caption; FIELDCAPTION("Shortcut Dimension 2 Code"))
            {
            }
            column(R_CENTERCaption; R_CENTERCaptionLbl)
            {
            }
            column(PROJECTCaption; PROJECTCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Printed_By_Caption; Printed_By_CaptionLbl)
            {
            }
            column(Amount_in_wordsCaption; Amount_in_wordsCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(name; name)
            {
            }
            column(PaymentNarration_PaymentsHeader; "Payments Header"."Payment Narration")
            {
            }
            column(names; "name+")
            {
            }
            column(addr; addr)
            {
            }
            column(email; email)
            {
            }
            column(PIN; PIN)
            {
            }
            column(VAT; VAT)
            {
            }
            column(lpo; no)
            {
            }
            column(ret; ret)
            {
            }
            column(appliedinv; appliedinv)
            {
            }
            column(co; confir)
            {
            }
            column(next1; next1)
            {
            }
            column(DATE; dat)
            {
            }
            column(CHECKED; checked)
            {
            }
            column(PREPARED; PREPARE)
            {
            }
            column(APPROVED; appr)
            {
            }
            column(com; confirma)
            {
            }
            column(internal; internalAM)
            {
            }
            column(paymentapp; paymentapp)
            {
            }
            column(md; md)
            {
            }
            column(authorized; Authorized)
            {
            }
            column(emptystr; emptystr)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102755013; EmptyStringCaption_Control1102755013Lbl)
            {
            }
            column(Amount_in_wordsCaption_Control1102755021; Amount_in_wordsCaption_Control1102755021Lbl)
            {
            }
            column(Printed_By_Caption_Control1102755026; Printed_By_Caption_Control1102755026Lbl)
            {
            }
            column(finance_controller; fincont)
            {
            }
            column(Accountant; accntnt)
            {
            }
            column(TotalCaption_Control1102755033; TotalCaption_Control1102755033Lbl)
            {
            }
            dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Unapplied = FILTER(false), "Initial Document Type" = filter(Invoice | ' '));
                column(ExternalDocumentNo_VendorLedgerEntry; "Detailed Vendor Ledg. Entry"."External No")
                {
                }
                column(EntryNo_VendorLedgerEntry; "Detailed Vendor Ledg. Entry"."Entry No.")
                {
                }
                column(VendorNo_VendorLedgerEntry; VenNM)
                {
                }
                column(Document_Type; "Document Type")
                {
                }
                column(Entry_Type; "Entry Type")
                {
                }
                column(Initial_Document_Type; "Initial Document Type")
                {
                }
                column(PostingDate_VendorLedgerEntry; "Detailed Vendor Ledg. Entry"."Posting Date")
                {
                }
                column(DocumentNo_VendorLedgerEntry; "Detailed Vendor Ledg. Entry"."Doc No")
                {
                }
                column(Description_VendorLedgerEntry; "Detailed Vendor Ledg. Entry".Description)
                {
                }
                column(Amount_VendorLedgerEntry; "Detailed Vendor Ledg. Entry".Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Detailed Vendor Ledg. Entry".CALCFIELDS(Description);
                    "Detailed Vendor Ledg. Entry".CALCFIELDS("External No");
                    "Detailed Vendor Ledg. Entry".CALCFIELDS("Doc No");

                    VenNM := '';
                    VendLedger.RESET();
                    VendLedger.SETRANGE(VendLedger."No.", "Payments Header"."No.");
                    IF VendLedger.FIND('-') THEN
                        VenNM := VendLedger.Name;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.GET();
                CompInfo.CALCFIELDS(Picture);

                StrCopyText := '';
                IF "No. Printed" >= 1 THEN
                    StrCopyText := 'DUPLICATE';
                TTotal := 0;

                IF "Payments Header"."Payment Type" = "Payments Header"."Payment Type"::Normal THEN
                    DOCNAME := 'PAYMENT VOUCHER'
                ELSE
                    DOCNAME := 'PETTY CASH VOUCHER';

                //Set currcode to Default if blank
                GLSetup.GET();
                IF "Payments Header"."Currency Code" = '' THEN
                    CurrCode := GLSetup."LCY Code"
                ELSE
                    CurrCode := "Payments Header"."Currency Code";

                //For Inv Curr Code
                IF "Payments Header"."Invoice Currency Code" = '' THEN
                    InvoiceCurrCode := GLSetup."LCY Code"
                ELSE
                    InvoiceCurrCode := "Payments Header"."Invoice Currency Code";

                //End;
                CALCFIELDS("Total Payment Amount", "Total Witholding Tax Amount");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, ("Total Payment Amount" - "Total Witholding Tax Amount"), '');
            end;

            trigger OnPostDataItem()
            begin
                IF CurrReport.PREVIEW = FALSE THEN BEGIN
                    "No. Printed" := "No. Printed" + 1;
                    MODIFY();
                END;
            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FIELDNO("No.");
                CompInfo.GET();
                CompInfo.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        VendLedger: Record Vendor;
        CheckReport: Report Check;
        CurrCode: Code[10];
        InvoiceCurrCode: Code[10];
        TTotal: Decimal;
        LastFieldNo: Integer;
        accntnt: Label 'Accountant:';
        addr: Label 'P.O BOX 30746 00100, Tel.+254-020-2247277,3620000, Fax +254020-3100223';
        Amount_in_wordsCaption_Control1102755021Lbl: Label 'Amount in words';
        Amount_in_wordsCaptionLbl: Label 'Amount in words';
        AMOUNTCaptionLbl: Label 'AMOUNT';
        appliedinv: Label 'Applied Invoice(s) Details';
        appr: Label 'APPROVED .';
        Authorized: Label 'Authorized.';
        checked: Label 'CHECKED .';
        Cheque_No__CaptionLbl: Label 'Cheque No.:';
        confir: Label 'I confirm accuracy and authenticity of the payment and that this expenditure has been entered in the votebook and is sufficiently covered.';
        confirma: Label 'CONFIRMED .';
        Currency_CaptionLbl: Label 'Currency:';
        dat: Label 'DATE:.';
        Date_CaptionLbl: Label 'Date:';
        Document_Date_CaptionLbl: Label 'Document Date:';
        Document_No___CaptionLbl: Label 'Document No. :';
        email: Label 'Nairobi,Kenya.Email info@kicc.co.ke,Website:www.kicc.co.ke';
        fincont: Label 'Financial Controller:';
        internalAM: Label 'Internal Audit Manage';
        md: Label 'Managing Director:';
        name: Label 'THE KENYATTA INTERNATIONAL CONFERENCE CENTRE';
        Name_CaptionLbl: Label 'Name:';
        "name+": Label '(CORPORATION)';
        NET_AMOUNTCaptionLbl: Label 'NET AMOUNT';
        next1: Label 'has been entered in the votebook and is sufficiently covered.';
        no: Label 'L.P.O/L.S.O';
        PAYMENT_DETAILSCaptionLbl: Label 'PAYMENT DETAILS';
        Payment_To_CaptionLbl: Label 'Payment To:';
        paymentapp: Label 'Payment Approved:';
        PIN: Label 'PIN:';
        PREPARE: Label 'PREPARE .';
        Printed_By_Caption_Control1102755026Lbl: Label 'Printed By:';
        Printed_By_CaptionLbl: Label 'Printed By:';
        PROJECTCaptionLbl: Label 'PROJECT';
        R_CENTERCaptionLbl: Label 'R.CENTER';
        RecipientCaptionLbl: Label 'Recipient';
        ret: Label 'Retention';
        Signature_CaptionLbl: Label 'Signature:';
        TotalCaption_Control1102755033Lbl: Label 'Total';
        TotalCaptionLbl: Label 'Total';
        VAT: Label 'VAT:';
        VATCaptionLbl: Label 'VAT';
        W_TAXCaptionLbl: Label 'W/TAX';
        VenNM: Text;
        DOCNAME: Text[30];
        StrCopyText: Text[30];
        NumberText: array[2] of Text[80];
        emptystr: TextConst ENU = '========================================================================================================================================';
        EmptyStringCaption_Control1102755013Lbl: TextConst ENU = '================================================================================================================================================================================================';
        EmptyStringCaptionLbl: TextConst ENU = '================================================================================================================================================================================================';
}
