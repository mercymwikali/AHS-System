namespace PTL.HMIS;

page 52203202 "Insurance Schemes Setup"
{
    ApplicationArea = All;
    Caption = 'Insurance Schemes Setup';
    PageType = List;
    SourceTable = "Insurance Scheme Setup";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Insurance Code"; Rec."Insurance Code")
                {
                    ToolTip = 'Specifies the value of the Insurance Code field.', Comment = '%';
                }
                field("Scheme Name"; Rec."Scheme Name")
                {
                    ToolTip = 'Specifies the value of the Scheme Name field.', Comment = '%';
                }
            }
        }
    }
}
