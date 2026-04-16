Page 85404 "HMS Pharmacy Role Centre"
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
        area(sections)
        {
            group(PatientManagement)
            {
                Caption = 'Patient Managment';
                action("Patients List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Register;
                    Promoted = true;
                    RunObject = Page "HMS Patient List2";
                    ToolTip = 'Executes the Patients List action.';
                }
                action("Patients Walkin")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Register;
                    Promoted = true;
                    Visible = false;
                    RunObject = Page "HMS Walkin Patient List";
                    ToolTip = 'Executes the Patients Walkin action.';
                }
                action(InPatientList)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'InPatient List';
                    RunObject = Page "HMS InPatient List";
                    ToolTip = 'Executes the InPatient List action.';
                }
            }
            group(Pharmacy)
            {
                Caption = 'Pharmacy';
                action(Pharm)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List Outpatient';
                    Image = Register;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = false;
                    RunObject = Page "HMS Pharmacy List";
                    RunPageView = where(Status = filter('New'),
                                        Inpatient = filter(false));
                    ToolTip = 'Executes the Pharmacy List Outpatient action.';
                }
                action("Pharmacy List Inpatient")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Pharmacy List Inpatient";
                    ToolTip = 'Executes the Pharmacy List Inpatient action.';
                }
                action("Pharmacy List Discharge")
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "HMS Pharmacy List Discharge";
                    ToolTip = 'Executes the Pharmacy List Discharge action.';
                }
                action(Pharm_Paid)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Paid Pharmacy List';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Pharmacy List Paid";
                    ToolTip = 'Executes the Paid Pharmacy List action.';
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
                action(Pharm_Cancel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancelled Pharmacy List';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HMS Pharmacy Cancelled List";
                    ToolTip = 'Executes the Cancelled Pharmacy List action.';
                }
                action("39003925")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy List-Returns';
                    RunObject = Page "HMS Pharmacy Line-returns";
                    ToolTip = 'Executes the Pharmacy List-Returns action.';
                }
            }
            group(Billing)
            {
                Caption = 'Hospital Billing';
                Image = Intrastat;
                Visible = false;
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
                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Executes the Invoice List action.';
                }
            }
            group("Pharm Store")
            {
                Caption = 'Store Managment';
                Image = Intrastat;
                action(Items)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    Image = Insurance;
                    Promoted = true;
                    RunObject = Page "Item List.";
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
                group(Reports)
                {
                    Caption = 'Stock Reports';
                    action(StockMovementSum)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Stock Movement Summary';
                        RunObject = report "Stock Movement Summary";
                        ToolTip = 'Prints a Summary of Opening, Closing Balance of items';
                    }
                    action(DetStockMovementSum)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Detailed Stock Movement Summary';
                        RunObject = report "Det. Stock Movement Summary";
                        ToolTip = 'Prints a detailed Summary of Opening, Closing Balance of items plus individual entries';
                    }
                    action(DetStockMovementSum2)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Detailed Stock Movement Summary 2';
                        RunObject = report "Stock Movement Detailed";
                        ToolTip = 'Prints a detailed Summary of Opening, Closing Balance of items plus individual entries';
                    }
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
        area(Embedding)
        {
            action("Patients")
            {
                ApplicationArea = Basic, Suite;
                Image = Register;
                Promoted = true;
                RunObject = Page "HMS Patient List2";
                ToolTip = 'Executes the Patients List action.';
            }
            action("Outpatient Pharmacy LIst")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pharmacy List Outpatient';
                Image = Register;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                RunObject = Page "HMS Pharmacy List";
                RunPageView = where(Status = filter(New),
                                        Inpatient = filter(false));
                ToolTip = 'Executes the Pharmacy List Outpatient action.';
            }
            action("Inpatient Pharmacy List")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Pharmacy List Inpatient";
                ToolTip = 'Executes the Pharmacy List Inpatient action.';
            }
            action("Discharge Pharmacy List")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Pharmacy List Discharge";
                ToolTip = 'Executes the Pharmacy List Discharge action.';
            }
        }
        area(Creation)
        {
            action(PurchaseRequest)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Requisition';
                RunObject = Page "Internal Requisitions U";
                RunPageMode = Create;
                ToolTip = 'Executes the Purchase Requisition action.';
            }
            action(InitateTransfer)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Transfer order';
                RunObject = Page "Transfer Orders";
                RunPageMode = Create;
                ToolTip = 'Executes the Transfer order action.';
            }
        }
        area(Reporting)
        {
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
            /* group(OP_Billing)
            {
                action(PharmSales)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pharmacy Sales Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Report "Pharmacy Sales";
                    ToolTip = 'Executes the Pharmacy Sales Report action.';
                }
            }
            action(Op_IpSales)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'OP/IP Prescriptions Report';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "HMS IP/OP Prescription";
                ToolTip = 'Executes the OP/IP Prescriptions Report action.';
            }
            action(PatIns)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Patients Per Insurance Summary';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "HMS Insurance Patients Summary";
                ToolTip = 'Executes the Patients Per Insurance Summary action.';
            }

            action(HMsPharmSales)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Pharmacy Sales Breakdown';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "HMS Pharmacy Sales";
                ToolTip = 'Executes the Pharmacy Sales Breakdown action.';
            }
            action(phPharmSales)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Breakdown Report';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "HMS Pharmacy Issues Report T";
                ToolTip = 'Executes the Pharmacy Issues Report';
            }
            action("Bed List Occupied")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bed List Occupied';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Bed List";
                ToolTip = 'Executes the Bed List Occupied action.';
            }
 */
        }
    }
}

profile "HMS Pharmacy Role Center"
{
    ProfileDescription = 'Pharmacy Role Center';
    Caption = 'New Pharmacy  Role Center';
    RoleCenter = "HMS Pharmacy Role Centre";
}
 

