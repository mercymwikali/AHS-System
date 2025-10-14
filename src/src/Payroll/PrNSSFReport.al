report 52202481 "NSSF Report"
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
            column(Othername; fName)
            {
            }
            column(LName; lastName)
            {
            }
            column(NHIFNo; NHIFNo)
            {
            }
            column(StaffNumber; "employee code")
            {
            }
            column(nssfamount; nssfamount)
            {
            }
            column(Voluntary; Voluntary)
            {
            }
            column(GrossPay; GrossPay)
            {
            }
            trigger OnPreDataItem()
            begin
                //Setfilter("Transaction Code", '%1', 'NHIF');
            end;

            trigger onaftergetrecord()
            var
                periodtrans: record "prPeriod Transactions";
            begin
                emp.reset();
                if emp.get("employee code") then begin
                    fName := emp."First Name" + ' ' + emp."Middle Name";
                    lastname := emp."Last Name";
                    IDNumber := emp."ID Number";
                    pin := emp."PIN Number";
                    nhifno := emp."NSSF No.";
                end;

                periodtrans.Reset();
                periodtrans.SetRange("Payroll Period", "Payroll Period");
                periodtrans.SetRange("Employee Code", "Employee Code");
                if periodtrans.find('-') then begin
                    IF periodtrans."Transaction Code" = 'NSSF' then
                        nssfamount := periodtrans.Amount;
                    IF periodtrans."Transaction Code" = 'D596' then
                        Voluntary := periodtrans.Amount;
                    IF periodtrans."Transaction Code" = 'GPAY' then
                        grosspay := periodtrans.Amount;
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

        NHIFNo: Code[10];
        PIN: code[15];
        GrossPay: Decimal;
        nssfamount: Decimal;
        Voluntary: Decimal;

        FName: text[50];
        LastName: Text[50];
}