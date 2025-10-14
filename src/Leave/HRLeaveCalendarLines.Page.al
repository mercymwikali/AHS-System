namespace PTL.HRMIS;

Page 52203240 "HR Leave Calendar Lines"
{
    ApplicationArea = Basic;
    PageType = ListPart;
    SourceTable = "HR Leave Calendar Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = true;
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Day; Rec.Day)
                {
                    ToolTip = 'Specifies the value of the Day field.';
                }
                field(NonWorking; Rec."Non Working")
                {
                    ToolTip = 'Specifies the value of the Non Working field.';
                }
                field(Reason; Rec.Reason)
                {
                    ToolTip = 'Specifies the value of the Reason field.';
                }
            }
        }
    }

    actions
    {
    }
}
