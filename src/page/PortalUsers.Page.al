namespace PTL.HMISBC;

page 85046 "Portal Users"
{
    ApplicationArea = All;
    Caption = 'Portal Users';
    PageType = List;
    SourceTable = "Portal User";
    CardPageId = "Portal User Card";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field.', Comment = '%';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.', Comment = '%';
                }

                field("Global Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
                }

                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the value of the Password field.', Comment = '%';
                    Editable = false;
                    Visible = false;
                }
                field(Role; Rec.Role)
                {
                    ToolTip = 'Specifies the value of the Role field.', Comment = '%';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.', Comment = '%';
                }
                field("Portal OTP Code"; Rec."Portal OTP Code")
                {
                    ToolTip = 'Specifies the value of the Portal OTP Code field.', Comment = '%';
                    Editable = false;
                }
                field("Portal OTP Date"; Rec."Portal OTP Date")
                {
                    ToolTip = 'Specifies the value of the Portal OTP Date field.', Comment = '%';
                    Editable = false;
                }
                field("Portal OTP Device"; Rec."Portal OTP Device")
                {
                    ToolTip = 'Specifies the value of the Portal OTP Device field.', Comment = '%';
                    Editable = false;
                }
                field("Portal Reset Token"; Rec."Portal Reset Token")
                {
                    ToolTip = 'Specifies the value of the Portal Reset Token field.', Comment = '%';
                    Editable = false;
                }
                field("Portal Reset Token Expired"; Rec."Portal Reset Token Expired")
                {
                    ToolTip = 'Specifies the value of the Portal Reset Token Expired field.', Comment = '%';
                    Editable = false;
                }
                field("OTP Code Used Today"; Rec."OTP Code Used Today")
                {
                    ToolTip = 'Specifies the value of the OTP Code Used Today field.', Comment = '%';
                    Editable = false;
                }
                field("Portal Session ID"; Rec."Portal Session ID")
                {
                    ToolTip = 'Specifies the value of the Portal Session ID field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(testDate)
            {
                ApplicationArea = All;
                RunObject = page "PC Company Information";
            }
        }
    }
}
