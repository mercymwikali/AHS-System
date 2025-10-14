Page 52202825 prPCAMassLines
{
    PageType = ListPart;
    SourceTable = prMassPCALines;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EmployeeCode; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field(TransactionCode; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(PeriodMonth; Rec."Period Month")
                {
                    ToolTip = 'Specifies the value of the Period Month field.';
                }
                field(PeriodYear; Rec."Period Year")
                {
                    ToolTip = 'Specifies the value of the Period Year field.';
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field(Membership; Rec.Membership)
                {
                    ToolTip = 'Specifies the value of the Membership field.';
                }
                field(ReferenceNo; Rec."Reference No")
                {
                    ToolTip = 'Specifies the value of the Reference No field.';
                }
                field("Salary Grade"; objemp."Salary Grade")
                {
                    ToolTip = 'Specifies the value of the Salary Grade field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(AutoFill)
            {
                Caption = 'AutoFill';
                ToolTip = 'Executes the AutoFill action.';
            }
        }
    }

    var
        objemp: Record "HR-Employee";
}
