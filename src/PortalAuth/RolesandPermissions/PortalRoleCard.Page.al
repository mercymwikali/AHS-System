namespace PTL.HMISBC;

page 52203234 "Portal Role Card"
{
    ApplicationArea = All;
    Caption = 'Portal Role Card';
    PageType = Card;
    SourceTable = "Portal Roles";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Role ID"; Rec."Role ID")
                {
                    ToolTip = 'Specifies the value of the Role ID field.', Comment = '%';
                }
                field(isAdmin; Rec.isAdmin)
                {
                    ToolTip = 'Specifies the value of the isAdmin field.', Comment = '%';
                }
            }
            group(Permission)
            {
                part(Permissions; "Portal Permissions List")
                {
                    SubPageLink = "Role ID" = field("Role ID");
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CopyPermission)
            {
                ApplicationArea = All;
                Caption = 'Copy Permissions';
                RunObject = report "Copy Role Permissions";
                ToolTip = 'Executes the Copy Permissions action.';
            }
        }
    }
}
