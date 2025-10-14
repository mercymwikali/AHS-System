report 52202483 "Employer Deductions Report"
{
    ApplicationArea = All;
    UsageCategory = Administration;

    dataset
    {
        dataitem(DataItemName; "prEmployer Deductions")
        {
            RequestFilterFields = "Payroll Period", "Transaction Code";

            column(Transaction_Code; "Transaction Code")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Employee_Code; "Employee Code")
            {
            }
            column(Payroll_Period; "Payroll Period")
            {
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    //field(Name; SourceExpression)
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Executes the ActionName action.';
                }
            }
        }
    }
}