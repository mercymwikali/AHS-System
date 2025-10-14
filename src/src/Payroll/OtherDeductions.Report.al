Report 52202563 "Other Deductions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/OtherDeductions.rdl';

    dataset
    {
        dataitem("prPeriod Transactions"; "prPeriod Transactions")
        {
            DataItemTableView = sorting(Membership) where(Membership = filter(<> ''));
            RequestFilterFields = Membership, "Payroll Period";
            column(ReportForNavId_7769; 7769)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(UserId; UserId)
            {
            }
            column(Today; Today)
            {
            }
            column(prPeriod_Transactions_Membership; Membership)
            {
            }
            column(Employee_Code_______Names; "Employee Code" + ': ' + Names)
            {
            }
            column(prPeriod_Transactions__Reference_No_; "Reference No")
            {
            }
            column(Transaction_Code________Transaction_Name_; "Transaction Code" + ': ' + "Transaction Name")
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(TOTAL_; 'TOTAL')
            {
            }
            column(prPeriod_Transactions_Amount_Control1102756026; Amount)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Other_DeductionsCaption; Other_DeductionsCaptionLbl)
            {
            }
            column(Employee_DetailsCaption; Employee_DetailsCaptionLbl)
            {
            }
            column(Membership_NoCaption; Membership_NoCaptionLbl)
            {
            }
            column(Transaction_DetailsCaption; Transaction_DetailsCaptionLbl)
            {
            }
            column(prPeriod_Transactions_AmountCaption; FieldCaption(Amount))
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(prPeriod_Transactions_Employee_Code; "Employee Code")
            {
            }
            column(prPeriod_Transactions_Transaction_Code; "Transaction Code")
            {
            }
            column(prPeriod_Transactions_Period_Month; "Period Month")
            {
            }
            column(prPeriod_Transactions_Period_Year; "Period Year")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //IF "prPeriod Transactions".Membership='' THEN
                // CurrReport.SKIP;
                Names := '';
                if HrEmp.Get("prPeriod Transactions"."Employee Code") then
                    Names := HrEmp."First Name" + ' ' + HrEmp."Middle Name" + ' ' + HrEmp."Last Name";
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo(Membership);
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);
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
        CompanyInfo: Record "Company Information";
        HrEmp: Record "HR-Employee";
        LastFieldNo: Integer;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..              Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                   Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Employee_DetailsCaptionLbl: label 'Employee Details';
        Membership_NoCaptionLbl: label 'Membership No';
        Other_DeductionsCaptionLbl: label 'Other Deductions';
        Page_No_CaptionLbl: label 'Page No:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Print_Date_CaptionLbl: label 'Print Date:';
        Transaction_DetailsCaptionLbl: label 'Transaction Details';
        User_Name_CaptionLbl: label 'User Name:';
        Names: Text[100];
}
