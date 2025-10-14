report 52202479 "HELB Report"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payroll/HelbDisbursment.rdl';

    dataset
    {
        dataitem(DataItemName; "prPeriod Transactions")
        {
            RequestFilterFields = "payroll period";

            column(IDNumber; idnumber)
            {
            }
            column(Name; EmployeeName)
            {
            }
            column(StaffNumber; "employee code")
            {
            }
            column(Amount; amount)
            {
            }
            trigger OnPreDataItem()
            begin
                Setfilter("Transaction Code", '%1', 'D0007');
            end;

            trigger onaftergetrecord()
            begin
                EmployeeName := '';
                IDNumber := '';
                HrEmployee.reset();
                if HrEmployee.get("employee code") then begin
                    EmployeeName := HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name";
                    IDNumber := HrEmployee."ID Number";
                end;
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
                
            }
        }
    }

    var

        HrEmployee: record "HR-Employee";

        IDNumber: code[10];

        EmployeeName: text[100];
}