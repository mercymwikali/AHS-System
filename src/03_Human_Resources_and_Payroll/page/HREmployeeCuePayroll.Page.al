Page 85732 "HR Employee Cue (Payroll)"
{
    PageType = CardPart;
    SourceTable = "Hr Cue";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            cuegroup(AllEmployees)
            {
                Caption = 'All Employees';
                field(ActiveEmployees; Rec."Employee-Normal (PR)")
                {
                    Caption = 'Active Employees';
                    DrillDownPageID = "HR Employee List";
                    ToolTip = 'Specifies the value of the Active Employees field.';
                }
                field(EmployeesMale; Rec."Employee-Male (PR)")
                {
                    Caption = 'Employees - Male';
                    DrillDownPageID = "HR Employee List";
                    ToolTip = 'Specifies the value of the Employees - Male field.';
                }
                field(EmployeesFemale; Rec."Employee-Female (PR)")
                {
                    Caption = 'Employees - Female';
                    DrillDownPageID = "HR Employee List";
                    ToolTip = 'Specifies the value of the Employees - Female field.';
                }
                field(InactiveEmp; Rec."Employee-InNormal (PR)")
                {
                    Caption = 'In-Active Employees';
                    DrillDownPageID = "HR Employee List";
                    ToolTip = 'Specifies the value of the In-Active Employees field.';
                }
            }
        }
    }
}