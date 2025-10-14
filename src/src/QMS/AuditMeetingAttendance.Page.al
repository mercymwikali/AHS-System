page 52202617 "Audit meeting Attendance"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Audit Meetings Attendance";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Attendee; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ToolTip = 'Executes the ActionName action.';

                trigger OnAction()
                begin
                end;
            }
        }
    }
}