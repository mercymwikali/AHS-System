Page 85617 Grades
{
    PageType = Worksheet;
    SourceTable = Grades;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Grade; Rec.Grade)
                {
                    ToolTip = 'Specifies the value of the Grade field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(AnnualLeaveDays; Rec."Annual Leave Days")
                {
                    ToolTip = 'Specifies the value of the Annual Leave Days field.';
                }
            }
        }
    }

    actions
    {
    }
}
