query 52202436 "Period Transactions"
{
    Caption = 'Period Transactions';
    QueryType = Normal;

    elements
    {
        dataitem(prPeriodTransactions; "prPeriod Transactions")
        {
            column(PeriodMonth; "Period Month")
            {
            }
            column(EmployeeCode; "Employee Code")
            {
            }
            column(DepartmentCode; "Department Code")
            {
            }
            dataitem(prPayrollPeriods; "prPayroll Periods")
            {
                DataItemLink = "Period Month" = prPeriodTransactions."Period Month", "Period Year" = prPeriodTransactions."Period Year";
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
                column(PeriodName; "Period Name")
                {
                }
                column(PeriodYear; "Period Year")
                {
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}
