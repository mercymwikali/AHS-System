Page 52203057 "HR Appointment Checklist"
{
    PageType = List;
    SourceTable = "HR Appointment Checklist";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(StartDate; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(EndDate; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
        }
    }

    actions
    {
    }
}
