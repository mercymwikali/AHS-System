report 85264 "Transactions Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(DataItemName; "prPeriod Transactions")
        {
            RequestFilterFields = "payroll period";

            column(IDNumber; idnumber)
            {
            }
            column(Name; Name)
            {
            }
            column(StaffNumber; "employee code")
            {
            }
            column(Amount; amount)
            {
            }
            column(designation; designation)
            {
            }
            column(Salutation; Salutation)
            {
            }
            column(pin; Pin)
            {
            }
            column(Department; Department)
            {
            }

            trigger OnPreDataItem()
            begin
                //Setfilter("Transaction Code", '%1|%2', 'D550,D552');
            end;

            trigger onaftergetrecord()
            begin
                emp.reset();
                if emp.get("employee code") then begin
                    Name := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
                    IDNumber := emp."ID Number";
                    pin := emp."PIN Number";
                    department := emp."Department Name";
                    designation := emp."Job Title";
                    Salutation := emp.Title;
                end
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
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

        Emp: record "hr-employee";

        IDNumber: code[10];

        pin: code[20];
        department: code[100];
        Salutation: Option ,Ms,Mrs,Mr,Prof,Dr,Miss,Rev,Capt;
        designation: text[100];

        Name: text[100];
}