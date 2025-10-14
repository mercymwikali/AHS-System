namespace PTL.HMISBC;

page 52203235 "Portal Permissions List"
{
    ApplicationArea = All;
    Caption = 'Portal Permissions List';
    PageType = ListPart;
    SourceTable = "Portal Role Permissions";

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
                field("Permission Action"; Rec."Permission Action")
                {
                    ToolTip = 'Specifies the value of the Action field.', Comment = '%';
                }
                
                field("Permission ID"; Rec."Permission Subject")
                {
                    ToolTip = 'Specifies the value of the Permission ID field.', Comment = '%';
                }
                field(ownDoctor; Rec."ownDoctor")
                {
                    ToolTip = 'Specifies if the permission is for own doctor.', Comment = '%';
                }
            }
        }
    }
}
