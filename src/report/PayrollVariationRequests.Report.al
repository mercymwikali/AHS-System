Report 85250 "Payroll Variation Requests"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PayrollVariationRequests.rdl';

    dataset
    {
        dataitem("Payroll Variations"; "Payroll Variations")
        {
            DataItemTableView = sorting("Employee Code");
            RequestFilterFields = "Employee Code";
            column(ReportForNavId_9162; 9162)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(UserId; UserId)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(Payroll_Variations__Employee_Code_; "Employee Code")
            {
            }
            column(Payroll_Variations__Payroll_Period_; "Payroll Period")
            {
            }
            column(Payroll_Variations_Type; Type)
            {
            }
            column(Payroll_Variations__Basic_Pay_; "Basic Pay")
            {
            }
            column(Payroll_Variations__Effective_Date_; "Effective Date")
            {
            }
            column(Payroll_Variations__Transaction_Code_; "Transaction Code")
            {
            }
            column(Payroll_Variations__New_Amount_; "New Amount")
            {
            }
            column(Payroll_Variations__Hrs_Worked_; "Hrs Worked")
            {
            }
            column(Payroll_Variations__Overtime_Type_; "Overtime Type")
            {
            }
            column(Payroll_Variations_Status; Status)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Payroll_VariationsCaption; Payroll_VariationsCaptionLbl)
            {
            }
            column(Payroll_Variations__Employee_Code_Caption; FieldCaption("Employee Code"))
            {
            }
            column(Payroll_Variations__Payroll_Period_Caption; FieldCaption("Payroll Period"))
            {
            }
            column(Payroll_Variations_TypeCaption; FieldCaption(Type))
            {
            }
            column(Payroll_Variations__Basic_Pay_Caption; FieldCaption("Basic Pay"))
            {
            }
            column(Payroll_Variations__Effective_Date_Caption; FieldCaption("Effective Date"))
            {
            }
            column(Payroll_Variations__Transaction_Code_Caption; FieldCaption("Transaction Code"))
            {
            }
            column(Payroll_Variations__New_Amount_Caption; FieldCaption("New Amount"))
            {
            }
            column(Payroll_Variations__Hrs_Worked_Caption; FieldCaption("Hrs Worked"))
            {
            }
            column(Payroll_Variations__Overtime_Type_Caption; FieldCaption("Overtime Type"))
            {
            }
            column(Payroll_Variations_StatusCaption; FieldCaption(Status))
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
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
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Payroll_VariationsCaptionLbl: label 'Payroll Variations';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
}
