Codeunit 85005 "Gen. Jnl.-Post B"
{
    TableNo = "Gen. Journal Line";

    trigger OnRun()
    begin
        GenJnlLine.Copy(Rec);
        Code();
        Rec.Copy(GenJnlLine);
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        TempJnlBatchName: Code[10];
        Text000: label 'cannot be filtered when posting recurring journals';
        Text002: label 'There is nothing to post.';

    local procedure "Code"()
    begin
        GenJnlTemplate.Get(GenJnlLine."Journal Template Name");
        GenJnlTemplate.TestField("Force Posting Report", false);
        if GenJnlTemplate.Recurring and (GenJnlLine.GetFilter("Posting Date") <> '') then
            GenJnlLine.FieldError("Posting Date", Text000);

        //IF NOT CONFIRM(Text001,FALSE) THEN
        //EXIT;

        TempJnlBatchName := GenJnlLine."Journal Batch Name";

        GenJnlPostBatch.Run(GenJnlLine);

        if GenJnlLine."Line No." = 0 then
            Message(Text002)
        else
            /*
              IF TempJnlBatchName = "Journal Batch Name" THEN
                MESSAGE(Text003)
              ELSE
                MESSAGE(
                  Text004,
                  "Journal Batch Name");
            */
            if not GenJnlLine.Find('=><') or (TempJnlBatchName <> GenJnlLine."Journal Batch Name") then begin
                GenJnlLine.Reset();
                GenJnlLine.FilterGroup(2);
                GenJnlLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                GenJnlLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                GenJnlLine.FilterGroup(0);
                GenJnlLine."Line No." := 1;
            end;
    end;

    procedure RemoveApplications(EntryNo: Integer)
    var
        CustD: Record "Detailed Cust. Ledg. Entry";
    begin
        if CustD.Get(EntryNo) then
            CustD.Delete();
    end;

    procedure UpdateBankRec(BankNo: Code[20]; SDate: Date)
    var
        BankLedger: Record "Bank Account Ledger Entry";
    begin
        BankLedger.Reset();
        BankLedger.SetRange(BankLedger."Bank Account No.", BankNo);
        BankLedger.SetRange(BankLedger.Reversed, false);
        BankLedger.SetFilter(BankLedger."Posting Date", '%1..%2', 20010101D, SDate);
        BankLedger.SetFilter(BankLedger."Statement Line No.", '%1', 0);
        if BankLedger.Find('-') then
            repeat
                BankLedger."Statement Difference" := BankLedger.Amount;
                BankLedger.Modify();
            until BankLedger.Next() = 0;
    end;

    procedure UpdateBankCheque(BankNo: Code[20]; DocNo: Code[20]; ChequeNo: Code[20])
    var
        BankL: Record "Bank Account Ledger Entry";
    begin
        BankL.Reset();
        BankL.SetRange("Document No.", DocNo);
        BankL.SetRange("Bank Account No.", BankNo);
        if BankL.Find('-') then
            repeat
                BankL."External Document No." := ChequeNo;
                BankL.Modify();
            until BankL.Next() = 0;
    end;

    procedure UpdateBankExternalDoc2(BankNo: Code[20])
    var
        BankAccLedgerMain: Record "Bank Account Ledger Entry";
    begin
        BankAccLedgerMain.Reset();
        BankAccLedgerMain.SetRange(BankAccLedgerMain."Bank Account No.", BankNo);
        //BankAccLedgerMain.SETFILTER(BankAccLedgerMain."External Document No. 2",'<>%1','');
        if BankAccLedgerMain.Find('-') then
            repeat
                if BankAccLedgerMain."External Document No. 2" <> CopyStr(BankAccLedgerMain."External Document No.", 1, 21) then begin
                    BankAccLedgerMain."External Document No. 2" := CopyStr(BankAccLedgerMain."External Document No.", 1, 21);
                    BankAccLedgerMain.Modify();
                end;
            until BankAccLedgerMain.Next() = 0;
    end;

    procedure DeleteBankRec(BankAcc: Code[20]; StatementNo: Code[20])
    var
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccLedgEntry.Reset();
        BankAccLedgEntry.SetFilter(BankAccLedgEntry."Bank Account No.", BankAcc);
        BankAccLedgEntry.SetFilter(BankAccLedgEntry."Statement Status", '=%1', BankAccLedgEntry."statement status"::Open);
        //BankAccLedgEntry.SETFILTER("Statement No.",StatementNo);

        //BankAccLedgEntry.SETFILTER(BankAccLedgEntry."Posting Date",'12/29/2017..4/30/2018');
        if BankAccLedgEntry.Find('-') then begin
            repeat
                //MESSAGE('%1',BankAccLedgEntry.COUNT);
                BankAccLedgEntry.Open := true;
                BankAccLedgEntry."Remaining Amount" := BankAccLedgEntry.Amount;
                BankAccLedgEntry."Statement Status" := BankAccLedgEntry."statement status"::Open;
                BankAccLedgEntry."Statement No." := '';
                BankAccLedgEntry."Statement Line No." := 0;
                BankAccLedgEntry.Modify();
            until BankAccLedgEntry.Next() = 0;
            BankAccLedgEntry.Modify();
            Message('done');
        end;
    end;
}
