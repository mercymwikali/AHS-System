Page 52202833 "HMS Hospital Role Centre1"
{
    Caption = 'Hospital Admin Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control60; "Headline RC General Mgt.")
            {
                ApplicationArea = RelationshipMgmt;
            }


            group(Control1900724808)
            {
                ShowCaption = false;


                part(Control8; "HMS Cue")
                {
                    Caption = 'HMS CUE';
                }
                part(Control16; "Team Member Activities")
                {
                    ApplicationArea = RelationshipMgmt;
                }

                // part(Control2; "Power BI Report Spinner Part")
                // {
                //     ApplicationArea = RelationshipMgmt;
                // }
            }
            group(Control1900724708)
            {
                ShowCaption = false;

                part("My Approval Entries"; "Requests to Approve")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approval Entries';
                }
                part(Control106; "My Job Queue")
                {
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(embedding)
        {
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Insurance/Customer';
                Image = Customer;
                RunObject = Page "Customer List2";
                RunPageView = where(Confirmed = filter(false));
                ToolTip = 'Executes the Insurance/Customer action.';
            }
            action(CustomersBlocked)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Blocked Customers List';
                Image = Customer;
                RunObject = Page "Customer List2";
                RunPageView = where(Confirmed = filter(true));
                ToolTip = 'Executes the Insurance/Customer action.';
            }
            action(CustomersBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
                ToolTip = 'Executes the Balance action.';
            }
            action(PatientBilling)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Active Patients';
                Image = Calculate;
                RunObject = Page "HMS Patient Billing";
                ToolTip = 'Executes the Active Patients action.';
            }
            action("Active InPatients")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Active Patient InPatients";
                ToolTip = 'Executes the Active InPatients action.';
            }
            action("Active OutPatients")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Active Patient OutPatients";
                ToolTip = 'Executes the Active OutPatients action.';
            }
            action("Discharge Request")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Admission Progress List";
                ToolTip = 'Executes the Discharge Request action.';
            }
            action("Discharge List")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Admission Discharge List";
                ToolTip = 'Executes the Discharge List action.';
            }
            action("Invoice Dispatch")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Invoice Dispatch List";
                ToolTip = 'Executes the Invoice Dispatch action.';
            }
            action(Charges)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Charges';
                Image = Reminder;
                RunObject = Page "HMS Charges";
                ToolTip = 'Executes the Charges action.';
            }
            action(Reminders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reminders';
                Image = Reminder;
                RunObject = Page "Reminder List";
                ToolTip = 'Executes the Reminders action.';
            }
            action(FinanceChargeMemos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Finance Charge Memos';
                Image = FinChargeMemo;
                RunObject = Page "Finance Charge Memo List";
                ToolTip = 'Executes the Finance Charge Memos action.';
            }
            action(IncomingDocuments)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Incoming Documents';
                Image = Documents;
                RunObject = Page "Incoming Documents";
                ToolTip = 'Executes the Incoming Documents action.';
            }
            action("Clinical Report")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Daily Clinical Report';
                Image = Documents;
                RunObject = Page "Daily Clinical Reports List";
                ToolTip = 'Executes the Daily Clinical Report action.';
            }
            action("Unsynced Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Unsynced Visit Invoices';
                Image = Documents;
                RunObject = Page "Unsynced Visits Invoices";
                ToolTip = 'Executes the Unsynced Invoices action.';
            }
            action("Sales Invoices Buffer")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Posted Sales Invoices Buffer';
                Image = Documents;
                RunObject = Page "Posted Sales Invoices Buffer";
                ToolTip = 'Executes the Posted Sales Invoices Buffer action.';
            }
        }
        area(processing)
        {
            group(Admissions)
            {
                Caption = 'Admissions';
                Image = Payables;
                action(AdmReq)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admission Requests';
                    Image = FixedAssets;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Admission Form Header List";
                    ToolTip = 'Executes the Admission Requests action.';
                }
                action(AdmReq1)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Verified Admission Requests';
                    Image = FixedAssets;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Admission Verified List";
                    ToolTip = 'Executes the Verified Admission Requests action.';
                }
                action(AdmAdmitted)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admitted Admission Requests';
                    Image = FixedAssets;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Admission Header Admitted";
                    ToolTip = 'Executes the Admitted Admission Requests action.';
                }
            }
            group(Referrals)
            {
                Caption = 'Referrals';
                Image = Confirm;
                action(RefHosp)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referral Hospitals';
                    Image = SetupColumns;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vendor Card";
                    ToolTip = 'Executes the Referral Hospitals action.';
                }
                action(ActiveRef)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Referrals';
                    Image = Setup;
                    Promoted = true;
                    RunObject = Page "HMS Referral Header Active";
                    ToolTip = 'Executes the Active Referrals action.';
                }
                action(hitRef)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Completed Referrals';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Referral Header Released";
                    ToolTip = 'Executes the Completed Referrals action.';
                }
            }
            group(Immunizations)
            {
                Caption = 'Immunizations';
                Image = SNInfo;
                action(Immunization)
                {
                    ApplicationArea = Basic, Suite;
                    Image = NewOrder;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Immunization Header";
                    ToolTip = 'Executes the Immunization action.';
                }
                action(ImmHist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Immunization History';
                    Image = History;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Immunization Posted";
                    ToolTip = 'Executes the Immunization History action.';
                }
            }
            group(Reports)
            {


                Caption = 'Reports';
                Image = SNInfo;

                group(HMSReports)
                {
                    Caption = 'HMS Reports';

                    group(Patient)
                    {
                        Caption = 'Patient Reports';
                        Image = Report2;
                        action(PatList)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Patient listing';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Patient Listing Report";
                            ToolTip = 'Executes the Patient listing action.';
                        }
                        action(Admission_List)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Admission listing';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Admission Listing Summary";
                            ToolTip = 'Executes the Admission listing action.';
                        }
                        action(Admission_List_Daily)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Daily Inpatient Report';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "Daily Inpatient Report";
                            ToolTip = 'Executes the Daily Inpatient Report action.';
                        }
                        action(Ref_list)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Referrals Listing';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Referral Listing Report";
                            ToolTip = 'Executes the Referrals Listing action.';
                        }
                        action(Daily_Att_OutPat)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Daily Attendance (Outpatient)';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Daily Attendance Report";
                            ToolTip = 'Executes the Daily Attendance (Outpatient) action.';
                        }
                        action(incomePerCheaxe)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Income per Patient Charges';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Income per Patient Charges";
                            ToolTip = 'Executes the Income per Patient Charges action.';
                        }
                    }
                    action(App)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appointments';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Appointments Listing";
                        ToolTip = 'Executes the Appointments action.';
                    }

                    action(Observ)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Triage Listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Observation Listing Report";
                        ToolTip = 'Executes the Observations action.';
                    }
                    action(App1)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Operational Monthly Totals';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Operational Monthly Totals";
                        ToolTip = 'Executes the Operational Monthly Totals action.';
                    }
                    action(App2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Operational Daily Totals';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Operational Daily Totals";
                        ToolTip = 'Executes the Operational Daily Totals action.';
                    }
                    action(ICD10)
                    {
                        ApplicationArea = Basic, Suite;
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Diagnosis List";
                        ToolTip = 'Executes the ICD10 action.';
                    }

                    action("39005644")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of account';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMs Invoice Statements";
                        ToolTip = 'Executes the Statement of account action.';
                    }
                    action(treatment)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Treatments';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Treatment Listing Report";
                        ToolTip = 'Executes the Treatments action.';
                    }
                    action("39005684")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Validate Patient Charges';
                        RunObject = Report "HMS Validate Charges Amount";
                        Visible = false;
                        ToolTip = 'Executes the Validate Patient Charges action.';
                    }

                    group(Lab1)
                    {
                        caption = 'Lab Reports';
                        Image = Report2;
                        action(labtest1)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Lab Tests Summary';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Laboratory Test Summary";
                            ToolTip = 'Executes the Lab Tests Summary action.';
                        }
                        action(labtest2)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Lab Tests Detailed';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Laboratory Test Detailed";
                            ToolTip = 'Executes the Lab Tests Detailed action.';
                        }
                        action(labtest3)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Lab tests Findings';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Laboratory Test Finding";
                            ToolTip = 'Executes the Lab tests Findings action.';
                        }
                        action(labtest5)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Test Per Insurance';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "Laboratory Detailed Report2";
                            ToolTip = 'Executes the Test Per Insurance action.';
                        }
                        action(labtest6)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Test Summary';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Lab Tests Summary";
                            ToolTip = 'Executes the Test Summary action.';
                        }
                        action(labtest7)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Laboratory Capitation';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "Laboratory -Capitation";
                            ToolTip = 'Executes the Laboratory Capitation action.';
                        }
                        action(labtest8)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Laboratory Insurance';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "Laboratory Insurance Count";
                            ToolTip = 'Executes the Laboratory Insurance action.';
                        }
                    }
                    group(Pharmarcy)
                    {
                        Caption = 'Pharmacy Reports';
                        Image = Report2;
                        action(pham_Drug_1)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Process Student Patients';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Pharmacy Issues Report";
                            ToolTip = 'Executes the Process Student Patients action.';
                        }
                        action(pham_Drug_3)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'HMS Pharmacy Issues Report';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Pharmacy Issues Report";
                            ToolTip = 'Executes the HMS Pharmacy Issues Report action.';
                        }
                        action(pham_Drug_4)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Pharmacy Sales Summary Report';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "Pharmacy Sales Summary";
                            ToolTip = 'Executes the Pharmacy Sales Summary Report action.';
                        }


                    }

                    action(Inj_Reg)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Injection Register';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Injection Register Report";
                        ToolTip = 'Executes the Injection Register action.';
                    }
                    action(Proc_Emp_and_Deps)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appointments';
                        Image = ExecuteAndPostBatch;
                        Promoted = true;
                        PromotedIsBig = true;
                        Visible = false;
                        RunObject = Report "HMS Process Employee & Deps";
                        ToolTip = 'Executes the Appointments action.';
                    }

                }
                group(ReceiptsReports)
                {
                    caption = 'Receipts Reports';
                    action("Receiptsshiftreport")
                    {

                        Caption = 'Receipts shift report';
                        Image = "Report";
                        RunObject = Report "Receipts Per Transaction Type";
                        ApplicationArea = all;
                        ToolTip = 'Executes the Receipts shift report action.';
                    }
                    action("ReceiptsSummary")
                    {
                        Caption = 'Receipts Summary';
                        Image = "Report";
                        RunObject = Report "Receipts Summary";
                        ApplicationArea = all;
                        ToolTip = 'Executes the Receipts Summary action.';
                    }
                    action("RevenueSummary")
                    {
                        Caption = 'Revenue Summary';
                        Image = "Report";
                        RunObject = Report "Receipts Per Transaction Type2";
                        ApplicationArea = all;
                        ToolTip = 'Executes the Revenue Summary action.';
                    }
                    action("ReceiptsReportCombined")
                    {
                        Caption = 'Receipts Report Combined';
                        Image = "Report";
                        RunObject = Report "Receipts Unscattered";
                        ApplicationArea = all;
                        ToolTip = 'Executes the Receipts Report Combined action.';
                    }
                }
                group(BillingReport)
                {
                    Caption = 'Billing Reports';
                    action("Patients Visits Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Image = VATStatement;
                        RunObject = Report "HMS Visit Summary";
                        ToolTip = 'Executes the Patients Visits Summary action.';
                    }
                    action("HMS Insurance Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insurance Summary';
                        Image = Receipt;
                        RunObject = Report "Posted Sales Invoice Summary";
                        ToolTip = 'Executes the Insurance Summary action.';
                    }
                    action("HMS Charges Prices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Charges Prices';
                        Image = Receipt;
                        RunObject = Report "HMS Charges Prices";
                        ToolTip = 'Executes the Charges Prices action.';
                    }
                    action("HMS Insurance Rates")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insurance Consultation Rates';
                        Image = Receipt;
                        RunObject = Report "HMS Insurance Rates";
                        ToolTip = 'Executes the Insurance Consultation Rates action.';
                    }
                }
            }
        }
        area(sections)
        {
            group(Registration)
            {
                Caption = 'Patient Management';
                action("Patients List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Patient List2";
                    RunPageView = where("Patient Status" = filter(Alive), "Walk-in" = filter(false));
                    ToolTip = 'Executes the Patients List action.';
                }
                action("Patients List2")
                {
                    Caption = 'Walkin Patients List';
                    ApplicationArea = Basic, Suite;
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Patient List2";
                    RunPageView = where("Walk-in" = filter(true));
                    ToolTip = 'Executes the Walkin Patients List action.';
                }
            }
            group(Appointments)
            {
                Caption = 'Appointments';
                Image = Statistics;
                action(Action19)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Appointment List";
                    ToolTip = 'Executes the Appointments action.';
                }
                action(AppointmentsControl)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments Control';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Appointment Form List";
                    ToolTip = 'Executes the Appointments Control action.';
                }
                action(AppointmentsHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Appointment Form History L";
                    ToolTip = 'Executes the Appointments History action.';
                }
            }
            group("Appointment Booking")
            {
                action("Appointment Booking List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Appointment Booking";
                    ToolTip = 'Executes the Appointment Booking List action.';
                }
                action("Availability Planner")
                {
                    ApplicationArea = All;
                    RunObject = page "Doctor Availability Plan";
                    ToolTip = 'Executes the Availablity Plan Action';
                }
                group("Appointment Schedule Setup")
                {
                    action(Slots)
                    {
                        ApplicationArea = All;
                        RunObject = page "Appointment Time Slots Setup";
                        ToolTip = 'Executes the Appointment Time Slots Setup Action';
                        Caption = 'Appointment Time Slots Setup';
                    }
                }
            }
            group(ObsRoom)
            {
                Caption = 'Triage Room';
                Image = RegisteredDocs;
                action(Action48)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Triage';
                    RunObject = Page "HMS Observation List";
                    ToolTip = 'Executes the Triage action.';
                }
                action(TriageHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Triage History';
                    RunObject = Page "HMS Observation History List";
                    ToolTip = 'Executes the Triage History action.';
                }
            }
            group(DocVisit)
            {
                Caption = 'Consultation Room';
                Image = Journals;
                action(DocVisits)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Visits';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Treatment List";
                    ToolTip = 'Executes the Doctor''s Visits action.';
                }
                action(ActiveDocVisits)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Doctor''s Visits';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Active Treatment List";
                    ToolTip = 'Executes the Active Doctor''s Visits action.';
                }
                action(DocRequests)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Requests';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Doctor Review Request";
                    ToolTip = 'Executes the Doctor''s Requests action.';
                }
                action(DoctorsVisitHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Visit History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Treatment History List";
                    ToolTip = 'Executes the Doctor''s Visit History action.';
                }
            }
            group(Therapy)
            {
                Caption = 'Psychology Consultations';
                Image = RegisteredDocs;
                action("Therapy Sessions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Psychology Consultations';
                    RunObject = Page "HMS Treatment List(Psychology)";
                    ToolTip = 'Executes the Therapy Sessions action.';
                }
                action("CLosed Therapy Sessions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Closed Therapy Sessions';
                    RunObject = Page "HMS Treatment List(Psychology)";
                    // RunPageView = where(Status = filter())
                    ToolTip = 'Executes the Closed Therapy Sessions List action.';
                }
            }

            group(Lab)
            {
                Caption = 'Lab. Visits';
                Image = FiledPosted;
                action(Lab_List)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Requests';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Laboratory List";
                    ToolTip = 'Executes the Test Requests action.';
                }
                action(findings)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Findings';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Laboratory History List";
                    ToolTip = 'Executes the Test Findings action.';
                }
                action(Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Visit History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Treatment History List";
                    ToolTip = 'Executes the Doctor''s Visit History action.';
                }
            }
            group(Pharmacy)
            {
                Caption = 'Pharmacy';
                Image = Departments;
                action(Pharm)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Pharmacy List";
                    ToolTip = 'Executes the Pharmacy List action.';
                }
                action(Pharm_Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Pharmacy History List";
                    ToolTip = 'Executes the Pharmacy History action.';
                }
                action("39003925")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List-Returns';
                    RunObject = Page "HMS Pharmacy Line-returns";
                    ToolTip = 'Executes the Pharmacy List-Returns action.';
                }
                group(pharm_reports)
                {
                    Caption = 'Pharmacy Reports';
                    action(pham_Drug8)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pharmacy Sales Summary Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Pharmacy Sales Summary";
                        ToolTip = 'Executes the Pharmacy Sales Summary Report action.';
                    }
                    action(StockDetailed)
                    {
                        ApplicationArea = All;
                        Caption = 'Detailed Stock Movement';
                        Image = StepOver;
                        RunObject = Report "Pharmacy Stock Movement";
                    }
                    action(ChargesPhrmacy)
                    {
                        ApplicationArea = All;
                        Caption = 'Pharmacy Billed Items';
                        Image = StepOver;
                        RunObject = Report "Pharmacy Posted Charges";
                    }
                    action(StockDetailedPNL)
                    {
                        ApplicationArea = All;
                        Caption = 'Pharmacy Sales Breakdown';
                        Image = StepOver;
                        RunObject = Report "Pharmacy Sales Breakdown";
                    }
                }

            }
            group(HMS_Admissions)
            {
                action(AdmissionRequests)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Admission Requests';
                    RunObject = Page "HMS Admission Form Header List";
                    ToolTip = 'Executes the New Admission Ruquests Action .';
                }
                action(AdmissionVerified)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Verified Admission Requests';
                    RunObject = Page "HMS Admission Verified List";
                    ToolTip = 'Executes the Verified Admission Requests Action .';
                }
                action(AdmissionAdmitted)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admitted Admission Requests';
                    RunObject = Page "HMS Admission Admitted List";
                    RunPageView = where(Status = const(AdmissionStatusEnum::Admitted));
                    ToolTip = 'Executes the Verified Admission Requests Action .';
                }
                action(AdmissionDischarged)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = ' Admission Discharged';
                    RunObject = Page "HMS Admission Admitted List";
                    RunPageView = where(Status = const(AdmissionStatusEnum::Discharged));
                    ToolTip = 'Executes the  Admission Discharged Action .';
                }
            }
            group(Inpatient_Management)
            {
                Caption = 'Inpatient Management';
                Image = LotInfo;


                action(InPatients)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'InPatients';
                    RunObject = Page "HMS InPatient List";
                    ToolTip = 'Executes the InPatients action.';
                }
                action(DischargeRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Discharge Request';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Admission Progress List";
                    ToolTip = 'Executes the Discharge Request action.';
                }
                action(Discharge)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Discharge List';
                    Image = ReleaseShipment;
                    RunObject = Page "HMS Admission Discharge List";
                    ToolTip = 'Executes the Discharge List action.';
                }
            }
            group(Reports_Diagnosis)
            {
                Caption = 'Diagnosis Report';
                Image = ReferenceData;
                action("Dignosis Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagnosis Over 5yrs';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Report "Diagnosis Over 5yrs";
                    ToolTip = 'Executes the Diagnosis Over 5yrs action.';
                }
                action(Under_5yrs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagnosis Under 5yrs';
                    Image = History;
                    Promoted = true;
                    RunObject = Report "Diagnosis Under 5yrs";
                    ToolTip = 'Executes the Diagnosis Under 5yrs action.';
                }
                action("Hospital Diagnosis.")
                {
                    ApplicationArea = Basic, Suite;
                    Image = DataEntry;
                    RunObject = Report "Hospital Diagnosis<5years";
                    ToolTip = 'Executes the Hospital Diagnosis. action.';
                }
            }
            group(Refs)
            {
                Caption = 'Referrals';
                Image = RegisteredDocs;
                action(ref)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referrals';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Referral Header List";
                    ToolTip = 'Executes the Referrals action.';
                }
                action(ref_Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referrals History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Referral Header List2";
                    ToolTip = 'Executes the Referrals History action.';
                }
            }

            group(Billing)
            {
                Caption = 'Hospital Billing';
                Image = Intrastat;
                action(Receipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Receipts';
                    Image = Insurance;
                    Promoted = true;
                    RunObject = Page "Receipts List";
                    ToolTip = 'Executes the Receipts action.';
                }
                action("Sales Invoice List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoice List';
                    RunObject = Page "Sales Invoice List.";
                    ToolTip = 'Executes the Invoice List action.';
                }
            }
            group(Sales)
            {
                Caption = 'Sales';
                action(SalesOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';
                    Image = "Order";
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Executes the Sales Orders action.';
                }
                action(SalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    Image = Invoice;
                    RunObject = Page "Sales Invoice List.";
                    ToolTip = 'Executes the Sales Invoices action.';
                }
                action(SalesReturnOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Order List";
                    ToolTip = 'Executes the Sales Return Orders action.';
                }
                action(Schemeplan)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scheme Plan';
                    Image = ReturnOrder;
                    RunObject = Page "HMS Scheme Plan List";
                    ToolTip = 'Executes the Scheme Plan action.';
                }
            }
            group(PostedDocuments)
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                action(PostedSalesShipments)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'Executes the Posted Sales Shipments action.';
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Executes the Posted Sales Invoices action.';
                }
                action(PostedReturnReceipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                    ToolTip = 'Executes the Posted Return Receipts action.';
                }
                action(PostedSalesCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Executes the Posted Sales Credit Memos action.';
                }
                action(PostedPurchaseInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Executes the Posted Purchase Invoices action.';
                }
                action(PostedPurchaseCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Executes the Posted Purchase Credit Memos action.';
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Administration;
                action(PendingMyApproval)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending My Approval';
                    RunObject = Page "Approval Entries";
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
                    RunObject = Page "Imprest Lists";
                    ToolTip = 'Executes the Imprest Requisitions action.';
                }
                action(LeaveApplications)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Leave Applications';
                    RunObject = Page "HR Leave Requisition List";
                    ToolTip = 'Executes the Leave Applications action.';
                }
                action(MyApprovedLeaves)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "Hr My Approved Leaves List";
                    ToolTip = 'Executes the My Approved Leaves action.';
                }
                action("Broadcast SMS")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "SMS Broadcast List1";
                    ToolTip = 'Executes the Broadcast SMS action.';
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action("Request to Approve")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Requests to Approve";
                    ToolTip = 'Executes the Request to Approve action.';
                }
            }
            group(Setups1)
            {
                Caption = 'Hospital Setups.';
                Image = SNInfo;

                action("39006182")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transaction code';
                    RunObject = Page "HMS Transaction code List";
                    ToolTip = 'Executes the Transaction code action.';
                }


                action(Setup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Card";
                    ToolTip = 'Executes the Setup Card action.';
                }
                action(userCard)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'User Setup Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "User Setup Card";
                    ToolTip = 'Executes the User Setup Card action.';
                }
                action(Systems_Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Systems Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Systems List";
                    ToolTip = 'Executes the Systems Card action.';
                }
                action(Setup_Doctor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Doctor';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Hms Setup Doctors List";
                    ToolTip = 'Executes the Setup Doctor action.';
                }
                action(Setup_Blood_Group)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Blood Group';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Blood Group List";
                    ToolTip = 'Executes the Setup Blood Group action.';
                }
                action(Vital_Scale)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vital Monitoring Chart Scale';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vital Monitoring Chart Range";
                    ToolTip = 'Executes the Vital Monitoring Chart Range.';
                }
                action(Blood_Group_Donation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Blood Group Donation';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Blood Group Donation List";
                    ToolTip = 'Executes the Blood Group Donation action.';
                }
                action(Drug_Interaction)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Drug Interaction';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Drug Interaction Header";
                    ToolTip = 'Executes the Drug Interaction action.';
                }
                action(Observation_Signs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Observation Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS General Observation Setup";
                    ToolTip = 'Executes the General Observation Setup action.';
                }
                action(Appointment_Typ)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointment Type';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Appointment Type Lst";
                    ToolTip = 'Executes the Appointment Type action.';
                }

                action("Setup Process")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Process Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Process List";
                    ToolTip = 'Executes the Process Setup action.';
                }
                action("Setup Dosage")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dosage Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Dosage Setup";
                    ToolTip = 'Executes the Dosage Setup action.';
                }
                action(Injection)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Injection';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Injection List";
                    ToolTip = 'Executes the Injection action.';
                }
                action(Diagnosis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagnosis Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Diagnosis List";
                    ToolTip = 'Executes the Diagnosis setup action.';
                }
                action(SecondaryDiagnosis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Secondary Diagnosis Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Secondary Diagnosis Setup";
                    ToolTip = 'Executes the Secondary Diagnosis Setup action.';
                }
                action("Expected Date of Discharge Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Expected Date of Discharge Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "EDD Protocol Setup Page";
                    ToolTip = 'Executes the Expected Date of Discharge Setup action.';
                }
                action("IP Form Lookup Values")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'In Patient Form Lookup Values';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "IP Form Lookup Values";
                    ToolTip = 'Executes the In Patient Form Lookup Values action.';
                }

                action(Allergy)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Allergy';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Allergy List";
                    ToolTip = 'Executes the Allergy action.';
                }
                action(signs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Signs';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Signs";
                    ToolTip = 'Executes the Signs action.';
                }
                action(Symptoms)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Symptoms';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Syptoms";
                    ToolTip = 'Executes the Symptoms action.';
                }
                action(messuring_Uni)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Measuring Units';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Measuring Unit List";
                    ToolTip = 'Executes the Measuring Units action.';
                }
                action(specimen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Specimen Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Specimen List";
                    ToolTip = 'Executes the Specimen Card action.';
                }
                action(Lab_test)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Lab Test Setups';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Lab Test List";
                    ToolTip = 'Executes the Lab Test Setups action.';
                }
                action(RadiologyTypes)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Radiology Types Setups';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Radiology Type List";
                    ToolTip = 'Executes the Lab Test Setups action.';
                }

                action(DosageSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dosage Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Dosage Setup";
                    ToolTip = 'Executes the Dosage Setup action.';
                }
                action(Therapy_Types)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Therapy Types Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Therapy Types";
                    ToolTip = 'Executes the Therapy Types Setup action.';
                }
                action(Schemeplans)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scheme Plan List';
                    Image = ReturnOrder;
                    RunObject = Page "HMS Scheme Plan List";
                    ToolTip = 'Executes the Scheme Plan List action.';
                }

                action(Setup_Disctarge_Process)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Discharge Process';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Disctarge Process";
                    ToolTip = 'Executes the Setup Discharge Process action.';
                }
                action(wards)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ward Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Ward List";
                    ToolTip = 'Executes the Ward Setup action.';
                }
                action(wardRooms)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ward Rooms Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Ward Rooms";
                    ToolTip = 'Executes the Ward Rooms Setup action.';
                }
                action(Beds)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Beds';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Beds";
                    ToolTip = 'Executes the Beds action.';
                }
                action(Hos_Charges)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hospital Charges Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Charges";
                    ToolTip = 'Executes the Hospital Charges Setup action.';
                }
                action(Hos_Drugs_Prof)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hospital Drugs Profit';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Drugs Profit";
                    ToolTip = 'Executes the Hospital Drugs Profit action.';
                }
                action(Clinics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hospital Clinics Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Clinics SetUp";
                    ToolTip = 'Executes the Hospital Clinics Setup action.';
                }
                action(County)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'County Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Application Setup County";
                    ToolTip = 'Executes the County Setup action.';
                }
                action(SubCounty)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sub-County Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sub-County Setup";
                    ToolTip = 'Executes the Sub-County Setup action.';
                }
                action(Couunty_Wards)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'County Wards';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "County Wards";
                    ToolTip = 'Executes the County Wards action.';
                }
                action("Marketing Strategies")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Marketing Strategies';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Marketing Strategies";
                    ToolTip = 'Executes the Marketing Strategies action.';
                }
                action(URGENCYSETUP)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Urgency Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Urgency Color Coding Setup";
                    ToolTip = 'Executes the Urgency Setup action.';
                }
                action(SchemeNames)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scheme Names Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Scheme Names Setups";
                    ToolTip = 'Executes the Scheme Names Setup action.';
                }
                action(InsuranceSchemeNames)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Insurance Scheme Names Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Insurance Schemes Setup";
                    ToolTip = 'Executes the Insurance Scheme Names Setup action.';
                }
            }
            group(SMSSetupList)
            {
                Caption = 'Doctor Form Setup';
                action(SMSsetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SMS Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "SMS Setup";
                    ToolTip = 'Executes the SMS Setup action.';
                }

                action(smsTemplating)
                {
                    ApplicationArea = All;
                    Caption = 'SMS Templates List';
                    Image = Template;
                    RunObject = page "SMS Templates List";
                    RunPageMode = Edit;
                    ToolTip = 'Executes the SMS Templates List action.';
                }
            }
            group(DocFormSetups)
            {
                Caption = 'Doctor Form Setup';

                action(SectionsSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Form Sections Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Form Sections Setup";
                    ToolTip = 'Executes the Form Sections Setup action.';
                }
                action(CategoriesSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Section Categories Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Section Categories Setup";
                    ToolTip = 'Executes the Section Categories Setup action.';
                }
                action(FormItems)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Form Items Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Form Items Setup";
                    ToolTip = 'Executes the Form Items Setup action.';
                }
            }
            group(PharmSetups)
            {
                Caption = 'Pharmacy Setups';
                action(DrugGenericNames)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Drug Generic Names';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Drug Generic Names Setup";
                    ToolTip = 'Executes the Drug Generic Names action.';
                }
            }

        }
    }

    var
        HMSSetup: Record "HMS Setup";
        Dialysismode: Boolean;
}

