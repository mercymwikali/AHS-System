Page 85754 "HR Employee-List"
{
    CardPageID = "prHeader Salary Card";
    Editable = true;
    PageType = List;
    SourceTable = "HR-Employee";
    SourceTableView = where(Status = filter(Normal), Exclude = filter(false));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(FirstName; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                }
                field(DateOfLeaving; Rec."Date Of Leaving")
                {
                    ToolTip = 'Specifies the value of the Date Of Leaving field.';
                }
                field(DateLeaving; Rec.DateLeaving)
                {
                    ToolTip = 'Specifies the value of the DateLeaving field.';
                }
                field(ExitDate; Rec."Exit Date")
                {
                    ToolTip = 'Specifies the value of the Exit Date field.';
                }
                field(MiddleName; Rec."Middle Name")
                {
                    ToolTip = 'Specifies the value of the Middle Name field.';
                }
                field(LastName; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                }
                field(BasicPay; Rec."Basic Pay")
                {
                    ToolTip = 'Specifies the value of the Basic Pay field.';
                }
                field(PostingGroup; Rec."Posting Group")
                {
                    ToolTip = 'Specifies the value of the Posting Group field.';
                }
                field(PayrollPostingGroup; Rec."Payroll Posting Group")
                {
                    ToolTip = 'Specifies the value of the Payroll Posting Group field.';
                }
                field(DepartmentCode; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(Initials; Rec.Initials)
                {
                    ToolTip = 'Specifies the value of the Initials field.';
                }
                field(MainBank; Rec."Main Bank")
                {
                    ToolTip = 'Specifies the value of the Main Bank field.';
                }
                field(BranchBank; Rec."Branch Bank")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Branch Bank field.';
                }
                field(BankAccountNumber; Rec."Bank Account Number")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Bank Account Number field.';
                }
                field(LengthOfService; Rec."Length Of Service")
                {
                    ToolTip = 'Specifies the value of the Length Of Service field.';
                }
                field(DateOfJoin; Rec."Date Of Join")
                {
                    ToolTip = 'Specifies the value of the Date Of Join field.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the value of the County field.';
                }
                field(HomePhoneNumber; Rec."Home Phone Number")
                {
                    ToolTip = 'Specifies the value of the Home Phone Number field.';
                }
                field(CellularPhoneNumber; Rec."Cellular Phone Number")
                {
                    ToolTip = 'Specifies the value of the Cellular Phone Number field.';
                }
                field(WorkPhoneNumber; Rec."Work Phone Number")
                {
                    ToolTip = 'Specifies the value of the Work Phone Number field.';
                }
                field(Ext; Rec."Ext.")
                {
                    ToolTip = 'Specifies the value of the Ext. field.';
                }
                field(EMail; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(JobApplicationNo; Rec."Job Application No")
                {
                    ToolTip = 'Specifies the value of the Job Application No field.';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.';
                }
                field(CountryCode; Rec."Country Code")
                {
                    ToolTip = 'Specifies the value of the Country Code field.';
                }
                field(StatisticsGroupCode; Rec."Statistics Group Code")
                {
                    ToolTip = 'Specifies the value of the Statistics Group Code field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status Reasons field.';
                }
                field("Department Code1"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(JobTitle; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                }
                field(Office; Rec.Office)
                {
                    ToolTip = 'Specifies the value of the Office field.';
                }
                field(ResourceNo; Rec."Resource No.")
                {
                    ToolTip = 'Specifies the value of the Resource No. field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(LastDateModified; Rec."Last Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last Date Modified field.';
                }
                field(FaxNumber; Rec."Fax Number")
                {
                    ToolTip = 'Specifies the value of the Fax Number field.';
                }
                field(CompanyEMail; Rec."Company E-Mail")
                {
                    ToolTip = 'Specifies the value of the Company E-Mail field.';
                }
                field(Title; Rec.Title)
                {
                    ToolTip = 'Specifies the value of the Title field.';
                }
                field(SalespersPurchCode; Rec."Salespers./Purch. Code")
                {
                    ToolTip = 'Specifies the value of the Salespers./Purch. Code field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(KnownAs; Rec."Known As")
                {
                    ToolTip = 'Specifies the value of the Known As field.';
                }
                field(Position; Rec.Position)
                {
                    ToolTip = 'Specifies the value of the Position field.';
                }
                field(FullPartTime; Rec."Full / Part Time")
                {
                    ToolTip = 'Specifies the value of the Full / Part Time field.';
                }
                field(ContractType; Rec."Contract Type")
                {
                    ToolTip = 'Specifies the value of the Contract Status field.';
                }
                field(ContractEndDate; Rec."Contract End Date")
                {
                    ToolTip = 'Specifies the value of the Contract End Date field.';
                }
                field(EthnicOrigin; Rec."Ethnic Origin")
                {
                    ToolTip = 'Specifies the value of the Ethnic Origin field.';
                }
                field(DateOfBirth; Rec."Date Of Birth")
                {
                    ToolTip = 'Specifies the value of the Date Of Birth field.';
                }
                field(Age; Rec.Age)
                {
                    ToolTip = 'Specifies the value of the Age field.';
                }
                field("Date Of Join1"; Rec."Date Of Join")
                {
                    ToolTip = 'Specifies the value of the Date Of Join field.';
                }
                field("Length Of Service1"; Rec."Length Of Service")
                {
                    ToolTip = 'Specifies the value of the Length Of Service field.';
                }
                field(EndOfProbationDate; Rec."End Of Probation Date")
                {
                    ToolTip = 'Specifies the value of the End Of Probation Date field.';
                }
                field(Divisions; Rec.Divisions)
                {
                    ToolTip = 'Specifies the value of the Divisions field.';
                }
                field(PensionSchemeJoin; Rec."Pension Scheme Join")
                {
                    ToolTip = 'Specifies the value of the Pension Scheme Join field.';
                }
                field(JobSpecification; Rec."Job Specification")
                {
                    ToolTip = 'Specifies the value of the Job ID field.';
                }
                field(Control220; Rec.DateOfBirth)
                {
                    ToolTip = 'Specifies the value of the DateOfBirth field.';
                }
                field(DateEngaged; Rec.DateEngaged)
                {
                    ToolTip = 'Specifies the value of the DateEngaged field.';
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ToolTip = 'Specifies the value of the Citizenship field.';
                }
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
                    RunObject = Page "prList Transactions";
                    RunPageLink = "Employee Code" = field("No.");
                    ToolTip = 'Executes the Assign Transaction action.';
                }
                separator(Action18)
                {
                }
                action(ViewTransCodes)
                {
                    Caption = 'View Trans Codes';
                    Image = ViewDetails;
                    RunObject = Page "prList TransCode";
                    ToolTip = 'Executes the View Trans Codes action.';
                }
                separator(Action16)
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
                separator(Action13)
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
            group(ActionGroup77)
            {
                Caption = 'Reports';
                group(GeneralReports)
                {
                    Caption = 'General Reports';
                    Visible = false;
                    action(View2PagePayslip)
                    {
                        Caption = 'View 2 Pages Payslip';
                        Image = Payment;
                        ToolTip = 'Executes the View 2 Pages Payslip action.';
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;

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
                                Report.Run(70135163, true, false, SalCard);
                        end;
                    }
                    action(ViewhorPayslip)
                    {
                        Caption = 'Payslip (Horizontal)';
                        Image = PrintReport;
                        ToolTip = 'Executes the Payslip (Horizontal) action.';
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;

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
                                Report.Run(70135172, true, false, SalCard);
                        end;
                    }
                    action(View3PagePayslip)
                    {
                        Caption = 'View3 Pages Payslip';
                        Image = PaymentHistory;
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

                            SalCard.Reset();
                            SalCard.SetRange(SalCard."Employee Code", Rec."No.");
                            SalCard.SetRange(SalCard."Payroll Period", SelectedPeriod);
                            if SalCard.Find('-') then
                                Report.Run(70135163, true, false, SalCard);
                        end;
                    }
                    action(vewpayslip)
                    {
                        Caption = 'vew payslip';
                        Image = "Report";
                        RunObject = Report "Individual Payslips mst";
                        ToolTip = 'Executes the vew payslip action.';
                    }
                    action(MasterPayrollSummary)
                    {
                        Caption = 'Master Payroll Summary';
                        Image = "Report";
                        RunObject = Report "Pr Payroll Summary Detailed";
                        ToolTip = 'Executes the Master Payroll Summary action.';
                    }
                    action(DeductionsSummary2)
                    {
                        Caption = 'Deductions Summary 2';
                        Image = "Report";
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
                    action(DeductionsSummary)
                    {
                        Caption = 'Deductions Summary';
                        Image = Report;
                        RunObject = Report "Deductions Summary";
                        ToolTip = 'Executes the Deductions Summary action.';
                    }
                    action(EarningsSummary)
                    {
                        Caption = 'Earnings Summary';
                        Image = DepositSlip;
                        RunObject = Report "Earnings Summary";
                        ToolTip = 'Executes the Earnings Summary action.';
                    }
                    action(Staffpension)
                    {
                        Caption = 'Staff pension';
                        Image = Aging;
                        RunObject = Report "prStaff Pension Contrib";
                        ToolTip = 'Executes the Staff pension action.';
                    }
                    action(GrossNetpay)
                    {
                        Caption = 'Gross Netpay';
                        Image = Giro;
                        RunObject = Report prGrossNetPay;
                        ToolTip = 'Executes the Gross Netpay action.';
                    }
                    action(ThirdRule)
                    {
                        Caption = 'Third Rule';
                        Image = AddWatch;
                        RunObject = Report "A third Rule Report";
                        ToolTip = 'Executes the Third Rule action.';
                    }
                    action(CoopRemittance)
                    {
                        Caption = 'Co_op Remittance';
                        Image = CreateForm;
                        RunObject = Report "prCoop remmitance";
                        ToolTip = 'Executes the Co_op Remittance action.';
                    }
                    separator(Action41)
                    {
                        Caption = 'setup finance';
                    }
                    action(Action39)
                    {
                        Caption = 'Transactions';
                        Image = "Report";
                        RunObject = Report "pr Transactions";
                        ToolTip = 'Executes the Transactions action.';
                    }
                    action(bankSchedule)
                    {
                        Caption = 'bank Schedule';
                        Image = "Report";
                        RunObject = Report "pr Bank Schedule";
                        ToolTip = 'Executes the bank Schedule action.';
                    }
                    separator(Action36)
                    {
                    }
                    action(P10)
                    {
                        Caption = 'P.10';
                        Image = "Report";
                        RunObject = Report "P.10 A mst";
                        ToolTip = 'Executes the P.10 action.';
                    }
                    action(PayeScheule)
                    {
                        Caption = 'Paye Scheule';
                        Image = "Report";
                        RunObject = Report "prPaye Schedule mst";
                        ToolTip = 'Executes the Paye Scheule action.';
                    }
                    action(NHIFSchedule)
                    {
                        Caption = 'NHIF Schedule';
                        Image = "Report";
                        RunObject = Report "prNHIF mst";
                        ToolTip = 'Executes the NHIF Schedule action.';
                    }
                    action(NSSFSchedule)
                    {
                        Caption = 'NSSF Schedule';
                        Image = "Report";
                        RunObject = Report "prNSSF mst";
                        ToolTip = 'Executes the NSSF Schedule action.';
                    }
                    separator(Action29)
                    {
                    }
                }
                group(periodics)
                {
                    Caption = 'periodic';
                    Visible = false;
                    action(payrollJournalTransfer)
                    {
                        Caption = 'payroll Journal Transfer';
                        Image = Journals;
                        RunObject = Report prPayrollJournalTransfer;
                        ToolTip = 'Executes the payroll Journal Transfer action.';
                    }
                    action(massupdateTransactions)
                    {
                        Caption = 'mass update Transactions';
                        Image = PostBatch;
                        RunObject = Report "Mass Update Transactions";
                        ToolTip = 'Executes the mass update Transactions action.';
                    }
                    action(PayrollPeriod)
                    {
                        Caption = 'Payroll Period';
                        Image = Period;
                        Promoted = true;
                        RunObject = Page "prPayroll Periods";
                        ToolTip = 'Executes the Payroll Period action.';
                    }
                }
            }
            group(Reports2)
            {
                Caption = 'Payroll Reports';
                Image = RegisteredDocs;
                group(MonthlySummaryReports)
                {
                    Caption = 'Monthly Summary Reports';
                    Image = FiledPosted;
                    action(Payslips)
                    {
                        Caption = 'Payslips';
                        Image = "Report";
                        RunObject = Report "Individual Payslips mst";
                        ToolTip = 'Executes the Payslips action.';
                    }
                    action(Action115)
                    {
                        Caption = 'Gross Netpay';
                        Image = "Report";
                        RunObject = Report prGrossNetPay;
                        ToolTip = 'Executes the Gross Netpay action.';
                    }
                    action(Action111)
                    {
                        Caption = 'Third Rule';
                        Image = "Report";
                        RunObject = Report "A third Rule Report";
                        ToolTip = 'Executes the Third Rule action.';
                    }
                    action(Action109)
                    {
                        Caption = 'Co_op Remittance';
                        Image = "Report";
                        RunObject = Report "prCoop remmitance";
                        ToolTip = 'Executes the Co_op Remittance action.';
                    }
                    action(Action107)
                    {
                        Caption = 'Transactions';
                        Image = "Report";
                        RunObject = Report "pr Transactions";
                        ToolTip = 'Executes the Transactions action.';
                    }
                    action(Action105)
                    {
                        Caption = 'Earnings Summary';
                        Image = "Report";
                        RunObject = Report "Earnings Summary";
                        ToolTip = 'Executes the Earnings Summary action.';
                    }
                }
                group(OtherPayrollReports)
                {
                    Caption = 'Other Payroll Reports';
                    Image = FiledPosted;
                    action("<Report pr Bank Schedule 2>")
                    {
                        Caption = 'Bank Schedule';
                        Image = "Report";
                        RunObject = Report "pr Bank Schedule 2";
                        ToolTip = 'Executes the Bank Schedule action.';
                    }
                    action(EFTTransfer)
                    {
                        Caption = 'EFT Transfer';
                        Image = "Report";
                        RunObject = Report "pr Bank Schedule";
                        ToolTip = 'Executes the EFT Transfer action.';
                    }
                    action(Action130)
                    {
                        Caption = 'Master Payroll Summary';
                        Image = "Report";
                        RunObject = Report "Company Payroll Summary 3";
                        ToolTip = 'Executes the Master Payroll Summary action.';
                    }
                    action(VarianceSummary)
                    {
                        Caption = 'Variance Summary';
                        Image = "Report";
                        RunObject = Report prVariance;
                        ToolTip = 'Executes the Variance Summary action.';
                    }
                    action(Variance)
                    {
                        Caption = 'Variance';
                        Image = "Report";
                        RunObject = Report "prDeductions Variance Report";
                        ToolTip = 'Executes the Variance action.';
                    }
                    action(Action127)
                    {
                        Caption = 'Deductions Summary';
                        Image = "Report";
                        RunObject = Report "Deductions Summary 2";
                        ToolTip = 'Executes the Deductions Summary action.';
                    }
                    action(Action125)
                    {
                        Caption = 'Earnings Summary 2';
                        Image = "Report";
                        RunObject = Report "Payments Summary 2";
                        ToolTip = 'Executes the Earnings Summary 2 action.';
                    }
                    action(EarningsDetailed)
                    {
                        Caption = 'Earnings Detailed';
                        Image = "Report";
                        RunObject = Report "Earnings Summary";
                        ToolTip = 'Executes the Earnings Detailed action.';
                    }
                    action("<Report Deductions Summary>")
                    {
                        Caption = 'Deductions Detailed';
                        Image = "Report";
                        RunObject = Report "Deductions Summary 2";
                        ToolTip = 'Executes the Deductions Detailed action.';
                    }
                    action(PayrollsummaryEnterprise)
                    {
                        Caption = 'Payroll summary Enterprise';
                        Image = Report;
                        RunObject = Report "Payroll Summary ENTERPRISE";
                        ToolTip = 'Executes the Payroll summary Enterprise action.';
                    }
                    action("<Report Payroll Summary 2 Enterprise>")
                    {
                        Caption = 'Payroll summary Detailed Enterprise';
                        Image = "Report";
                        RunObject = Report "Payroll Summary 2 Enterprise";
                        ToolTip = 'Executes the Payroll summary Detailed Enterprise action.';
                    }
                    action(Action117)
                    {
                        Caption = 'Staff pension';
                        Image = "Report";
                        RunObject = Report "prStaff Pension Contrib";
                        ToolTip = 'Executes the Staff pension action.';
                    }
                }
                group(MonthlyStatutoriesReports)
                {
                    Caption = 'Monthly Statutories Reports';
                    Image = FiledPosted;
                    
                    action(Action93)
                    {
                        Caption = 'P.10';
                        Image = "Report";
                        RunObject = Report "KRA PAYE";
                        ToolTip = 'Executes the P.10 action.';
                    }
                    action(P9ReportV26)
                    {
                        Caption = 'P.10 V26 Report';
                        Image = PrintForm;
                        RunObject = Report "P10 Ver 26";
                        ToolTip = 'Executes the P10 Version 26 action.';
                    }
                    action(Action99)
                    {
                        Caption = 'Transactions';
                        Image = "Report";
                        RunObject = Report "pr Transactions";
                        ToolTip = 'Executes the Transactions action.';
                    }
                    action(Action91)
                    {
                        Caption = 'Paye Scheule';
                        Image = "Report";
                        RunObject = Report "prPaye Schedule mst";
                        ToolTip = 'Executes the Paye Scheule action.';
                    }
                    action(Action89)
                    {
                        Caption = 'NHIF Schedule';
                        Image = "Report";
                        RunObject = Report "prNHIF mst";
                        ToolTip = 'Executes the NHIF Schedule action.';
                    }
                    action(Action87)
                    {
                        Caption = 'NSSF Schedule';
                        Image = "Report";
                        RunObject = Report "prNSSF mst";
                        ToolTip = 'Executes the NSSF Schedule action.';
                    }
                    action(Action85)
                    {
                        Caption = 'Third Rule';
                        Image = AddWatch;
                        RunObject = Report "A third Rule Report";
                        ToolTip = 'Executes the Third Rule action.';
                    }
                    action(Action83)
                    {
                        Caption = 'Co_op Remittance';
                        Image = CreateForm;
                        RunObject = Report "prCoop remmitance";
                        ToolTip = 'Executes the Co_op Remittance action.';
                    }
                }
                group(YearlyStatutoriesReports)
                {
                    Caption = 'Yearly Statutories Reports';
                    Image = FiledPosted;
                    action(P9Report)
                    {
                        Caption = 'P9 Report';
                        Image = PrintForm;
                        RunObject = Report "P9 Report (Final)";
                        ToolTip = 'Executes the P9 Report action.';
                    }
                }
                group(Periodic)
                {
                    Caption = 'Periodic';
                    Image = Bank;
                    action(Action79)
                    {
                        Caption = 'mass update Transactions';
                        Image = PostBatch;
                        RunObject = Report "Mass Update Transactions";
                        ToolTip = 'Executes the mass update Transactions action.';
                    }
                    action(Action38)
                    {
                        Caption = 'payroll Journal Transfer';
                        Image = Journals;
                        RunObject = Report prPayrollJournalTransfer;
                        ToolTip = 'Executes the payroll Journal Transfer action.';
                    }
                }
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
                    prempTrns: Record "prEmployee Transactions";
                    Var1: Code[10];
                    progre: Dialog;
                    counts: Integer;
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

                    PeriodTrans.Reset();
                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                    if PeriodTrans.Find('-') then
                        PeriodTrans.DeleteAll();


                    HrEmployee.Reset();
                    HrEmployee.SetRange(HrEmployee."Status 1", HrEmployee."Status 1"::Active);
                    HrEmployee.SetRange(Exclude, false);
                    if HrEmployee.Find('-') then begin
                        PeriodTrans.Reset();
                        PeriodTrans.SetRange(PeriodTrans."Employee Code", HrEmployee."No.");
                        PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                        if PeriodTrans.Find('-') then
                            PeriodTrans.DeleteAll();

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
                        progre.Open('Processing Please wait..............\#1###############################################################' +
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
                        '\#13###############################################################',
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

                                    PeriodTrans.Reset();
                                    PeriodTrans.SetRange(PeriodTrans."Employee Code", HrEmployee."No.");
                                    PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                                    PeriodTrans.DeleteAll(); // Delete Processed Transactions

                                    ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, 0, false, false, false, SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");

                                    // ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, 0, false, false, false, SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");
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
                                                PeriodTrans.Reset();
                                                PeriodTrans.SetRange(PeriodTrans."Employee Code", HrEmployee."No.");
                                                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                                                PeriodTrans.DeleteAll();
                                            end// delete stuff from transactions table

                                            else begin
                                                ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, salaryCard."Basic Pay", salaryCard."Pays PAYE", salaryCard."Pays NSSF", salaryCard."Pays SHA", SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");

                                                // ProcessPayroll.fnProcesspayroll(HrEmployee."No.", DOJ, 0, false, false, false, SelectedPeriod, SelectedPeriod, '', '', dateofLeaving, false, HrEmployee."Shortcut Dimension 2 Code", salaryCard."Gratuity Perc.", salaryCard."Pays AHL", salaryCard."Pays SHA", salaryCard."Pays NSSF Tier 1", salaryCard."Pays NSSF Tier 2");

                                                Clear(Var1);
                                                counts := counts + 1;
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
                    //SalCard2.SETFILTER(SalCard2.Closed,'=%1',FALSE);

                    //REPORT.RUN(70135134,TRUE,FALSE,SalCard);
                end;
            }
            group(ActionGroup70)
            {
                Caption = 'periodic';
                Description = 'PeriodicActions';
                Image = Administration;
                action(Action69)
                {
                    Caption = 'payroll Journal Transfer';
                    Image = Journals;
                    RunObject = Report prPayrollJournalTransfer;
                    ToolTip = 'Executes the payroll Journal Transfer action.';
                }
                action(Action67)
                {
                    Caption = 'mass update Transactions';
                    Image = PostBatch;
                    RunObject = Report "Mass Update Transactions";
                    ToolTip = 'Executes the mass update Transactions action.';
                }
                action(Action65)
                {
                    Caption = 'Payroll Period';
                    Image = Period;
                    RunObject = Page "prPayroll Periods";
                    ToolTip = 'Executes the Payroll Period action.';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        UserRec: record "User Setup";
    begin
        if UserRec.get(database.UserId) then begin
            if UserRec."View Payroll" = false then
                error('Please note that you dont have the rights to access the payroll');
        end else
            error('Please note that you dont have the rights to access the payroll');
    end;

    var
        ContrInfo: Record "Control-Information";
        HREmp: Record "HR-Employee";
        HrEmployee: Record "HR-Employee";
        objEmp: Record "HR-Employee";
        objPeriod: Record "prPayroll Periods";
        PeriodTrans: Record "prPeriod Transactions";
        salaryCard: Record "prSalary Card";
        SalCard: Record "prSalary Card";
        SalCard2: Record "prSalary Card";
        ProcessPayroll: Codeunit prPayrollProcessing;
        GetsPAYERelief: Boolean;
        DepCode: Code[10];
        OfficeCode: Code[10];
        dateofJoining: Date;
        dateofLeaving: Date;
        DOJ: Date;
        SelectedPeriod: Date;
        i: Integer;
        j: Integer;

    procedure SetNewFilter(var DepartmentCode: Code[10]; var "Office Code": Code[10])
    begin
        DepCode := DepartmentCode;
        OfficeCode := "Office Code";
    end;
}
