Report 52202637 "Hr Employee Per Contract"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HrEmployeePerContract.rdl';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            DataItemTableView = where(Status = filter(Normal));
            column(ReportForNavId_1; 1)
            {
            }
            column(ContractStartDate_HREmployee; "HR-Employee"."Contract Start Date")
            {
            }
            column(ContractDuration_HREmployee; "HR-Employee"."Contract Duration")
            {
            }
            column(ContractEndDate_HREmployee; "HR-Employee"."Contract End Date")
            {
            }
            column(DateOfJoin_HREmployee; "HR-Employee"."Date Of Join")
            {
            }
            column(Gender_HREmployee; "HR-Employee".Gender)
            {
            }
            column(JobTitle_HREmployee; "HR-Employee"."Job Title")
            {
            }
            column(TypeofContract_HREmployee; "HR-Employee"."Type of Contract")
            {
            }
            column(No_HREmployee; "HR-Employee"."No.")
            {
            }
            column(FirstName_HREmployee; "HR-Employee"."First Name")
            {
            }
            column(MiddleName_HREmployee; "HR-Employee"."Middle Name")
            {
            }
            column(LastName_HREmployee; "HR-Employee"."Last Name")
            {
            }
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
}
