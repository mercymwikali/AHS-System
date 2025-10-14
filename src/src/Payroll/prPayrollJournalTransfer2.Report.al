Report 52202443 prPayrollJournalTransfer2
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("prPayroll Periods"; "prPayroll Periods")
        {
            RequestFilterFields = "Date Opened";
            column(ReportForNavId_6207; 6207)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //For use when posting Pension and NSSF
                PostingGroup.Get(SelectedPostingGroup);
                PostingGroup.TestField("NSSF Employer Account");
                PostingGroup.TestField("NSSF Employee Account");
                PostingGroup.TestField("Pension Employer Acc");
                PostingGroup.TestField("Pension Employee Acc");

                LineNumber := LineNumber + 10;

                //BPAY
                Credits := 0;
                PeriodTrans.Reset();
                PeriodTrans.SetCurrentkey("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");

                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'BPAY');
                PeriodTrans.SetRange(periodtrans."posting group", SelectedPostingGroup);
                if EmployeeNo <> '' then
                    PeriodTrans.SetFilter(periodtrans."Employee Code", EmployeeNo);
                if directorate <> '' then
                    PeriodTrans.SetFilter(periodtrans."Global Dimension 1 code", Directorate);
                if PeriodTrans.Find('-') then begin
                    repeat
                        //BPAY
                        Credits := Credits + PeriodTrans.Amount;
                    until PeriodTrans.Next() = 0;
                    //Debit Staff Expense
                    CreateJnlEntry(0, PostingGroup."Salary Account",
                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", Credits, 0, 1, '',
                    SaccoTransactionType, '');
                end;

                AmountToDebit := 0;
                AmountToCredit := 0;
                //END Basic Pay
                //Transactions setup in the transaction Code
                TransCode.Reset();
                if TransCode.Find('-') then
                    repeat

                        PeriodTrans.Reset();
                        PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                        PeriodTrans.SetRange(PeriodTrans."Transaction Code", TransCode."Transaction Code");
                        PeriodTrans.SetRange(periodtrans."posting group", SelectedPostingGroup);
                        if EmployeeNo <> '' then
                            PeriodTrans.SetFilter(periodtrans."Employee Code", EmployeeNo);
                        if directorate <> '' then
                            PeriodTrans.SetFilter(periodtrans."Global Dimension 1 code", Directorate);
                        if PeriodTrans.Find('-') then begin
                            repeat

                                if PeriodTrans."Journal Account Code" <> '' then begin
                                    if PeriodTrans."Post As" = PeriodTrans."post as"::Debit then
                                        AmountToDebit := AmountToDebit + PeriodTrans.Amount;

                                    if PeriodTrans."Post As" = PeriodTrans."post as"::Credit then
                                        AmountToCredit := AmountToCredit + PeriodTrans.Amount;

                                    if PeriodTrans."Journal Account Type" = PeriodTrans."Journal Account Type"::"G/L Account" then
                                        IntegerPostAs := 0;
                                    if PeriodTrans."Journal Account Type" = PeriodTrans."Journal Account Type"::Customer then
                                        IntegerPostAs := 1;
                                    if PeriodTrans."Journal Account Type" = PeriodTrans."Journal Account Type"::Vendor then
                                        IntegerPostAs := 2;

                                    SaccoTransactionType := Saccotransactiontype::" ";

                                    if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::loan then
                                        SaccoTransactionType := Saccotransactiontype::Repayment;

                                    if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::"loan Interest" then
                                        SaccoTransactionType := Saccotransactiontype::"Interest Paid";

                                    if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Welfare then
                                        SaccoTransactionType := Saccotransactiontype::"Welfare Contribution";

                                    if PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::shares then
                                        SaccoTransactionType := Saccotransactiontype::"Deposit Contribution";
                                end
                            until PeriodTrans.Next() = 0;
                            if PeriodTrans."Transaction Code" <> 'NHIF' then
                                CreateJnlEntry(IntegerPostAs, PeriodTrans."Journal Account Code",
                                     GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", AmountToDebit, AmountToCredit,
                                     PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType, '')
                            else begin
                                NhifRL := GetNHIFRelief(PeriodTrans."Employee Code");
                                AmountToCredit := AmountToCredit - NhifRL;
                                CreateJnlEntry(IntegerPostAs, PeriodTrans."Journal Account Code",
                             GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + PeriodTrans."Employee Code", AmountToDebit, AmountToCredit,
                             PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType, PostingGroup."Net Salary Payable");
                            end;
                            AmountToDebit := 0;
                            AmountToCredit := 0;
                        end;
                    until TransCode.Next() = 0;
                //End Transactions setup in the transaction Code
                //NHIF
                Credits := 0;
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'NHIF');
                PeriodTrans.SetRange(periodtrans."posting group", SelectedPostingGroup);
                if EmployeeNo <> '' then
                    PeriodTrans.SetFilter(periodtrans."Employee Code", EmployeeNo);
                if directorate <> '' then
                    PeriodTrans.SetFilter(periodtrans."Global Dimension 1 code", Directorate);
                PeriodTrans.SetRange(periodtrans."posting group", SelectedPostingGroup);
                if EmployeeNo <> '' then
                    PeriodTrans.SetFilter(periodtrans."Employee Code", EmployeeNo);
                if directorate <> '' then
                    PeriodTrans.SetFilter(periodtrans."Global Dimension 1 code", Directorate);
                if PeriodTrans.Find('-') then begin
                    repeat
                        //NHIF
                        Credits := Credits + PeriodTrans.Amount;
                    until PeriodTrans.Next() = 0;
                    //Debit Staff Expense
                    CreateJnlEntry(0, PostingGroup."SHIF Employee Account",
                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", 0, Credits, PeriodTrans."Post As", '',
                    SaccoTransactionType, '');
                end;
                //End NHIF
                //NSSF Employee
                Credits := 0;
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'NSSF');
                PeriodTrans.SetRange(periodtrans."posting group", SelectedPostingGroup);
                if EmployeeNo <> '' then
                    PeriodTrans.SetFilter(periodtrans."Employee Code", EmployeeNo);
                if directorate <> '' then
                    PeriodTrans.SetFilter(periodtrans."Global Dimension 1 code", Directorate);
                if PeriodTrans.Find('-') then begin
                    repeat
                        //NSSF
                        Credits := Credits + PeriodTrans.Amount;
                    until PeriodTrans.Next() = 0;

                    //Debit Staff Expense

                    CreateJnlEntry(0, PostingGroup."NSSF Employee Account",
                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", 0, Credits, PeriodTrans."Post As", '',
                    SaccoTransactionType, '');
                end;
                //END NSSF Employee
                //NetPAY
                Credits := 0;
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'NPAY');
                PeriodTrans.SetRange(periodtrans."posting group", SelectedPostingGroup);
                if EmployeeNo <> '' then
                    PeriodTrans.SetFilter(periodtrans."Employee Code", EmployeeNo);
                if directorate <> '' then
                    PeriodTrans.SetFilter(periodtrans."Global Dimension 1 code", Directorate);
                if PeriodTrans.Find('-') then begin
                    repeat
                        //NPAY
                        Credits := Credits + PeriodTrans.Amount;
                    until PeriodTrans.Next() = 0;
                    //Debit Staff Expense
                    CreateJnlEntry(0, PostingGroup."Net Salary Payable",
                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", 0, Credits, PeriodTrans."Post As", '',
                    SaccoTransactionType, '');
                end;
                //END Netpay
                //Pension Employer
                TransCode.Reset();
                TransCode.SetRange(TransCode."Include Employer Deduction", true);
                TransCode.SetRange(TransCode."Special Transactions", TransCode."special transactions"::"Defined Contribution");
                if TransCode.Find('-') then
                    repeat
                        Debits := 0;
                        PeriodTrans.Reset();
                        PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                        PeriodTrans.SetRange(PeriodTrans."Transaction Code", TransCode."Transaction Code");
                        PeriodTrans.SetRange(periodtrans."posting group", SelectedPostingGroup);
                        if EmployeeNo <> '' then
                            PeriodTrans.SetFilter(periodtrans."Employee Code", EmployeeNo);
                        if directorate <> '' then
                            PeriodTrans.SetFilter(periodtrans."Global Dimension 1 code", Directorate);
                        if PeriodTrans.Find('-') then begin
                            repeat

                                //Pension
                                if PeriodTrans."Journal Account Code" <> '' then begin
                                    //Get from Employer Deduction
                                    EmployerDed.Reset();
                                    EmployerDed.SetRange(EmployerDed."Employee Code", PeriodTrans."Employee Code");
                                    EmployerDed.SetRange(EmployerDed."Transaction Code", PeriodTrans."Transaction Code");
                                    EmployerDed.SetRange(EmployerDed."Payroll Period", PeriodTrans."Payroll Period");
                                    if EmployerDed.Find('-') then
                                        Debits := EmployerDed.Amount + Debits;
                                end
                            //END;
                            until PeriodTrans.Next() = 0;
                            //Credit Payables
                            CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                            GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", 0,
                            Debits, PeriodTrans."Post As", '', SaccoTransactionType, '');

                            //Debit Staff Expense
                            CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                            GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", Debits, 0, 1, '',
                            SaccoTransactionType, '');
                        end;
                    until TransCode.Next() = 0;
                //End Pension Employer
                //NSSF Employer
                Credits := 0;
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'NSSF');
                PeriodTrans.SetRange(periodtrans."posting group", SelectedPostingGroup);
                if EmployeeNo <> '' then
                    PeriodTrans.SetFilter(periodtrans."Employee Code", EmployeeNo);
                if directorate <> '' then
                    PeriodTrans.SetFilter(periodtrans."Global Dimension 1 code", Directorate);
                if PeriodTrans.Find('-') then begin
                    repeat
                        //NSSF
                        Credits := Credits + PeriodTrans.Amount;
                    until PeriodTrans.Next() = 0;

                    CreateJnlEntry(0, PostingGroup."NSSF Employee Account",
                     GlobalDim1, GlobalDim2, 'Emp:' + PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", 0, Credits,
                     PeriodTrans."Post As", '', SaccoTransactionType, '');

                    //Debit Staff Expense

                    CreateJnlEntry(0, PostingGroup."NSSF Employer Account",
                    GlobalDim1, GlobalDim2, 'Emp:' + PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", Credits, 0, 1, '',
                    SaccoTransactionType, '');
                end;
                //END NSSF
                //Housing Levy Employer
                Credits := 0;
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'HLEVY');
                PeriodTrans.SetRange(periodtrans."posting group", SelectedPostingGroup);
                if EmployeeNo <> '' then
                    PeriodTrans.SetFilter(periodtrans."Employee Code", EmployeeNo);
                if directorate <> '' then
                    PeriodTrans.SetFilter(periodtrans."Global Dimension 1 code", Directorate);
                if PeriodTrans.Find('-') then begin
                    repeat
                        //NSSF
                        Credits := Credits + PeriodTrans.Amount;
                    until PeriodTrans.Next() = 0;

                    CreateJnlEntry(0, PostingGroup."Housing Levy Employee Account",
                     GlobalDim1, GlobalDim2, 'Emp:' + PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", 0, Credits,
                     PeriodTrans."Post As", '', SaccoTransactionType, '');

                    //Debit Staff Expense

                    CreateJnlEntry(0, PostingGroup."Housing Levy Employer Account",
                    GlobalDim1, GlobalDim2, 'Emp:' + PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", Credits, 0, 1, '',
                    SaccoTransactionType, '');
                end;
                //END Housing Levy

                //PAYE
                Credits := 0;
                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Transaction Code", 'PAYE');
                PeriodTrans.SetRange(periodtrans."posting group", SelectedPostingGroup);
                if EmployeeNo <> '' then
                    PeriodTrans.SetFilter(periodtrans."Employee Code", EmployeeNo);
                if directorate <> '' then
                    PeriodTrans.SetFilter(periodtrans."Global Dimension 1 code", Directorate);
                if PeriodTrans.Find('-') then begin
                    repeat
                        //PAYE
                        Credits := Credits + PeriodTrans.Amount;
                    until PeriodTrans.Next() = 0;
                    //Debit Staff Expense
                    CreateJnlEntry(0, PostingGroup."Income Tax Account",
                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + "Slip/Receipt No", 0, Credits, PeriodTrans."Post As", '',
                    SaccoTransactionType, '');
                end;

                //End PAYE

                //Gratuity
                Credits := 0;
                //Get from Employer Deduction
                EmployerDed.Reset();
                //EmployerDed.SETRANGE(EmployerDed."Employee Code","Employee Code");
                EmployerDed.SetRange(EmployerDed."Transaction Code", 'D753');
                EmployerDed.SetRange(EmployerDed."Payroll Period", SelectedPeriod);
                if EmployeeNo <> '' then
                    EmployerDed.SetFilter(EmployerDed."Employee Code", EmployeeNo);
                //if directorate<>'' then begin
                //EmployerDed.SetFilter(EmployerDed.,Directorate);
                //end;
                if EmployerDed.Find('-') then begin
                    REPEAT
                        Credits := Credits + PeriodTrans.Amount;
                    UNTIL EmployerDed.NEXT() = 0;
                    //Credit Payables
                    CreateJnlEntry(0, PostingGroup.StaffGratuityCredit,
                    GlobalDim1, GlobalDim2, 'NITA-' + FORMAT(SelectedPeriod), 0,
                    Credits, PeriodTrans."Post As", '', SaccoTransactionType, '');

                    //Debit Staff Expense
                    CreateJnlEntry(0, PostingGroup.StaffGratuityDebit,
                    GlobalDim1, GlobalDim2, 'NITA-' + FORMAT(SelectedPeriod), Credits, 0, 1, '',
                    SaccoTransactionType, '');
                end;
            end;

            trigger OnPostDataItem()
            begin
                //Rounding Off
                Credits := 0;
                GeneraljnlLine.Reset();
                GeneraljnlLine.SetRange("Journal Batch Name", 'SALARIES');
                GeneraljnlLine.SetRange("Journal Template Name", 'GENERAL');
                if GeneraljnlLine.Find('-') then begin
                    repeat
                        Credits := GeneraljnlLine.Amount + Credits
                    until GeneraljnlLine.Next() = 0;
                    if Credits > 0 then
                        //Credit Payables
                        CreateJnlEntry(0, PostingGroup."Net Salary Payable",
                          GlobalDim1, GlobalDim2, 'Roundoff-' + "Slip/Receipt No", 0,
                          Credits, 2, '', SaccoTransactionType, '')
                    else
                        //Debit Staff Expenser
                        CreateJnlEntry(0, PostingGroup."Net Salary Payable",
                          GlobalDim1, GlobalDim2, 'Roundoff-' + "Slip/Receipt No", -(Credits), 0, 1, '',
                          SaccoTransactionType, '');
                end;
                //Rounding Off

                Message('Journals Created Successfully');
            end;

            trigger OnPreDataItem()
            begin

                LineNumber := 10000;

                //Create batch*****************************************************************************
                GenJnlBatch.Reset();
                GenJnlBatch.SetRange(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SetRange(GenJnlBatch.Name, 'SALARIES');
                if GenJnlBatch.Find('-') = false then begin
                    GenJnlBatch.Init();
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := 'SALARIES';
                    GenJnlBatch.Insert();
                end;
                // End Create Batch

                // Clear the journal Lines
                GeneraljnlLine.SetRange(GeneraljnlLine."Journal Batch Name", 'SALARIES');
                if GeneraljnlLine.Find('-') then
                    GeneraljnlLine.DeleteAll();

                "Slip/Receipt No" := UpperCase(objPeriod."Period Name");

                //"prSalary Card".SETRANGE("prSalary Card"."Payroll Period",SelectedPeriod);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(SelectedPostingGroup; SelectedPostingGroup)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the SelectedPostingGroup field.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        if UserSetup.Get(UserId) then
            if UserSetup."View Payroll" = false then
                Error('You dont have permissions for payroll, Contact your system administrator! ');
    end;

    trigger OnPreReport()
    begin
        Evaluate(PeriodFilter, "prPayroll Periods".GetFilter("Date Opened"));
        if PeriodFilter = 0D then
            Error('You must specify the period filter');

        SelectedPeriod := PeriodFilter;
        objPeriod.Reset();
        if objPeriod.Get(SelectedPeriod) then
            PeriodName := objPeriod."Period Name";

        PostingDate := CalcDate('1M-1D', SelectedPeriod);
    end;

    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GeneraljnlLine: Record "Gen. Journal Line";
        PostingGroup: Record "prEmployee Posting Group";
        EmployerDed: Record "prEmployer Deductions";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        PeriodTrans2: Record "prPeriod Transactions";
        TransCode: Record "PR Transaction Codes";
        UserSetup: Record "User Setup";
        directorate: code[20];
        EmployeeNo: code[20];
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        SelectedPostingGroup: Code[20];
        "Slip/Receipt No": Code[50];
        PeriodFilter: Date;
        PostingDate: Date;
        SelectedPeriod: Date;
        AmountToCredit: Decimal;
        AmountToDebit: Decimal;
        Credits: Decimal;
        Debits: Decimal;
        NhifRL: Decimal;
        IntegerPostAs: Integer;
        LineNumber: Integer;
        SaccoTransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2";
        PeriodName: Text[30];

    procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[50]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2"; BalAccountNo: Code[20])
    begin

        LineNumber := LineNumber + 100;
        GeneraljnlLine.Init();
        GeneraljnlLine."Journal Template Name" := 'GENERAL';
        GeneraljnlLine."Journal Batch Name" := 'SALARIES';
        GeneraljnlLine."Line No." := LineNumber;
        GeneraljnlLine."Document No." := "Slip/Receipt No";
        //GeneraljnlLine."Loan No":=LoanNo;
        //GeneraljnlLine."Transaction Type":=TransType;
        GeneraljnlLine."Posting Date" := PostingDate;
        GeneraljnlLine."Account Type" := AccountType;
        GeneraljnlLine."Account No." := AccountNo;
        GeneraljnlLine.Validate(GeneraljnlLine."Account No.");
        GeneraljnlLine.Description := Description;
        if PostAs = Postas::Debit then begin
            GeneraljnlLine."Debit Amount" := DebitAmount;
            GeneraljnlLine.Validate("Debit Amount");
        end else begin
            GeneraljnlLine."Credit Amount" := CreditAmount;
            GeneraljnlLine.Validate("Credit Amount");
        end;
        GeneraljnlLine."Bal. Account No." := BalAccountNo;
        GeneraljnlLine.Validate(GeneraljnlLine."Bal. Account No.");
        GeneraljnlLine."Gen. Bus. Posting Group" := '';
        GeneraljnlLine."Gen. Prod. Posting Group" := '';
        GeneraljnlLine."Shortcut Dimension 1 Code" := GlobalDime1;
        GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 1 Code");
        GeneraljnlLine."Shortcut Dimension 2 Code" := GlobalDime2;
        GeneraljnlLine.Validate(GeneraljnlLine."Shortcut Dimension 2 Code");
        if GeneraljnlLine.Amount <> 0 then
            GeneraljnlLine.Insert();
    end;

    procedure GetNHIFRelief("Employee Code": Text) RLAmount: Decimal
    begin
        PeriodTrans2.Reset();
        PeriodTrans2.SetRange(PeriodTrans2."Employee Code", "Employee Code");
        PeriodTrans2.SetRange(PeriodTrans2."Payroll Period", SelectedPeriod);
        PeriodTrans2.SETRANGE(PeriodTrans2."Transaction Code", 'NHIF-RL');
        if PeriodTrans2.Find('-') then
            RLAmount := PeriodTrans2.Amount;
    end;
}