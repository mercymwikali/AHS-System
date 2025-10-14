Report 52202448 "Bank Acc. Recon. -Posted1"
{
    Caption = 'Bank Acc. Recon. - Test';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BankAccReconPosted1.rdl';

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            RequestFilterFields = "Statement No.";
            column(ReportForNavId_38; 38)
            {
            }
            column(BankAccountNo_BankAccountStatement; "Bank Account Statement"."Bank Account No.")
            {
            }
            column(StatementNo_BankAccountStatement; "Bank Account Statement"."Statement No.")
            {
            }
            column(StatementEndingBalance_BankAccountStatement; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(StatementDate_BankAccountStatement; "Bank Account Statement"."Statement Date")
            {
            }
            column(BalanceLastStatement_BankAccountStatement; "Bank Account Statement"."Balance Last Statement")
            {
            }
            column(CashBookBalance_BankAccountStatement; "Bank Account Statement"."Cash Book Balance")
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BankAccountNo; BankAccountNo)
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
            column(UnpresentedChequesTotal2; UnpresentedChequesTotal2)
            {
            }
            column(UncreditedBanking2; UncreditedBanking2)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(DifferencesInBankTotalDebits; DifferencesInBankTotalDebits)
            {
            }
            column(DifferencesInBankTotalCredits; DifferencesInBankTotalCredits)
            {
            }
            dataitem(BankAccountLedgerEntry; "PosteBank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
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
                    SetFilter("Posting Date", '%1..%2', 20010101D, "Bank Account Statement"."Statement Date");
                    SetFilter("Statement Status", '%1', "statement status"::Open);
                    SetFilter(Open, '%1', true);
                    SetFilter(Reversed, '%1', false);

                    //BankAccountLedgerEntry.SETFILTER("Statement Difference",'<>%1',0);
                    SetFilter(Amount, '<%1', 0);
                    //SETFILTER("Statement Difference",'<%1',0);
                end;
            }
            dataitem(BankAccountLedgerEntry1; "PosteBank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."), "Statement No." = field("Statement No.");
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
                    SetFilter("Posting Date", '%1..%2', 20010101D, "Bank Account Statement"."Statement Date");
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
                column(BankDebits; BankDebits)
                {
                }
                column(BankCredits; BankCredits)
                {
                }
                column(CreditAmount_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Credit Amount")
                {
                }
                column(DebitAmount_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Debit Amount")
                {
                }
                column(CheckNo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Check No.")
                {
                }
                column(AdditionalTransactionInfo_BankAccReconciliationLine; "Bank Acc. Reconciliation Line"."Additional Transaction Info")
                {
                }
            }
            dataitem(BankAccReconciliationLine1; "Bank Account Statement Line1")
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

                trigger OnPreDataItem()
                begin
                    BankAccReconciliationLine1.SetFilter(Difference, '>%1', 0);
                end;
            }
            dataitem(BankAccReconciliationLine3; "Bank Account Statement Line1")
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

                trigger OnPreDataItem()
                begin
                    BankAccReconciliationLine3.SetFilter(Difference, '<%1', 0);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                BankCode := '';
                BankAccountNo := '';
                BankName := '';
                BankAccountBalanceasperCashBook := 0;
                UnpresentedChequesTotal := 0;
                UncreditedBanking := 0;

                /*Bank.RESET;
                Bank.SETRANGE(Bank."No.","Bank Account No.");
                IF Bank.FIND('-') THEN BEGIN
                  BankCode:=Bank."No.";
                  BankAccountNo:=Bank."Bank Account No.";
                  BankName:=Bank.Name;
                 // Bank.CALCFIELDS(Bank.Balance);
                 // BankAccountBalanceasperCashBook:="Cash Book Balance";
                   BankAccountBalanceasperCashBook:="Bank Account Statement"."Cash Book Balance";
                */
                Bank.Reset();
                Bank.SetRange(Bank."No.", "Bank Account No.");
                if Bank.Find('-') then begin
                    BankCode := Bank."No.";
                    BankAccountNo := Bank."Bank Account No.";
                    BankName := Bank.Name;
                    Bank.SetRange(Bank."Date Filter", 0D, "Statement Date");
                    Bank.CalcFields(Bank."Net Change");
                    BankAccountBalanceasperCashBook := Bank."Net Change";

                    BankStatementLine.Reset();
                    BankStatementLine.SetRange(BankStatementLine."Bank Account No.", Bank."No.");
                    BankStatementLine.SetRange(BankStatementLine."Statement No.", "Statement No.");
                    BankStatementLine.SetRange(BankStatementLine.Reconciled, false);
                    BankStatementLine.SetFilter(BankStatementLine."Applied Amount", '=%1', 0);
                    if BankStatementLine.Find('-') then
                        repeat
                            if BankStatementLine.Difference < 0 then
                                UnpresentedChequesTotal := UnpresentedChequesTotal + BankStatementLine.Difference
                            else
                                if BankStatementLine."Statement Amount" > 0 then
                                    UncreditedBanking := UncreditedBanking + BankStatementLine.Difference;
                        until BankStatementLine.Next() = 0;

                    UnpresentedChequesTotal := UnpresentedChequesTotal * -1;

                    //BankStatementLine
                end;
                UnpresentedChequesTotal2 := 0;
                UncreditedBanking2 := 0;
                //ERROR('Test '+FORMAT(Bank."No."));
                BankAccountLedgerEntry.Reset();
                BankAccountLedgerEntry.SetRange("Bank Account No.", Bank."No.");
                BankAccountLedgerEntry.SetRange(Open, true);
                BankAccountLedgerEntry.SetRange(Reversed, false);
                BankAccountLedgerEntry.SetRange("Statement No.", "Bank Account Statement"."Statement No.");
                BankAccountLedgerEntry.SetFilter("Posting Date", '%1..%2', 20010101D, "Bank Account Statement"."Statement Date");
                //BankAccountLedgerEntry2.SETFILTER("Statement Difference",'<>%1',0);
                if BankAccountLedgerEntry.Find('-') then
                    repeat

                        //IsApplied :=FALSE;
                        IsApplied := BankAccountLedgerEntry."Statement Status" = BankAccountLedgerEntry."statement status"::Open;

                        if IsApplied then
                            if BankAccountLedgerEntry.Amount < 0 then
                                UnpresentedChequesTotal2 := UnpresentedChequesTotal2 + BankAccountLedgerEntry.Amount
                            else
                                if BankAccountLedgerEntry.Amount > 0 then
                                    UncreditedBanking2 := UncreditedBanking2 + BankAccountLedgerEntry.Amount;
                    until BankAccountLedgerEntry.Next() = 0;
                UnpresentedChequesTotal2 := UnpresentedChequesTotal2 * -1;
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
        BankRecPresented: Record "Bank Acc. Reconciliation Line";
        BankStatementLine: Record "Bank Acc. Reconciliation Line";
        Bank: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        IsApplied: Boolean;
        BankAccountNo: Code[20];
        BankCode: Code[20];
        BankAccountBalanceasperCashBook: Decimal;
        BankCredits: Decimal;
        BankDebits: Decimal;
        DifferencesInBankTotalCredits: Decimal;
        DifferencesInBankTotalDebits: Decimal;
        TotalDifference: Decimal;
        UncreditedBanking: Decimal;
        UncreditedBanking2: Decimal;
        UnpresentedChequesTotal: Decimal;
        UnpresentedChequesTotal2: Decimal;
        SNo: Integer;
        SNo1: Integer;
        BankName: Text;

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
        BankRecPresented.SetRange(BankRecPresented."Bank Account No.", "Bank Account Statement"."Bank Account No.");
        BankRecPresented.SetRange(BankRecPresented."Statement No.", "Bank Account Statement"."Statement No.");
        //BankRecPresented.SETRANGE(BankRecPresented.Reconciled,TRUE);
        if BankRecPresented.Find('-') then
            repeat
                TotalDifference := TotalDifference + BankRecPresented.Difference;
            until BankRecPresented.Next() = 0;
        //MESSAGE('%1',TotalDifference);
    end;
}
