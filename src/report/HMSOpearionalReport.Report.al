Report 85096 "HMS Opearional Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSOpearionalReport.rdl';

    dataset
    {
        dataitem("HMS Theatre Form Header"; "HMS Theatre Form Header")
        {
            RequestFilterFields = "Patient No.", "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(TreatmentNo_HMSTreatmentFormHeader; "HMS Theatre Form Header"."No.")
            {
            }
            column(PatientNo_HMSTreatmentFormHeader; "HMS Theatre Form Header"."Patient No.")
            {
            }
            column(Notess; Notess)
            {
            }
            column(NurseNotess; NurseNotess)
            {
            }
            column(AnaesNotess; AnaesNotess)
            {
            }
            column(Complecations; complecations)
            {
            }
            column(Biopsy; Biopsy)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(PatientName; PatientName)
            {
            }
            column(TheatreDate_HMSTheatreFormHeader; "HMS Theatre Form Header"."Theatre Date")
            {
            }
            column(TheatreTime_HMSTheatreFormHeader; "HMS Theatre Form Header"."Theatre Time")
            {
            }
            column(SurgeryCode_HMSTheatreFormHeader; "HMS Theatre Form Header"."Surgery Code")
            {
            }
            column(Surgery_HMSTheatreFormHeader; "HMS Theatre Form Header".Surgery)
            {
            }
            column(AnaesthetistID_HMSTheatreFormHeader; "HMS Theatre Form Header"."Anaesthetist ID")
            {
            }
            column(ScrubNurse_HMSTheatreFormHeader; "HMS Theatre Form Header"."Scrub Nurse")
            {
            }
            column(TheatreAssistant_HMSTheatreFormHeader; "HMS Theatre Form Header"."Theatre Assistant")
            {
            }
            column(Count_HMSTheatreFormHeader; "HMS Theatre Form Header".Count)
            {
            }
            column(EstimatedBloodLoss_HMSTheatreFormHeader; "HMS Theatre Form Header"."Estimated Blood Loss")
            {
            }
            column(Incision_HMSTheatreFormHeader; "HMS Theatre Form Header".Incision)
            {
            }
            column(PreopDiagnosis_HMSTheatreFormHeader; "HMS Theatre Form Header"."Pre-op Diagnosis")
            {
            }
            column(DoctorID_HMSTheatreFormHeader; "HMS Theatre Form Header"."Doctor ID")
            {
            }
            column(Anaesthesia_HMSTheatreFormHeader; "HMS Theatre Form Header".Anaesthesia)
            {
            }
            column(Ward; AdmissionForm.Ward)
            {
            }
            column(Gender; objPat.Gender)
            {
            }
            column(mAge; objPat."Age in Years")
            {
            }
            column(Diagnosis; Diagnosis)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Notess := '';
                Biopsy := '';
                complecations := '';

                ObjDiagnosis.Reset();
                ObjDiagnosis.SetRange("Treatment No.", "HMS Theatre Form Header"."Link No.");
                if ObjDiagnosis.Find('-') then begin
                    ObjDiagnosis.CalcFields("Diagnosis Name");
                    Diagnosis := ObjDiagnosis."Diagnosis Name";
                end;

                objPat.Reset();
                objPat.SetRange(objPat."Patient No.", "HMS Theatre Form Header"."Patient No.");
                if objPat.Find('-') then
                    PatientName := '(' + objPat."Patient No." + ') ' + objPat.Surname + ' ' + objPat."Middle Name" + ' ' + objPat."Last Name";

                hmsnotes.Reset();
                hmsnotes.SetRange(hmsnotes."Theatre No.", "HMS Theatre Form Header"."No.");
                hmsnotes.SetRange(hmsnotes.notesType, hmsnotes.Notestype::"Surgeon Notes");
                if hmsnotes.Find('-') then
                    repeat
                        Notess := Notess + ' ' + hmsnotes.Notes;
                    until hmsnotes.Next() = 0;

                hmsnotes.Reset();
                hmsnotes.SetRange(hmsnotes."Theatre No.", "HMS Theatre Form Header"."No.");
                hmsnotes.SetRange(hmsnotes.notesType, hmsnotes.Notestype::"Nurse Notes");
                if hmsnotes.Find('-') then
                    repeat
                        NurseNotess := NurseNotess + ' ' + hmsnotes.Notes;
                    until hmsnotes.Next() = 0;

                hmsnotes.Reset();
                hmsnotes.SetRange(hmsnotes."Theatre No.", "HMS Theatre Form Header"."No.");
                hmsnotes.SetRange(hmsnotes.notesType, hmsnotes.Notestype::"Anaesthesist Notes");
                if hmsnotes.Find('-') then
                    repeat
                        AnaesNotess := AnaesNotess + ' ' + hmsnotes.Notes;
                    until hmsnotes.Next() = 0;

                hmsnotes.Reset();
                hmsnotes.SetRange(hmsnotes."Theatre No.", "HMS Theatre Form Header"."No.");
                hmsnotes.SetRange(hmsnotes.notesType, hmsnotes.Notestype::Complications);
                if hmsnotes.Find('-') then
                    repeat
                        complecations := complecations + ' ' + hmsnotes.Notes;
                    until hmsnotes.Next() = 0;

                hmsnotes.Reset();
                hmsnotes.SetRange(hmsnotes."Theatre No.", "HMS Theatre Form Header"."No.");
                hmsnotes.SetRange(hmsnotes.notesType, hmsnotes.Notestype::"Biopsy Specimen");
                if hmsnotes.Find('-') then
                    repeat
                        Biopsy := Biopsy + ' ' + hmsnotes.Notes;
                    until hmsnotes.Next() = 0;

                AdmissionForm.Reset();
                AdmissionForm.SetRange(AdmissionForm."Patient No.", "HMS Theatre Form Header"."Patient No.");
                //AdmissionForm.SETRANGE(AdmissionForm."Link No.","HMS Theatre Form Header"."No.");
                if AdmissionForm.Find('-') then;

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
        AdmissionForm: Record "HMS Admission Form Header";
        hmsnotes: Record "HMS Operational Notes";
        objPat: Record "HMS Patient";
        ObjDiagnosis: Record "HMS Treatment Form Diagnosis";
        AnaesNotess: Text;
        Biopsy: Text;
        complecations: Text;
        Diagnosis: Text;
        Notess: Text;
        NurseNotess: Text;
        PatientName: Text;
}
