Page 85792 prSalaryArrears
{
    Editable = false;
    PageType = List;
    SourceTable = "prSalary Arrears";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field(EmployeeCode; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field(TransactionCode; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
                field(StartDate; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(EndDate; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(SalaryArrears; Rec."Salary Arrears")
                {
                    ToolTip = 'Specifies the value of the Salary Arrears field.';
                }
                field(PAYEArrears; Rec."PAYE Arrears")
                {
                    ToolTip = 'Specifies the value of the PAYE Arrears field.';
                }
                field(PeriodMonth; Rec."Period Month")
                {
                    ToolTip = 'Specifies the value of the Period Month field.';
                }
                field(PeriodYear; Rec."Period Year")
                {
                    ToolTip = 'Specifies the value of the Period Year field.';
                }
                field(CurrentBasic; Rec."Current Basic")
                {
                    ToolTip = 'Specifies the value of the Current Basic field.';
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
            }
        }
    }

    actions
    {
    }
}
