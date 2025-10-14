Page 52203076 "Activity Employess"
{
    PageType = Worksheet;
    SourceTable = "Activity Employees";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(EmployeeNo; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';

                    trigger OnValidate()
                    begin
                        Emp.Reset();
                        Emp.SetRange(Emp."No.", Rec."Employee No");
                        if Emp.Find('-') then
                            Rec."Full Names" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    end;
                }
                field(FullNames; Rec."Full Names")
                {
                    ToolTip = 'Specifies the value of the Full Names field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {
    }

    var
        Emp: Record "HR-Employee";
}
