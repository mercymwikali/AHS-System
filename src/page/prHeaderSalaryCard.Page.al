Page 85774 "prHeader Salary Card"
{
    // strempcode,dtDOE,curbasicpay,blnpaye,blnnssf,blnnhif,selectedperio,dtopenperio,
    // membership,referenceno,dttermination,blngetspayereleif

    PageType = Document;
    SaveValues = true;
    SourceTable = "HR-Employee";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(EmployeeDetails)
            {
                Caption = 'Employee Details';
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(LastName; Rec."Last Name")
                {
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(FirstName; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                }
                field(DepartmentCode; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(DateOfJoin; Rec."Date Of Join")
                {
                    ToolTip = 'Specifies the value of the Date Of Join field.';
                }
                field(FullPartTime; Rec."Full / Part Time")
                {
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Full / Part Time field.';
                }
                field(ContractEndDate; Rec."Contract End Date")
                {
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(Disabled; Rec.Disabled)
                {
                    ToolTip = 'Specifies the value of the Disabled field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status Reasons field.';
                }
            }
            group(PayrollDetails)
            {
                field(NSSFNo; Rec."NSSF No.")
                {
                    ToolTip = 'Specifies the value of the NSSF No. field.';
                }
                field(NHIFNo; Rec."NHIF No.")
                {
                    ToolTip = 'Specifies the value of the NHIF No. field.';
                }
                field(PINNumber; Rec."PIN Number")
                {
                    ToolTip = 'Specifies the value of the PIN Number field.';
                }
                field(PayrollCode; Rec."Payroll Code")
                {
                    ToolTip = 'Specifies the value of the Payroll Code field.';
                }
                field(JobSpecification; Rec."Job Specification")
                {
                    ToolTip = 'Specifies the value of the Job ID field.';
                }
                field(SalaryCategory; Rec."Salary Category")
                {
                    ToolTip = 'Specifies the value of the Salary Category field.';
                }
                field(SalaryGrade; Rec."Salary Grade")
                {
                    ToolTip = 'Specifies the value of the Salary Grade field.';
                }
                field(GradeLevel; Rec."Grade Level")
                {
                    Caption = 'Salary Step';
                    ToolTip = 'Specifies the value of the Salary Step field.';
                }

            }
            group(Posting)
            {
                Caption = 'Posting';
                field(PostingGroup; Rec."Posting Group")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Posting Group field.';
                }
                field("Payroll Posting Group"; Rec."Payroll Posting Group")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Payroll Posting Group field.';
                }
                field(PaymentMode; Rec."Payment Mode")
                {
                    ToolTip = 'Specifies the value of the Payment Mode field.';
                }
                field("Main Bank1"; Rec."Main Bank")
                {
                    ToolTip = 'Specifies the value of the Main Bank field.';
                }
                field("Branch Bank1"; Rec."Branch Bank")
                {
                    ToolTip = 'Specifies the value of the Branch Bank field.';
                }
                field("Bank Account Number1"; Rec."Bank Account Number")
                {
                    ToolTip = 'Specifies the value of the Bank Account Number field.';
                }
            }
            part(Control1102756041; prSalaryCard)
            {
                Caption = 'Salary Details';
                SubPageLink = "Employee Code" = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Transactions)
            {
                Caption = 'Transactions';
                action(AssignTransaction)
                {
                    Caption = 'Assign Transaction';
                    Image = ApplyEntries;
                    Promoted = true;
                    RunObject = Page "prList Transactions";
                    RunPageLink = "Employee Code" = field("No.");
                    ToolTip = 'Executes the Assign Transaction action.';
                }
                separator(Action1102756009)
                {
                }
                action(ViewTransCodes)
                {
                    Caption = 'View Trans Codes';
                    Image = ViewDetails;
                    Promoted = true;
                    RunObject = Page "prList TransCode";
                    ToolTip = 'Executes the View Trans Codes action.';
                }
                separator(Action1102756011)
                {
                }
            }
            group(OtherInfo)
            {
                Caption = 'Other Info';
                action(BankingDetails)
                {
                    Caption = 'Banking Details';
                    Image = BankAccount;
                    RunObject = Page "prEmployee Trans PCA";
                    RunPageLink = "Employee Code" = field("No.");
                    ToolTip = 'Executes the Banking Details action.';
                }
                separator(Action1102756059)
                {
                }
                action(PensionDetails)
                {
                    Caption = 'Pension Details';
                    Image = History;
                    RunObject = Page "Pension Contribution Details";
                    RunPageLink = "Employee Code" = field("No.");
                    ToolTip = 'Executes the Pension Details action.';
                }
                action("Refresh HR Employees")
                {
                    Image = UpdateDescription;
                    ToolTip = 'Executes the Refresh HR Employees action.';

                    trigger OnAction()
                    begin
                        i := 0;
                        HREmp.Reset();
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Normal);
                        if HREmp.Find('-') then
                            repeat
                                if not objEmp.Get(HREmp."No.") then begin
                                    i := i + 1;
                                    objEmp.Init();
                                    objEmp."No." := HREmp."No.";
                                    objEmp."First Name" := HREmp."First Name";
                                    objEmp."Middle Name" := HREmp."Middle Name";
                                    objEmp."Last Name" := HREmp."Last Name";
                                    objEmp.Initials := HREmp.Initials;
                                    objEmp."Search Name" := HREmp."Search Name";
                                    objEmp."Cellular Phone Number" := HREmp."Cellular Phone Number";
                                    objEmp."E-Mail" := HREmp."E-Mail";
                                    objEmp."ID Number" := HREmp."ID Number";
                                    objEmp.Gender := HREmp.Gender;
                                    objEmp.Status := objEmp.Status::Normal;
                                    objEmp."Company E-Mail" := HREmp."Company E-Mail";
                                    objEmp."Date Of Birth" := HREmp."Date Of Birth";
                                    objEmp."Date Of Join" := HREmp."Date Of Join";
                                    objEmp."PIN Number" := HREmp."PIN Number";
                                    objEmp."NSSF No." := HREmp."NSSF No.";
                                    objEmp."NHIF No." := HREmp."NHIF No.";
                                    objEmp."Shortcut Dimension 2 Code" := HREmp."Shortcut Dimension 2 Code";
                                    objEmp."Posting Group" := 'PAYROLL';
                                    objEmp.Insert();
                                end else begin
                                    j := j + 1;
                                    objEmp."First Name" := HREmp."First Name";
                                    objEmp."Middle Name" := HREmp."Middle Name";
                                    objEmp."Last Name" := HREmp."Last Name";
                                    objEmp.Initials := HREmp.Initials;
                                    objEmp."Search Name" := HREmp."Search Name";
                                    objEmp."Cellular Phone Number" := HREmp."Cellular Phone Number";
                                    objEmp."E-Mail" := HREmp."E-Mail";
                                    objEmp."ID Number" := HREmp."ID Number";
                                    objEmp.Gender := HREmp.Gender;
                                    objEmp.Status := objEmp.Status::Normal;
                                    objEmp."Company E-Mail" := HREmp."Company E-Mail";
                                    objEmp."Date Of Birth" := HREmp."Date Of Birth";
                                    objEmp."Date Of Join" := HREmp."Date Of Join";
                                    objEmp."PIN Number" := HREmp."PIN Number";
                                    objEmp."NSSF No." := HREmp."NSSF No.";
                                    objEmp."NHIF No." := HREmp."NHIF No.";
                                    objEmp."Shortcut Dimension 2 Code" := HREmp."Shortcut Dimension 2 Code";
                                    objEmp."Posting Group" := 'PAYROLL';
                                    objEmp.Modify();
                                end;
                            until HREmp.Next() = 0;
                        Message(Format(i) + ' Employees Created, ' + Format(j) + ' Employees Updated');
                    end;
                }
            }
        }
        area(reporting)
        {
            action(View2PagePayslip)
            {
                Caption = 'View Payslip';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the View Payslip action.';

                trigger OnAction()
                begin

                    objPeriod.Reset();
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    //CLEAR(objOcx);
                    //objOcx.fnMandatoryProcesses;

                    //Display payslip report
                    SalCard.SetRange("Employee Code", Rec."No.");
                    SalCard.SetRange(SalCard."Period Filter", SelectedPeriod);
                    Report.Run(52202581, true, false, SalCard);
                end;
            }
            action(ViewhorPayslip)
            {
                Caption = 'Payslip (Horizontal)';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Payslip (Horizontal) action.';

                trigger OnAction()
                begin

                    objPeriod.Reset();
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    SalCard.Reset();
                    SalCard.SetRange(SalCard."Employee Code", Rec."No.");
                    SalCard.SetRange(SalCard."Payroll Period", SelectedPeriod);
                    if SalCard.Find('-') then
                        Report.Run(52202581, true, false, SalCard);
                end;
            }
            action(View3PagePayslip)
            {
                Caption = 'View3 Pages Payslip';
                Image = PaymentHistory;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the View3 Pages Payslip action.';

                trigger OnAction()
                begin

                    objPeriod.Reset();
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    //CLEAR(objOcx);
                    //objOcx.fnMandatoryProcesses;

                    //Display payslip report
                    SalCard.SetRange("Employee Code", Rec."No.");
                    SalCard.SetRange(SalCard."Period Filter", SelectedPeriod);
                    Report.Run(52202581, true, false, SalCard);
                end;
            }
            action(MasterPayrollSummary)
            {
                Caption = 'Master Payroll Summary';
                Image = "Report";
                Promoted = true;
                RunObject = Report "Company Payroll Summary 3";
                ToolTip = 'Executes the Master Payroll Summary action.';
            }
            action(DeductionsSummary2)
            {
                Caption = 'Deductions Summary 2';
                Image = "Report";
                Promoted = true;
                RunObject = Report "Deductions Summary 2";
                ToolTip = 'Executes the Deductions Summary 2 action.';
            }
            action(EarningsSummary2)
            {
                Caption = 'Earnings Summary 2';
                Image = "Report";
                Promoted = true;
                RunObject = Report "Payments Summary 2";
                ToolTip = 'Executes the Earnings Summary 2 action.';
            }
            action(P10)
            {
                Caption = 'P.10';
                Image = "Report";
                Promoted = true;
                RunObject = Report "P.10 A mst";
                ToolTip = 'Executes the P.10 action.';
            }
            action(PayeScheule)
            {
                Caption = 'Paye Scheule';
                Image = "Report";
                Promoted = true;
                RunObject = Report "prPaye Schedule mst";
                ToolTip = 'Executes the Paye Scheule action.';
            }
            action(NHIFSchedult)
            {
                Caption = 'NHIF Schedult';
                Image = "Report";
                Promoted = true;
                RunObject = Report "prNHIF mst";
                ToolTip = 'Executes the NHIF Schedult action.';
            }
            action(NSSFSchedule)
            {
                Caption = 'NSSF Schedule';
                Image = "Report";
                Promoted = true;
                RunObject = Report "prNSSF mst";
                ToolTip = 'Executes the NSSF Schedule action.';
            }
        }
        area(processing)
        {
            action(ProcessPayroll)
            {
                Caption = 'Process Payslip';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                ToolTip = 'Executes the Process Payslip action.';

                trigger OnAction()
                var
                    PrEmployeeTransactions: Record "prEmployee Transactions";
                    progressDialog: Dialog;
                    TotalCount: Integer;
                    CurrentCount: Integer;
                    Var1: Code[10];
                    progre: Dialog;
                    counted: Integer;
                    counts: Integer;
                    text1: label '.';
                    text2: label '.  .';
                    text3: label '.  .  .';
                    text4: label '.  .  .  .';
                    text5: label '.  .  .  .  .';
                    text6: label '.  .  .  .  .  .';
                    text7: label '.  .  .  .  .  .  .';
                    text8: label '.  .  .  .  .  .  .  .';
                    text9: label '.  .  .  .  .  .  .  .  .';
                    text10: label '.  .  .  .  .  .  .  .  .  .';
                    progDots: Text[50];
                    RecCount1: Text[120];
                    RecCount2: Text[120];
                    RecCount3: Text[120];
                    RecCount4: Text[120];
                    RecCount5: Text[120];
                    RecCount6: Text[120];
                    RecCount7: Text[120];
                    RecCount8: Text[120];
                    RecCount9: Text[120];
                    RecCount10: Text[120];
                    BufferString: Text[1024];
                begin
                    ContrInfo.Get();

                    if Confirm('This will process salaries for all employees, Continue?', false) = false then
                        exit;

                    objPeriod.Reset();
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    //SalCard.GET("No.");
                    /*
                          PeriodTrans.RESET;
                          PeriodTrans.SETRANGE(PeriodTrans."Payroll Period",SelectedPeriod);
                          IF PeriodTrans.FIND('-') THEN
                          PeriodTrans.DELETEALL;
                    */

                    //Use CODEUNIT
                    HrEmployee.Reset();
                    HrEmployee.SetRange(HrEmployee."Status 1", HrEmployee."Status 1"::Active);
                    HrEmployee.SetRange(Exclude, false);
                    TotalCount := HrEmployee.count();
                    if HrEmployee.Find('-') then begin
                        // if HrEmployee."Contract Start Date" = 0D then begin
                        //     HrEmployee."Contract Start Date" := 20000101D;
                        //     HrEmployee.Modify();
                        // end;
                        /*
                        PeriodTrans.RESET;
                           PeriodTrans.SETRANGE(PeriodTrans."Employee Code",HrEmployee."No.");
                           PeriodTrans.SETRANGE(PeriodTrans."Payroll Period",SelectedPeriod);
                           IF PeriodTrans.FIND('-') THEN
                           PeriodTrans.DELETEALL;
                           */

                        ProgressDialog.Open('Processing employees... #1 of #2', CurrentCount, TotalCount);

                        repeat
                            CurrentCount += 1;
                            DOJ := 0D;

                            dateofJoining := 0D;
                            dateofLeaving := CalcDate('<100Y>', Today);
                            if HrEmployee."Date Of Join" = 0D then
                                dateofJoining := CalcDate('<-1M>', Today);

                            salaryCard.Reset();
                            salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                            if not salaryCard.Find('-') then begin

                                if salaryCard.Find('-') then
                                    if salaryCard."Suspend Pay" <> true then begin
                                        //IF salaryCard."Gets Personal Relief"=salaryCard."Gets Personal Relief"::"1" THEN GetsPAYERelief:=TRUE ELSE GetsPAYERelief:=FALSE;
                                        GetsPAYERelief := salaryCard."Pays PAYE";
                                        if HrEmployee."Date Of Join" = 0D then
                                            DOJ := CalcDate('<-2M>', Today)
                                        else
                                            DOJ := HrEmployee."Date Of Join";
                                        salaryCard.Reset();
                                        salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                                        ////salaryCard.SETFILTER(salaryCard.Closed,'=%1',FALSE);
                                        if salaryCard.Find('-') then
                                            if salaryCard."Suspend Pay" = true then begin
                                                PeriodTransactions.Reset();
                                                PeriodTransactions.SetRange(PeriodTransactions."Employee Code", HrEmployee."No.");
                                                PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);
                                                if PeriodTransactions.Find('-') then
                                                    PeriodTransactions.DELETEALL();
                                            end// delete stuff from transactions table
                                            else begin
                                                if "Payroll Posting Group" <> '' THEN
                                                    ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE", salaryCard."Pays NSSF", salaryCard."Pays SHA", SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");

                                                // ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays NSSF", false, false, SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");

                                                Clear(Var1);
                                                counts := counts + 1;
                                                if ((counted = 21) or (counted = 11)) then begin
                                                    if counted = 21 then
                                                        counted := 0;
                                                    Sleep(150);
                                                end;
                                                counted := counted + 1;
                                                progDots := '';
                                                case counted of
                                                    1:
                                                        progDots := text1;
                                                    2:
                                                        progDots := text2;
                                                    3:
                                                        progDots := text3;
                                                    4:
                                                        progDots := text4;
                                                    5:
                                                        progDots := text5;
                                                    6:
                                                        progDots := text6;
                                                    7:
                                                        progDots := text7;
                                                    8:
                                                        progDots := text8;
                                                    9:
                                                        progDots := text9;
                                                    10:
                                                        progDots := text10;
                                                    11:
                                                        progDots := text9;
                                                    12:
                                                        progDots := text8;
                                                    13:
                                                        progDots := text7;
                                                    14:
                                                        progDots := text6;
                                                    15:
                                                        progDots := text5;
                                                    16:
                                                        progDots := text4;
                                                    17:
                                                        progDots := text3;
                                                    18:
                                                        progDots := text2;
                                                    19:
                                                        progDots := text1;
                                                    else
                                                        progDots := '';

                                                end;
                                                case counts of
                                                    1:
                                                        RecCount1 := CopyStr(Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name", 1, MaxStrLen(RecCount1));
                                                    2:
                                                        RecCount2 := CopyStr(Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name", 1, MaxStrLen(RecCount2));
                                                    3:
                                                        RecCount3 := CopyStr(Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name", 1, MaxStrLen(RecCount3));
                                                    4:
                                                        RecCount4 := CopyStr(Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name", 1, MaxStrLen(RecCount4));
                                                    5:
                                                        RecCount5 := CopyStr(Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name", 1, MaxStrLen(RecCount5));
                                                    6:
                                                        RecCount6 := CopyStr(Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name", 1, MaxStrLen(RecCount6));
                                                    7:
                                                        RecCount7 := CopyStr(Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name", 1, MaxStrLen(RecCount7));
                                                    8:
                                                        RecCount8 := CopyStr(Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name", 1, MaxStrLen(RecCount8));
                                                    9:
                                                        RecCount9 := CopyStr(Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name", 1, MaxStrLen(RecCount9));
                                                    10:
                                                        RecCount10 := CopyStr(Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name", 1, MaxStrLen(RecCount10));
                                                    else
                                                        if counts > 10 then begin
                                                            RecCount1 := RecCount2;
                                                            RecCount2 := RecCount3;
                                                            RecCount3 := RecCount4;
                                                            RecCount4 := RecCount5;
                                                            RecCount5 := RecCount6;
                                                            RecCount6 := RecCount7;
                                                            RecCount7 := RecCount8;
                                                            RecCount8 := RecCount9;
                                                            RecCount9 := RecCount10;
                                                            RecCount10 := CopyStr(Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name", 1, MaxStrLen(RecCount10));
                                                        end;

                                                end;
                                                Clear(BufferString);
                                                BufferString := 'Total Records processed = ' + Format(counts);

                                                progre.Update();
                                                Sleep(50);
                                            end;
                                        //   END;
                                    end;
                            end else begin
                                // If employee has no Basic Salary
                                PrEmployeeTransactions.Reset();
                                PrEmployeeTransactions.SetRange(PrEmployeeTransactions."Employee Code", HrEmployee."No.");
                                PrEmployeeTransactions.SetRange(PrEmployeeTransactions."Payroll Period", SelectedPeriod);
                                if not PrEmployeeTransactions.IsEmpty() then begin
                                    PeriodTransactions.Reset();
                                    PeriodTransactions.SetRange(PeriodTransactions."Employee Code", HrEmployee."No.");
                                    PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);
                                    if PeriodTransactions.Find('-') then
                                        PeriodTransactions.DELETEALL(); // Delete Processed Transactions
                                    IF "Payroll Posting Group" <> '' THEN
                                        ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE", salaryCard."Pays NSSF", salaryCard."Pays SHA", SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");

                                    // ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, 0, false, false, false, SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");
                                end;// Hast Transaction
                            end;
                        until HrEmployee.Next() = 0;
                        ////Progress Window
                        progre.Close();
                    end;
                    //CODEUNIT

                    SalCard2.Reset();
                    SalCard2.SetRange("Employee Code", Rec."No.");
                    SalCard2.SetRange(SalCard2."Period Filter", SelectedPeriod);
                    ////SalCard.SETFILTER(SalCard.Closed,'=%1',FALSE);

                    //REPORT.RUN(70135134,TRUE,FALSE,SalCard);
                end;
            }
            action(IndividualProcessPayroll)
            {
                Caption = 'Individual Process Payslip';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                ToolTip = 'Executes the Individual Process Payslip action.';

                trigger OnAction()
                var
                    prempTrns: Record "prEmployee Transactions";
                    Var1: Code[10];
                    progre: Dialog;
                    counted: Integer;
                    counts: Integer;
                    text1: label '.';
                    text2: label '.  .';
                    text3: label '.  .  .';
                    text4: label '.  .  .  .';
                    text5: label '.  .  .  .  .';
                    text6: label '.  .  .  .  .  .';
                    text7: label '.  .  .  .  .  .  .';
                    text8: label '.  .  .  .  .  .  .  .';
                    text9: label '.  .  .  .  .  .  .  .  .';
                    text10: label '.  .  .  .  .  .  .  .  .  .';
                    progDots: Text[50];
                    RecCount1: Text[120];
                    RecCount2: Text[120];
                    RecCount3: Text[120];
                    RecCount4: Text[120];
                    RecCount5: Text[120];
                    RecCount6: Text[120];
                    RecCount7: Text[120];
                    RecCount8: Text[120];
                    RecCount9: Text[120];
                    RecCount10: Text[120];
                    BufferString: Text[1024];
                begin
                    ContrInfo.Get();

                    if Confirm('This will process salaries for all employees, Continue?', false) = false then
                        exit;

                    objPeriod.Reset();
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    //SalCard.GET("No.");

                    PeriodTransactions.Reset();
                    PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);
                    PeriodTransactions.SetRange(PeriodTransactions."Employee Code", Rec."No.");
                    if PeriodTransactions.Find('-') then
                        PeriodTransactions.DeleteAll();

                    //Use CODEUNIT
                    HrEmployee.Reset();
                    HrEmployee.SetRange(HrEmployee."Status 1", HrEmployee."Status 1"::Active);
                    // HrEmployee.SetRange("No.", Rec."No.");
                    HrEmployee.SetRange(Exclude, false);
                    if HrEmployee.Find('-') then begin
                        // PeriodTransactions.Reset();
                        // PeriodTransactions.SetRange(PeriodTransactions."Employee Code", HrEmployee."No.");
                        // PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);
                        // if PeriodTransactions.Find('-') then
                        //     PeriodTransactions.DeleteAll();
                        Clear(progDots);
                        Clear(RecCount1);
                        Clear(RecCount2);
                        Clear(RecCount3);
                        Clear(RecCount4);
                        Clear(RecCount5);
                        Clear(RecCount6);
                        Clear(RecCount7);
                        Clear(RecCount8);
                        Clear(RecCount9);
                        Clear(RecCount10);
                        Clear(counts);
                        progre.Open('Processing Please wait #1#############################' +
                        '\ ' +
                        '\#2###############################################################' +
                        '\#3###############################################################' +
                        '\#4###############################################################' +
                        '\#5###############################################################' +
                        '\#6###############################################################' +
                        '\#7###############################################################' +
                        '\#8###############################################################' +
                        '\#9###############################################################' +
                        '\#10###############################################################' +
                        '\#11###############################################################' +
                        '\#12###############################################################' +
                        '\#13###############################################################' +
                        '\#14###############################################################',
                            progDots,
                            RecCount1,
                            RecCount2,
                            RecCount3,
                            RecCount4,
                            RecCount5,
                            RecCount6,
                            RecCount7,
                            RecCount8,
                            RecCount9,
                            RecCount10,
                            Var1,
                            Var1,
                            BufferString
                        );

                        repeat



                            dateofJoining := 0D;
                            dateofLeaving := CalcDate('100Y', Today);
                            if HrEmployee."Date Of Join" = 0D then
                                dateofJoining := CalcDate('-1M', Today);
                            //Progress Window

                            //  ProgressWindow.UPDATE(1,HrEmployee."No."+':'+HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");
                            //IF SalCard.GET(HrEmployee."No.") THEN BEGIN

                            salaryCard.Reset();
                            salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                            if not salaryCard.Find('-') then begin
                                // If employee has no Basic Salary
                                prempTrns.Reset();
                                prempTrns.SetRange(prempTrns."Employee Code", HrEmployee."No.");
                                prempTrns.SetRange(prempTrns."Payroll Period", SelectedPeriod);
                                if prempTrns.Find('-') then begin
                                    // PeriodTransactions.Reset();
                                    // PeriodTransactions.SetRange(PeriodTransactions."Employee Code", HrEmployee."No.");
                                    // PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);
                                    // PeriodTransactions.DeleteAll(); // Delete Processed Transactions

                                    ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, 0, false, false, false, SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");
                                end;// Hast Transaction
                            end else begin
                                // Message('Employeee No: %1', salaryCard."Employee Code");
                                if salaryCard."Suspend Pay" = false then begin
                                    //IF salaryCard."Gets Personal Relief"=salaryCard."Gets Personal Relief"::"1" THEN GetsPAYERelief:=TRUE ELSE GetsPAYERelief:=FALSE;
                                    GetsPAYERelief := true;
                                    DOJ := 0D;
                                    if HrEmployee."Date Of Join" = 0D then
                                        DOJ := CalcDate('-2M', Today)
                                    else
                                        DOJ := HrEmployee."Date Of Join";
                                    // salaryCard.Reset();
                                    // salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                                    // //salaryCard.SETFILTER(salaryCard.Closed,'=%1',FALSE);
                                    // if salaryCard.Find('-') then
                                    //     if salaryCard."Suspend Pay" = true then begin
                                    //         PeriodTransactions.Reset();
                                    //         PeriodTransactions.SetRange(PeriodTransactions."Employee Code", HrEmployee."No.");
                                    //         PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);
                                    //         PeriodTransactions.DeleteAll();
                                    //     end// delete stuff from transactions table
                                    //     else begin
                                    //         PeriodTransactions.Reset();
                                    //         PeriodTransactions.SetRange(PeriodTransactions."Employee Code", HrEmployee."No.");
                                    //         PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);

                                    //         PeriodTransactions.DeleteAll();
                                    //         Error('selected Period %1', SelectedPeriod);
                                    ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE", salaryCard."Pays NSSF", salaryCard."Pays SHA", SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");

                                    Clear(Var1);
                                    counts := counts + 1;
                                    if ((counted = 21) or (counted = 11)) then begin
                                        if counted = 21 then
                                            counted := 0;
                                        Sleep(150);
                                    end;
                                    counted := counted + 1;
                                    if counted = 1 then
                                        progDots := text1
                                    else
                                        if counted = 2 then
                                            progDots := text2
                                        else
                                            if counted = 3 then
                                                progDots := text3
                                            else
                                                if counted = 4 then
                                                    progDots := text4
                                                else
                                                    if counted = 5 then
                                                        progDots := text5
                                                    else
                                                        if counted = 6 then
                                                            progDots := text6
                                                        else
                                                            if counted = 7 then
                                                                progDots := text7
                                                            else
                                                                if counted = 8 then
                                                                    progDots := text8
                                                                else
                                                                    if counted = 9 then
                                                                        progDots := text9
                                                                    else
                                                                        if counted = 10 then
                                                                            progDots := text10
                                                                        else
                                                                            if counted = 19 then
                                                                                progDots := text1
                                                                            else
                                                                                if counted = 18 then
                                                                                    progDots := text2
                                                                                else
                                                                                    if counted = 17 then
                                                                                        progDots := text3
                                                                                    else
                                                                                        if counted = 16 then
                                                                                            progDots := text4
                                                                                        else
                                                                                            if counted = 15 then
                                                                                                progDots := text5
                                                                                            else
                                                                                                if counted = 14 then
                                                                                                    progDots := text6
                                                                                                else
                                                                                                    if counted = 13 then
                                                                                                        progDots := text7
                                                                                                    else
                                                                                                        if counted = 12 then
                                                                                                            progDots := text8
                                                                                                        else
                                                                                                            if counted = 11 then
                                                                                                                progDots := text9
                                                                                                            else
                                                                                                                progDots := '';

                                    if counts = 1 then
                                        RecCount1 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                    else
                                        if counts = 2 then
                                            RecCount2 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                        else
                                            if counts = 3 then
                                                RecCount3 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                            HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                            else
                                                if counts = 4 then
                                                    RecCount4 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                else
                                                    if counts = 5 then
                                                        RecCount5 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                    else
                                                        if counts = 6 then
                                                            RecCount6 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                        else
                                                            if counts = 7 then
                                                                RecCount7 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                            HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                            else
                                                                if counts = 8 then
                                                                    RecCount8 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                else
                                                                    if counts = 9 then
                                                                        RecCount9 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                    else
                                                                        if counts = 10 then
                                                                            RecCount10 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                        else
                                                                            if counts > 10 then begin
                                                                                RecCount1 := RecCount2;
                                                                                RecCount2 := RecCount3;
                                                                                RecCount3 := RecCount4;
                                                                                RecCount4 := RecCount5;
                                                                                RecCount5 := RecCount6;
                                                                                RecCount6 := RecCount7;
                                                                                RecCount7 := RecCount8;
                                                                                RecCount8 := RecCount9;
                                                                                RecCount9 := RecCount10;
                                                                                RecCount10 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                            HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
                                                                            end;
                                    Clear(BufferString);
                                    BufferString := 'Total Records processed = ' + Format(counts);

                                    progre.Update();
                                    Sleep(50);
                                    // end;
                                    //   END;
                                end;
                            end;
                        until HrEmployee.Next() = 0;
                        ////Progress Window
                        progre.Close();
                    end;
                    //CODEUNIT

                    SalCard2.Reset();
                    SalCard2.SetRange("Employee Code", Rec."No.");
                    SalCard2.SetRange(SalCard2."Period Filter", SelectedPeriod);
                    //SalCard.SETFILTER(SalCard.Closed,'=%1',FALSE);

                    //REPORT.RUN(70135134,TRUE,FALSE,SalCard);
                end;
            }
            action(ProcessPayroll2)
            {
                Caption = 'Process Payslip2';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                ToolTip = 'Executes the Process Payslip2 action.';

                trigger OnAction()
                var
                    prempTrns: Record "prEmployee Transactions";
                    Var1: Code[10];
                    progre: Dialog;
                    counted: Integer;
                    counts: Integer;
                    text1: label '.';
                    text2: label '.  .';
                    text3: label '.  .  .';
                    text4: label '.  .  .  .';
                    text5: label '.  .  .  .  .';
                    text6: label '.  .  .  .  .  .';
                    text7: label '.  .  .  .  .  .  .';
                    text8: label '.  .  .  .  .  .  .  .';
                    text9: label '.  .  .  .  .  .  .  .  .';
                    text10: label '.  .  .  .  .  .  .  .  .  .';
                    progDots: Text[50];
                    RecCount1: Text[120];
                    RecCount2: Text[120];
                    RecCount3: Text[120];
                    RecCount4: Text[120];
                    RecCount5: Text[120];
                    RecCount6: Text[120];
                    RecCount7: Text[120];
                    RecCount8: Text[120];
                    RecCount9: Text[120];
                    RecCount10: Text[120];
                    BufferString: Text[1024];
                begin
                    ContrInfo.Get();

                    if Confirm('This will process salaries for all employees, Continue?', false) = false then
                        exit;

                    objPeriod.Reset();
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    //SalCard.GET("No.");

                    PeriodTransactions.Reset();
                    PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);
                    if PeriodTransactions.Find('-') then
                        PeriodTransactions.DeleteAll();

                    //Use CODEUNIT
                    HrEmployee.Reset();
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Normal);
                    // HrEmployee.SETRANGE(HrEmployee."Employee Type",HrEmployee."Employee Type"::Permanent);
                    //HrEmployee.SETRANGE(HrEmployee."No.",'KABU-0688');
                    if HrEmployee.Find('-') then begin
                        PeriodTransactions.Reset();
                        PeriodTransactions.SetRange(PeriodTransactions."Employee Code", HrEmployee."No.");
                        PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);
                        if PeriodTransactions.Find('-') then
                            PeriodTransactions.DeleteAll();
                        Clear(progDots);
                        Clear(RecCount1);
                        Clear(RecCount2);
                        Clear(RecCount3);
                        Clear(RecCount4);
                        Clear(RecCount5);
                        Clear(RecCount6);
                        Clear(RecCount7);
                        Clear(RecCount8);
                        Clear(RecCount9);
                        Clear(RecCount10);
                        Clear(counts);
                        progre.Open('Processing Please wait #1#############################' +
                        '\ ' +
                        '\#2###############################################################' +
                        '\#3###############################################################' +
                        '\#4###############################################################' +
                        '\#5###############################################################' +
                        '\#6###############################################################' +
                        '\#7###############################################################' +
                        '\#8###############################################################' +
                        '\#9###############################################################' +
                        '\#10###############################################################' +
                        '\#11###############################################################' +
                        '\#12###############################################################' +
                        '\#13###############################################################' +
                        '\#14###############################################################',
                            progDots,
                            RecCount1,
                            RecCount2,
                            RecCount3,
                            RecCount4,
                            RecCount5,
                            RecCount6,
                            RecCount7,
                            RecCount8,
                            RecCount9,
                            RecCount10,
                            Var1,
                            Var1,
                            BufferString
                        );

                        repeat
                            salaryCard.Reset();
                            salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                            //salaryCard.SETFILTER(salaryCard.Closed,'=%1',FALSE);
                            //IF salaryCard.FIND('-') THEN BEGIN
                            //END;

                            dateofJoining := 0D;
                            dateofLeaving := CalcDate('100Y', Today);
                            if HrEmployee."Date Of Join" = 0D then
                                dateofJoining := CalcDate('-1M', Today);
                            //Progress Window

                            //  ProgressWindow.UPDATE(1,HrEmployee."No."+':'+HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");
                            //IF SalCard.GET(HrEmployee."No.") THEN BEGIN

                            if not salaryCard.Find('-') then begin
                                // If employee has no Basic Salary
                                prempTrns.Reset();
                                prempTrns.SetRange(prempTrns."Employee Code", HrEmployee."No.");
                                prempTrns.SetRange(prempTrns."Payroll Period", SelectedPeriod);
                                if prempTrns.Find('-') then begin
                                    PeriodTransactions.Reset();
                                    PeriodTransactions.SetRange(PeriodTransactions."Employee Code", HrEmployee."No.");
                                    PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);
                                    PeriodTransactions.DeleteAll(); // Delete Processed Transactions

                                    ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, 0, false, false, false, SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");
                                end;// Hast Transaction
                            end else
                                if salaryCard.Find('-') then
                                    if salaryCard."Suspend Pay" <> true then begin
                                        //IF salaryCard."Gets Personal Relief"=salaryCard."Gets Personal Relief"::"1" THEN GetsPAYERelief:=TRUE ELSE GetsPAYERelief:=FALSE;
                                        GetsPAYERelief := true;
                                        DOJ := 0D;
                                        if HrEmployee."Date Of Join" = 0D then
                                            DOJ := CalcDate('-2M', Today)
                                        else
                                            DOJ := HrEmployee."Date Of Join";
                                        salaryCard.Reset();
                                        salaryCard.SetRange(salaryCard."Employee Code", HrEmployee."No.");
                                        //salaryCard.SETFILTER(salaryCard.Closed,'=%1',FALSE);
                                        if salaryCard.Find('-') then
                                            if salaryCard."Suspend Pay" = true then begin
                                                PeriodTransactions.Reset();
                                                PeriodTransactions.SetRange(PeriodTransactions."Employee Code", HrEmployee."No.");
                                                PeriodTransactions.SetRange(PeriodTransactions."Payroll Period", SelectedPeriod);
                                                PeriodTransactions.DeleteAll();
                                            end// delete stuff from transactions table
                                            else begin
                                                ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", false, false, false, SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");

                                                Clear(Var1);
                                                counts := counts + 1;
                                                if ((counted = 21) or (counted = 11)) then begin
                                                    if counted = 21 then
                                                        counted := 0;
                                                    Sleep(150);
                                                end;
                                                counted := counted + 1;
                                                if counted = 1 then
                                                    progDots := text1
                                                else
                                                    if counted = 2 then
                                                        progDots := text2
                                                    else
                                                        if counted = 3 then
                                                            progDots := text3
                                                        else
                                                            if counted = 4 then
                                                                progDots := text4
                                                            else
                                                                if counted = 5 then
                                                                    progDots := text5
                                                                else
                                                                    if counted = 6 then
                                                                        progDots := text6
                                                                    else
                                                                        if counted = 7 then
                                                                            progDots := text7
                                                                        else
                                                                            if counted = 8 then
                                                                                progDots := text8
                                                                            else
                                                                                if counted = 9 then
                                                                                    progDots := text9
                                                                                else
                                                                                    if counted = 10 then
                                                                                        progDots := text10
                                                                                    else
                                                                                        if counted = 19 then
                                                                                            progDots := text1
                                                                                        else
                                                                                            if counted = 18 then
                                                                                                progDots := text2
                                                                                            else
                                                                                                if counted = 17 then
                                                                                                    progDots := text3
                                                                                                else
                                                                                                    if counted = 16 then
                                                                                                        progDots := text4
                                                                                                    else
                                                                                                        if counted = 15 then
                                                                                                            progDots := text5
                                                                                                        else
                                                                                                            if counted = 14 then
                                                                                                                progDots := text6
                                                                                                            else
                                                                                                                if counted = 13 then
                                                                                                                    progDots := text7
                                                                                                                else
                                                                                                                    if counted = 12 then
                                                                                                                        progDots := text8
                                                                                                                    else
                                                                                                                        if counted = 11 then
                                                                                                                            progDots := text9
                                                                                                                        else
                                                                                                                            progDots := '';

                                                if counts = 1 then
                                                    RecCount1 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                else
                                                    if counts = 2 then
                                                        RecCount2 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                    else
                                                        if counts = 3 then
                                                            RecCount3 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                        else
                                                            if counts = 4 then
                                                                RecCount4 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                            HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                            else
                                                                if counts = 5 then
                                                                    RecCount5 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                else
                                                                    if counts = 6 then
                                                                        RecCount6 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                    else
                                                                        if counts = 7 then
                                                                            RecCount7 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                        else
                                                                            if counts = 8 then
                                                                                RecCount8 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                            HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                            else
                                                                                if counts = 9 then
                                                                                    RecCount9 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                                HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                                else
                                                                                    if counts = 10 then
                                                                                        RecCount10 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                                    HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name"
                                                                                    else
                                                                                        if counts > 10 then begin
                                                                                            RecCount1 := RecCount2;
                                                                                            RecCount2 := RecCount3;
                                                                                            RecCount3 := RecCount4;
                                                                                            RecCount4 := RecCount5;
                                                                                            RecCount5 := RecCount6;
                                                                                            RecCount6 := RecCount7;
                                                                                            RecCount7 := RecCount8;
                                                                                            RecCount8 := RecCount9;
                                                                                            RecCount9 := RecCount10;
                                                                                            RecCount10 := Format(counts) + '). ' + HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' +
                                                                                        HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
                                                                                        end;
                                                Clear(BufferString);
                                                BufferString := 'Total Records processed = ' + Format(counts);

                                                progre.Update();
                                                Sleep(50);
                                            end;
                                        //   END;
                                    end;
                        until HrEmployee.Next() = 0;
                        ////Progress Window
                        progre.Close();
                    end;
                    //CODEUNIT

                    SalCard2.Reset();
                    SalCard2.SetRange("Employee Code", Rec."No.");
                    SalCard2.SetRange(SalCard2."Period Filter", SelectedPeriod);
                    //SalCard.SETFILTER(SalCard.Closed,'=%1',FALSE);

                    //REPORT.RUN(70135134,TRUE,FALSE,SalCard);
                end;
            }
        }
    }

    trigger OnInit()
    begin

        objPeriod.Reset();
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";
        end;
    end;

    var
        ContrInfo: Record "Control-Information";
        HREmp: Record "HR-Employee";
        HrEmployee: Record "HR-Employee";
        objEmp: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        PeriodTransactions: Record "prPeriod Transactions";
        salaryCard: Record "prSalary Card";
        SalCard: Record "prSalary Card";
        SalCard2: Record "prSalary Card";
        ProcessPayroll: Codeunit prPayrollProcessing;
        GetsPAYERelief: Boolean;
        dateofJoining: Date;
        dateofLeaving: Date;
        DOJ: Date;
        SelectedPeriod: Date;
        i: Integer;
        j: Integer;
        PeriodMonth: Integer;
        PeriodYear: Integer;
        PeriodName: Text[30];
}
