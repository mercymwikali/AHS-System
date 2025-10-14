Page 52202815 "Salary Grades"
{
    PageType = Card;
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
                field(Basic_salary; Rec.Basic_salary)
                {
                    Caption = 'Basic Salary';
                    ToolTip = 'Specifies the value of the Basic Salary field.';
                }
                field(SalaryAmount; Rec."Salary Amount")
                {
                    caption = 'Gross Salary';
                    ToolTip = 'Specifies the value of the Gross Salary field.';
                }
                field("House Allowance"; Rec."House Allowance")
                {
                    ToolTip = 'Specifies the value of the House Allowance field.';
                }
                field("Travel Allowance"; Rec."Travel Allowance")
                {
                    ToolTip = 'Specifies the value of the Travel Allowance field.';
                }
                field(Ceiling_salary; Rec.Ceiling_salary)
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
