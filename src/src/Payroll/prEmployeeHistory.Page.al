Page 52202804 "prEmployee History"
{
    PageType = List;
    SourceTable = "prEmployee P9 Info";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(EmployeeCode; Rec."Employee Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
                field(BasicPay; Rec."Basic Pay")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Basic Pay field.';
                }
                field(GrossPay; Rec."Gross Pay")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Gross Pay field.';
                }
                field(NetPay; Rec."Net Pay")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Net Pay field.';
                }
                field(Allowances; Rec.Allowances)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Allowances field.';
                }
                field(Deductions; Rec.Deductions)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Deductions field.';
                }
                field(PAYE; Rec.PAYE)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the PAYE field.';
                }
                field(NSSF; Rec.NSSF)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the NSSF field.';
                }
                field(NHIF; Rec.NHIF)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the NHIF field.';
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
            }
        }
    }

    actions
    {
    }
}
