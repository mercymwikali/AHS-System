namespace PTL.HMISBC;

page 85039 "HR Leave Non Working Days"
{
    ApplicationArea = All;
    Caption = 'HR Leave Non Working Days';
    PageType = List;
    SourceTable = "HR Leave Non Working Days";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(Reason; Rec.Reason)
                {
                    ToolTip = 'Specifies the value of the Reason field.', Comment = '%';
                }
                field(Recurring; Rec.Recurring)
                {
                    ToolTip = 'Specifies the value of the Recurring field.', Comment = '%';
                }
                field("Calender Code"; Rec."Calender Code")
                {
                    ToolTip = 'Specifies the value of the Calender Code field.', Comment = '%';
                }
            }
        }
    }
}
