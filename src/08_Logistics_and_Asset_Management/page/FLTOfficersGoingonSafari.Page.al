Page 85143 "FLT Officers Going on Safari"
{
    PageType = List;
    SourceTable = "FLT-Safari Accompanying Off.";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EmployeeNo; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.';
                }
                field(EmpPinNo; Rec."Emp. Pin No.")
                {
                    ToolTip = 'Specifies the value of the Emp. Pin No. field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
            }
        }
    }

    actions
    {
    }
}
