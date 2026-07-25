Report 85091 "HMS Medical Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSMedicalReport.rdl';

    dataset
    {
        dataitem("HMS Treatment Form Header"; "HMS Treatment Form Header")
        {
            RequestFilterFields = "Patient No.", "Treatment No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(TreatmentNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Treatment No.")
            {
            }
            column(PatientNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Patient No.")
            {
            }
            column(Notess; Notess)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(PatientName; PatientName)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Notess := '';

                objPat.Reset();
                objPat.SetRange(objPat."Patient No.", "HMS Treatment Form Header"."Patient No.");
                if objPat.Find('-') then
                    PatientName := 'Medical Report For:  ' + ' (' + objPat."Patient No." + ') ' + objPat.Surname + ' ' + objPat."Middle Name" + ' ' + objPat."Last Name";

                hmsnotes.Reset();
                hmsnotes.SetRange(hmsnotes."Patient No", "HMS Treatment Form Header"."Patient No.");
                hmsnotes.SetRange(hmsnotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                hmsnotes.SetRange(hmsnotes."Notes Type", hmsnotes."notes type"::MedicalReport);
                //hmsnotes.SETFILTER(hmsnotes.LineNo);
                if hmsnotes.Find('-') then
                    repeat
                        // Notess := Notess + ' ' + hmsnotes.Notes;
                        // REFACTOR : Use RichTextContent to display notes.
                    until hmsnotes.Next() = 0;
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
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        hmsnotes: Record "hms Notes";
        objPat: Record "HMS Patient";
        Notess: Text;
        PatientName: Text;
}
