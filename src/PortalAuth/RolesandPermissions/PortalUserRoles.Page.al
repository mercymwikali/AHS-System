namespace PTL.HMISBC;

page 52203236 "Portal User Roles"
{
    ApplicationArea = All;
    Caption = 'Portal User Roles';
    PageType = ListPart;
    SourceTable = "Portal User Roles";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the User Id field.', Comment = '%';
                }
                field("Role ID"; Rec."Role ID")
                {
                    ToolTip = 'Specifies the value of the Role ID field.', Comment = '%';
                }
            }
        }
    }
}
