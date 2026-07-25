Page 85771 "prEmployee Posting Group"
{
    PageType = List;
    SourceTable = "prEmployee Posting Group";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(SalaryAccount; Rec."Salary Account")
                {
                    ToolTip = 'Specifies the value of the Salary Account field.';
                }
                field(IncomeTaxAccount; Rec."Income Tax Account")
                {
                    ToolTip = 'Specifies the value of the Income Tax Account field.';
                }
                field(NSSFEmployerAccount; Rec."NSSF Employer Account")
                {
                    ToolTip = 'Specifies the value of the NSSF Employer Account field.';
                }
                field(NSSFEmployeeAccount; Rec."NSSF Employee Account")
                {
                    ToolTip = 'Specifies the value of the NSSF Employee Account field.';
                }
                field(NSSFPayableAcc; Rec."NSSF Payable Acc")
                {
                    ToolTip = 'Specifies the value of the NSSF Payable Acc field.';
                }
                field(NetSalaryPayable; Rec."Net Salary Payable")
                {
                    ToolTip = 'Specifies the value of the Net Salary Payable field.';
                }
                field(OperatingOvertime; Rec."Operating Overtime")
                {
                    ToolTip = 'Specifies the value of the Operating Overtime field.';
                }
                field(EmployeeProvidentFundAcc; Rec."Employee Provident Fund Acc.")
                {
                    ToolTip = 'Specifies the value of the Employee Provident Fund Acc. field.';
                }
                field(PensionEmployerAcc; Rec."Pension Employer Acc")
                {
                    ToolTip = 'Specifies the value of the Pension Employer Acc field.';
                }
                field(PensionEmployeeAcc; Rec."Pension Employee Acc")
                {
                    ToolTip = 'Specifies the value of the Pension Employee Acc field.';
                }
                field(PensionPayableAcc; Rec."Pension Payable Acc")
                {
                    ToolTip = 'Specifies the value of the Pension Payable Acc field.';
                }
                field(PayrollCode; Rec."Payroll Code")
                {
                    ToolTip = 'Specifies the value of the Payroll Code field.';
                }
                field(NHIFEmployeeAccount; Rec."SHIF Employee Account")
                {
                    ToolTip = 'Specifies the value of the NHIF Employee Account field.';
                }
                field(StaffGratuityDebit; Rec.StaffGratuityDebit)
                {
                    ToolTip = 'Specifies the value of the StaffGratuityDebit field.';
                }
                field(StaffGratuityCredit; Rec.StaffGratuityCredit)
                {
                    ToolTip = 'Specifies the value of the StaffGratuityCredit field.';
                }
                field("Housing Levy Employee Account"; Rec."Housing Levy Employee Account")
                {
                    ToolTip = 'Specifies the value of the Housing Levy Employee Account field.';
                }
                field("Housing Levy Employer Account"; Rec."Housing Levy Employer Account")
                {
                    ToolTip = 'Specifies the value of the Housing Levy Employer Account field.';
                }
            }
        }
    }

    actions
    {
    }
}
