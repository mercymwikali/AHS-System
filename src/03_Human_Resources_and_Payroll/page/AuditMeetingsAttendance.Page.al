Page 85077 "Audit Meetings Attendance"
{
    PageType = List;
    SourceTable = "Audit Meetings Attendance";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(MeetingCode; Rec."Meeting Code")
                {
                    ToolTip = 'Specifies the value of the Meeting Code field.';
                }
                field(Attendee; Rec.Attendee)
                {
                    ToolTip = 'Specifies the value of the Attendee field.';
                }
                field(DateCreated; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(CreatedBy; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
            }
        }
    }

    actions
    {
    }
}
