Report 52202569 "New Employee Advise"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/NewEmployeeAdvise.rdl';

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
            column(Payroll_Variations__Basic_Pay_; "Basic Pay")
            {
            }
            column(Payroll_Variations__Effective_Date_; "Effective Date")
            {
            }
            column(Names; Names)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(New_Employee_AdviseCaption; New_Employee_AdviseCaptionLbl)
            {
            }
            column(Payroll_Variations__Employee_Code_Caption; FieldCaption("Employee Code"))
            {
            }
            column(Payroll_Variations__Payroll_Period_Caption; FieldCaption("Payroll Period"))
            {
            }
            column(Payroll_Variations__Basic_Pay_Caption; FieldCaption("Basic Pay"))
            {
            }
            column(Payroll_Variations__Effective_Date_Caption; FieldCaption("Effective Date"))
            {
            }
            column(NamesCaption; NamesCaptionLbl)
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

            trigger OnAfterGetRecord()
            begin
                Names := '';
                if "Hr-Employee".Get("Employee Code") then
                    Names := "Hr-Employee"."First Name" + ' ' + "Hr-Employee"."Middle Name" + ' ' + "Hr-Employee"."Last Name";
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Employee Code");
                "Payroll Variations".SetRange("Payroll Variations".Type, "Payroll Variations".Type::"New Employee")
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
        "Hr-Employee": Record "HR-Employee";
        LastFieldNo: Integer;
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..              Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                   Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        NamesCaptionLbl: label 'Names';
        New_Employee_AdviseCaptionLbl: label 'New Employee Advise';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á..                 Date┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á┬Á';
        Names: Text[100];
}
