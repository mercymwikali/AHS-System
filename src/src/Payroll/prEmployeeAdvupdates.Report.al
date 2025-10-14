Report 52202551 prEmployeeAdvupdates
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prEmployeeAdvupdates.rdl';

    dataset
    {
        dataitem("prSalary Card"; "prSalary Card")
        {
            RequestFilterFields = "Period Filter";
            column(ReportForNavId_6207; 6207)
            {
            }

            trigger OnAfterGetRecord()
            begin
                AdvAmount := 0;
                AdvBal := 0;
                AdvRef := '';

                employeeAdvance.Reset();
                employeeAdvance.SetRange(employeeAdvance."Employee Code", "Employee Code");
                employeeAdvance.SetRange(employeeAdvance."Payroll Period", SelectedPeriod);
                employeeAdvance.SetRange(employeeAdvance.imported, false);
                employeeAdvance.SetFilter(employeeAdvance.Amount, '<>0');
                employeeAdvance.SetRange(employeeAdvance."Transaction Code", 'DED001');

                if employeeAdvance.Find('-') then begin
                    if employeeAdvance.Count > 1 then
                        repeat
                            AdvAmount := AdvAmount + Abs(employeeAdvance.Amount);
                            AdvRef := AdvRef + '/' + employeeAdvance."Reference No";
                            AdvBal := AdvBal + employeeAdvance.Balance;
                            //Flag as imported
                            employeeAdvance.imported := true;
                            employeeAdvance.Modify();
                        until employeeAdvance.Next() = 0
                    else begin
                        AdvAmount := Abs(employeeAdvance.Amount);
                        AdvRef := employeeAdvance."Reference No";
                        AdvBal := employeeAdvance.Balance;
                        //Flag as imported
                        employeeAdvance.imported := true;
                        employeeAdvance.Modify();
                    end;

                    EmployeeTrans.Init();
                    EmployeeTrans."Employee Code" := "Employee Code";
                    EmployeeTrans."Transaction Code" := employeeAdvance."Transaction Code";
                    EmployeeTrans."Period Month" := employeeAdvance."Period Month";
                    EmployeeTrans."Period Year" := employeeAdvance."Period Year";
                    EmployeeTrans."Payroll Period" := employeeAdvance."Payroll Period";
                    EmployeeTrans."Reference No" := AdvRef;
                    EmployeeTrans."Transaction Name" := employeeAdvance."Transaction Name";
                    EmployeeTrans.Amount := AdvAmount;
                    EmployeeTrans.Balance := AdvBal;
                    EmployeeTrans."Original Amount" := employeeAdvance."Original Amount";
                    EmployeeTrans."#of Repayments" := employeeAdvance."#of Repayments";
                    EmployeeTrans.Membership := employeeAdvance.Membership;
                    EmployeeTrans.Insert();
                end;

                //**************EARNING
                AdvAmount := 0;
                AdvBal := 0;
                AdvRef := '';

                employeeAdvance.Reset();
                employeeAdvance.SetRange(employeeAdvance."Employee Code", "Employee Code");
                employeeAdvance.SetRange(employeeAdvance."Payroll Period", SelectedPeriod);
                employeeAdvance.SetRange(employeeAdvance.imported, false);
                employeeAdvance.SetFilter(employeeAdvance.Amount, '<>0');
                employeeAdvance.SetRange(employeeAdvance."Transaction Code", 'EARN001');

                if employeeAdvance.Find('-') then begin
                    if employeeAdvance.Count > 1 then
                        repeat
                            AdvAmount := AdvAmount + Abs(employeeAdvance.Amount);
                            AdvRef := AdvRef + '/' + employeeAdvance."Reference No";
                            AdvBal := AdvBal + employeeAdvance.Balance;
                            //Flag as imported
                            employeeAdvance.imported := true;
                            employeeAdvance.Modify();
                        until employeeAdvance.Next() = 0
                    else begin
                        AdvAmount := Abs(employeeAdvance.Amount);
                        AdvRef := employeeAdvance."Reference No";
                        AdvBal := employeeAdvance.Balance;
                        //Flag as imported
                        employeeAdvance.imported := true;
                        employeeAdvance.Modify();
                    end;

                    EmployeeTrans.Init();
                    EmployeeTrans."Employee Code" := "Employee Code";
                    EmployeeTrans."Transaction Code" := employeeAdvance."Transaction Code";
                    EmployeeTrans."Period Month" := employeeAdvance."Period Month";
                    EmployeeTrans."Period Year" := employeeAdvance."Period Year";
                    EmployeeTrans."Payroll Period" := employeeAdvance."Payroll Period";
                    EmployeeTrans."Reference No" := AdvRef;
                    EmployeeTrans."Transaction Name" := employeeAdvance."Transaction Name";
                    EmployeeTrans.Amount := AdvAmount;
                    EmployeeTrans.Balance := AdvBal;
                    EmployeeTrans."Original Amount" := employeeAdvance."Original Amount";
                    EmployeeTrans."#of Repayments" := employeeAdvance."#of Repayments";
                    EmployeeTrans.Membership := employeeAdvance.Membership;
                    EmployeeTrans.Insert();
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        PeriodFilter := "prSalary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then
            Error('You must specify the period filter');

        SelectedPeriod := "prSalary Card".GetRangeMin("Period Filter");
        objPeriod.Reset();
        if objPeriod.Get(SelectedPeriod) then
            PeriodName := objPeriod."Period Name";
    end;

    var
        EmployeeTrans: Record "prEmployee Transactions";
        employeeAdvance: Record "prEmployee Transactions Ads";
        objPeriod: Record "prPayroll Periods";
        SelectedPeriod: Date;
        AdvAmount: Decimal;
        AdvBal: Decimal;
        PeriodFilter: Text[50];
        PeriodName: Text[50];
        AdvRef: Text[250];
}
