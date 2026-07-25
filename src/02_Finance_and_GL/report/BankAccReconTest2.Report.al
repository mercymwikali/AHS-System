Report 85015 "Bank Acc. Recon. - Test2"
{
    Caption = 'Bank Acc. Recon. - Test';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BankAccReconTest2.rdl';

    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {
            RequestFilterFields = "Statement No.";
            column(ReportForNavId_30; 30)
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement No.")
            {
            }
            column(StatementDate_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Date")
            {
            }
            column(BankAccountNo; BankAccountNo)
            {
            }
            column(StatementEndingBalance_BankAccReconciliation; "Bank Acc. Reconciliation"."Statement Ending Balance")
            {
            }
            column(BankName; BankName)
            {
            }
            column(BankAccountBalanceasperCashBook; BankAccountBalanceasperCashBook)
            {
            }
            column(UnpresentedChequesTotal; UnpresentedChequesTotal)
            {
            }
            column(UncreditedBanking; UncreditedBanking)
            {
            }
            column(ReconciliationStatement; ReconciliationStatement)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(RecCashBkBal; RecCashBkBal)
            {
            }
            column(DifferencesBW; DifferencesBW)
            {
            }
            column(DifferencesInBankTotal; DifferencesInBankTotal)
            {
            }
            column(DocNo; DocNo)
            {
            }
            column(Description; Descr)
            {
            }
            column(BankDebits; BankDebits)
            {
            }
            column(BankCredits; BankCredits)
            {
            }
            column(DifferencesInBankTotalDebits; DifferencesInBankTotalDebits)
            {
            }
            column(DifferencesInBankTotalCredits; DifferencesInBankTotalCredits)
            {
            }
            dataitem(BankAccountLedgerEntry; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No.");
                DataItemTableView = where("Statement Status" = filter(Open), Reversed = const(false), Open = const(true), Amount = filter(< 0), Amount = filter(<> 0));
                column(ReportForNavId_16; 16)
                {
                }
                column(StatementLineNo_BankAccountLedgerEntry; BankAccountLedgerEntry."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry; BankAccountLedgerEntry."Document No.")
                {
                }
                column(TransactionDate_BankAccountLedgerEntry; BankAccountLedgerEntry."Posting Date")
                {
                }
                column(PayeeName_BankAccountLedgerEntry; BankAccountLedgerEntry."Payee Name")
                {
                }
                column(Description_BankAccountLedgerEntry; BankAccountLedgerEntry.Description)
                {
                }
                column(StatementAmount_BankAccountLedgerEntry; BankAccountLedgerEntry.Amount)
                {
                }
                column(SNo; SNo)
                {
                }
                column(Remarks_BankAccountLedgerEntry; BankAccountLedgerEntry.Remarks)
                {
                }
                column(StatementDifference_BankAccountLedgerEntry; BankAccountLedgerEntry."Statement Difference")
                {
                }
                column(CreditAmount_BankAccountLedgerEntry; BankAccountLedgerEntry."Credit Amount")
                {
                }
                column(ExternalDocumentNo_BankAccountLedgerEntry; BankAccountLedgerEntry."External Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNo += 1;
                end;

                trigger OnPreDataItem()
                begin
                    //Reconciled=CONST(No)
                    //BankAccountLedgerEntry.SETFILTER("Posting Date",'<=%1',"Bank Acc. Reconciliation"."Statement Date");
                    SetFilter("Posting Date", '%1..%2', 20010101D, "Bank Acc. Reconciliation"."Statement Date");
                    SetFilter("Statement Status", '%1', "statement status"::Open);
                    SetFilter(Open, '%1', true);
                    SetFilter(Reversed, '%1', false);

                    //BankAccountLedgerEntry.SETFILTER("Statement Difference",'<>%1',0);
                    SetFilter(Amount, '<%1', 0);
                    //SETFILTER("Statement Difference",'<%1',0);
                end;
            }
            dataitem(BankAccountLedgerEntry1; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No.");
                column(ReportForNavId_8; 8)
                {
                }
                column(StatementLineNo_BankAccountLedgerEntry1; BankAccountLedgerEntry1."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry1; BankAccountLedgerEntry1."Document No.")
                {
                }
                column(TransactionDate_BankAccountLedgerEntry1; BankAccountLedgerEntry1."Posting Date")
                {
                }
                column(Description_BankAccountLedgerEntry1; BankAccountLedgerEntry1.Description)
                {
                }
                column(StatementAmount_BankAccountLedgerEntry1; BankAccountLedgerEntry1.Amount)
                {
                }
                column(SNo1; SNo1)
                {
                }
                column(Remarks_BankAccountLedgerEntry1; BankAccountLedgerEntry1.Remarks)
                {
                }
                column(StatementDifference_BankAccountLedgerEntry1; BankAccountLedgerEntry1."Statement Difference")
                {
                }
                column(ExternalDocumentNo_BankAccountLedgerEntry1; BankAccountLedgerEntry1."External Document No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNo1 += 1;
                end;

                trigger OnPreDataItem()
                begin
                    //Reconciled=CONST(No)
                    //BankAccountLedgerEntry1.SETFILTER("Posting Date",'<=%1',"Bank Acc. Reconciliation"."Statement Date");
                    SetFilter("Posting Date", '%1..%2', 20010101D, "Bank Acc. Reconciliation"."Statement Date");
                    SetFilter("Statement Status", '%1', "statement status"::Open);
                    //BankAccountLedgerEntry1.SETFILTER("Statement Difference",'<>%1',0);
                    SetFilter(Open, '%1', true);
                    SetFilter(Reversed, '%1', false);
                    SetFilter(Amount, '>%1', 0);
                    //SETFILTER("Statement Difference",'>%1',0);

                    SetFilter("Debit Amount", '<>%1', 0);
                end;
            }
            dataitem("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                DataItemTableView = where(Difference = filter(<> 0), "Applied Amount" = filter(= 0));
                column(ReportForNavId_1000000002; 1000000002)
                {
                }
                column(StatementLineNo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine; "Bank Acc. Reconciliation Line".Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Statement Amount")
                {
                }
                column(Difference_BankAccReconciliationLine; "Bank Acc. Reconciliation Line".Difference)
                {
                }
                column(CheckNo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Check No.")
                {
                }
                column(AdditionalTransactionInfo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Additional Transaction Info")
                {
                }
            }
            dataitem(BankAccReconciliationLine1; "Bank Acc. Statement Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                column(ReportForNavId_1000000015; 1000000015)
                {
                }
                column(StatementLineNo_BankAccReconciliationLine1; BankAccReconciliationLine1."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine1; BankAccReconciliationLine1."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine1; BankAccReconciliationLine1."Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine1; BankAccReconciliationLine1.Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine1; BankAccReconciliationLine1."Statement Amount")
                {
                }
                column(Difference_BankAccReconciliationLine1; BankAccReconciliationLine1.Difference)
                {
                }
                column(CheckNo_BankAccReconciliationLine1; BankAccReconciliationLine1."Check No.")
                {
                }
                column(AdditionalTransactionInfo_BankAccReconciliationLine1; BankAccReconciliationLine1."Additional Transaction Info")
                {
                }

                trigger OnPreDataItem()
                begin
                    //BankAccReconciliationLine1.SETFILTER(Difference,'>%1',0);
                end;
            }
            dataitem(BankAccReconciliationLine3; "Bank Acc. Statement Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
                column(ReportForNavId_52; 52)
                {
                }
                column(StatementLineNo_BankAccReconciliationLine3; BankAccReconciliationLine3."Statement Line No.")
                {
                }
                column(DocumentNo_BankAccReconciliationLine3; BankAccReconciliationLine3."Document No.")
                {
                }
                column(TransactionDate_BankAccReconciliationLine3; BankAccReconciliationLine3."Transaction Date")
                {
                }
                column(Description_BankAccReconciliationLine3; BankAccReconciliationLine3.Description)
                {
                }
                column(StatementAmount_BankAccReconciliationLine3; BankAccReconciliationLine3."Statement Amount")
                {
                }
                column(Difference_BankAccReconciliationLine3; BankAccReconciliationLine3.Difference)
                {
                }
                column(CheckNo_BankAccReconciliationLine3; BankAccReconciliationLine3."Check No.")
                {
                }
                column(AdditionalTransactionInfo_BankAccReconciliationLine3; BankAccReconciliationLine3."Additional Transaction Info")
                {
                }

                trigger OnPreDataItem()
                begin
                    //BankAccReconciliationLine3.SETFILTER(Difference,'<%1',0);
                end;
            }

            trigger OnAfterGetRecord()
            var
                BankAccountLedgerEntry2: Record "Bank Account Ledger Entry";
            begin
                BankCode := '';
                BankAccountNo := '';
                BankName := '';
                BankDebits := 0;
                BankCredits := 0;
                BankAccountBalanceasperCashBook := 0;
                UnpresentedChequesTotal := 0;
                UncreditedBanking := 0;

                RecCashBkBal := 0;

                TotalDiffFunc();

                Bank.Reset();
                Bank.SetRange(Bank."No.", "Bank Account No.");
                if Bank.Find('-') then begin
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    Bank.SetRange(Bank."Date Filter", 0D, "Statement Date");
                    Bank.CalcFields(Bank."Net Change");
                    BankAccountBalanceasperCashBook := Bank."Net Change";
                    /*
                      BankStatementLine.RESET;
                      BankStatementLine.SETRANGE(BankStatementLine."Bank Account No.",Bank."No.");
                      BankStatementLine.SETRANGE(BankStatementLine."Statement No.","Statement No.");
                      BankStatementLine.SETRANGE(BankStatementLine.Reconciled,FALSE);
                      IF BankStatementLine.FIND('-') THEN REPEAT
                        IF BankStatementLine."Statement Amount"<0 THEN
                         UnpresentedChequesTotal:=UnpresentedChequesTotal+BankStatementLine."Statement Amount"
                        ELSE IF BankStatementLine."Statement Amount">0 THEN
                         UncreditedBanking:=UncreditedBanking+BankStatementLine."Statement Amount";
                      UNTIL BankStatementLine.NEXT=0;
                    */

                    BankStatementLine.Reset();
                    BankStatementLine.SetRange(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SetRange(BankStatementLine."Statement No.", "Statement No.");
                    //BankStatementLine.SETRANGE(BankStatementLine.Reconciled,FALSE);
                    if BankStatementLine.Find('-') then
                        repeat
                            RecCashBkBal += BankStatementLine."Applied Amount";
                        until BankStatementLine.Next() = 0;

                    BankAccountLedgerEntry2.Reset();
                    BankAccountLedgerEntry2.SetRange("Bank Account No.", Bank."No.");
                    BankAccountLedgerEntry2.SetRange(Open, true);
                    BankAccountLedgerEntry2.SetRange(Reversed, false);
                    BankAccountLedgerEntry2.SetFilter("Posting Date", '%1..%2', 20010101D, "Bank Acc. Reconciliation"."Statement Date");
                    //BankAccountLedgerEntry2.SETFILTER("Statement Difference",'<>%1',0);
                    if BankAccountLedgerEntry2.Find('-') then
                        repeat

                            IsApplied := (BankAccountLedgerEntry2."Statement Status" = BankAccountLedgerEntry2."statement status"::Open);
                            if IsApplied then
                                if BankAccountLedgerEntry2.Amount < 0 then
                                    UnpresentedChequesTotal := UnpresentedChequesTotal + BankAccountLedgerEntry2.Amount
                                else
                                    if BankAccountLedgerEntry2.Amount > 0 then
                                        UncreditedBanking := UncreditedBanking + BankAccountLedgerEntry2.Amount;
                        until BankAccountLedgerEntry2.Next() = 0;

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                    BankStatBalance := "Bank Acc. Reconciliation"."Statement Ending Balance";

                    BankAccReconciliationLine.Reset();
                    BankAccReconciliationLine.SetRange(BankAccReconciliationLine."Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
                    BankAccReconciliationLine.SetRange(BankAccReconciliationLine."Statement No.", "Bank Acc. Reconciliation"."Statement No.");
                    //BankAccReconciliationLine.SETRANGE(Imported,FALSE);
                    // BankAccReconciliationLine.SetRange(BankAccReconciliationLine.Type, BankAccReconciliationLine.Type::"Bank Account Ledger Entry");
                    BankAccReconciliationLine.SetFilter("Applied Amount", '=%1', 0);
                    if BankAccReconciliationLine.Difference < 0 then
                        BankDebits := BankDebits + BankAccReconciliationLine.Difference
                    else
                        BankCredits := BankCredits + BankAccReconciliationLine.Difference;

                    DifferencesInBankTotal := 0;
                    DifferencesInBankTotalDebits := 0;
                    DifferencesInBankTotalCredits := 0;

                    BankAccReconciliationLine3.Reset();
                    BankAccReconciliationLine3.SetRange(BankAccReconciliationLine3."Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
                    BankAccReconciliationLine3.SetRange(BankAccReconciliationLine3."Statement No.", "Bank Acc. Reconciliation"."Statement No.");
                    BankAccReconciliationLine3.SetFilter(Difference, '<>%1', 0);
                    if BankAccReconciliationLine3.FindSet() then begin
                        BankAccReconciliationLine3.CalcSums(Difference);
                        DifferencesInBankTotal := BankAccReconciliationLine3.Difference;
                    end;
                    //Have deits and credits Separate
                    BankAccReconciliationLine.Reset();
                    BankAccReconciliationLine.SetRange(BankAccReconciliationLine."Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
                    BankAccReconciliationLine.SetRange(BankAccReconciliationLine."Statement No.", "Bank Acc. Reconciliation"."Statement No.");
                    BankAccReconciliationLine.SetFilter(Difference, '<>%1', 0);
                    if BankAccReconciliationLine.FindSet() then
                        repeat
                            if BankAccReconciliationLine.Difference > 0 then
                                DifferencesInBankTotalDebits := DifferencesInBankTotalDebits + BankAccReconciliationLine.Difference
                            else
                                if BankAccReconciliationLine.Difference < 0 then
                                    DifferencesInBankTotalCredits := (DifferencesInBankTotalCredits + BankAccReconciliationLine.Difference * -1)
                  until BankAccReconciliationLine.Next() = 0;

                    BankAccReconciliationLine1.Reset();
                    BankAccReconciliationLine1.SetRange(BankAccReconciliationLine1."Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
                    BankAccReconciliationLine1.SetRange(BankAccReconciliationLine1."Statement No.", "Bank Acc. Reconciliation"."Statement No.");
                    BankAccReconciliationLine1.SetFilter(Difference, '<>%1', 0);
                    if BankAccReconciliationLine.FindSet() then
                        //BEGIN
                        if BankAccReconciliationLine1.Difference < 0 then
                            BankDebits := BankDebits + BankAccReconciliationLine1."Statement Amount";

                    //END;

                    if ((BankAccountBalanceasperCashBook + UnpresentedChequesTotal - UncreditedBanking) + TotalDifference - DifferencesBW = "Statement Ending Balance") then
                        ReconciliationStatement := ''
                    else
                        ReconciliationStatement := 'Reconciliation is incomplete please go through it again';
                end;

                myDifferences := 0;

                myDifferences := ("Bank Acc. Reconciliation"."Statement Ending Balance" - UnpresentedChequesTotal - DifferencesInBankTotalDebits + DifferencesInBankTotalCredits + UncreditedBanking) - (BankAccountBalanceasperCashBook);
                if ReconciliationStatement <> '' then begin
                    if myDifferences > 0 then
                        if myDifferences <= 10 then
                            ReconciliationStatement := '';
                    if myDifferences < 0 then
                        if myDifferences >= -10 then
                            ReconciliationStatement := '';
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);
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

    trigger OnPreReport()
    begin
        //BankAccReconFilter := "Bank Acc. Reconciliation".GETFILTERS;
    end;

    var
        BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        BankRecPresented: Record "Bank Acc. Reconciliation Line";
        BankStatementLine: Record "Bank Acc. Reconciliation Line";
        Bank: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        IsApplied: Boolean;
        BankAccountNo: Code[20];
        BankCode: Code[20];
        DocNo: Code[30];
        BankAccountBalanceasperCashBook: Decimal;
        BankCredits: Decimal;
        BankDebits: Decimal;
        BankStatBalance: Decimal;
        DifferencesBW: Decimal;
        DifferencesInBankTotal: Decimal;
        DifferencesInBankTotalCredits: Decimal;
        DifferencesInBankTotalDebits: Decimal;
        myDifferences: Decimal;
        RecCashBkBal: Decimal;
        TotalDifference: Decimal;
        UncreditedBanking: Decimal;
        UnpresentedChequesTotal: Decimal;
        SNo: Integer;
        SNo1: Integer;
        BankName: Text;
        ReconciliationStatement: Text;
        Descr: Text[250];

    local procedure AddError()
    begin
        /*
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
        */
    end;

    procedure TotalDiffFunc()
    begin
        BankRecPresented.Reset();
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", "Bank Acc. Reconciliation"."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", "Bank Acc. Reconciliation"."Statement No.");
        //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        if BankRecPresented.Find('-') then
            repeat
                TotalDifference := TotalDifference + BankRecPresented.Difference;
            until BankRecPresented.Next() = 0;
        //MESSAGE('%1',TotalDifference);
    end;
}
