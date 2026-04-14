report 85308 "Salary Transfer Batch"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("prTransaction Codes"; "PR Transaction Codes")
        {
            RequestFilterFields = "Transaction Code";

            trigger OnAfterGetRecord()
            begin
                //For use when posting Pension and NSSF
                PostingGroup.GET(SelectedPostingGroup);
                PostingGroup.TESTFIELD("NSSF Employer Account");
                PostingGroup.TESTFIELD("NSSF Employee Account");
                PostingGroup.TESTFIELD("Pension Employer Acc");
                PostingGroup.TESTFIELD("Pension Employee Acc");
                PostingGroup.TESTFIELD("Housing Levy Employee Account");
                PostingGroup.TESTFIELD("Housing Levy Employer Account");

                LineNumber := LineNumber + 10;
                PeriodTrans.RESET();
                PeriodTrans.SETCURRENTKEY("Employee Code", "Transaction Code", "Period Month", "Period Year", Membership, "Reference No");
                PeriodTrans.SETRANGE(PeriodTrans."Transaction Code", "Transaction Code");
                PeriodTrans.SETRANGE(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SETFILTER(PeriodTrans."Journal Account Code", '<>%1', '');
                PeriodTrans.SETRANGE(PeriodTrans."Posting Group", SelectedPostingGroup);
                //Added
                IF EmployeeNo <> '' THEN
                    PeriodTrans.SETFILTER("Employee Code", EmployeeNo);
                IF Directorate <> '' THEN;
                //PeriodTrans.SETRANGE(PeriodTrans."Global Dimension 1 Code",Directorate);
                //Added
                IF PeriodTrans.FINDSET(FALSE, FALSE) THEN BEGIN
                    //REPEAT

                    //Sum all trans
                    PeriodTrans.CALCSUMS(PeriodTrans.Amount);

                    MyDialog.UPDATE(1, PeriodTrans."Transaction Code" + ' - ' + PeriodTrans."Transaction Name");

                    IF PeriodTrans."Journal Account Code" <> '' THEN BEGIN
                        AmountToDebit := 0;
                        AmountToCredit := 0;
                        IF PeriodTrans."Post As" = PeriodTrans."Post As"::Debit THEN
                            AmountToDebit := PeriodTrans.Amount;

                        IF PeriodTrans."Post As" = PeriodTrans."Post As"::Credit THEN
                            AmountToCredit := PeriodTrans.Amount;

                        IF PeriodTrans."Journal Account Type" = JAC::"G/L Account" THEN  //GL
                            IntegerPostAs := 0;   //0 debit
                        IF PeriodTrans."Journal Account Type" = JAC::Customer THEN
                            IntegerPostAs := 1;  // 1 =
                        IF PeriodTrans."Journal Account Type" = JAC::Vendor THEN
                            IntegerPostAs := 2;  // 1 =

                        SaccoTransactionType := SaccoTransactionType::" ";

                        IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::loan THEN
                            SaccoTransactionType := SaccoTransactionType::Repayment;

                        IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::"loan Interest" THEN
                            SaccoTransactionType := SaccoTransactionType::"Interest Paid";

                        IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Welfare THEN
                            SaccoTransactionType := SaccoTransactionType::"Welfare Contribution";

                        IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::shares THEN
                            SaccoTransactionType := SaccoTransactionType::"Deposit Contribution";

                        CreateJnlEntry(IntegerPostAs, PeriodTrans."Journal Account Code",
                        GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Transaction Code", AmountToDebit, AmountToCredit,
                        PeriodTrans."Post As", PeriodTrans."Loan Number", SaccoTransactionType);

                        //Pension
                        IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::Pension THEN BEGIN

                            //Get from Employer Deduction
                            EmployerDed.RESET();
                            // EmployerDed.SETRANGE(EmployerDed."Posting Group",SelectedPostingGroup);
                            EmployerDed.SETCURRENTKEY("Employee Code", "Transaction Code", "Period Month", "Period Year", "Payroll Period");
                            EmployerDed.SETRANGE(EmployerDed."Transaction Code", PeriodTrans."Transaction Code");
                            EmployerDed.SETRANGE(EmployerDed."Payroll Period", PeriodTrans."Payroll Period");
                            //Added
                            IF EmployeeNo <> '' THEN
                                EmployerDed.SETFILTER("Employee Code", EmployeeNo);
                            IF Directorate <> '' THEN;
                            //  EmployerDed.SETRANGE(EmployerDed."Global Dimension 1 Code",Directorate);
                            //Added

                            IF EmployerDed.FINDSET(FALSE, FALSE) THEN BEGIN
                                //Credit Payables
                                EmployerDed.CALCSUMS(EmployerDed.Amount);

                                CreateJnlEntry(0, PostingGroup."Pension Employee Acc",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Transaction Code", 0,
                               EmployerDed.Amount, PeriodTrans."Post As", '', SaccoTransactionType);

                                //Debit Staff Expense
                                CreateJnlEntry(0, PostingGroup."Pension Employer Acc",
                                GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Transaction Code", EmployerDed.Amount, 0, 1, '',
                                SaccoTransactionType);
                            END;
                        END;

                        //NSSF
                        IF PeriodTrans."coop parameters" = PeriodTrans."coop parameters"::NSSF THEN BEGIN
                            //Credit Payables
                            //Credit Payables

                            CreateJnlEntry(0, PostingGroup."NSSF Employee Account",
                            GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Transaction Code", 0, PeriodTrans.Amount,
                            PeriodTrans."Post As", '', SaccoTransactionType);

                            //Debit Staff Expense

                            CreateJnlEntry(0, PostingGroup."NSSF Employer Account",
                            GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Transaction Code", PeriodTrans.Amount, 0, 1, '',
                            SaccoTransactionType);
                        END;
                        IF PeriodTrans."Transaction Code" = 'HLEVY' THEN BEGIN
                            //Credit Payables
                            //Credit Payables

                            CreateJnlEntry(0, PostingGroup."Housing Levy Employee Account",
                            GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Transaction Code", 0, PeriodTrans.Amount,
                            PeriodTrans."Post As", '', SaccoTransactionType);

                            //Debit Staff Expense

                            CreateJnlEntry(0, PostingGroup."Housing Levy Employer Account",
                            GlobalDim1, GlobalDim2, PeriodTrans."Transaction Name" + '-' + PeriodTrans."Transaction Code", PeriodTrans.Amount, 0, 1, '',
                            SaccoTransactionType);
                        END;
                    END;

                    //UNTIL PeriodTrans.NEXT=0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                EndTime := CREATEDATETIME(TODAY, TIME);
                TotalTimeTaken := EndTime - StartTime;

                MyDialog.CLOSE();
                MESSAGE('Payroll Journal Generated Succesfully [%1]', TotalTimeTaken);
            end;

            trigger OnPreDataItem()
            begin
                BNAME := SelectedPostingGroup;
                IF SelectedPostingGroup <> '' THEN
                    BNAME := 'SALARIES';
                GenJournalLine.RESET();
                GenJournalLine.SETRANGE("Journal Template Name", 'GENERAL');
                GenJournalLine.SETRANGE("Journal Batch Name", BNAME);
                IF GenJournalLine.FIND('-') THEN
                    //******************************* Check if journal journal has entries for a different period *******************************
                    IF (GenJournalLine."Document No." <> UPPERCASE(PeriodName)) AND (GenJournalLine.COUNT > 2) THEN
                        ERROR(Text10001, GenJournalLine.COUNT, GenJournalLine."Document No.")
                    ELSE BEGIN
                        //Journal Approval Status
                        GenJnlBatch.RESET();
                        GenJnlBatch.SETRANGE(GenJnlBatch."Journal Template Name", 'GENERAL');
                        GenJnlBatch.SETRANGE(GenJnlBatch.Name, BNAME);
                        IF GenJnlBatch.FIND('-') THEN;

                        //Clear journal
                        GenJournalLine.DELETEALL();
                    END;
                //******************************* Check if journal journal has entries for a different period *******************************

                LineNo := 10000;

                //Create batch*****************************************************************************
                //MESSAGE('get the journal batch');
                GenJnlBatch.RESET();
                GenJnlBatch.SETRANGE(GenJnlBatch."Journal Template Name", 'GENERAL');
                GenJnlBatch.SETRANGE(GenJnlBatch.Name, BNAME);
                IF GenJnlBatch.FIND('-') = FALSE THEN BEGIN
                    GenJnlBatch.INIT();
                    GenJnlBatch."Journal Template Name" := 'GENERAL';
                    GenJnlBatch.Name := BNAME;
                    GenJnlBatch.INSERT();
                END;
                // End Create Batch************************************************************************
                "Slip/Receipt No" := UPPERCASE(objPeriod."Period Name");
                DialogInfo := Text0006 + Text0009 + Text0010;
                MyDialog.OPEN(DialogInfo);  //**
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(General)
                {
                    Caption = 'Options';
                    field(PeriodFilter; PeriodFilter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Period';
                        TableRelation = "prPayroll Periods"."Date Opened";
                        ToolTip = 'Specifies the value of the Payroll Period field.';
                    }
                    field(SelectedPostingGroup; SelectedPostingGroup)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posting Group';
                        TableRelation = "prEmployee Posting Group";
                        ToolTip = 'Specifies the value of the Posting Group field.';
                    }
                    field(EmployeeNo; EmployeeNo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee No.';
                        TableRelation = "HR-Employee"."No.";
                        ToolTip = 'Specifies the value of the Employee No. field.';
                    }
                    field(Directorate; Directorate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Department';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                        ToolTip = 'Specifies the value of the Department field.';
                    }
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
    var
    //  HRPRAccess: Record "70134810";
    begin
        StartTime := CREATEDATETIME(TODAY, TIME);
        EndTime := CREATEDATETIME(0D, 0T);
        CLEAR(TotalTimeTaken);

        IF PeriodFilter = 0D THEN
            ERROR('You must specify the period filter');
        IF SelectedPostingGroup = '' THEN
            ERROR('Please select Posting Group to transfer to Journal');
        SelectedPeriod := PeriodFilter;
        objPeriod.RESET();
        IF objPeriod.GET(SelectedPeriod) THEN
            PeriodName := objPeriod."Period Name";

        PostingDate := CALCDATE('1M-1D', SelectedPeriod);
        IF CompanyInfo.GET() THEN
            CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

        //Dan - Ensure All TransCode have respective GL
        TransCode.RESET();
        TransCode.SETFILTER(TransCode."Transaction Code", '<>%1', '');
        IF TransCode.FINDFIRST() THEN
            REPEAT
                TransCode.TESTFIELD(TransCode."GL Account");
            UNTIL TransCode.NEXT() = 0;
        //Dan - Ensure All TransCode have respective GL
    end;

    var
        CompanyInfo: Record "Company Information";
        GenJnlBatch: Record "Gen. Journal Batch";
        GeneraljnlLine: Record "Gen. Journal Line";
        GenJournalLine: Record "Gen. Journal Line";
        PostingGroup: Record "prEmployee Posting Group";
        EmployerDed: Record "prEmployer Deductions";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        TransCode: Record "PR Transaction Codes";
        SelectedPostingGroup: Code[10];
        BNAME: Code[20];
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        "Slip/Receipt No": Code[50];
        Directorate: Code[100];
        EmployeeNo: Code[100];
        PeriodFilter: Date;
        PostingDate: Date;
        SelectedPeriod: Date;
        EndTime: DateTime;
        StartTime: DateTime;
        AmountToCredit: Decimal;
        AmountToDebit: Decimal;
        MyDialog: Dialog;
        TotalTimeTaken: Duration;
        IntegerPostAs: Integer;
        LineNo: Integer;
        LineNumber: Integer;
        Text0006: Label '#1############################3######';
        Text0009: Label '#2######';
        Text0010: Label '#3######';
        Text10001: Label 'There are [%1] entries that exist in the Journal for Payroll Period [%2] Please post the before generating a new Journal';
        JAC: Option " ","G/L Account",Customer,Vendor;
        SaccoTransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Welfare Contribution","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Welfare Contribution 2";
        DialogInfo: Text;
        PeriodName: Text[30];

    procedure CreateJnlEntry(AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[20]; GlobalDime1: Code[20]; GlobalDime2: Code[20]; Description: Text[150]; DebitAmount: Decimal; CreditAmount: Decimal; PostAs: Option " ",Debit,Credit; LoanNo: Code[20]; TransType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Loan Penalty","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee Due","Loan Guard",Prepayment,"Administration Fee Paid","Car Savings","SchFees Savings","Holiday Savings","CIC Fixed Deposit","Withdrawable Savings","Children Savings","KMA Investment","KMA Fixed Deposit","UAP Premiums","UAP Admin Fee","Direct Debit")
    begin

        LineNumber := LineNumber + 100;
        GeneraljnlLine.INIT();
        GeneraljnlLine."Journal Template Name" := 'GENERAL';
        GeneraljnlLine."Journal Batch Name" := BNAME;
        GeneraljnlLine."Line No." := LineNumber;
        GeneraljnlLine."Document No." := "Slip/Receipt No";
        GeneraljnlLine."Posting Date" := PostingDate;
        GeneraljnlLine."Account Type" := AccountType;
        GeneraljnlLine."Account No." := AccountNo;
        GeneraljnlLine.VALIDATE(GeneraljnlLine."Account No.");
        GeneraljnlLine.Description := Description;
        IF PostAs = PostAs::Debit THEN BEGIN
            GeneraljnlLine."Debit Amount" := DebitAmount;
            GeneraljnlLine.VALIDATE("Debit Amount");
        END ELSE BEGIN
            GeneraljnlLine."Credit Amount" := CreditAmount;
            GeneraljnlLine.VALIDATE("Credit Amount");
        END;
        GeneraljnlLine."Shortcut Dimension 1 Code" := GlobalDime1;
        GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 1 Code");
        GeneraljnlLine."Shortcut Dimension 2 Code" := GlobalDime2;
        GeneraljnlLine.VALIDATE(GeneraljnlLine."Shortcut Dimension 2 Code");
        IF GeneraljnlLine.Amount <> 0 THEN
            GeneraljnlLine.INSERT();
    end;
}
