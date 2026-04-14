Report 85132 "Hospital Diagnosis<5years"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HospitalDiagnosis5years.rdl';

    dataset
    {
        dataitem("HMS Treatment Form Diagnosis"; "HMS Treatment Form Diagnosis")
        {
            CalcFields = "Diagnosis Date", "Diagnosis Count";
            DataItemTableView = where("Diagnosis Name" = filter(<> ''));
            RequestFilterFields = "Date Filter";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo())
            {
            }
            column(cname; CompInfor.Name)
            {
            }
            column(Caddress; CompInfor.Address)
            {
            }
            column(ccity; CompInfor.City)
            {
            }
            column(cmobile; CompInfor."Phone No.")
            {
            }
            column(Cpic; CompInfor.Picture)
            {
            }
            column(Printed_On; Pdate)
            {
            }
            column(Printed_Time; ptime)
            {
            }
            column(Printed_By; Puser)
            {
            }
            column(TreatmentNo; NoPatients)
            {
            }
            column(DiagnosisNo; "HMS Treatment Form Diagnosis"."Diagnosis No.")
            {
            }
            column(Name; "HMS Treatment Form Diagnosis"."Diagnosis Name")
            {
            }
            column(Date; "HMS Treatment Form Diagnosis"."Treatment Date")
            {
            }
            column(DateFilter; GetFilter("HMS Treatment Form Diagnosis"."Date Filter"))
            {
            }
            column(Gender; "HMS Treatment Form Diagnosis".Gender)
            {
            }
            column(Age; "HMS Treatment Form Diagnosis"."Age in Years")
            {
            }
            column(From; StartDate)
            {
            }
            column("To"; EndDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalculateAge();
                if "HMS Treatment Form Diagnosis"."Age in Years" < 5 then begin
                    ObjectDiagnosis.Reset();
                    ObjectDiagnosis.SetRange(ObjectDiagnosis."Treatment No.", "HMS Treatment Form Diagnosis"."Treatment No.");
                    ObjectDiagnosis.SetRange(ObjectDiagnosis."Treatment Date", "HMS Treatment Form Diagnosis"."Treatment Date");
                    if ObjectDiagnosis.Find('-') = true then
                        NoPatients := 1;
                end;
                StartDate := CopyStr(GetFilter("HMS Treatment Form Diagnosis"."Date Filter"), 1, 8);
                EndDate := CopyStr(GetFilter("HMS Treatment Form Diagnosis"."Date Filter"), 11, 8);
                if NoPatients = 0 then
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                CompInfor.Get();
                CompInfor.CalcFields(Picture);

                if GetFilter("HMS Treatment Form Diagnosis"."Date Filter") <> '' then
                    "HMS Treatment Form Diagnosis".SetFilter("HMS Treatment Form Diagnosis"."Treatment Date", GetFilter("HMS Treatment Form Diagnosis"."Date Filter"));
                NoPatients := 0;
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
        CompInfor: Record "Company Information";
        ObjectDiagnosis: Record "HMS Treatment Form Diagnosis";
        Puser: Code[50];
        Pdate: Date;
        NoPatients: Integer;
        EndDate: Text;
        StartDate: Text;
        ptime: Time;

    local procedure CalculateAge()
    begin
    end;
}
