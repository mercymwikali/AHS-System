page 52203152 "HMS Psychiatrist Role Centre"
{
    ApplicationArea = All;
    Caption = 'Pychiatrist Role Centre';
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
            }
            action(CustomersBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = where("Balance (LCY)" = filter(<> 0));
            }
            action(PatientBilling)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Active Patients';
                Image = Calculate;
                RunObject = Page "HMS Patient Billing";
            }

            action("Active OutPatients")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Active Patient OutPatients";
            }
            action("Discharge Request")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Admission Progress List";
            }
            action("Discharge List")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Admission Discharge List";
            }
            action("Invoice Dispatch")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Invoice Dispatch List";
            }
            action(Charges)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Charges';
                Image = Reminder;
                RunObject = Page "HMS Charges";
            }
            action(Reminders)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reminders';
                Image = Reminder;
                RunObject = Page "Reminder List";
            }
            action(FinanceChargeMemos)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Finance Charge Memos';
                Image = FinChargeMemo;
                RunObject = Page "Finance Charge Memo List";
            }
            action(IncomingDocuments)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Incoming Documents';
                Image = Documents;
                RunObject = Page "Incoming Documents";
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
                }
                action(AdmProg)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Admission Process';
                    Image = FixedAssetLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Admission Progress";
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
                }
                action(ActiveRef)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Active Referrals';
                    Image = Setup;
                    Promoted = true;
                    RunObject = Page "HMS Referral Header Active";
                }
                action(hitRef)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Completed Referrals';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Referral Header Released";
                }


            }
            group(Reports)
            {


                Caption = 'Reports';
                Image = SNInfo;
                group(ReceiptsReports)
                {
                    caption = 'Receipts Reports';
                    action("Receiptsshiftreport")
                    {

                        Caption = 'Receipts shift report';
                        Image = "Report";
                        RunObject = Report "Receipts Per Transaction Type";
                        ApplicationArea = all;
                    }
                    action("ReceiptsSummary")
                    {
                        Caption = 'Receipts Summary';
                        Image = "Report";
                        RunObject = Report "Receipts Summary";
                        ApplicationArea = all;
                    }
                    action("RevenueSummary")
                    {
                        Caption = 'Revenue Summary';
                        Image = "Report";
                        RunObject = Report "Receipts Per Transaction Type2";
                        ApplicationArea = all;
                    }
                    action("ReceiptsReportCombined")
                    {
                        Caption = 'Receipts Report Combined';
                        Image = "Report";
                        RunObject = Report "Receipts Unscattered";
                        ApplicationArea = all;
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
                    }
                    action("HMS Insurance Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insurance Summary';
                        Image = Receipt;
                        RunObject = Report "Posted Sales Invoice Summary";
                    }
                    action("HMS Charges Prices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Charges Prices';
                        Image = Receipt;
                        RunObject = Report "HMS Charges Prices";
                    }
                    action("HMS Insurance Rates")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Insurance Consultation Rates';
                        Image = Receipt;
                        RunObject = Report "HMS Insurance Rates";
                    }
                }
                group(HMSReports)
                {
                    Caption = 'HMS Reports';
                    action(App)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appointments';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Appointments Listing";
                    }
                    action(App1)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Operational Monthly Totals';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Operational Monthly Totals";
                    }
                    action(App2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Operational Daily Totals';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Operational Daily Totals";
                    }
                    action(ICD10)
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Report "HMS Diagnosis List";
                    }
                    action(incomePerCheaxe)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income per Patient Charges';
                        RunObject = Report "HMS Income per Patient Charges";
                    }
                    action(Observ)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Observations';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Observation Listing Report";
                    }
                    action("39005644")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of account';
                        RunObject = Report "HMs Invoice Statements";
                    }
                    action(treatment)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Treatments';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Treatment Listing Report";
                    }
                    action("39005684")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Validate Patient Charges';
                        RunObject = Report "HMS Validate Charges Amount";
                    }

                    group(Lab1)
                    {
                        caption = 'Lab Reports';
                        action(labtest1)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Lab Tests Summary';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Laboratory Test Summary";
                        }
                        action(labtest2)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Lab Tests Detailed';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Laboratory Test Detailed";
                        }
                        action(labtest3)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Lab tests Findings';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Laboratory Test Finding";
                        }
                        action(labtest5)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Test Per Insurance';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "Laboratory Detailed Report2";
                        }
                        action(labtest6)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Test Summary';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "HMS Lab Tests Summary";
                        }
                        action(labtest7)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Laboratory Capitation';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "Laboratory -Capitation";
                        }
                        action(labtest8)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Laboratory Insurance';
                            Image = "Report";
                            Promoted = true;
                            PromotedIsBig = true;
                            RunObject = Report "Laboratory Insurance Count";
                        }
                    }
                    action(pham_Drug_1)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Process Student Patients';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Pharmacy Issues Report";
                    }
                    action(pham_Drug_3)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Process Student Patients';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Pharmacy Issues Report";
                    }
                    action(PatList)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Patient listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Patient Listing Report";
                    }
                    action(Admission_List)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Admission listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Admission Listing Summary";
                    }
                    action(Ref_list)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Referrals Listing';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Referral Listing Report";
                    }
                    action(Daily_Att_OutPat)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Daily Attendance (Outpatient)';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Daily Attendance Report";
                    }
                    action(Inj_Reg)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Injection Register';
                        Image = "Report";
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Injection Register Report";
                    }
                    action(Proc_Emp_and_Deps)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Appointments';
                        Image = ExecuteAndPostBatch;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "HMS Process Employee & Deps";
                    }

                }
            }





        }
        area(sections)
        {
            group(Registration)
            {
                action("Patients List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Patient List2";
                    RunPageView = where("Patient Status" = filter(Alive));
                }
                action("Patients List2")
                {
                    Caption = 'RIP Patients List';
                    ApplicationArea = Basic, Suite;
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Patient List2";
                    RunPageView = where("Patient Status" = const(Dead));
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
                }
                action(AppointmentsControl)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments Control';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Appointment Form List";
                }
                action(AppointmentsHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Appointment Form History L";
                }
            }
            group("Appointment Booking")
            {
                action("Appointment Booking List")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Appointment Booking";
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
                }
                action(TriageHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Triage History';
                    RunObject = Page "HMS Observation History List";
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
                }
                action(DoctorsVisitHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Visit History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Treatment History List";
                }
            }
            group(Therapy)
            {
                Caption = 'Therapy Booking';
                Image = RegisteredDocs;
                action(TheatreList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Therapy Booking List';
                    RunObject = Page "HMS Therapy List";
                    RunPageView = where(Status = filter(<> Closed));
                }
                action(TheatreHistory)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Therapy Booking History';
                    RunObject = Page "HMS Therapy List";
                    RunPageView = where(Status = filter(Closed));
                }
            }
            // group(ICU)
            // {
            //     Caption = 'ICU';
            //     Image = RegisteredDocs;
            //     action(ICUList)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'ICU List';
            //         RunObject = Page "HMS ICU List";
            //     }
            //     action(ICUHistory)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'ICU History';
            //         RunObject = Page "HMS ICU History";
            //     }
            // }
            // group(Physio)
            // {
            //     Caption = 'Physiotherapy';
            //     Image = RegisteredDocs;
            //     action(PhysiotheraphyObservations)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'PhysiotheraphyObservations';
            //         RunObject = Page "HMS Physiotheraphy List";
            //     }
            //     action("CLosed Physiotheraphy List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
            //         //PromotedIsBig = true;
            //         RunObject = Page "HMS CLosed Physiotheraphy List";
            //     }
            // }

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
                }
                action(findings)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Findings';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Laboratory History List";
                }
                action(Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Doctor''s Visit History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Treatment History List";
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
                }
                action(Pharm_Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Pharmacy History List";
                }
                action("39003925")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List-Returns';
                    RunObject = Page "HMS Pharmacy Line-returns";
                }
            }
            // group(HMS_Admissions)
            // {
            //     Caption = 'InPatients';
            //     Image = LotInfo;
            //     action(InPatients)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'InPatients';
            //         RunObject = Page "HMS InPatient List";
            //     }
            //     action(DischargeRequest)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Discharge Request';
            //         Image = History;
            //         Promoted = true;
            //         RunObject = Page "HMS Admission Progress List";
            //     }
            //     action(Discharge)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Discharge List';
            //         Image = ReleaseShipment;
            //         RunObject = Page "HMS Admission Discharge List";
            //     }
            // }
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
                }
                action(Under_5yrs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagnosis Under 5yrs';
                    Image = History;
                    Promoted = true;
                    RunObject = Report "Diagnosis Under 5yrs";
                }
                action("Hospital Diagnosis.")
                {
                    ApplicationArea = Basic, Suite;
                    Image = DataEntry;
                    RunObject = Report "Hospital Diagnosis<5years";
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
                }
                action(ref_Hist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Referrals History';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Referral Header List2";
                }
            }
            // group(Immuns)
            // {
            //     Caption = 'Immunizations';
            //     Image = ReferenceData;
            //     action(Immun)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Immunizations';
            //         Image = Register;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         PromotedIsBig = false;
            //         RunObject = Page "HMS Immunization Header List";
            //     }
            //     action(Immun_History)
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Caption = 'Immunizations History';
            //         Image = History;
            //         Promoted = true;
            //         RunObject = Page "HMS Immunization Posted List";
            //     }
            // }
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
                }
                action("Sales Invoice List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoice List';
                    RunObject = Page "Sales Invoice List.";
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
                }
                action(SalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    Image = Invoice;
                    RunObject = Page "Sales Invoice List.";
                }
                action(SalesReturnOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Order List";
                }
                action(Schemeplan)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scheme Plan';
                    Image = ReturnOrder;
                    RunObject = Page "HMS Scheme Plan List";
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
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                }
                action(PostedReturnReceipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page "Posted Return Receipts";
                }
                action(PostedSalesCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action(PostedPurchaseInvoices)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action(PostedPurchaseCreditMemos)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
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
                }
                action(MyApprovalrequests)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
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
                }
                action(StaffClaim)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff Claim';
                    RunObject = Page "Staff Claim List";
                }
                action(PurchaseRequisition)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Requisition';
                    RunObject = Page "Purchase Requisition";
                }
                action(ImprestSurrender)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Surrender';
                    RunObject = Page "Imprest Accounting";
                }
                action(ImprestRequisitions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Requisitions';
                    RunObject = Page "Imprest Lists";
                }
                action(LeaveApplications)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Leave Applications';
                    RunObject = Page "HR Leave Requisition List";
                }
                action(MyApprovedLeaves)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'My Approved Leaves';
                    Image = History;
                    RunObject = Page "Hr My Approved Leaves List";
                }
                action("Broadcast SMS")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "SMS Broadcast List1";
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action("Request to Approve")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Requests to Approve";
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
                }

                action(ImmunHist)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Immunization History';
                    Image = History;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Immunization Posted";
                }
                action(Setup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Card";
                }
                action(Systems_Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Systems Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Systems List";
                }
                action(Setup_Doctor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Doctor';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Hms Setup Doctors List";
                }
                action(Setup_Blood_Group)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Blood Group';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Blood Group List";
                }
                action(Blood_Group_Donation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Blood Group Donation';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Blood Group Donation List";
                }
                action(Drug_Interaction)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Drug Interaction';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Drug Interaction Header";
                }
                action(Observation_Signs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Observation Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS General Observation Setup";
                }
                action(Appointment_Typ)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointment Type';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Appointment Type Lst";
                }

                action("Setup Process")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Process Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Process List";
                }
                action("Setup Dosage")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dosage Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Dosage Setup";
                }
                action(Injection)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Injection';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Injection List";
                }
                action(Diagnosis)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Diagnosis';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Diagnosis List";
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
                action(Allergy)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Allergy';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Allergy List";
                }
                action(signs)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Signs';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Signs";
                }
                action(Symptoms)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Symptoms';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Syptoms";
                }
                action(messuring_Uni)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Measuring Units';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Measuring Unit List";
                }
                action(specimen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Specimen Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Specimen List";
                }
                action(Lab_test)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Lab Test Setups';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Lab Test List";
                }
                action(Rad_Types)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Radiology Types';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Radiology Type List";
                }
                action(DosageSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dosage Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Dosage Setup";
                }
                action(Theatre_Types)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Procedure List';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS THeatre Type List";
                }
                action(Schemeplans)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scheme Plan List';
                    Image = ReturnOrder;
                    RunObject = Page "HMS Scheme Plan List";
                }

                action(Setup_Disctarge_Process)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup Discharge Process';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Setup Disctarge Process";
                }
                action(wards)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Ward Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Ward List";
                }
                action(Beds)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Beds';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Beds";
                }
                action(Hos_Charges)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hospital Charges Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Charges";
                }
                action(Hos_Drugs_Prof)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Hospital Drugs Profit';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Drugs Profit";
                }
            }

        }
    }

    var
        HMSSetup: Record "HMS Setup";
        Dialysismode: Boolean;
}


