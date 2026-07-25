Report 85190 "HMS Shift Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSShiftReport.rdl';

    dataset
    {
        dataitem("Split Receipt Buffer"; "Split Receipt Buffer")
        {
            RequestFilterFields = "Date Posted", "Branch Code", "Posted By", "Receipt No", "Patient No";
            column(ReportForNavId_1; 1)
            {
            }
            column(Receipt_No; "Receipt No")
            {
            }
            column(Pay_Mode; "Pay Mode")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Bank_Account_No; "Bank Account No")
            {
            }
            column(Transaction_No; "Transaction No")
            {
            }
            column(Transaction_Type; "Transaction Type")
            {
            }
            column(Patient_No; "Patient No")
            {
            }
            column(Visit_No; "Visit No")
            {
            }
            column(Date_Posted; "Date Posted")
            {
            }
            column(Posted_By; "Posted By")
            {
            }
            column(Branch_Code; "Branch Code")
            {
            }
            column(Time_Posted; "Time Posted")
            {
            }
            column(Patient_Name; "Patient Name")
            {
            }
            column(CompLogo; CompINf.Picture)
            {
            }
            column(CompName; CompINf.Name)
            {
            }
            column(LogoName; CompINf.Picture)
            {
            }
            column(CompInfAddress; CompINf.Address)
            {
            }
            column(CompInfAddress2; CompINf."Address 2")
            {
            }
            column(CompInfPhone; CompINf."Phone No.")
            {
            }
            column(Cemail; CompINf."E-Mail")
            {
            }
            column(chomepage; CompINf."Home Page")
            {
            }
            column(SchemeName; SchemeName)
            {
            }
            column(Cash; Cash)
            {
            }
            column(Mpesa; Mpesa)
            {
            }
            column(Cheque; Cheque)
            {
            }
            column(EFT; EFT)
            {
            }
            column(Deposit; "Deposit Slip")
            {
            }
            column(BankersCheq; "Banker's Cheque")
            {
            }
            column(RTGS; RTGS)
            {
            }

            trigger OnAfterGetRecord()
            begin
            end;

            trigger OnPreDataItem()
            begin
                CompINf.Get();
                CompINf.CalcFields(Picture);
                Buffer.Reset();
                Buffer.DeleteAll();
                ReqLine.Reset();
                ReqLine.SetFilter(ReqLine."Date Posted", "Split Receipt Buffer".GetFilter("Date Posted"));
                ReqLine.SetFilter(ReqLine."Split Exits", '%1', true);
                ReqLine.SetFilter(ReqLine."Global Dimension 1 Code", "Split Receipt Buffer".GetFilter("Branch Code"));
                ReqLine.SetFilter(ReqLine."Posting Time", "Split Receipt Buffer".GetFilter("Time Posted"));
                ReqLine.SetFilter(ReqLine."Posted User", "Split Receipt Buffer".GetFilter("Posted By"));
                ReqLine.SetFilter(ReqLine."Header Posted", '%1', true);
                ReqLine.SetFilter(ReqLine.Reversed, '%1', false);
                if ReqLine.Find('-') then
                    repeat
                        ReceiptSplit.reset();
                        ReceiptSplit.setrange(ReceiptSplit."Receipt No", ReqLine.No);

                        if ReceiptSplit.find('-') then
                            repeat
                                ReceiptsHeader.Get(ReceiptSplit."Receipt No");
                                Buffer.Init();
                                Buffer."Receipt No" := ReqLine.No;
                                Buffer."Pay Mode" := ReceiptSplit."Pay Mode";
                                Buffer.Amount := ReceiptSplit.Amount;
                                Buffer."Bank Account No" := ReceiptSplit."Bank Account No";
                                Buffer."Transaction No" := ReceiptSplit."Transaction No";
                                Buffer."Transaction Name" := ReqLine."Transaction Name";
                                Buffer."Transaction Type" := ReqLine."HSM Transaction Type";
                                Buffer."Patient No" := ReqLine."Patient No";
                                Buffer."Visit No" := ReceiptsHeader."Patient Appointment No";
                                Buffer."Date Posted" := ReqLine."Date Posted";
                                Buffer."Posted By" := ReqLine."Posted By";
                                Buffer."Time Posted" := ReqLine."Time Posted";
                                Buffer."Patient Name" := ReceiptsHeader."On Behalf Of";
                                Buffer."Receipt Line No" := ReqLine."Line No.";
                                Buffer."Branch Code" := ReqLine."Global Dimension 1 Code";
                                Buffer.Insert();
                            until ReceiptSplit.Next() = 0;
                        ReqLine."Buffer Report" := true;
                    //  ReqLine.Modify();
                    until ReqLine.Next() = 0;

                ReqLine.Reset();
                ReqLine.setrange(ReqLine."Date Posted", "Date Posted");
                ReqLine.SetFilter(ReqLine."Split Exits", '%1', false);
                // ReqLine.setrange(ReqLine."Buffer Report", false);
                if ReqLine.Find('-') then
                    repeat
                        ReceiptsHeader.Get(ReceiptSplit."Receipt No");
                        Buffer.Init();
                        Buffer."Receipt No" := ReqLine.No;
                        Buffer."Pay Mode" := ReqLine."Pay Mode";
                        Buffer.Amount := ReqLine.Amount;
                        Buffer."Bank Account No" := ReqLine."Bank Account";
                        Buffer."Transaction No" := ReqLine."Transaction No.";
                        Buffer."Transaction Name" := ReqLine."Transaction Name";
                        Buffer."Transaction Type" := ReqLine."HSM Transaction Type";
                        Buffer."Patient No" := ReqLine."Patient No";
                        Buffer."Visit No" := ReceiptsHeader."Patient Appointment No";
                        Buffer."Date Posted" := ReqLine."Date Posted";
                        Buffer."Posted By" := ReqLine."Posted By";
                        Buffer."Time Posted" := ReqLine."Time Posted";
                        Buffer."Patient Name" := ReceiptsHeader."On Behalf Of";
                        Buffer."Receipt Line No" := ReqLine."Line No.";
                        Buffer."Branch Code" := ReqLine."Global Dimension 1 Code";
                        Buffer.Insert();
                        ReqLine."Buffer Report" := true;
                    //  ReqLine.Modify();
                    until ReqLine.Next() = 0;
                ///// Calcaulate totals
                // ReqLine := "Receipt No";
                ReqLine.SetFilter(ReqLine.Date, "Split Receipt Buffer".GetFilter("Date Posted"));
                ReqLine.SetFilter(ReqLine."Global Dimension 1 Code", "Split Receipt Buffer".GetFilter("Branch Code"));
                ReqLine.SetFilter(ReqLine."Posting Time", "Split Receipt Buffer".GetFilter("Time Posted"));
                ReqLine.SetFilter(ReqLine."Posted User", "Split Receipt Buffer".GetFilter("Posted By"));
                ReqLine.SetFilter(ReqLine."Header Posted", '%1', true);
                ReqLine.SetFilter(ReqLine.Reversed, '%1', false);
                ReqLine.SetFilter(ReqLine."Split Exits", '%1', false);
                if ReqLine.Find('-') then
                    repeat
                        if ((ReqLine."Pay Mode" = ReqLine."pay mode"::PDQ) or (ReqLine."Pay Mode" = ReqLine."pay mode"::PDQ)) then
                            "Banker's Cheque" := "Banker's Cheque" + ReqLine.Amount;
                        if ReqLine."Pay Mode" = ReqLine."pay mode"::Cash then
                            Cash := Cash + ReqLine.Amount;
                        if ReqLine."Pay Mode" = ReqLine."pay mode"::MPESA then
                            Mpesa := Mpesa + ReqLine.Amount;
                        if ReqLine."Pay Mode" = ReqLine."pay mode"::Cheque then
                            Cheque := Cheque + ReqLine.Amount;
                        if ReqLine."Pay Mode" = ReqLine."pay mode"::"Deposit Slip" then
                            "Deposit Slip" := "Deposit Slip" + ReqLine.Amount;
                        if ReqLine."Pay Mode" = ReqLine."pay mode"::EFT then
                            EFT := EFT + ReqLine.Amount;
                        if ReqLine."Pay Mode" = ReqLine."pay mode"::RTGS then
                            EFT := EFT + ReqLine.Amount;
                    until ReqLine.Next() = 0;

                // Get from Split Receipts
                //  ReqLine := "Split Receipt Buffer";
                ReqLine.SetFilter(ReqLine.Date, "Split Receipt Buffer".GetFilter("Date Posted"));
                ReqLine.SetFilter(ReqLine."Global Dimension 1 Code", "Split Receipt Buffer".GetFilter("Branch Code"));
                ReqLine.SetFilter(ReqLine."Posting Time", "Split Receipt Buffer".GetFilter("Time Posted"));
                ReqLine.SetFilter(ReqLine."Posted User", "Split Receipt Buffer".GetFilter("Posted By"));
                ReqLine.SetFilter(ReqLine."Header Posted", '%1', true);
                ReqLine.SetFilter(ReqLine.Reversed, '%1', false);
                ReqLine.SetFilter(ReqLine."Split Exits", '%1', true);
                if ReqLine.Find('-') then
                    repeat
                        ReceiptSplit.reset();
                        ReceiptSplit.setrange("Receipt No", ReqLine.No);
                        if ReceiptSplit.find('-') then
                            repeat
                                if ((ReceiptSplit."Pay Mode" = ReceiptSplit."pay mode"::PDQ) or (ReceiptSplit."Pay Mode" = ReceiptSplit."pay mode"::PDQ)) then
                                    "Banker's Cheque" := "Banker's Cheque" + ReceiptSplit.Amount;
                                if ReceiptSplit."Pay Mode" = ReceiptSplit."pay mode"::Cash then
                                    Cash := Cash + ReceiptSplit.Amount;
                                if ReceiptSplit."Pay Mode" = ReceiptSplit."pay mode"::MPESA then
                                    Mpesa := Mpesa + ReceiptSplit.Amount;
                                if ReceiptSplit."Pay Mode" = ReceiptSplit."pay mode"::Cheque then
                                    Cheque := Cheque + ReceiptSplit.Amount;
                                if ReceiptSplit."Pay Mode" = ReceiptSplit."pay mode"::"Deposit Slip" then
                                    "Deposit Slip" := "Deposit Slip" + ReceiptSplit.Amount;
                                if ReceiptSplit."Pay Mode" = ReceiptSplit."pay mode"::EFT then
                                    EFT := EFT + ReceiptSplit.Amount;
                                if ReceiptSplit."Pay Mode" = ReceiptSplit."pay mode"::RTGS then
                                    EFT := EFT + ReceiptSplit.Amount;
                            until ReceiptSplit.next() = 0;
                    until ReqLine.Next() = 0;
                ///
                ///
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
        CompINf: Record "Company Information";
        ReqLine: Record "Receipt Line q";
        ReceiptsHeader: Record "Receipts Header";
        ReceiptSplit: Record "Receipt Split";

        Buffer: Record "Split Receipt Buffer";
        "Banker's Cheque": Decimal;
        Cash: Decimal;
        Cheque: Decimal;
        "Deposit Slip": Decimal;
        EFT: Decimal;
        Mpesa: Decimal;
        RTGS: Decimal;
        SchemeName: Text;
}
