Page 85797 "Salary Grades List"
{
    Editable = true;
    PageType = List;
    SourceTable = "Salary Grades";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field(SalaryGrade; Rec."Salary Grade")
                {
                    ToolTip = 'Specifies the value of the Salary Grade field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(SalaryAmount; Rec."Salary Amount")
                {
                    Caption = 'Gross Amount';
                    ToolTip = 'Specifies the value of the Gross Amount field.';
                }
                field(Basicsalary; Rec.Basic_salary)
                {
                    ToolTip = 'Specifies the value of the Basic_salary field.';
                }
                field(HouseAllowance; Rec."House Allowance")
                {
                    ToolTip = 'Specifies the value of the House Allowance field.';
                }
                field(LeaveAllowance; Rec."Leave Allowance")
                {
                    ToolTip = 'Specifies the value of the Leave Allowance field.';
                }
                field("Travel Allowance"; Rec."Travel Allowance")
                {
                    ToolTip = 'Specifies the value of the Travel Allowance field.';
                }
                field(Ceilingsalary; Rec.Ceiling_salary)
                {
                    ToolTip = 'Specifies the value of the Ceiling_salary field.';
                }
            }
        }
    }

    actions
    {
    }
}
