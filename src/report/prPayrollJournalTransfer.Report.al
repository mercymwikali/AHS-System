Report 85283 prPayrollJournalTransfer
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code", "Period Month";
            column(ReportForNavId_6207; 6207)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //For use when posting Pension and NSSF
                PostingGroup.Get(PayrollPostingGroup);
                PostingGroup.TestField("NSSF Employer Account");
                PostingGroup.TestField("NSSF Employee Account");
                PostingGroup.TestField("Pension Employer Acc");
                PostingGroup.TestField("Pension Employee Acc");
                PostingGroup.TestField("Housing Levy Employee Account");
                PostingGroup.TestField("Housing Levy Employer Account");

                //Get the staff details (header)
                objEmp.SetRange(objEmp."No.", "Employee Code");
                if objEmp.Find('-') then begin
                    strEmpName := '[' + "Employee Code" + '] ' + objEmp."Last Name" + ' ' + objEmp."First Name" + ' ' + objEmp."Middle Name";
                    GlobalDim1 := objEmp."Shortcut Dimension 1 Code";
                    GlobalDim2 := objEmp."Shortcut Dimension 2 Code";
                end;

                LineNumber := LineNumber + 10;

                PeriodTrans.Reset();
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                //PeriodTrans.SETRANGE(PeriodTrans."Period Month",7);
                if PeriodTrans.Find('-') then begin
                    repeat
                        if PeriodTrans."Journal Account Code" <> '' then begin
                            AmountToDebit := 0;
                            AmountToCredit := 0;
                            if PeriodTrans."Post As" = PeriodTrans."post as"::Debit then
                                AmountToDebit := PeriodTrans.Amount;

                            if PeriodTrans."Post As" = PeriodTrans."post as"::Credit then
                                AmountToCredit := PeriodTrans.Amount;

                            if PeriodTrans."Journal Account Type" = 1 then
                                IntegerPostAs := 0;
                            if PeriodTrans."Journal Account Type" = 2 then
                                IntegerPostAs := 1;

                            /* SaccoTransactionType:=SaccoTransactionType::" ";

                            IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::loan THEN
                               SaccoTransactionType:=SaccoTransactionType::Repayment;

                            IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::"loan Interest" THEN
                               SaccoTransactionType:=SaccoTransactionType::"Interest Paid";

                            IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Welfare THEN
                               SaccoTransactionType:=SaccoTransactionType::"Welfare Contribution";

                            IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::shares THEN
                               SaccoTransactionType:=SaccoTransactionType::"Deposit Contribution";
                            */

                            if PeriodTrans."Transaction Code" <> 'NHIF' then
                                CreateJnlEntry(IntegerPostAs, PeriodTrans."Journal Account Code",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + PeriodTrans."Employee Code", AmountToDebit, AmountToCredit,
                                PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType, PostingGroup."Net Salary Payable")
                            else begin
                                NhifRL := GetNHIFRelief(PeriodTrans."Employee Code");
                                AmountToCredit := AmountToCredit - NhifRL;
                                CreateJnlEntry(IntegerPostAs, PeriodTrans."Journal Account Code",
                             GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + PeriodTrans."Employee Code", AmountToDebit, AmountToCredit,
                             PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType, PostingGroup."Net Salary Payable");
                            end;

                            //Pension
                            //    IF PeriodTrans."coop parameters"=PeriodTrans."coop parameters"::Pension THEN BEGIN
                            TransCode.Reset();
                            TransCode.SetRange(TransCode."Transaction Code", PeriodTrans."Transaction Code");
                            TransCode.SetRange(TransCode."Special Transactions", TransCode."special transactions"::"Defined Contribution");
                            if TransCode.Find('-') then begin

                                //Get from Employer Deduction
                                EmployerDed.Reset();
                                EmployerDed.SetRange(EmployerDed."Employee Code", PeriodTrans."Employee Code");
                                EmployerDed.SetRange(EmployerDed."Transaction Code", PeriodTrans."Transaction Code");
                                EmployerDed.SetRange(EmployerDed."Payroll Period", PeriodTrans."Payroll Period");
                                if EmployerDed.Find('-') then begin
                                    //Credit Payables
                                    CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + PeriodTrans."Employee Code", 0,
                                    EmployerDed.Amount, PeriodTrans."Post As", '', SaccoTransactionType, PostingGroup."Pension Payable Acc");

                                    //Debit Staff Expense
                                    CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                                    GlobalDim1, GlobalDim2, PeriodTrans."Transaction Code" + '-' + PeriodTrans."Employee Code", EmployerDed.Amount, 0, 1, '',
                                    SaccoTransactionType, PostingGroup."Pension Payable Acc");
                                end;
                            end;

                            //NSSF
                            if PeriodTrans."Transaction Code" = 'NSSF' then begin
                                //Credit Payables
                                //Credit Payables

                                CreateJnlEntry(0, PostingGroup."NSSF Employee Account",
                                GlobalDim1, GlobalDim2, 'Emp:' + PeriodTrans."Transaction Code" + '-' + PeriodTrans."Employee Code", 0, PeriodTrans.Amount,
                                PeriodTrans."Post As", '', SaccoTransactionType, PostingGroup."NSSF Payable Acc");

                                //Debit Staff Expense

                                CreateJnlEntry(0, PostingGroup."NSSF Employer Account",
                                GlobalDim1, GlobalDim2, 'Emp:' + PeriodTrans."Transaction Code" + '-' + PeriodTrans."Employee Code", PeriodTrans.Amount, 0, 1, '',
                                SaccoTransactionType, PostingGroup."NSSF Payable Acc");
                            end;
                            //Housing Levy
                            if PeriodTrans."Transaction Code" = 'HLEVY' then begin
                                //Credit Payables

                                CreateJnlEntry(0, PostingGroup."Housing Levy Employee Account",
                                GlobalDim1, GlobalDim2, 'Emp:' + PeriodTrans."Transaction Code" + '-' + PeriodTrans."Employee Code", 0, PeriodTrans.Amount,
                                PeriodTrans."Post As", '', SaccoTransactionType, PostingGroup."Net Salary Payable");

                                //Debit Staff Expense

                                CreateJnlEntry(0, PostingGroup."Housing Levy Employer Account",
                                GlobalDim1, GlobalDim2, 'Emp:' + PeriodTrans."Transaction Code" + '-' + PeriodTrans."Employee Code", PeriodTrans.Amount, 0, 1, '',
                                SaccoTransactionType, PostingGroup."Net Salary Payable");
                            end;
                        end;
                    until PeriodTrans.Next() = 0;

                    //Gratuity
                    //Get from Employer Deduction
                    EmployerDed.Reset();
                    EmployerDed.SetRange(EmployerDed."Employee Code", "Employee Code");
                    EmployerDed.SetRange(EmployerDed."Transaction Code", 'GRAT');
                    EmployerDed.SetRange(EmployerDed."Payroll Period", SelectedPeriod);
                    if EmployerDed.Find('-') then begin
                        //Credit Payables
                        CreateJnlEntry(0, PostingGroup.StaffGratuityCredit,
                        GlobalDim1, GlobalDim2, 'Gratuity-' + PeriodTrans."Employee Code", 0,
                        EmployerDed.Amount, PeriodTrans."Post As", '', SaccoTransactionType, '');

                        //Debit Staff Expense
                        CreateJnlEntry(0, PostingGroup.StaffGratuityDebit,
                        GlobalDim1, GlobalDim2, 'Gratuity-' + PeriodTrans."Employee Code", EmployerDed.Amount, 0, 1, '',
                        SaccoTransactionType, '');
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
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
                field(PeriodFilter; PeriodFilter)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Period Filter';
                    Lookup = true;
                    LookupPageID = "prPayroll Periods";
                    TableRelation = "prPayroll Periods";
                    ToolTip = 'Specifies the value of the Period Filter field.';
                }
                field(PayrollPostingGroup; PayrollPostingGroup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Posting Group';
                    Lookup = true;
                    LookupPageID = "prEmployee Posting Group";
                    TableRelation = "prEmployee Posting Group";
                    ToolTip = 'Specifies the value of the Payroll Posting Group field.';
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

    trigger OnPreReport()
    begin
        //PeriodFilter:="prSalary Card".GETFILTER("Period Filter");
        if PeriodFilter = 0D then
            Error('You must specify the period filter');
        if PayrollPostingGroup = '' then
            error('You must specify the Posting Group');

        SelectedPeriod := PeriodFilter;
        objPeriod.Reset();
        if objPeriod.Get(SelectedPeriod) then
            PeriodName := objPeriod."Period Name";

        PostingDate := CalcDate('1M-1D', SelectedPeriod);
    end;

    trigger OnPostReport()
    var
        credits: Decimal;

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
    end;
    //Rounding Off

    var
        GenJnlBatch: Record "Gen. Journal Batch";
        GeneraljnlLine: Record "Gen. Journal Line";
        objEmp: Record "HR-Employee";
        PostingGroup: Record "prEmployee Posting Group";
        EmployerDed: Record "prEmployer Deductions";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        PeriodTrans2: Record "prPeriod Transactions";
        TransCode: Record "PR Transaction Codes";
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        PayrollPostingGroup: Code[20];
        "Slip/Receipt No": Code[50];
        PeriodFilter: Date;
        PostingDate: Date;
        SelectedPeriod: Date;
        AmountToCredit: Decimal;
        AmountToDebit: Decimal;
        NhifRL: Decimal;
        IntegerPostAs: Integer;
        LineNumber: Integer;
        SaccoTransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2";
        PeriodName: Text[30];
        strEmpName: Text[150];

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
        //GeneraljnlLine."Account Type":=AccountType;
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
        //GeneraljnlLine."Bal. Account No." := BalAccountNo;
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
