namespace PTL.HMISBC;

page 52203229 "Portal Sessions"
{
    ApplicationArea = All;
    Caption = 'Portal Sessions';
    PageType = List;
    SourceTable = "Portal Sessions";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Session ID"; Rec."Session ID")
                {
                    ToolTip = 'Specifies the value of the Session ID field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date field.', Comment = '%';
                }
                field("Expiry Date"; Rec.ExpiresAt)
                {
                    ToolTip = 'Specifies the value of the Expiry Date field.', Comment = '%';
                }
                field("Near Expiry"; Rec."Near Expiry")
                {
                    ToolTip = 'Specifies the value of the Near Expiry field.', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(IMportPatiens)
            {
                ApplicationArea = All;
                RunObject = xmlport HMSPatients;
                ToolTip = 'Executes the IMportPatiens action.';
            }
        }
    }
}
