Page 52202527 "Legal  Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control10)
            {
                part(Control8; "Legal  Role Cue")
                {
                    Caption = 'Legal & Litigation Summary';
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
            group("Legal Management")
            {
                Caption = 'Legal Management';
                Image = LotInfo;
                action("<Page  NewLegal Requests>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Legal Requests List';
                    RunObject = Page "Legal List (New)";
                    ToolTip = 'Executes the Legal Requests List action.';
                }
                action("<Page Legal Requests Approved>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Legal Request Approved';
                    RunObject = Page "Legal Approved (Approved)";
                    ToolTip = 'Executes the Legal Request Approved action.';
                }
                action("<Page Legal Request Posted>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Legal Request under Litigation';
                    RunObject = Page "Legal Posted (Posted)";
                    ToolTip = 'Executes the Legal Request under Litigation action.';
                }
            }
            group("Litigation Management")
            {
                Caption = 'Litigation Management';
                Image = RegisteredDocs;
                action("<Page litigation list>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'New Litigation Requests';
                    Image = History;
                    RunObject = Page "Litigation List";
                    ToolTip = 'Executes the New Litigation Requests action.';
                }
                action("<Page litigation Pending>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Litigation Requests Pending';
                    Image = History;
                    RunObject = Page "Litigation List";
                    RunPageView = where("Litigation Cleared" = filter(false));
                    ToolTip = 'Executes the Litigation Requests Pending action.';
                }
                action("Page litigation cleared")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Litigation Cleared';
                    Image = History;
                    RunObject = Page "Litigation List (Cleared)";
                    ToolTip = 'Executes the Litigation Cleared action.';
                }
                action("Send Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send Request';
                    Visible = false;
                    ToolTip = 'Executes the Send Request action.';
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
                action("<Institute Booking CL>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Intergration Institute Bookings Approved';
                    Image = History;
                    RunObject = Page "Corporate list (Approved)";
                    ToolTip = 'Executes the Intergration Institute Bookings Approved action.';
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
                action("<Institute Booking Form>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Intergration Institute Booking Request';
                    Image = History;
                    RunObject = Page "Corporate List";
                    ToolTip = 'Executes the Intergration Institute Booking Request action.';
                }
            }
        }
    }
}
