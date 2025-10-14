Page 52202581 "Risk  Role Center"
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
            // action("LegalList")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Risk Register';
            //     RunObject = Page "Risk Register List";
            // }
            // action("Risk Category")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Risk Category';
            //     RunObject = Page "Risk Category";
            // }
        }
        area(reporting)
        {
        }
        area(sections)
        {
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
