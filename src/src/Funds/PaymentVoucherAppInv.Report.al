Report 52202607 "Payment Voucher App Inv"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PaymentVoucherAppInv.rdl';

    dataset
    {
        dataitem("Payments Header"; "Payments Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_6437; 6437)
            {
            }
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
            column(Payments_Header_Payee; Payee)
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
            column(UserId; UserId)
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(TTotal; TTotal)
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + Format(Today, 0, 4))
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
            column(TIME_PRINTED_____FORMAT_TIME__Control1102755003; 'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4__Control1102755004; 'DATE PRINTED:' + Format(Today, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(USERID_Control1102755012; UserId)
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
            column(Payments_Header__Global_Dimension_1_Code_Caption; FieldCaption("Global Dimension 1 Code"))
            {
            }
            column(Payments_Header__Shortcut_Dimension_2_Code_Caption; FieldCaption("Shortcut Dimension 2 Code"))
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
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Applies-to ID" = field("No.");
                DataItemTableView = where(Amount = filter(<> 0));
                column(ReportForNavId_5; 5)
                {
                }
                column(ExternalDocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(EntryNo_VendorLedgerEntry; "Vendor Ledger Entry"."Entry No.")
                {
                }
                column(VendorNo_VendorLedgerEntry; VenNM)
                {
                }
                column(PostingDate_VendorLedgerEntry; "Vendor Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Description_VendorLedgerEntry; "Vendor Ledger Entry".Description)
                {
                }
                column(Amount_VendorLedgerEntry; "Vendor Ledger Entry".Amount)
                {
                }
                column(amount; "Vendor Ledger Entry"."Amount to Apply")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    VenNM := '';
                    VendLedger.Reset();
                    VendLedger.SetRange(VendLedger."No.", "Payments Header"."No.");
                    if VendLedger.Find('-') then
                        VenNM := VendLedger.Name;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.Get();
                CompInfo.CalcFields(Picture);

                StrCopyText := '';
                if "No. Printed" >= 1 then
                    StrCopyText := 'DUPLICATE';
                TTotal := 0;

                if "Payments Header"."Payment Type" = "Payments Header"."payment type"::Normal then
                    DOCNAME := 'PAYMENT VOUCHER'
                else
                    DOCNAME := 'PETTY CASH VOUCHER';

                //Set currcode to Default if blank
                GLSetup.Get();
                if "Payments Header"."Currency Code" = '' then
                    CurrCode := GLSetup."LCY Code"
                else
                    CurrCode := "Payments Header"."Currency Code";

                //For Inv Curr Code
                if "Payments Header"."Invoice Currency Code" = '' then
                    InvoiceCurrCode := GLSetup."LCY Code"
                else
                    InvoiceCurrCode := "Payments Header"."Invoice Currency Code";

                //End;
                CalcFields("Total Payment Amount", "Total Witholding Tax Amount");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, ("Total Payment Amount" - "Total Witholding Tax Amount"), '');
            end;

            trigger OnPostDataItem()
            begin
                if CurrReport.Preview = false then begin
                    "No. Printed" := "No. Printed" + 1;
                    Modify();
                end;
            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FieldNo("No.");
                CompInfo.Get();
                CompInfo.CalcFields(Picture);
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
        accntnt: label 'Accountant:';
        addr: label 'P.O BOX 30746 00100, Tel.+254-020-2247277,3620000, Fax +254020-3100223';
        Amount_in_wordsCaption_Control1102755021Lbl: label 'Amount in words';
        Amount_in_wordsCaptionLbl: label 'Amount in words';
        AMOUNTCaptionLbl: label 'AMOUNT';
        appliedinv: label 'Applied Invoice(s) Details';
        appr: label 'APPROVED .';
        Authorized: label 'Authorized.';
        checked: label 'CHECKED .';
        Cheque_No__CaptionLbl: label 'Cheque No.:';
        confir: label 'I confirm accuracy and authenticity of the payment and that this expenditure has been entered in the votebook and is sufficiently covered.';
        confirma: label 'CONFIRMED .';
        Currency_CaptionLbl: label 'Currency:';
        dat: label 'DATE:.';
        Date_CaptionLbl: label 'Date:';
        Document_Date_CaptionLbl: label 'Document Date:';
        Document_No___CaptionLbl: label 'Document No. :';
        email: label 'Nairobi,Kenya.Email info@kicc.co.ke,Website:www.kicc.co.ke';
        emptystr: label '========================================================================================================================================';
        EmptyStringCaption_Control1102755013Lbl: label '================================================================================================================================================================================================';
        EmptyStringCaptionLbl: label '================================================================================================================================================================================================';
        fincont: label 'Financial Controller:';
        md: label 'Managing Director:';
        name: label 'THE KENYATTA INTERNATIONAL CONFERENCE CENTRE';
        Name_CaptionLbl: label 'Name:';
        "name+": label '(CORPORATION)';
        NET_AMOUNTCaptionLbl: label 'NET AMOUNT';
        next1: label 'has been entered in the votebook and is sufficiently covered.';
        no: label 'L.P.O/L.S.O';
        PAYMENT_DETAILSCaptionLbl: label 'PAYMENT DETAILS';
        Payment_To_CaptionLbl: label 'Payment To:';

        paymentapp: label 'Payment Approved:';
        PIN: label 'PIN:';
        PREPARE: label 'PREPARE .';
        Printed_By_Caption_Control1102755026Lbl: label 'Printed By:';
        Printed_By_CaptionLbl: label 'Printed By:';
        PROJECTCaptionLbl: label 'PROJECT';
        R_CENTERCaptionLbl: label 'R.CENTER';
        RecipientCaptionLbl: label 'Recipient';
        ret: label 'Retention';
        Signature_CaptionLbl: label 'Signature:';
        TotalCaption_Control1102755033Lbl: label 'Total';
        TotalCaptionLbl: label 'Total';
        VAT: label 'VAT:';
        VATCaptionLbl: label 'VAT';
        W_TAXCaptionLbl: label 'W/TAX';
        VenNM: Text;
        DOCNAME: Text[30];
        StrCopyText: Text[30];
        NumberText: array[2] of Text[80];
}
