Report 52202668 "Casual Payslip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Layouts/CasualPayslip.rdl';

    dataset
    {
        dataitem("Casual Employees"; "Casual Employees")
        {
            RequestFilterFields = "Date Filter";
            column(ReportForNavId_1; 1)
            {
            }
            column(No; "Casual Employees"."Casual No")
            {
            }
            column(FullName; "Casual Employees"."Full  Name")
            {
            }
            column(CName; CompanyInfo.Name)
            {
            }
            column(CAddress; CompanyInfo.Address)
            {
            }
            column(CPic; CompanyInfo.Picture)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(PINNo; "Casual Employees"."PIN No")
            {
            }
            column(NSSFNo; "Casual Employees"."NSSF NO")
            {
            }
            column(NHIFNo; "Casual Employees"."NHIF NO")
            {
            }
            column(BankName; "Casual Employees"."Bank Name")
            {
            }
            column(BranchName; "Casual Employees"."Bank Branch Name")
            {
            }
            column(BankAccNo; "Casual Employees"."Bank Account Number")
            {
            }
            dataitem("prPeriod Transactions-Casuals"; "prPeriod Transactions-Casuals")
            {
                DataItemLink = "Employee Code" = field("Casual No");
                RequestFilterFields = "Payroll Period";
                column(ReportForNavId_6; 6)
                {
                }
                column(TCode; "Transaction Code")
                {
                }
                column(TName; "Transaction Name")
                {
                }
                column(Grouping; "Group Order")
                {
                }
                column(TBalances; Balance)
                {
                }
                column(Amount; Amount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PayrollCalender.Reset();
                    PayrollCalender.SetRange(PayrollCalender."Date Opened", "prPeriod Transactions-Casuals"."Payroll Period");
                    if PayrollCalender.Find('-') then
                        PeriodName := PayrollCalender."Period Name";
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        if UserSetup.Get(UserId) then begin
            if not UserSetup."View Payroll" then
                Error(PemissionDenied);
        end else
            Error(UserNotFound, UserId);
    end;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        PayrollCalender: Record "prPayroll Periods";
        UserSetup: Record "User Setup";
        PemissionDenied: label 'User Account is not Setup for Payroll Use. Contact System Administrator.';
        UserNotFound: label 'User Setup %1 not found.';
        PeriodName: Text;
}
