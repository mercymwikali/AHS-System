report 52202477 "Pension Report"
{
    DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/prPensionReport.rdl';

    dataset
    {
        dataitem(DataItemName; "Hr-employee")
        {
            //RequestFilterFields = se;

            column(EmployeeCode; "No.")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(IDNumber; "ID Number")
            {
            }
            column(PensionNumber; "Pension Number")
            {
            }
            column(EmployeeAmount; "Employee Amount")
            {
            }
            column(EmployerAmount; "Employer Amount")
            {
            }
            column(VoluntaryPensionAmount; "Voluntary Pension Amount")
            {
            }
            column(TotalPension; "Total Pension")
            {
            }
            column("Tax"; "Tax")
            {
            }
            column(NetContribution; "Net Contribution")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //selectedperiod:= getfilter("Payroll Period");
                "Employee Amount" := 0;
                "Employer Amount" := 0;
                "Voluntary Pension Amount" := 0;
                Tax := 0;
                "Net Contribution" := 0;
                EMp.reset();
                if emp.get() then begin
                    "Employee Name" := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
                    IDNumber := emp."ID Number";
                end;

                trans.reset();
                trans.setrange("Transaction Code", 'D751');
                trans.SetRange("Payroll Period", SelectedPeriod);
                trans.setrange("Employee Code", "No.");
                if Trans.find('-') then begin
                    "Employee Amount" := Trans.Amount;
                    "Employer Amount" := Trans.Amount * 2;
                end;
                trans.reset();
                trans.setrange("Transaction Code", 'D625');
                trans.SetRange("Payroll Period", SelectedPeriod);
                trans.setrange("Employee Code", "No.");
                if Trans.find('-') then
                    "Voluntary Pension Amount" := Trans.Amount;
                    //"Employer Amount" := Trans.Amount * 2;
                "Total Pension" := "Employee Amount" + "Employer Amount" + "Voluntary Pension Amount";
                if "Total Pension" > 20000 then
                    tax := ("Total Pension" - 20000) * 0.3;
                "Net Contribution" := "Total Pension" - Tax
            end;

            //IF "prPeriod Transactions".TRANSAC
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(options)
                {
                    field(SelectedPeriod; SelectedPeriod)
                    {
                        ApplicationArea = all;
                        // tablerelation = "prpayroll period"."payroll period";
                        Caption = 'Payroll period';
                        ToolTip = 'Specifies the value of the Payroll period field.';
                    }
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

    var
        emp: record "hr-employee";
        Trans: record "prperiod transactions";
        IDNumber: Code[10];
        "Pension Number": code[20];
        SelectedPeriod: date;
        "Employee Amount": decimal;
        "Employer Amount": decimal;
        "Net Contribution": decimal;
        Tax: decimal;
        "Total Pension": decimal;
        "Voluntary Pension Amount": decimal;
        "Employee Name": text;
}
