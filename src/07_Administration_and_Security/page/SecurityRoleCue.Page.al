Page 85063 "Security Role Cue"
{
    PageType = CardPart;
    SourceTable = "Hr Cue";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            cuegroup(AllVisitors)
            {
                Caption = 'All Visitors';
                field(NewVisitors; Rec."New Visitors")
                {
                    Caption = 'New Visitors';
                    DrillDownPageID = "Sec-Visitor Management (New)";
                    ToolTip = 'Specifies the value of the New Visitors field.';
                }
                field(ClearedVisitors; Rec."Cleared Visitors")
                {
                    Caption = 'Cleared Visitors';
                    DrillDownPageID = "Sec-Visitor Manager (Cleared)";
                    ToolTip = 'Specifies the value of the Cleared Visitors field.';
                }
            }
        }
    }
}