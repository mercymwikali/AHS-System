Report 52202595 prVariance
{
    ApplicationArea = All;
    UsageCategory = Administration;

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            RequestFilterFields = "Employee Code", "Posting Group", "Transaction Code", "Payroll Period", "Prev. Payroll Period Filter";
            column(Employee_Code; "Employee Code")
            {
            }
            column(Transaction_Code; "Transaction Code")
            {
            }
            column(Transaction_Name; "Transaction Name")
            {
            }
            column(Payroll_Period; "Payroll Period")
            {
            }
            column(Prev__Payroll_Period_Filter; "prPeriod Transactions".getfilter("Prev. Payroll Period Filter"))
            {
            }
            column(CompInfLogo; CompInf.Picture)
            {
            }
            column(CompInfName; CompInf.Name)
            {
            }
            column(Amount; Amount)
            {
            }
            column(PrevAmt; PrevAmt)
            {
            }
            trigger OnAfterGetRecord()
            begin
                PrevAmt := 0;
                prTrans.reset();
                prtrans.setrange("Employee Code", "prPeriod Transactions"."Employee Code");
                prtrans.setrange("Transaction Code", "prPeriod Transactions"."Transaction Code");
                prtrans.setfilter("Payroll Period", getfilter("prPeriod Transactions"."Prev. Payroll Period Filter"));
                if prtrans.find('-') then
                    PrevAmt := prTrans.Amount;

                if PrevAmt = "prPeriod Transactions".Amount then
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                CompInf.get();
                CompInf.CalcFields(Picture);
                if "prPeriod Transactions".getfilter("Payroll Period") = '' then
                    error('Please select the Current Payroll period');
                if "prPeriod Transactions".getfilter("Prev. Payroll Period Filter") = '' then
                    error('Please select the Prev. Payroll period');
            end;
        }
    }

    var
        CompInf: Record "Company Information";
        prTrans: Record "prPeriod Transactions";
        PrevAmt: Decimal;
}