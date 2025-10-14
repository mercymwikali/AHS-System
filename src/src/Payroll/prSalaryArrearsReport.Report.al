Report 52202566 "prSalary Arrears Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/prSalaryArrearsReport.rdl';

    dataset
    {
        dataitem("prSalary Arrears"; "prSalary Arrears")
        {
            DataItemTableView = sorting("Employee Code", "Period Month", "Period Year");
            RequestFilterFields = "Employee Code";
            column(ReportForNavId_4749; 4749)
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
            column(prSalary_Arrears__Employee_Code_; "Employee Code")
            {
            }
            column(Names; Names)
            {
            }
            column(prSalary_Arrears__Employee_Code__Control1102756011; "Employee Code")
            {
            }
            column(prSalary_Arrears__Transaction_Code_; "Transaction Code")
            {
            }
            column(prSalary_Arrears__Start_Date_; "Start Date")
            {
            }
            column(prSalary_Arrears__End_Date_; "End Date")
            {
            }
            column(prSalary_Arrears__Salary_Arrears_; "Salary Arrears")
            {
            }
            column(prSalary_Arrears__PAYE_Arrears_; "PAYE Arrears")
            {
            }
            column(prSalary_Arrears__Period_Month_; "Period Month")
            {
            }
            column(prSalary_Arrears__Period_Year_; "Period Year")
            {
            }
            column(prSalary_Arrears__Current_Basic_; "Current Basic")
            {
            }
            column(prSalary_Arrears__Payroll_Period_; "Payroll Period")
            {
            }
            column(TOTALS_; 'TOTALS')
            {
            }
            column(prSalary_Arrears__Salary_Arrears__Control1102756041; "Salary Arrears")
            {
            }
            column(prSalary_Arrears__PAYE_Arrears__Control1102756042; "PAYE Arrears")
            {
            }
            column(prSalary_Arrears__Current_Basic__Control1102756043; "Current Basic")
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
            column(Salary_ArrearsCaption; Salary_ArrearsCaptionLbl)
            {
            }
            column(prSalary_Arrears__Employee_Code__Control1102756011Caption; FieldCaption("Employee Code"))
            {
            }
            column(prSalary_Arrears__Transaction_Code_Caption; FieldCaption("Transaction Code"))
            {
            }
            column(prSalary_Arrears__Start_Date_Caption; FieldCaption("Start Date"))
            {
            }
            column(prSalary_Arrears__End_Date_Caption; FieldCaption("End Date"))
            {
            }
            column(prSalary_Arrears__Salary_Arrears_Caption; FieldCaption("Salary Arrears"))
            {
            }
            column(prSalary_Arrears__PAYE_Arrears_Caption; FieldCaption("PAYE Arrears"))
            {
            }
            column(prSalary_Arrears__Period_Month_Caption; FieldCaption("Period Month"))
            {
            }
            column(prSalary_Arrears__Period_Year_Caption; FieldCaption("Period Year"))
            {
            }
            column(prSalary_Arrears__Current_Basic_Caption; FieldCaption("Current Basic"))
            {
            }
            column(prSalary_Arrears__Payroll_Period_Caption; FieldCaption("Payroll Period"))
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

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Employee Code");
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
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        LastFieldNo: Integer;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..              Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                   Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Page_No_CaptionLbl: label 'Page No:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Print_Date_CaptionLbl: label 'Print Date:';
        Salary_ArrearsCaptionLbl: label 'Salary Arrears';
        User_Name_CaptionLbl: label 'User Name:';
        Names: Text[100];
}
