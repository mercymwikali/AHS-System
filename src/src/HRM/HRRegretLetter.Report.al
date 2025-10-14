Report 52202641 "HR Regret Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HRRegretLetter.rdl';

    dataset
    {
        dataitem(Applicants; Applicants)
        {
            PrintOnlyIfDetail = false;
            // RequestFilterFields = Field1;
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(Application_No; "Application No")
            {
                IncludeCaption = true;
            }
            column(First_Name; "First Name")
            {
                IncludeCaption = true;
            }
            column(Middle_Name; "Middle Name")
            {
                IncludeCaption = true;
            }
            column(Last_Name; "Last Name")
            {
                IncludeCaption = true;
            }
            column(Job_Applied_For; "Job Applied For")
            {
                IncludeCaption = true;
            }
            column(Job_Applied_for_Description; "Job Applied for Description")
            {
            }
            column(City; City)
            {
                IncludeCaption = true;
            }
            column(Post_Code; "Post Code")
            {
                IncludeCaption = true;
            }
            column(ID_Number; "ID Number")
            {
                IncludeCaption = true;
            }
            column(Gender; Gender)
            {
                IncludeCaption = true;
            }
            column(Country_Code; "Country Code")
            {
                IncludeCaption = true;
            }
            column(Home_Phone_Number; "Home Phone Number")
            {
                IncludeCaption = true;
            }
            column(Cell_Phone_Number; "Cell Phone Number")
            {
                IncludeCaption = true;
            }
            column(WorkPhoneNumber_HRJobApplications; "Work Phone Number")
            {
                IncludeCaption = true;
            }
            column(EMail_HRJobApplications; "E-Mail")
            {
                IncludeCaption = true;
            }
            column(PostalAddress_HRJobApplications; "Postal Address")
            {
                IncludeCaption = true;
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
            column(Date_Applied; "Date Applied")
            {
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(BPAY; objJobs."Basic Salary")
            {
            }
            column(DateofInterview_HRJobApplications; "Date of Interview")
            {
            }
            column(HSEAll; objJobs."House Allowance")
            {
            }
            column(ScaleFrom; objJobs."Salary Scale From")
            {
            }
            column(ScaleTo; objJobs."Salary Scale To")
            {
            }
            column(Medical_IN; objJobs."Medical Insurance Cover IN")
            {
            }
            column(Medical_OUT; objJobs."Medical Insurance Cover OUT")
            {
            }
            column(TOC; objJobs."Type Of Contract")
            {
            }
            column(Grade; objJobs.Grade)
            {
            }
            dataitem("Employee Responsibility"; "Employee Responsibility")
            {
                // DataItemLink =a==field(Field59);
                column(ReportForNavId_1; 1)
                {
                }
                column(JobID_HRJobResponsiblities; "Employee Responsibility"."Responsibility Description")
                {
                }
                column(ResponsibilityDescription_HRJobResponsiblities; "Employee Responsibility".Remarks)
                {
                }
                column(Remarks_HRJobResponsiblities; "Employee Responsibility"."Responsibility Code")
                {
                }
                column(ResponsibilityCode_HRJobResponsiblities; "Employee Responsibility"."Start Date")
                {
                }
                column(StartDate_HRJobResponsiblities; "Employee Responsibility"."End Date")
                {
                }
                column(EndDate_HRJobResponsiblities; "Employee Responsibility".Position)
                {
                }
                column(Position_HRJobResponsiblities; "Employee Responsibility".Position)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                objJobs.Reset();
                objJobs.SetRange(objJobs."Job ID", "Job Applied For");
                objJobs.FindFirst();
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

        //GET FILTER
    end;

    var
        CI: Record "Company Information";
        objJobs: Record "HR Jobs";
}
