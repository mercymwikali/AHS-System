Report 85201 "HR Commission For Univ. Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HRCommissionForUnivReport.rdl';

    dataset
    {
        dataitem("Employee Categories"; "Employee Categories")
        {
            PrintOnlyIfDetail = true;
            column(ReportForNavId_17; 17)
            {
            }
            dataitem("HR-Employee"; "HR-Employee")
            {
                DataItemLink = "Salary Category" = field(Code);
                PrintOnlyIfDetail = false;
                column(ReportForNavId_1; 1)
                {
                }
                column(compName; info.Name)
                {
                }
                column(addr; info.Address + ', ' + info.City)
                {
                }
                column(phone; info."Phone No.")
                {
                }
                column(email; info."E-Mail")
                {
                }
                column(pics; info.Picture)
                {
                }
                column(hrYear; hrYear)
                {
                }
                column(Category; "Employee Categories".Code)
                {
                }
                column(No; "HR-Employee"."No.")
                {
                }
                column(empName; "HR-Employee"."First Name" + ' ' + "HR-Employee"."Middle Name" + ' ' + "HR-Employee"."Last Name")
                {
                }
                column(highestQual; qual.Qualification)
                {
                }
                column(Position; "HR-Employee"."Job Title")
                {
                }
                column(Age; ages)
                {
                }
                column(Gender; Format("HR-Employee".Gender))
                {
                }
                column(Ethnicity; "HR-Employee".Tribe)
                {
                }
                column(Disability_Status; "HR-Employee"."Physical Disability")
                {
                }
                column(seq; seq)
                {
                }
                column(G_Total; G_Total)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    qual.Reset();
                    qual.SetRange(qual."Employee No.", "HR-Employee"."No.");
                    qual.SetRange(qual."Highest Qualification", true);
                    if qual.Find('-') then;
                    ages := dates.DetermineAge_Years("HR-Employee"."Date Of Birth", Today);
                    seq := seq + 1;
                    G_Total := G_Total + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(seq);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(Year; hrYear)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'HR Year';
                    ToolTip = 'Specifies the value of the HR Year field.';
                }
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
        info.Reset();
        if info.Find('-') then
            info.CalcFields(info.Picture);
        Clear(G_Total);
    end;

    trigger OnPreReport()
    begin
        if hrYear = '' then
            Error('Please specify the Year first!');
    end;

    var
        info: Record "Company Information";
        qual: Record "Employee Qualifications Fin";
        dates: Codeunit "HR Dates";
        hrYear: Code[30];
        ages: Code[100];
        G_Total: Integer;
        seq: Integer;
}
