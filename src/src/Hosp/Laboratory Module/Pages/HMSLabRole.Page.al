Page 52203101 "HMS Lab Role"
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
                part(Control2; "Power BI Report Spinner Part")
                {
                    ApplicationArea = RelationshipMgmt;
                }
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
            action(RegistrationList)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Registration';
                RunObject = Page "HMS Patient List";
                ToolTip = 'Executes the Registration action.';
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
            action("Discharge List")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "Admission Discharge List";
                ToolTip = 'Executes the Discharge List action.';
            }
        }
        area(processing)
        {
            group(Reports)
            {
                Caption = 'HMS Reports';
                Image = SNInfo;
                action(labtest11)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Lab Revenue Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "Laboratory Revenue Report";
                    ToolTip = 'Executes the Lab Revenue Report action.';
                }
                action(labtest16)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Lab Diagnosis Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "HMS Lab Diagnosis Report";
                    ToolTip = 'Executes the Lab Diagnosis Report action.';
                }
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
            group(Setups)
            {
                Caption = 'Hospital Setups';
                Image = SNInfo;

                action(Systems_Card)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Systems Card';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Systems List";
                    Visible = false;
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
                action(Blood_Group_Donation)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Blood Group Donation';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Blood Group Donation List";
                    visible = false;
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
                    Visible = false; // REFACTOR: Replace this with list page
                    ToolTip = 'Executes the Drug Interaction action.';
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
                    Caption = 'Drugs Profit Setup';
                    Image = SetupList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "HMS Drugs Profit";
                    Visible = false; //REFACTOR: What is this
                    ToolTip = 'Executes the Drugs Profit Setup action.';
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
                    RunObject = Page "HMS Patient List";
                    ToolTip = 'Executes the Patients List action.';
                }
                action(walkin)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Walk-in';
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Walkin Patient List";
                    ToolTip = 'Executes the Walk-in action.';
                }
                action(TreatmentSheet)
                {
                    Caption = 'Doctors Consultations';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Treatment List";
                    ToolTip = 'Executes the TreatmentSheet action.';
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
                    RunObject = Page "HMS Appointment Form List";
                    ToolTip = 'Executes the Appointments action.';
                }
                action(AppointmentsControl)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Appointments Control';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Appointment Lists";
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
                    RunObject = Page "Hms Lab List";
                    RunPageView = where(Status = filter(New));
                    ToolTip = 'Executes the Test Requests action.';
                }
                action("Test Requests History")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Requests History';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "HMS Laboratory History List";
                    RunPageView = where(Status = filter(Completed));
                    ToolTip = 'Executes the Test Requests History action.';
                }
                group(LabSetups)
                {
                    Caption = 'Lab Setups';
                    action(LabPackage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lab Package setup';
                        RunObject = Page "HMS Setup Lab Package List";
                        ToolTip = 'Executes the Lab Package action.';
                    }
                    action(LabPackTest)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lab Package Test setup';
                        RunObject = Page "HMS Setup Lab Pack Test SF";
                        ToolTip = 'Executes the Lab Pack Test action.';
                    }
                    action(LabTest)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lab Test Setup';
                        RunObject = Page "HMS Setup Lab Test List";
                        ToolTip = 'Executes the Lab Test action.';
                    }
                    action(LabSpecimen)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Lab Analyte';
                        RunObject = Page "HMS Setup Specimen List";
                        ToolTip = 'Executes the Lab Analyte action.';
                    }
                    action("Lab Parameters")
                    {
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "HMS Lab Parameters Setup List";
                        ToolTip = 'Executes the Lab Parameters action.';
                    }
                }
            }
            group("Lab Store")
            {
                Caption = 'Store Managment';
                Image = Intrastat;
                action(Items)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    Image = Insurance;
                    // Promoted = true;
                    RunObject = Page "Item List.";
                    // RunPageLink = "Gen. Prod. Posting Group" = filter('Lab');
                    RunPageView = where("Gen. Prod. Posting Group" = filter('Lab'));
                    ToolTip = 'Executes the Items action.';
                }
                action(transferOrder)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Transfer order';
                    RunObject = Page "Transfer Orders";
                    ToolTip = 'Executes the Transfer order action.';
                }

                action(StockTake)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Stock Take';
                    RunObject = Page "Phys. Inventory Journal";
                    ToolTip = 'Executes the Stock Take action.';
                }
            }
            group(Procurement)
            {

                action(PurchaseQoute)
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Quote';
                    Image = Vendor;
                    RunObject = Page "Purchase Quotes.";
                    ToolTip = 'Executes the Purchase Quote action.';
                }
                action(PurchaseOrder)
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Order';
                    Image = Vendor;
                    RunObject = Page "Purchase Order List.";
                    ToolTip = 'Executes the Purchase Order action.';
                }
                action(PurchaseOrdersPartDeliv)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Partially Delivered';
                    RunObject = Page "Purchase Order List";
                    RunPageView = where(Status = filter(Released),
                                    Receive = filter(true),
                                    "Completely Received" = filter(false));
                    ToolTip = 'View the list of purchases that are partially received.';
                }
                action(PurchaseCreditmemo)
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Credit memos';
                    Image = Vendor;
                    RunObject = Page "Purchase Credit Memos.";
                    ToolTip = 'Executes the Purchase Credit memos action.';
                }
                action(PurchaseInv)
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Invoice';
                    Image = Vendor;
                    RunObject = Page "Purchase Invoices.";
                    ToolTip = 'Executes the Purchase Invoice action.';
                }
                action(PurchaseRec)
                {
                    ApplicationArea = all;
                    Caption = 'Purchase Receipts';
                    Image = Vendor;
                    RunObject = Page "Posted Purchase Receipts.";
                    ToolTip = 'Executes the Purchase Receipts action.';
                }

            }
            group(PostedDocuments)
            {
                Caption = 'Posted Documents';

                action("Posted Purchase Invoices")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Executes the Posted Purchase Invoices action.';
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
                    RunObject = Page "Imprest List UP";
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
            }
        }
    }
}
