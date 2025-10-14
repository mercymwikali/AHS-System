page 52202440 "Human Resource Role Centre"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control60; "Headline RC General Mgt.")
            {
                ApplicationArea = RelationshipMgmt;
            }
            group(Control29)
            {
                ShowCaption = false;
                part("Employees Cue"; "HR Employee Cue")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employees Cue';
                }
            }
            group(Control26)
            {
                ShowCaption = false;
                part("My Approval Entries"; "Requests to Approve")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approval Entries';
                }
                systempart(Control24; Links)
                {
                }
                systempart(Control23; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group("Employee Reports")
            {
                Caption = 'Employee Reports';
                Image = HumanResources;
                group(Employees)
                {
                    Caption = 'Employees';
                    Image = HRSetup;
                    action("Employee List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee List';
                        RunObject = Report "HR Employee List";
                        ToolTip = 'Executes the Employee List action.';
                    }
                    action("Employee List Per Division")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee List Per Division';
                        RunObject = Report "HR Employee Per Division";
                        ToolTip = 'Executes the Employee List Per Division action.';
                    }
                    action("Employee List Per Dept")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee List Per Dept';
                        RunObject = Report "HR Employee Per Dept";
                        ToolTip = 'Executes the Employee List Per Dept action.';
                    }
                    action("Employee list per div per dept")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee list per div per dept';
                        RunObject = Report "HR Employee Per Dimension";
                        ToolTip = 'Executes the Employee list per div per dept action.';
                    }
                    action("Employee Qualifications")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Qualifications';
                        RunObject = Report "HR Employee Qualifications";
                        ToolTip = 'Executes the Employee Qualifications action.';
                    }
                    action("Hr Employee per contract")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Hr Employee per contract';
                        RunObject = Report "Hr Employee Per Contract";
                        ToolTip = 'Executes the Hr Employee per contract action.';
                    }
                    action("Hr Employee review")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Hr Employee review';
                        RunObject = Report "HR Employee Review On Terms";
                        ToolTip = 'Executes the Hr Employee review action.';
                    }
                    action("Employee Beneficiaries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Beneficiaries';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HR Regret Letter";
                        ToolTip = 'Executes the Employee Beneficiaries action.';
                    }
                    action("Comission Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Comission Report';
                        RunObject = Report "HR Commission For Univ. Report";
                        ToolTip = 'Executes the Comission Report action.';
                    }
                    action("Executive Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Executive Summary';
                        RunObject = Report "Executive Summary";
                        ToolTip = 'Executes the Executive Summary action.';
                    }
                    action("Employee Change History")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Change History';
                        RunObject = Report "Employee Change History";
                        ToolTip = 'Executes the Employee Change History action.';
                    }
                }
                group("Monthly Payroll Reports")
                {
                    Caption = 'Monthly Payroll Reports';
                    Image = FiledPosted;
                    action("Third Rule")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Third Rule';
                        RunObject = Report "A third Rule Report";
                        ToolTip = 'Executes the Third Rule action.';
                    }
                    action("Co-op Remittance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Co-op Remittance';
                        RunObject = Report "prCoop remmitance";
                        ToolTip = 'Executes the Co-op Remittance action.';
                    }
                    action(Transactions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transactions';
                        RunObject = Report "pr Transactions";
                        ToolTip = 'Executes the Transactions action.';
                    }
                    action("Earnings Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Earnings Summary';
                        RunObject = Report "Earnings Summary";
                        ToolTip = 'Executes the Earnings Summary action.';
                    }
                    action("Employee Gratuity")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Gratuity';
                        RunObject = Report "prEmployer Gratuity";
                        ToolTip = 'Executes the Employee Gratuity action.';
                    }
                    action(Variance)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variance';
                        RunObject = Report "prDeductions Variance Report";
                        ToolTip = 'Executes the Variance action.';
                    }
                    action("Variance Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variance Summary';
                        RunObject = Report prVarianceSummary;
                        ToolTip = 'Executes the Variance Summary action.';
                    }
                    action("PCA Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'PCA Report';
                        RunObject = Report "PCA Report";
                        ToolTip = 'Executes the PCA Report action.';
                    }
                }
                group(Leave)
                {
                    Caption = 'Leave';
                    Image = Travel;
                    action("Leave Balance Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Report "Employee Leave Summary";
                        ToolTip = 'Executes the Leave Balance Summary action.';
                    }
                    action("Leave Balances")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Report "Employee Leaves";
                        ToolTip = 'Executes the Leave Balances action.';
                    }
                    action("Leave Transactions")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Report "Standard Leave Balance Report";
                        ToolTip = 'Executes the Leave Transactions action.';
                    }
                    action("Leave Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Report "Leave statements";
                        ToolTip = 'Executes the Leave Statement action.';
                    }
                }
            }
        }
        area(creation)
        {
            action("Leave Journal")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Hr Emp. Leave Journal Lines";
                ToolTip = 'Executes the Leave Journal action.';
            }
        }
        area(sections)
        {
            group(Payroll)
            {
                Caption = 'Payroll';

                action("Raise Paychange Advice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Raise Paychange Advice';
                    RunObject = Page "prPCA list";
                    RunPageView = WHERE(Status = FILTER(Open));
                    ToolTip = 'Executes the Raise Paychange Advice action.';
                }
                action("Approved Paychange Advice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Paychange Advice';
                    RunObject = Page "prPCA list";
                    RunPageView = WHERE(Status = FILTER(Approved));
                    ToolTip = 'Executes the Approved Paychange Advice action.';
                }
                action("Raise Mass PCA")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Raise Mass PCA';
                    RunObject = Page prPCAMassList;
                    ToolTip = 'Executes the Raise Mass PCA action.';
                }
                action("Posted Paychange Advice History")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Paychange Advice History';
                    RunObject = Page "prPCA list";
                    RunPageView = WHERE(Status = FILTER(Posted));
                    ToolTip = 'Executes the Posted Paychange Advice History action.';
                }
                action("Posted Mass Paychange Advice History")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Mass Paychange Advice History';
                    RunObject = Page prPostedPCAMassList;
                    ToolTip = 'Executes the Posted Mass Paychange Advice History action.';
                }
            }
            group(EmployeeMan)
            {
                Caption = 'Employee Manager';
                Image = HumanResources;
                action(Action22)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employee List';
                    Image = Employee;
                    RunObject = Page "HR Employee List";
                    ToolTip = 'Executes the Employee List action.';
                }
                // action("Part Time employee List")
                // {
                //     Caption = 'Part Time employee List';
                //     ApplicationArea = Basic, Suite;
                //     RunObject = Page "HR Employee List-Parttime1";
                // }

                // action("Part-Time List Password Change")
                // {
                //     Caption = 'Part-Time List Password Change';
                //     ApplicationArea = Basic, Suite;
                //     RunObject = Page "HR Employees (Part-Time)1";
                //     Visible = false;
                // }
                action(InactiveStafff)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inactive Employee List';
                    Image = Employee;
                    RunObject = Page "HR Employee List Archive";
                    ToolTip = 'Executes the Inactive Employee List action.';
                }
            }
            group(LeaveMan)
            {
                Caption = 'Leave Management';
                Image = Capacities;
                action("Leave Applications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Leave Applications';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HR Leave Requisition List";
                    ToolTip = 'Executes the Leave Applications action.';
                }
                action("Staff Movement Form")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HR Back To Office List";
                    ToolTip = 'Executes the Staff Movement Form action.';
                }
                action("On Leave List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Absence;
                    RunObject = Page "HR On Leave List";
                    ToolTip = 'Executes the On Leave List action.';
                }
                action("Posted Leave Application")
                {
                    ApplicationArea = Basic, Suite;
                    Image = PaymentHistory;
                    RunObject = Page "HR Leave Requisi Posted List";
                    ToolTip = 'Executes the Posted Leave Application action.';
                }
                action("Leave Journal2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Leave Journal';
                    RunObject = Page "Hr Emp. Leave Journal Lines";
                    ToolTip = 'Executes the Leave Journal action.';
                }
                action("Leave Type")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Leave Types";
                    ToolTip = 'Executes the Leave Type action.';
                }
                action("Holidays")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Holidays";
                    ToolTip = 'Executes the Holidays action.';
                }
                action("Leave Family")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Leave Family Groups";
                    ToolTip = 'Executes the Leave Family action.';
                }
            }
            group(JobMan)
            {
                Caption = 'Jobs Management';
                Image = ResourcePlanning;
                action("Jobs List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Jobs List';
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HR Jobs List";
                    ToolTip = 'Executes the Jobs List action.';
                }
            }
            group(Recruit)
            {
                Caption = 'Recruitment Management';
                action("Employee Requisitions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employee Requisitions';
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HR Employee Requisitions List";
                    ToolTip = 'Executes the Employee Requisitions action.';
                }
                action("Shortlisting Stages")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Segment;
                    RunObject = Page "HR Recruitment Stages List";
                    ToolTip = 'Executes the Shortlisting Stages action.';
                }
                action("Short Listing")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Short Listing';
                    RunObject = Page "HR Shortlisting List";
                    ToolTip = 'Executes the Short Listing action.';
                }
                action("Job Applicants")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Job Application';
                    RunObject = Page "Applicants List";
                    ToolTip = 'Executes the Job Application action.';
                }
                action("Qualified Job Applicants")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Qualified Job Applicants';
                    RunObject = Page "HR Job Applicants Qualified";
                    ToolTip = 'Executes the Qualified Job Applicants action.';
                }
                action("Unqualified Applicants")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Unqualified Applicants';
                    RunObject = Page "HR Job Applicants Unqualified";
                    ToolTip = 'Executes the Unqualified Applicants action.';
                }
                action("Advertised Jobs")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Advertised Jobs';
                    RunObject = Page "Hr Advertised Job List";
                    ToolTip = 'Executes the Advertised Jobs action.';
                }
            }
            group(Welfare)
            {
                Caption = 'Welfare Management';
                Image = Capacities;

                action("Company Activity")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Activity';
                    RunObject = Page "Company Activities";
                    ToolTip = 'Executes the Company Activity action.';
                }
                action("Commitee")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Commitees';
                    RunObject = Page "Committees";
                    ToolTip = 'Executes the Commitees action.';
                }
            }
            group(setus)
            {
                Caption = 'Setups';
                Image = HRSetup;
                action("Institutions List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Institutions List';
                    Image = Line;
                    Promoted = true;
                    RunObject = Page "HR Institutions List";
                    ToolTip = 'Executes the Institutions List action.';
                }
                action("SalaryGrades")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Salary Grades List';
                    RunObject = Page "Salary Grades List";
                    ToolTip = 'Executes the Salary Grades List action.';
                }
                /* action("Base Calendar")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Base Calendar';
                    RunObject = Page "Base Calendar List";
                    ToolTip = 'Executes the Base Calendar action.';
                } */
                action("Hr Setups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hr Setups';
                    RunObject = Page "HR SetUp List";
                    ToolTip = 'Executes the Hr Setups action.';
                }
                action("Look Up Values")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Look Up Values';
                    RunObject = Page "HR Lookup Values List";
                    ToolTip = 'Executes the Look Up Values action.';
                }
                /* action("Hr Calendar")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hr Calendar';
                    RunObject = Page "Base Calendar List";
                    ToolTip = 'Executes the Hr Calendar action.';
                } */
                action(" Email Parameters List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = ' Email Parameters List';
                    RunObject = Page "Hr Email Parameters List";
                    ToolTip = 'Executes the  Email Parameters List action.';
                }
                action(Rules)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rules & Regulations';
                    RunObject = Page "Rules & Regulations";
                    ToolTip = 'Executes the Rules & Regulations action.';
                }
                action("Dimension Values")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimension Values';
                    RunObject = Page Dimensions;
                    ToolTip = 'Executes the Dimension Values action.';
                }
                action("Appraisal Assessment Areas")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appraisal Assessment Areas';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Appraisal Criteria";
                    ToolTip = 'Executes the Appraisal Assessment Areas action.';
                }
                action(HrLeaveCalendar)
                {
                    ApplicationArea = All;
                    Caption = 'HR Leave Calendar';
                    RunObject = page "HR Leave Calendar List";
                }
            }
            group(pension)
            {
                Caption = 'Pension Management';
                Image = History;
                action(Action40)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employee Beneficiaries';
                    RunObject = Page "Hr Employee Beneficiaries List";
                    ToolTip = 'Executes the Employee Beneficiaries action.';
                }
                action("Pension Payments List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pension Payments List';
                    RunObject = Page "Hr Pension Payments List";
                    ToolTip = 'Executes the Pension Payments List action.';
                }
            }
            group("Appraisal Management")
            {
                Caption = 'Appraisal Management';
                Image = HumanResources;
                action("Appraisal Form")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal List";
                    ToolTip = 'Executes the Appraisal Form action.';
                }
                action("Appraisal Type")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal Types";
                    ToolTip = 'Executes the Appraisal Type action.';
                }
                action("Appraisal Period")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal Periods";
                    ToolTip = 'Executes the Appraisal Period action.';
                }
                action("Appraisal Rating")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal Ratings";
                    ToolTip = 'Executes the Appraisal Rating action.';
                }
                action("Appraisal Creteria")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal Criteria";
                    ToolTip = 'Executes the Appraisal Creteria action.';
                }
                action("Appraisal Indicators")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Appraisal Indicators";
                    ToolTip = 'Executes the Appraisal Indicators action.';
                }
            }
            group("Staff Appraisal")
            {
                Caption = 'Staff Appraisal';
            }
            group(train)
            {
                Caption = 'Training Management';
                action("Training Applications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Training Applications';
                    RunObject = Page "HR Training Application List";
                    ToolTip = 'Executes the Training Applications action.';
                }
                action("Training Courses")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Training Courses';
                    RunObject = Page "HR Course List";
                    ToolTip = 'Executes the Training Courses action.';
                }
                action("Training Providers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Training Providers';
                    RunObject = Page "HR Training Providers List";
                    ToolTip = 'Executes the Training Providers action.';
                }
                action("Training Needs")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Training Needs';
                    RunObject = Page "Training Need Analysis List";
                    ToolTip = 'Executes the Training Needs action.';
                }
                action("Back To Office")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Back To Office';
                    RunObject = Page "HR Back To Office List";
                    ToolTip = 'Executes the Back To Office action.';
                }
            }
            group(Disciplinary)
            {
                Caption = 'Disciplinary';
                Image = Alerts;
                action("EmpDisciplinary")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Disciplinary Cases';
                    RunObject = Page "HR Disciplinary Cases List";
                    ToolTip = 'Executes the Disciplinary Cases action.';
                }
                action("OtherIncidence")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = ' Employee Other Incidents';
                    RunObject = Page "Employee Other Incidents";
                    ToolTip = 'Executes the  Employee Other Incidents action.';
                }
                group(DisciplinarySetup)
                {
                    action(DisciplinaryCaseRatings)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = ' Disciplinary Case Ratings';
                        RunObject = Page "Disciplinary Case Ratings";
                        ToolTip = 'Executes the  Disciplinary Case Ratings action.';
                    }
                    action(DisciplinaryRemarks)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = ' Disciplinary Remarks';
                        RunObject = Page "Disciplinary Remarks";
                        ToolTip = 'Executes the  Disciplinary Remarks action.';
                    }
                    action(DisciplinaryCases)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = ' Disciplinary Cases';
                        RunObject = Page "Disciplinary Cases";
                        ToolTip = 'Executes the  Disciplinary Cases action.';
                    }
                    action(DisciplinaryAction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = ' Disciplinary Actions';
                        RunObject = Page "Disciplinary Actions";
                        ToolTip = 'Executes the  Disciplinary Actions action.';
                    }
                }
            }
            group(exitInterview)
            {
                Caption = 'Exit Interviews';
                Image = Alerts;
                action(" Exit Interview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = ' Exit Interview';
                    RunObject = Page "HR Exit Interview List";
                    ToolTip = 'Executes the  Exit Interview action.';
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;
                action("Pending My Approval")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending My Approval';
                    RunObject = Page "Requests to Approve";
                    ToolTip = 'Executes the Pending My Approval action.';
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                    ToolTip = 'Executes the My Approval requests action.';
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action("Stores Requisitions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stores Requisitions';
                    RunObject = Page "Store Requisition";
                    ToolTip = 'Executes the Stores Requisitions action.';
                }
                action("Staff Claim")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff Claim';
                    RunObject = Page "Staff Claim List";
                    ToolTip = 'Executes the Staff Claim action.';
                }
                action("Purchase Requisition")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Requisition';
                    RunObject = Page "Purchase Requisition";
                    ToolTip = 'Executes the Purchase Requisition action.';
                }
                action("Imprest Surrender")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Surrender';
                    RunObject = Page "Imprest Accounting";
                    ToolTip = 'Executes the Imprest Surrender action.';
                }
                action("Imprest Requisitions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "Imprest List UP";
                    ToolTip = 'Executes the Imprest Requisitions action.';
                }
                action(Action68)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Leave Applications';
                    RunObject = Page "HR Leave Requisition List";
                    ToolTip = 'Executes the Leave Applications action.';
                }
                action("My Approved Leaves")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "Hr My Approved Leaves List";
                    ToolTip = 'Executes the My Approved Leaves action.';
                }
            }
        }
    }
}
