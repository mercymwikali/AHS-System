Page 52202651 "Corporate  Role Center"
{
    Caption = 'Corporate  Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control10)
            {
                part(Control8; "Risk Card")
                {
                    Caption = 'Corporate Affairs Summary';
                }
            }
            group(Control18)
            {
                systempart(Control17; Outlook)
                {
                }
            }
            group(Control16)
            {
                part(Control15; "My Job Queue")
                {
                    Visible = false;
                }
                part(Control14; "Copy Profile")
                {
                    Visible = false;
                }
                systempart(Control13; MyNotes)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Setup)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Setup';
                Image = setup;
                RunObject = Page "Legal Setups";
                ToolTip = 'Executes the Setup action.';
            }
        }
        area(reporting)
        {
        }
        area(sections)
        {
            group("Corporate Affairs Management")
            {
                Caption = 'Corporate Affairs Management';
                Image = LotInfo;
                action("<Institute Booking Form>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Intergration Institute Booking Request';
                    Image = History;
                    RunObject = Page "Corporate List";
                    ToolTip = 'Executes the Intergration Institute Booking Request action.';
                }
                action("<Institute Booking C1L>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Intergration Institute Bookings Approved';
                    Image = History;
                    RunObject = Page "Corporate list (Approved)";
                    ToolTip = 'Executes the Intergration Institute Bookings Approved action.';
                }
                action("Compliments/Complaints List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Compliments/Complaints List';
                    RunObject = Page "Compliments/Complaints List";
                    ToolTip = 'Executes the Compliments/Complaints List action.';
                }
                action("Pending Complaints")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending Complaints ';
                    Image = History;
                    RunObject = Page "Pending Complaints";
                    ToolTip = 'Executes the Pending Complaints  action.';
                }
                action("Resolved Complaints/Compliment")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Resolved Complaints/Compliment';
                    Image = History;
                    RunObject = Page "Resolved Complaints/Compliment";
                    ToolTip = 'Executes the Resolved Complaints/Compliment action.';
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
            group(hist)
            {
                Caption = 'History';
                Image = History;
                action("<Page Legal cleared>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Legal Requests Cleared';
                    RunObject = Page "Legal Posted (Posted)";
                    ToolTip = 'Executes the Legal Requests Cleared action.';
                }
                action("<Page Litigation Cleared>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Litigation Cleared';
                    Image = Invoice;
                    Promoted = true;
                    RunObject = Page "Litigation List (Cleared)";
                    ToolTip = 'Executes the Litigation Cleared action.';
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
    }
}
