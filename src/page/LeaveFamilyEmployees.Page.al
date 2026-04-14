Page 85710 "Leave Family Employees"
{
    PageType = ListPart;
    SourceTable = "Leave Family Employees";
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
                }
                field(Names; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
                {
                    Caption = 'Names';
                    ToolTip = 'Specifies the value of the Names field.';
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
        Employee: Record "HR-Employee";
}
