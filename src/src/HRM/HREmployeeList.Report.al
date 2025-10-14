Report 52202626 "HR Employee List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HREmployeeList.rdl';

    dataset
    {
        dataitem("HR-Employee"; "HR-Employee")
        {
            RequestFilterFields = "No.", "ID Number", Status;

            column(ReportForNavId_6075; 6075)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(UserId; UserId)
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(CI_EMail; CI."E-Mail")
            {
                IncludeCaption = true;
            }
            column(CI_HomePage; CI."Home Page")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(HR_Employees__No__; "No.")
            {
            }
            column(HR_Employees__ID_Number_; "ID Number")
            {
            }
            column(HR_Employees__Date_Of_Joining_the_Company_; "Date Of Join")
            {
            }
            column(HR_Employees__FullName; "HR-Employee"."First Name" + ' ' + "HR-Employee"."Middle Name" + ' ' + "HR-Employee"."Last Name")
            {
            }
            column(HR_Employees__Cell_Phone_Number_; "HR-Employee"."Cellular Phone Number")
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_ListCaption; Employee_ListCaptionLbl)
            {
            }
            column(P_O__BoxCaption; P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employees__No__Caption; FieldCaption("No."))
            {
            }
            column(HR_Employees__ID_Number_Caption; FieldCaption("ID Number"))
            {
            }
            column(HR_Employees__Date_Of_Joining_the_Company_Caption; FieldCaption("Date Of Join"))
            {
            }
            column(Full_NamesCaption; Full_NamesCaptionLbl)
            {
            }
            column(LengthOfService_HREmployees; "HR-Employee"."Length Of Service")
            {
            }
            column(LenghtOfServices; LenghtOfServices)
            {
            }
            column(Age; Age)
            {
            }
            column(JobTitle_HREmployeeC; "HR-Employee"."Job Title")
            {
            }
            column(Gender_HREmployeeC; "HR-Employee".Gender)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(LenghtOfServices);
                if (("Date Of Join" <> 0D) and ("Date Of Join" <= Today)) then
                    LenghtOfServices := HrDates.DetermineAge("Date Of Join", Today);

                Clear(Age);
                if (("Date Of Birth" <> 0D) and ("Date Of Birth" <= Today)) then
                    Age := HrDates.DetermineAge("Date Of Birth", Today);
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
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        HrDates: Codeunit "HR Dates";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Employee_ListCaptionLbl: label 'Employee List';
        EmployeeCaptionLbl: label 'Employee';
        Full_NamesCaptionLbl: label 'Full Names';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        LenghtOfServices: Text[100];
}
