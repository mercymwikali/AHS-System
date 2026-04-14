Report 85038 "Flash Revenue"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ReceiptsPerTransactionType.rdl';

    dataset
    {
        dataitem("Receipt Line q"; "Receipt Line q")
        {
            DataItemTableView = sorting("Line No.", No) order(ascending) where("Header Posted" = const(true), Reversed = filter(false), "Reversed Lk" = filter(false));
            RequestFilterFields = Date, "Posted User", "HSM Transaction Type", "Posting Time";
            column(ReportForNavId_1; 1)
            {
            }
            column(No_ReceiptLineq; "Receipt Line q".No)
            {
            }
            column(Date_ReceiptLineq; "Receipt Line q".Date)
            {
            }
            column(PayMode_ReceiptLineq; "Receipt Line q"."Pay Mode")
            {
            }
            column(BankCode_ReceiptLineq; "Receipt Line q"."Bank Code")
            {
            }
            column(ReceivedFrom_ReceiptLineq; "Receipt Line q"."Receipt From H")
            {
            }
            column(Amount_ReceiptLineq; "Receipt Line q".Amount)
            {
            }
            column(TransactionName_ReceiptLineq; "Receipt Line q"."Transaction Name")
            {
            }
            column(TransactionNo_ReceiptLineq; "Receipt Line q"."Transaction No.")
            {
            }
            column(HSMTransactionType_ReceiptLineq; "Receipt Line q"."HSM Transaction Type")
            {
            }
            column(PatientNo_ReceiptLineq; "Receipt Line q"."Patient No")
            {
            }
            column(TimePosted_ReceiptLineq; "Receipt Line q"."Time Posted")
            {
            }
            column(HeaderTimePosted_ReceiptLineq; "Receipt Line q"."Posting Time")
            {
            }
            column(HeaderPatientNo_ReceiptLineq; "Receipt Line q"."Header Patient No")
            {
            }
            column(PatientName; PatNames)
            {
            }
            column(TransactionCode; ReceiptsHeader."Transaction Code")
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
            column(DateFilter; Getfilter(Date))
            {
            }
            column(BranchFilter; Getfilter("Global Dimension 1 Code"))
            {
            }
            column(BankedAmt; BankedAmt)
            {
            }
            dataitem("Receipt Split"; "Receipt Split")
            {
                DataItemLink = "Receipt No" = field("No");
                column(Receipt_No; "Receipt No")

                {
                }
                column(Pay_Mode; "Pay Mode")
                {
                }
                column(Transaction_No; "Transaction No")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Bank_Account_No; "Bank Account No")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Header Patient No");
                CalcFields("Posting Time");
                ReceiptsHeader.get("Receipt Line q".No);
                PatNames := '';
                if PatRec.Get("Header Patient No") then
                    PatNames := PatRec.Surname + ' ' + PatRec."Last Name";

                HMSPatient.Reset();
                HMSPatient.SetRange(HMSPatient."Patient No.", "Receipt Line q"."Patient No");
                if HMSPatient.Find('-') then
                    if (HMSPatient."Patient Type" = HMSPatient."patient type"::Cash) or (HMSPatient."Patient Type" = HMSPatient."patient type"::" ") then
                        SchemeName := 'CASH'
                    else
                        SchemeName := (HMSPatient."Insurance Name");
                BankedAmt := 0;
                InterBank.reset();
                InterBank.setfilter(InterBank."Receiving Depot Code", "Receipt Line q".GetFilter("Global Dimension 1 Code"));
                InterBank.setfilter(InterBank.Date, '%1', "Receipt Line q".Date - 1);
                if InterBank.Find('-') then
                    repeat
                        BankedAmt := BankedAmt + InterBank.Amount;
                    until InterBank.Next() = 0;
            end;

            trigger OnPreDataItem()
            begin
                CompINf.Get();
                CompINf.CalcFields(Picture);
                ReqLine := "Receipt Line q";
                ReqLine.SetFilter(ReqLine.Date, "Receipt Line q".GetFilter(Date));
                ReqLine.SetFilter(ReqLine."Global Dimension 1 Code", "Receipt Line q".GetFilter("Global Dimension 1 Code"));
                ReqLine.SetFilter(ReqLine."Posting Time", "Receipt Line q".GetFilter("Posting Time"));
                ReqLine.SetFilter(ReqLine."Posted User", "Receipt Line q".GetFilter("Posted User"));
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
                ReqLine := "Receipt Line q";
                ReqLine.SetFilter(ReqLine.Date, "Receipt Line q".GetFilter(Date));
                ReqLine.SetFilter(ReqLine."Global Dimension 1 Code", "Receipt Line q".GetFilter("Global Dimension 1 Code"));
                ReqLine.SetFilter(ReqLine."Posting Time", "Receipt Line q".GetFilter("Posting Time"));
                ReqLine.SetFilter(ReqLine."Posted User", "Receipt Line q".GetFilter("Posted User"));
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
        HMSPatient: Record "HMS Patient";
        PatRec: Record "HMS Patient";
        InterBank: Record "InterBank Transfers";
        ReqLine: Record "Receipt Line q";
        ReceiptsHeader: Record "Receipts Header";
        ReceiptSplit: Record "Receipt Split";
        BankedAmt: Decimal;
        "Banker's Cheque": Decimal;
        Cash: Decimal;
        Cheque: Decimal;
        "Deposit Slip": Decimal;
        EFT: Decimal;
        Mpesa: Decimal;
        RTGS: Decimal;
        SchemeName: Text;
        PatNames: Text[100];
}
