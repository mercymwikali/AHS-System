page 85804 "Audit Meetings Card"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "Audit Meetings";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Audit Code"; Rec."Audit Code")
                {
                    ToolTip = 'Specifies the value of the Audit Code field.';
                }
                field("Audit No."; Rec."Audit No.")
                {
                    ToolTip = 'Specifies the value of the Audit No. field.';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field("Audit Programme"; Rec."Audit Programme")
                {
                    ToolTip = 'Specifies the value of the Audit Programme field.';
                }
            }
            group(Agenda)
            {
                part(MeetingAgends; "Audit Meeting Agenda")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Meeting Code" = field(Code);
                }
            }
            group(Attendance)
            {
                part(Attendee; "Audit meeting Attendance")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Meeting Code" = field(Code);
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