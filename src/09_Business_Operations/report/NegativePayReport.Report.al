report 85272 "Negative Pay Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/NegativePay.rdl';

    dataset
    {
        dataitem(DataItemName; "prPeriod Transactions")
        {
            RequestFilterFields = "Payroll Period";

            column(EmployeeCode; "Employee Code")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(Amount; amount)
            {
            }
            column(Transaction_Code; transcode)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //selectedperiod:= getfilter("Payroll Period");
                EMp.reset();
                if emp.get() then
                    "Employee Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";

                trans.reset();
                trans.setrange("Transaction Code", 'NPAY');
                trans.SetRange("Payroll Period", SelectedPeriod);
                //Trans.SetFilter(Amount,'<0');
                if Trans.find('-') then
                    IF trans.Amount > 0 then
                        CurrReport.Skip();

                transCodes.reset();
                transCodes.SetRange(transCodes."Transaction Type", transCodes."Transaction Type"::Deduction);
                if transCodes.find('-') then
                    repeat
                        trans.reset();
                        trans.SetRange("Payroll Period", SelectedPeriod);
                        Trans.SetRange("Transaction Code", transCodes."Transaction Code");
                        if Trans.find('-') then begin
                            TransCode := Trans."Transaction Code";
                            AMounts := Trans.Amount;
                        end;
                    until transCodes.next() = 0
            end;

            //IF "prPeriod Transactions".TRANSAC
        }
    }

    requestpage
    {
        layout
        {
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

    var
        emp: record "hr-employee";
        Trans: record "prperiod transactions";
        transCodes: record "PR Transaction Codes";
        TransCode: code[10];
        SelectedPeriod: date;
        AMounts: Decimal;
        "Employee Name": text;
}