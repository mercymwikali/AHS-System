Page 85764 "Payroll & Rec. Role Center1"
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
            group(Reports2)
            {
                Caption = 'Payroll Reports';
                Image = RegisteredDocs;

                action(Payslips)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payslips';
                    Image = "Report";
                    RunObject = Report "Individual Payslips mst";
                    ToolTip = 'Executes the Payslips action.';
                }
                group(OtherPayrollReports)
                {
                    Caption = 'Summary Payroll Reports';
                    Image = FiledPosted;
                    action(PayrollSummary)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Summary Detailed';
                        Image = "Report";
                        RunObject = Report "Pr Payroll Summary Detailed";
                        ToolTip = 'Executes the Payroll Summary Detailed action.';
                    }
                    action(PayrollSummary2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Summary2';
                        Image = "Report";
                        RunObject = Report "Payroll Summary";
                        ToolTip = 'Executes the Payroll Summary2 action.';
                    }
                    action(MasterPayrollSummary)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Master Payroll Summary';
                        Image = "Report";
                        RunObject = Report "Company Payroll Summary 3";
                        ToolTip = 'Executes the Master Payroll Summary action.';
                    }
                    action(prTransactions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transactions Report';
                        Image = "Report";
                        RunObject = Report "prTransactions";
                        ToolTip = 'Executes the Transactions Report action.';
                    }
                    action(Variance)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variance';
                        Image = "Report";
                        RunObject = Report prVariance;
                        ToolTip = 'Executes the Variance action.';
                    }
                    action(Variance2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variance2';
                        Image = "Report";
                        RunObject = Report "prDeductions Variance Report2";
                        ToolTip = 'Executes the Variance2 action.';
                    }
                    action(DeductionsSummary)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Deductions Summary';
                        Image = "Report";
                        RunObject = Report "Deductions Summary 2";
                        ToolTip = 'Executes the Deductions Summary action.';
                    }
                    action(EarningsSummary2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Earnings Summary 2';
                        Image = "Report";
                        RunObject = Report "Payments Summary 2";
                        ToolTip = 'Executes the Earnings Summary 2 action.';
                    }
                    action(EarningsDetailed)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Earnings Detailed';
                        Image = "Report";
                        RunObject = Report "Earnings Summary";
                        ToolTip = 'Executes the Earnings Detailed action.';
                    }
                    action("<Report Deductions Summary>")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Deductions Detailed';
                        Image = "Report";
                        RunObject = Report "Deductions Summary 2";
                        ToolTip = 'Executes the Deductions Detailed action.';
                    }
                    action(Staffpension)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Staff pension';
                        Image = "Report";
                        RunObject = Report "prStaff Pension Contrib";
                        ToolTip = 'Executes the Staff pension action.';
                    }
                    action(GrossNetpay)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Gross Netpay';
                        Image = "Report";
                        RunObject = Report prGrossNetPay;
                        ToolTip = 'Executes the Gross Netpay action.';
                    }
                }
                group(BankSchedules)
                {

                    action(BankSchedule)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Schedule';
                        Image = "Report";
                        RunObject = Report "pr Bank Schedule";
                        ToolTip = 'Executes the Bank Schedule action.';
                    }
                    action(EFTTransfer)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'EFT Transfer';
                        Image = "Report";
                        RunObject = Report "pr Bank Schedule";
                        ToolTip = 'Executes the EFT Transfer action.';
                    }
                }
                group(MonthlySummaryReports)
                {
                    Caption = 'Monthly Summary Reports';
                    Image = FiledPosted;
                    action(ThirdRule)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Third Rule';
                        Image = "Report";
                        RunObject = Report "A third Rule Report";
                        ToolTip = 'Executes the Third Rule action.';
                    }
                    action(CoopRemittance)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Co_op Remittance';
                        Image = "Report";
                        RunObject = Report "prCoop remmitance";
                        ToolTip = 'Executes the Co_op Remittance action.';
                    }
                    action(Transactions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transactions';
                        Image = "Report";
                        RunObject = Report "pr Transactions";
                        ToolTip = 'Executes the Transactions action.';
                    }
                }
                group(YearlyStatutoriesReports)
                {
                    Caption = 'Yearly Statutories Reports';
                    Image = FiledPosted;
                    action(P9Report)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'P9 Report';
                        Image = PrintForm;
                        RunObject = Report "P9 Report (Final)";
                        ToolTip = 'Executes the P9 Report action.';
                    }
                }
                group(MonthlyStatutoriesReports)
                {
                    Caption = 'Monthly Statutories Reports';
                    Image = FiledPosted;
                    action(P10)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'P.10';
                        Image = "Report";
                        RunObject = Report "KRA PAYE";
                        ToolTip = 'Executes the P.10 action.';
                    }
                    action(P10V26)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'P.10 V26';
                        Image = "Report";
                        RunObject = Report "P10 Ver 26";
                        ToolTip = 'Executes the P.10 action.';
                    }
                    action(PayeScheule)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Paye Scheule';
                        Image = "Report";
                        RunObject = Report "prPaye Schedule mst";
                        ToolTip = 'Executes the Paye Scheule action.';
                    }
                    action(prHelbReport)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Helb Schedule';
                        Image = "Report";
                        RunObject = Report "HELB Report";
                        ToolTip = 'Executes the Helb Scheule action.';
                    }
                    action(NHIFSchedule)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'NHIF Schedule';
                        Image = "Report";
                        RunObject = Report "NHIF Report";
                        ToolTip = 'Executes the NHIF Schedule action.';
                    }
                    action(NSSFSchedule)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'NSSF Schedule';
                        Image = "Report";
                        RunObject = Report "prNSSF 2";
                        ToolTip = 'Executes the NSSF Schedule action.';
                    }
                    action(Action13)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Third Rule';
                        Image = AddWatch;
                        RunObject = Report "A third Rule Report";
                        ToolTip = 'Executes the Third Rule action.';
                    }
                    action(Action8)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Co_op Remittance';
                        Image = CreateForm;
                        RunObject = Report "prCoop remmitance";
                        ToolTip = 'Executes the Co_op Remittance action.';
                    }
                }
                group(Periodic)
                {
                    Caption = 'Periodic';
                    Image = Bank;
                    action(massupdateTransactions)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'mass update Transactions';
                        Image = PostBatch;
                        RunObject = Report "Mass Update Transactions";
                        ToolTip = 'Executes the mass update Transactions action.';
                    }
                    action(payrollJournalTransfer)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Journal Transfer Per Employee';
                        Image = Journals;
                        RunObject = Report prPayrollJournalTransfer;
                        ToolTip = 'Executes the Payroll Journal Transfer Per Employee action.';
                    }
                    action(payrollJournalTransferSummarized)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Journal Transfer Summarized';
                        Image = Journals;
                        RunObject = Report prPayrollJournalTransfer2;
                        ToolTip = 'Executes the Payroll Journal Transfer Summarized action.';
                    }
                    action(ImportTrans)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Import Employee Transactions';
                        Image = Import;
                        RunObject = xmlport "PrEmployeeTransactions";
                        ToolTip = 'Executes the Import Employee Transactions action.';
                    }
                    action(P9Trans)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Transfer Payrol P9 Info';
                        Image = Import;
                        RunObject = report "Transfer Payrol P9 Info";
                        ToolTip = 'Executes the Transfer Payrol P9 Info action.';
                    }
                }
            }
        }
        area(sections)
        {
            group(Payroll)
            {
                Caption = 'Payroll';
                Image = SNInfo;

                action(SalaryCard)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Salary Card';
                    Image = SetupLines;
                    Promoted = true;
                    RunObject = Page "HR Employee-List";
                    ToolTip = 'Executes the Salary Card action.';
                }
            }
            group(Casual)
            {
                Caption = 'Casuals';
                Image = SNInfo;

                action(CasualList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Casuals';
                    Image = SetupLines;
                    Promoted = true;
                    RunObject = Page "Casual Employees";
                    ToolTip = 'Executes the Casuals action.';
                }
                // action(ParttimerList)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'PartTimers';
                //     Image = SetupLines;
                //     Promoted = true;
                //     RunObject = Page "HR Employees (Part-Time)1";
                // }
                action(CasualPayment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Casual Payment';
                    Image = SetupLines;
                    Promoted = true;
                    RunObject = Page "Casual Payment Header List";
                    ToolTip = 'Executes the Casual Payment action.';
                }
                action(CasualTies)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Casual Rates';
                    Image = SetupLines;
                    Promoted = true;
                    RunObject = Page "Casual Tiers";
                    ToolTip = 'Executes the Casual Rates action.';
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;
                action(PendingMyApproval)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending My Approval';
                    RunObject = Page "Requests to Approve";
                    ToolTip = 'Executes the Pending My Approval action.';
                }
                action(MyApprovalrequests)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                    ToolTip = 'Executes the My Approval requests action.';
                }
            }
            group(Common_req)
            {
                Caption = 'Common Requisitions';
                Image = LotInfo;
                action(StoresRequisitions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stores Requisitions';
                    RunObject = Page "Store Requisition";
                    ToolTip = 'Executes the Stores Requisitions action.';
                }
                action(StaffClaim)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff Claim';
                    RunObject = Page "Staff Claim List";
                    ToolTip = 'Executes the Staff Claim action.';
                }
                action(PurchaseRequisition)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Requisition';
                    RunObject = Page "Purchase Requisition";
                    ToolTip = 'Executes the Purchase Requisition action.';
                }
                action(ImprestSurrender)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Surrender';
                    RunObject = Page "Imprest Accounting";
                    ToolTip = 'Executes the Imprest Surrender action.';
                }
                action(ImprestRequisitions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "Imprest List UP";
                    ToolTip = 'Executes the Imprest Requisitions action.';
                }
                action(LeaveApplications)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Leave Applications';
                    RunObject = Page "HR Leave Requisition List";
                    ToolTip = 'Executes the Leave Applications action.';
                }
                action("<Page My Approved Leaves>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "Hr My Approved Leaves List";
                    ToolTip = 'Executes the My Approved Leaves action.';
                }
            }
        }
        area(creation)
        {
            group(Payroll_Setups)
            {
                Caption = 'Payroll Setups';
                Image = HRSetup;
                action(PayrollPeriod)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Period';
                    Image = Period;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "prPayroll Periods";
                    ToolTip = 'Executes the Payroll Period action.';
                }
                action(TrasactionsList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transactions Codes List';
                    Image = SetupColumns;
                    RunObject = Page "prTransactions Codes List";
                    ToolTip = 'Executes the Transactions Codes List action.';
                }
                action(RatesandCeiling)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Rates and Ceiling';
                    Image = SetupColumns;
                    RunObject = Page "Pr Payroll Setup Card";
                    ToolTip = 'Executes the Rates and Ceiling action.';
                }
                action(payeSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'paye Setup';
                    Image = SetupPayment;
                    RunObject = Page "prP.A.Y.E Setup";
                    ToolTip = 'Executes the paye Setup action.';
                }
                action(Action6)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'NHIF Setup';
                    Image = SetupLines;
                    RunObject = Page "prNHIF SetUp";
                    Visible = false;
                    ToolTip = 'Executes the NHIF Setup action.';
                }
                action(Action7)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'NSSF Setup';
                    Image = SetupLines;
                    RunObject = Page "PR NSSF Setup";
                    ToolTip = 'Executes the NSSF Setup action.';
                }
                action(BankAccounts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Acocunts';
                    Image = Bank;
                    RunObject = Page "Pr Bank Acocunts";
                    ToolTip = 'Executes the Bank Acounts action.';
                }
                action(BankStructure)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Brances';
                    Image = Bank;
                    RunObject = Page "Pr Bank Branches";
                    ToolTip = 'Executes the Bank Branches action.';
                }
                action(controlinformation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'control information';
                    Image = CompanyInformation;
                    RunObject = Page "Control-Information";
                    ToolTip = 'Executes the control information action.';
                }
                action(SalaryGrades)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Salary Grades';
                    Image = EmployeeAgreement;
                    RunObject = Page "Salary Grades";
                    ToolTip = 'Executes the Salary Grades action.';
                }
                action(postinggroup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'posting group';
                    Image = PostingEntries;
                    RunObject = Page "prEmployee Posting Group";
                    ToolTip = 'Executes the posting group action.';
                }
            }
        }
    }
}
