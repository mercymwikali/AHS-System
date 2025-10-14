Report 52202688 "HMS Discharge Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSDischargeSummary.rdl';

    dataset
    {
        dataitem("HMS Admission Discharge Header"; "HMS Admission Discharge Header")
        {
            RequestFilterFields = "Admission No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(StrNames; StrNames)
            {
            }
            column(logos; CompanyInfo.Picture)
            {
            }
            column(gender; objPat.Gender)
            {
            }
            column(tel1; objPat."Telephone No. 1")
            {
            }
            column(ageinyear; objPat."Age in Years")
            {
            }
            column(todaysDate; todaysDate)
            {
            }
            column(AdmissionNo_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Admission No.")
            {
            }
            column(DischargeDate_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Discharge Date")
            {
            }
            column(DischargeTime_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Discharge Time")
            {
            }
            column(DoctorID_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Doctor ID")
            {
            }
            column(Remarks_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header".Remarks)
            {
            }
            column(WardNo_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Ward No.")
            {
            }
            column(BedNo_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Bed No.")
            {
            }
            column(PatientNo_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Patient No.")
            {
            }
            column(DateofAdmission_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Date of Admission")
            {
            }
            column(TimeOfAdmission_HMSAdmissionDischargeHeader; "HMS Admission Discharge Header"."Time Of Admission")
            {
            }
            column(PastMed1; PastMed[1])
            {
            }
            column(PastMed2; PastMed[2])
            {
            }
            column(PastMed3; PastMed[3])
            {
            }
            column(PastMed4; PastMed[4])
            {
            }
            column(PastMed5; PastMed[5])
            {
            }
            column(PastMed6; PastMed[6])
            {
            }
            column(PastMed7; PastMed[7])
            {
            }
            column(PastMed8; PastMed[8])
            {
            }
            column(PastMed9; PastMed[9])
            {
            }
            column(PastMed10; PastMed[10])
            {
            }
            column(SurgeryName; SurgeryName)
            {
            }
            column(Discharge1; Discharge[1])
            {
            }
            column(Discharge2; Discharge[2])
            {
            }
            column(Discharge3; Discharge[3])
            {
            }
            column(Discharge4; Discharge[4])
            {
            }
            column(Discharge5; Discharge[5])
            {
            }
            column(Management1; Management[1])
            {
            }
            column(Management2; Management[2])
            {
            }
            column(Management3; Management[3])
            {
            }
            column(Management4; Management[4])
            {
            }
            column(Management5; Management[5])
            {
            }
            column(Investigation1; Investigation[1])
            {
            }
            column(Investigation2; Investigation[2])
            {
            }
            column(Investigation3; Investigation[3])
            {
            }
            column(Investigation4; Investigation[4])
            {
            }
            column(Investigation5; Investigation[5])
            {
            }
            column(DischargeDoc; DischargeDoc)
            {
            }
            column(AdmitDoc; AdmitDoc)
            {
            }
            dataitem("HMS Discharge Summary"; "HMS Discharge Summary")
            {
                DataItemLink = "Discharge Code" = field("Admission No.");
                column(ReportForNavId_64; 64)
                {
                }
                column(DischargeCode_HMSDischargeSummary; "HMS Discharge Summary"."Discharge Code")
                {
                }
                column(LineNo_HMSDischargeSummary; "HMS Discharge Summary"."Line No")
                {
                }
                column(Type_HMSDischargeSummary; "HMS Discharge Summary".Type)
                {
                }
                column(Description_HMSDischargeSummary; "HMS Discharge Summary".Description)
                {
                }
                column(TreatmentNo_HMSDischargeSummary; "HMS Discharge Summary"."Admission No")
                {
                }
                column(PatientNo_HMSDischargeSummary; "HMS Discharge Summary".PatientNo)
                {
                }
                column(ReviewDate_HMSDischargeSummary; "HMS Discharge Summary"."Review Date")
                {
                }
                column(DifferentialDiagnosis_HMSTreatmentFormDiagnosis; "HMS Discharge Summary"."Diagnosis")
                {
                }
                dataitem("hms Notes"; "hms Notes")
                {
                    DataItemLink = TreatmentNo = field("Admission No");
                    column(ReportForNavId_35; 35)
                    {
                    }
                    column(Condition_History; "hms Notes".Notes)
                    {
                    }
                }
                dataitem("HMS Operational Notes"; "HMS Operational Notes")
                {
                    DataItemLink = "Treatment No" = field("Admission No");
                    column(ReportForNavId_37; 37)
                    {
                    }
                    column(Surgery_Notes; "HMS Operational Notes".Notes)
                    {
                    }
                }
                dataitem("HMS Treatment Form Header"; "HMS Treatment Form Header")
                {
                    DataItemLink = "Treatment No." = field("Admission No");
                    column(ReportForNavId_20; 20)
                    {
                    }
                    column(TreatmentNo_TreatmentFormHeader; "HMS Treatment Form Header"."Treatment No.")
                    {
                    }
                    column(AdmNo_TreatmentFormHeader; "HMS Treatment Form Header"."Adm No.")
                    {
                    }
                    column(LinkNo_TreatmentFormHeader; "HMS Treatment Form Header"."Link No.")
                    {
                    }
                    column(LinkType_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Link Type")
                    {
                    }
                }
                dataitem("HMS Treatment Form Diagnosis"; "HMS Treatment Form Diagnosis")
                {
                    DataItemLink = "Treatment No." = field("Admission No");
                    column(ReportForNavId_25; 25)
                    {
                    }
                    column(DiagnosisNo_HMSTreatmentDiagnosis; "HMS Treatment Form Diagnosis"."Diagnosis No.")
                    {
                    }
                    column(Confirmed_HMSTreatmentDiagnosis; "HMS Treatment Form Diagnosis".Confirmed)
                    {
                    }
                    column(Remarks_HMSTreatmentDiagnosis; "HMS Treatment Form Diagnosis".Remarks)
                    {
                    }
                    column(DiagnosisCode_HMSTreatmentDiagnosis; "HMS Treatment Form Diagnosis"."Diagnosis Code")
                    {
                    }
                    column(Description_HMSTreatmentDiagnosis; "HMS Treatment Form Diagnosis".Description)
                    {
                    }
                    column(DiagnosisType_HMSTreatmentDiagnosis; "HMS Treatment Form Diagnosis"."Diagnosis Type")
                    {
                    }
                    column(DiagnosisName_HMSTreatmentDiagnosis; "HMS Treatment Form Diagnosis"."Diagnosis Name")
                    {
                    }
                    column(Remarks_HMSTreatmentFormDiagnosis; "HMS Treatment Form Diagnosis".Remarks)
                    {
                    }
                    column(mcount; "HMS Treatment Form Diagnosis"."Diagnosis Count")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                StrNames := '';

                objPat.Reset();
                objPat.SetRange(objPat."Patient No.", "HMS Admission Discharge Header"."Patient No.");
                if objPat.Find('-') then
                    StrNames := objPat.Surname + ' ' + objPat."Middle Name" + ' ' + objPat."Last Name";

                AdmDischage.Reset();
                AdmDischage.SetRange(AdmDischage."Discharge Code", "HMS Admission Discharge Header"."Admission No.");

                if AdmDischage.Find('-') then begin

                    AdmisNotes.Reset();
                    AdmisNotes.SetRange(AdmisNotes.TreatmentNo, AdmDischage."Admission No");
                    AdmisNotes.SetRange(AdmisNotes."Notes Type", AdmisNotes."notes type"::"Patient History");
                    if AdmisNotes.Find('-') then begin

                        repeat
                            if i < 11 then begin
                                i := i + 1;
                                // TODO : Notes is a blob field. Need to refactor to use RichTextContent
                                // PastMed[i] := AdmisNotes.Notes
                            end;
                        until AdmisNotes.Next() = 0;
                        i := 0;
                    end;
                    Theatre.Reset();
                    Theatre.SetRange(Theatre."Link No.", AdmDischage."Admission No");
                    if Theatre.Find('-') then
                        SurgeryName := Theatre.Surgery;
                end;

                AdmDis.Reset();
                AdmDis.SetRange(AdmDis."Discharge Code", "HMS Admission Discharge Header"."Admission No.");
                AdmDis.SetRange(AdmDis.Type, AdmDis.Type::"Discharge Instructions");
                if AdmDis.Find('-') then begin

                    repeat
                        if j < 11 then begin
                            j := j + 1;
                            Discharge[j] := AdmDis.Description
                        end;
                    until AdmDis.Next() = 0;
                    j := 0;
                end;
                AdmDis.Reset();
                AdmDis.SetRange(AdmDis."Discharge Code", "HMS Admission Discharge Header"."Admission No.");
                AdmDis.SetRange(AdmDis.Type, AdmDis.Type::Investigation);
                if AdmDis.Find('-') then begin

                    repeat
                        if j < 11 then begin
                            j := j + 1;
                            Investigation[j] := AdmDis.Description
                        end;
                    until AdmDis.Next() = 0;
                    j := 0;
                end;

                AdmDis.Reset();
                AdmDis.SetRange(AdmDis."Discharge Code", "HMS Admission Discharge Header"."Admission No.");
                AdmDis.SetRange(AdmDis.Type, AdmDis.Type::Management);
                if AdmDis.Find('-') then begin

                    repeat
                        if j < 11 then begin
                            j := j + 1;
                            Management[j] := AdmDis.Description
                        end;
                    until AdmDis.Next() = 0;
                    j := 0;
                end;

                UserSetUpPortal.Reset();
                UserSetUpPortal.SetRange(UserSetUpPortal."User ID", "HMS Admission Discharge Header"."Doctor ID");
                if UserSetUpPortal.Find('-') then
                    docID := UserSetUpPortal."Doctor ID"
                else
                    docID := "HMS Admission Discharge Header"."Doctor ID";

                doc.Reset();
                doc.SetRange("Doctor ID", docID);
                if doc.Find('-') then
                    DischargeDoc := doc."Doctors Name";

                AdmH.Reset();
                AdmH.SetRange("Admission No.", "HMS Admission Discharge Header"."Admission No.");
                if AdmH.Find('-') then
                    doc.Reset();
                doc.SetRange("Doctor ID", AdmH.Doctor);
                if doc.Find('-') then
                    AdmitDoc := doc."Doctors Name";
            end;

            trigger OnPreDataItem()
            begin
                if CompanyInfo.Get() then
                    CompanyInfo.CalcFields(CompanyInfo.Picture);

                todaysDate := Today;
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
        AdmH: Record "HMS Admission Form Header";
        AdmDis: Record "HMS Discharge Summary";
        AdmDischage: Record "HMS Discharge Summary";
        AdmisNotes: Record "hms Notes";
        objPat: Record "HMS Patient";
        doc: Record "HMS Setup Doctor";
        Theatre: Record "HMS Theatre Form Header";
        UserSetUpPortal: Record "User Setup";
        todaysDate: Date;
        i: Integer;
        j: Integer;
        AdmitDoc: Text;
        DischargeDoc: Text;
        docID: Text;
        StrNames: Text;
        SurgeryName: Text;
        Discharge: array[20] of Text[500];
        Investigation: array[20] of Text[500];
        Management: array[20] of Text[500];
        PastMed: array[20] of Text[500];
}
