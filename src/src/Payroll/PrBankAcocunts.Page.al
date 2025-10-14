namespace PTL.HMISBC;

page 52203231 "Pr Bank Acocunts"
{
    ApplicationArea = All;
    Caption = 'Pr Bank Acocunts';
    PageType = List;
    SourceTable = "PR Bank Accounts";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.', Comment = '%';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.', Comment = '%';
                }
                field("Bank Type"; Rec."Bank Type")
                {
                    ToolTip = 'Specifies the value of the Bank Type field.', Comment = '%';
                }
            }
        }
    }
}
