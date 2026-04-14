namespace PTL.HMISBC;

page 85045 "Portal User Card"
{
    ApplicationArea = All;
    Caption = 'Portal User Card';
    PageType = Card;
    SourceTable = "Portal User";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field.', Comment = '%';
                }
                field(Role; Rec.Role)
                {
                    ToolTip = 'Specifies the value of the Role field.', Comment = '%';
                }
                field("Doctor ID"; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.', Comment = '%';
                }
                field("Staff E-mail"; Rec."Staff E-mail")
                {
                    ToolTip = 'Specifies the value of the Staff E-mail field.', Comment = '%';
                }
                field("Staff Phone No."; Rec."Staff Phone No.")
                {
                    ToolTip = 'Specifies the value of the Staff Phone No. field.', Comment = '%';
                }
            }
            // group(Roles)
            // {
            //     part(portalRoles; "Portal User Roles")
            //     {
            //         SubPageLink = "User Id" = field("User ID");
            //     }
            // }
        }
    }
}
