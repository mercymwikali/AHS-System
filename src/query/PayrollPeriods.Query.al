query 85002 "Payroll Periods"
{
    Caption = 'Payroll Periods';
    QueryType = Normal;

    elements
    {
        dataitem(prPayrollPeriods; "prPayroll Periods")
        {
            column(Closed; Closed)
            {
            }
            column(DateClosed; "Date Closed")
            {
            }
            column(AllowViewofOnlinePayslips; "Allow View of Online Payslips")
            {
            }
            column(DateOpened; "Date Opened")
            {
            }
            column(PayrollCode; "Payroll Code")
            {
            }
            column(PeriodMonth; "Period Month")
            {
            }
            column(PeriodName; "Period Name")
            {
            }
            column(PeriodYear; "Period Year")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}
