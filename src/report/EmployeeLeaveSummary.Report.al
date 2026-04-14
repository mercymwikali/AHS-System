Report 85199 "Employee Leave Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/EmployeeLeaveSummary.rdl';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = where(Status = const(Normal));
            RequestFilterFields = "No.", "Date Filter";
            column(ReportForNavId_1; 1)
            {
            }
            column(No_HREmployee; "HR-Employee"."No.")
            {
            }
            column(Names; "HR-Employee"."First Name" + ' ' + "HR-Employee"."Middle Name" + ' ' + "HR-Employee"."Last Name")
            {
            }
            column(LeaveAllocation_HREmployee; "HR-Employee"."Leave Allocation")
            {
            }
            column(LeaveTaken_HREmployee; "HR-Employee"."Leave Taken")
            {
            }
            column(LeaveAdjustment_HREmployee; "HR-Employee"."Leave Adjustment")
            {
            }
            column(LeaveBalance_HREmployee; "HR-Employee"."Leave Balance")
            {
            }
            column(DateFilter_HREmployee; "HR-Employee".GetFilter("Date Filter"))
            {
            }
            column(LeaveOveralBal_HREmployee; "HR-Employee"."Leave Overal Bal")
            {
            }
            column(BrF; BrF)
            {
            }
            column(SalaryGrade_HREmployee; "HR-Employee"."Salary Grade")
            {
            }
            column(JobSpecification_HREmployee; "HR-Employee"."Job Title")
            {
            }
            column(CompLogo; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }

            trigger OnAfterGetRecord()
            begin

                "HR-Employee".CalcFields("Leave Overal Bal");
                BrF := "HR-Employee"."Leave Overal Bal" - "HR-Employee"."Leave Balance";
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(CompInf.Picture);
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

    var
        CompInf: Record "Company Information";
        BrF: Decimal;
}
