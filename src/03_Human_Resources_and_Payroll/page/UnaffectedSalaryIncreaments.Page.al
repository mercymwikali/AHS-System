Page 85741 "Un-affected Salary Increaments"
{
    Editable = false;
    PageType = List;
    SourceTable = "Un-affected Salary Increaments";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(IncreamentMonth; Rec."Increament Month")
                {
                    ToolTip = 'Specifies the value of the Increament Month field.';
                }
                field(IncreamentYear; Rec."Increament Year")
                {
                    ToolTip = 'Specifies the value of the Increament Year field.';
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(EmployeeCategory; Rec."Employee Category")
                {
                    ToolTip = 'Specifies the value of the Employee Category field.';
                }
                field(EmployeeGrade; Rec."Employee Grade")
                {
                    ToolTip = 'Specifies the value of the Employee Grade field.';
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
