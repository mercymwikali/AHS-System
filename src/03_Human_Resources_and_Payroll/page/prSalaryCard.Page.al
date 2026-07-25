Page 85793 prSalaryCard
{
    PageType = ListPart;
    SourceTable = "prSalary Card";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000001)
            {
                field(BasicPay; Rec."Basic Pay")
                {
                    ToolTip = 'Specifies the value of the Basic Pay field.';
                }
                field(PaymentMode; Rec."Payment Mode")
                {
                    ToolTip = 'Specifies the value of the Payment Mode field.';
                }
                field(Currency; Rec.Currency)
                {
                    ToolTip = 'Specifies the value of the Currency field.';
                }
                field(PaysNSSF; Rec."Pays NSSF")
                {
                    ToolTip = 'Specifies the value of the Pays NSSF field.';
                }
                field("Pays NSSF Tier 1"; Rec."Pays NSSF Tier 1")
                {
                    ToolTip = 'Specifies the value of the Pays NSSF Tier 1 field.', Comment = '%';
                }
                field("Pays NSSF Tier 2"; Rec."Pays NSSF Tier 2")
                {
                    ToolTip = 'Specifies the value of the Pays NSSF Tier 2 field.', Comment = '%';
                }
                field(PaysNHIF; Rec."Pays NHIF")
                {
                    ToolTip = 'Specifies the value of the Pays NHIF field.';
                }

                field(PaysPAYE; Rec."Pays PAYE")
                {
                    ToolTip = 'Specifies the value of the Pays PAYE field.';
                }
                field("Pays 30% PAYE"; Rec."Pays 30% PAYE")
                {
                    ToolTip = 'Specifies the value of the Pays 35% PAYE field.';
                }
                field(PaysPension; Rec."Pays Pension")
                {
                    ToolTip = 'Specifies the value of the Pays Pension field.';
                }
                field("Gets PAYE Relief"; Rec."Gets PAYE Relief")
                {
                    ToolTip = 'Specifies the value of the Gets PAYE Relief field.';
                }
                field("Pays AHL"; Rec."Pays AHL")
                {
                    ToolTip = 'Specifies the value of the Pays AHL field.', Comment = '%';
                }
                field("Pays SHA"; Rec."Pays SHA")
                {
                    ToolTip = 'Specifies the value of the Pays SHA field.', Comment = '%';
                }
                field(GratuityPerc; Rec."Gratuity Perc.")
                {
                    ToolTip = 'Specifies the value of the Gratuity Perc. field.';
                }
                field(PayslipMessage; Rec."Payslip Message")
                {
                    ToolTip = 'Specifies the value of the Payslip Message field.';
                }
                field(SuspendPay; Rec."Suspend Pay")
                {
                    ToolTip = 'Specifies the value of the Suspend Pay field.';
                }
                field(SuspensionDate; Rec."Suspension Date")
                {
                    ToolTip = 'Specifies the value of the Suspension Date field.';
                }
                field(SuspensionReasons; Rec."Suspension Reasons")
                {
                    ToolTip = 'Specifies the value of the Suspension Reasons field.';
                }
                field(CummBasicPay; Rec."Cumm BasicPay")
                {
                    ToolTip = 'Specifies the value of the Cumm BasicPay field.';
                }
                field(CummGrossPay; Rec."Cumm GrossPay")
                {
                    ToolTip = 'Specifies the value of the Cumm GrossPay field.';
                }
                field(CummNetPay; Rec."Cumm NetPay")
                {
                    ToolTip = 'Specifies the value of the Cumm NetPay field.';
                }
                field(CummAllowances; Rec."Cumm Allowances")
                {
                    ToolTip = 'Specifies the value of the Cumm Allowances field.';
                }
                field(CummDeductions; Rec."Cumm Deductions")
                {
                    ToolTip = 'Specifies the value of the Cumm Deductions field.';
                }
                field(PeriodFilter; Rec."Period Filter")
                {
                    ToolTip = 'Specifies the value of the Period Filter field.';
                }
                field(CummPAYE; Rec."Cumm PAYE")
                {
                    ToolTip = 'Specifies the value of the Cumm PAYE field.';
                }
                field(CummNSSF; Rec."Cumm NSSF")
                {
                    ToolTip = 'Specifies the value of the Cumm NSSF field.';
                }
                field(CummPension; Rec."Cumm Pension")
                {
                    ToolTip = 'Specifies the value of the Cumm Pension field.';
                }
                field(CummHELB; Rec."Cumm HELB")
                {
                    ToolTip = 'Specifies the value of the Cumm HELB field.';
                }
                field(CummNHIF; Rec."Cumm NHIF")
                {
                    ToolTip = 'Specifies the value of the Cumm NHIF field.';
                }
                field(CummEmployerPension; Rec."Cumm Employer Pension")
                {
                    ToolTip = 'Specifies the value of the Cumm Employer Pension field.';
                }
                field(PayrollPeriod; Rec."Payroll Period")
                {
                    ToolTip = 'Specifies the value of the Payroll Period field.';
                }
                field(EmployeeCode; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                }
            }
        }
    }

    actions
    {
    }
}
