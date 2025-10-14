Page 52202469 "Salary Increament Register"
{
    Editable = false;
    PageType = List;
    SourceTable = "Salary Increament Register";
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
                field(names; names)
                {
                    Caption = 'Employee Name';
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(IncreamentMonth; Rec."Increament Month")
                {
                    ToolTip = 'Specifies the value of the Increament Month field.';
                }
                field(IncreamentYear; Rec."Increament Year")
                {
                    ToolTip = 'Specifies the value of the Increament Year field.';
                }
                field(UserID; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(PrevSalary; Rec."Prev. Salary")
                {
                    ToolTip = 'Specifies the value of the Prev. Salary field.';
                }
                field(CurrentSalary; Rec."Current Salary")
                {
                    ToolTip = 'Specifies the value of the Current Salary field.';
                }
                field(JobGrade; Rec."Job Grade")
                {
                    ToolTip = 'Specifies the value of the Job Grade field.';
                }
                field(JobCategory; Rec."Job Category")
                {
                    ToolTip = 'Specifies the value of the Job Category field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field(Reversed; Rec.Reversed)
                {
                    ToolTip = 'Specifies the value of the Reversed field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord()
    begin
        Clear(names);
        if emps.Get(Rec."Employee No.") then
            names := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
    end;

    var
        emps: Record "HR-Employee";
        names: Text[250];
}
