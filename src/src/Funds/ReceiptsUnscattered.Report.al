Report 52202501 "Receipts Unscattered"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ReceiptsUnscattered.rdl';

    dataset
    {
        dataitem("Receipt Line q"; "Receipt Line q")
        {
            DataItemTableView = sorting("Line No.", No) order(ascending) where("Header Posted" = const(true), "Reversed Lk" = filter(false));
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
            column(ReceivedFrom; ReceiptH."Received From")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Header Patient No");
                CalcFields("Posting Time");
                PatNames := '';
                if PatRec.Get("Header Patient No") then
                    PatNames := PatRec.Surname + ' ' + PatRec."Last Name";
                /*
                ReqLine:="Receipt Line q";
                ReceiptH.GET(ReqLine.No);
                IF (PatNames ='') then BEGIN
                  PatNames :=ReceiptH."Received From";
                IF  Customer.GET(ReqLine."Account No.") THEN
                PatNames :=Customer.Name;
                END;
                */
                if ReceiptH.Get("Receipt Line q".No) then;
            end;

            trigger OnPreDataItem()
            begin
                CompINf.Get();
                CompINf.CalcFields(Picture);
                ReqLine := "Receipt Line q";
                ReqLine.SetFilter(ReqLine.Date, "Receipt Line q".GetFilter(Date));
                ReqLine.SetFilter(ReqLine."Posting Time", "Receipt Line q".GetFilter("Posting Time"));
                ReqLine.SetFilter(ReqLine."Posted User", "Receipt Line q".GetFilter("Posted User"));
                ReqLine.SetFilter(ReqLine."Header Posted", '%1', true);
                ReqLine.SetFilter(ReqLine."Reversed Lk", '%1', false);
                if ReqLine.Find('-') then
                    repeat
                        if ReqLine."Pay Mode" = ReqLine."pay mode"::"Banker's Cheque" then
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
        PatRec: Record "HMS Patient";
        ReqLine: Record "Receipt Line q";
        ReceiptH: Record "Receipts Header";
        "Banker's Cheque": Decimal;
        Cash: Decimal;
        Cheque: Decimal;
        "Deposit Slip": Decimal;
        EFT: Decimal;
        Mpesa: Decimal;
        RTGS: Decimal;
        PatNames: Text[100];
}
