namespace PTL.HMISBC;

page 52203233 "Portal Roles"
{
    ApplicationArea = All;
    Caption = 'Portal Roles';
    PageType = List;
    SourceTable = "Portal Roles";
    UsageCategory = Lists;
    CardPageId = "Portal Role Card";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Role ID"; Rec."Role ID")
                {
                    ToolTip = 'Specifies the value of the Role ID field.', Comment = '%';
                }
                field(isAdmin; Rec.isAdmin)
                {
                    ToolTip = 'Specifies the value of the isAdmin field.', Comment = '%';
                }
            }
        }
    }
}
