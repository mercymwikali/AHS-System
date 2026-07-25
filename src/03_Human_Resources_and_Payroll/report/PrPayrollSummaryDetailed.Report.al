namespace PTL.Hospital;
using Microsoft.Foundation.Company;

report 85290 "Pr Payroll Summary Detailed"
{
    ApplicationArea = All;
    Caption = 'Pr Payroll Summary Detailed';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payroll/payrollSummaryDetailed.rdl';
    dataset
    {
        dataitem(prPeriodTransactions; "prPeriod Transactions")
        {
            RequestFilterFields = "Payroll Period";
            column(TransactionCode; "Transaction Code")
            {
            }
            column(EmployeeCode; "Employee Code")
            {
            }
            column(TransactionName; "Transaction Name")
            {
            }
            column(Amount; Amount)
            {
            }
            column(GroupOrder; "Group Order")
            {
            }
            column(SubGroupOrder; "Sub Group Order")
            {
            }
            column(PeriodMonth; "Period Month")
            {
            }
            column(PeriodYear; "Period Year")
            {
            }
            column(PayrollPeriod; "Payroll Period")
            {
            }
            column(FullName; FullName) { }
            column(RowNum; RowNum) { }
            column(CompanyInformation_picture; CompanyInformation.Picture) { }
            column(CompanyInformation_name; CompanyInformation.Name) { }
            column(CompanyInformation_address; CompanyInformation.Address) { }
            column(CompanyInformation_email; CompanyInformation."E-Mail") { }
            trigger OnAfterGetRecord()
            begin
                FullName := '';
                RowNum := RowNum + 1;
                if HREmployee.Get(prPeriodTransactions."Employee Code") then
                    FullName := UpperCase(HREmployee.FullName());
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
                CompanyInformation.CalcFields(Picture);
            end;

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
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnInitReport()
    begin
        if prPeriodTransactions.GetFilter(prPeriodTransactions."Payroll Period") = '' then begin
            prPayrollPeriods.Reset();
            prPayrollPeriods.SetRange(prPayrollPeriods.Closed, false);
            if prPayrollPeriods.FindFirst() then begin
                prPeriodTransactions.SetFilter(prPeriodTransactions."Payroll Period", Format(prPayrollPeriods."Date Opened"));
            end;
        end;
    end;

    trigger OnPreReport()
    begin
        prPeriodTransactions.SetCurrentKey(prPeriodTransactions."Employee Code", prPeriodTransactions."Period Month", prPeriodTransactions."Period Year", prPeriodTransactions."Group Order", prPeriodTransactions."Sub Group Order");
    end;

    var
        CompanyInformation: Record "Company Information";
        prPayrollPeriods: Record "prPayroll Periods";
        FullName: Text[250];
        RowNum: Integer;
        HREmployee: Record "HR-Employee";

}
