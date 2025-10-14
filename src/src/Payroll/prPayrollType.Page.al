Page 52202814 "prPayroll Type"
{
    PageType = List;
    SourceTable = "prPayroll Type";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field(PayrollCode; Rec."Payroll Code")
                {
                    ToolTip = 'Specifies the value of the Payroll Code field.';
                }
                field(PayrollName; Rec."Payroll Name")
                {
                    ToolTip = 'Specifies the value of the Payroll Name field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(PeriodLength; Rec."Period Length")
                {
                    ToolTip = 'Specifies the value of the Period Length field.';
                }
            }
        }
    }

    actions
    {
    }
}
