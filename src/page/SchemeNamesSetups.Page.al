namespace PTL.HMIS;

page 85172 "Scheme Names Setups"
{
    ApplicationArea = All;
    Caption = 'Scheme Names Setups';
    PageType = List;
    SourceTable = "Scheme Names Setup";
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Scheme Name"; Rec."Scheme Name")
                {
                    ToolTip = 'Specifies the value of the Scheme Name field.', Comment = '%';
                }
            }
        }
    }
}
