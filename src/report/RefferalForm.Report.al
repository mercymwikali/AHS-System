Report 85166 "Refferal Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/RefferalForm.rdl';

    dataset
    {
        dataitem("HMS Treatment Form Header"; "HMS Treatment Form Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Logo; Company.Picture)
            {
            }
            column(ComName; Company.Name)
            {
            }
            column(Name_of_Patient______UPPERCASE_PatientName_; UpperCase(PatientName))
            {
            }
            column(Doctors_Name______DoctorName; DoctorName)
            {
            }
            column(TreatmentNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Treatment No.")
            {
            }
            column(TreatmentType_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Treatment Type")
            {
            }
            column(TreatmentDate_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Treatment Date")
            {
            }
            column(TreatmentTime_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Treatment Time")
            {
            }
            column(DoctorID_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Doctor ID")
            {
            }
            column(PatientNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Patient No.")
            {
            }
            column(TreatmentRemarks_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Doctor Notes")
            {
            }
            column(Status_HMSTreatmentFormHeader; "HMS Treatment Form Header".Status)
            {
            }
            column(LinkNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Link No.")
            {
            }
            column(LinkType_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Link Type")
            {
            }
            column(NoSeries_HMSTreatmentFormHeader; "HMS Treatment Form Header"."No. Series")
            {
            }
            column(OffDutyDays_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Off Duty Days")
            {
            }
            column(LightDutyDays_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Light Duty Days")
            {
            }
            column(OffDutyComments_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Off Duty Comments")
            {
            }
            column(OffDuty_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Off Duty")
            {
            }
            column(TreatmentLocation_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Treatment Location")
            {
            }
            column(PatientType_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Patient Type")
            {
            }
            column(Direct_HMSTreatmentFormHeader; "HMS Treatment Form Header".Direct)
            {
            }
            column(LabStatus_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Lab Status")
            {
            }
            column(RadiologyStatus_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Radiology Status")
            {
            }
            column(PharmacyStatus_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Pharmacy Status")
            {
            }
            column(InjectionStatus_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Injection Status")
            {
            }
            column(Surname_HMSTreatmentFormHeader; "HMS Treatment Form Header".Surname)
            {
            }
            column(MiddleName_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Middle Name")
            {
            }
            column(LastName_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Last Name")
            {
            }
            column(CorrespondenceAddress1_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Correspondence Address 1")
            {
            }
            column(TelephoneNo1_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Telephone No. 1")
            {
            }
            column(Email_HMSTreatmentFormHeader; "HMS Treatment Form Header".Email)
            {
            }
            column(PatientRefNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Patient Ref. No.")
            {
            }
            column(PatientName_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Patient Name")
            {
            }
            column(SettlementType_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Settlement Type")
            {
            }
            column(MembershipNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Membership No")
            {
            }
            column(InsuranceName_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Insurance Name")
            {
            }
            column(AdmNo_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Adm No.")
            {
            }
            column(DoctorNotes_HMSTreatmentFormHeader; "HMS Treatment Form Header"."Doctor Notes")
            {
            }
            column(Nt1; Nt[1])
            {
            }
            column(Nt2; Nt[2])
            {
            }
            column(Nt3; Nt[3])
            {
            }
            column(Nt4; Nt[4])
            {
            }
            column(Nt5; Nt[5])
            {
            }
            column(Nt6; Nt[6])
            {
            }
            column(Nt7; Nt[7])
            {
            }
            column(Nt8; Nt[8])
            {
            }
            column(Nt9; Nt[9])
            {
            }
            column(Nt10; Nt[10])
            {
            }
            column(Exam; Exam)
            {
            }
            dataitem("HMS Referral Header"; "HMS Referral Header")
            {
                DataItemLink = "Treatment no." = field("Treatment No.");
                column(ReportForNavId_40; 40)
                {
                }
                column(Treatmentno_HMSReferralHeader; "HMS Referral Header"."Treatment no.")
                {
                }
                column(HospitalNo_HMSReferralHeader; "HMS Referral Header"."Hospital No.")
                {
                }
                column(PatientNo_HMSReferralHeader; "HMS Referral Header"."Patient No.")
                {
                }
                column(DateReferred_HMSReferralHeader; "HMS Referral Header"."Date Referred")
                {
                }
                column(ReferralReason_HMSReferralHeader; "HMS Referral Header"."Referral Reason")
                {
                }
                column(ReferralRemarks_HMSReferralHeader; "HMS Referral Header"."Referral Remarks")
                {
                }
                column(Status_HMSReferralHeader; "HMS Referral Header".Status)
                {
                }
                column(Surname_HMSReferralHeader; "HMS Referral Header".Surname)
                {
                }
                column(MiddleName_HMSReferralHeader; "HMS Referral Header"."Middle Name")
                {
                }
                column(LastName_HMSReferralHeader; "HMS Referral Header"."Last Name")
                {
                }
                column(IDNumber_HMSReferralHeader; "HMS Referral Header"."ID Number")
                {
                }
                column(CorrespondenceAddress1_HMSReferralHeader; "HMS Referral Header"."Correspondence Address 1")
                {
                }
                column(TelephoneNo1_HMSReferralHeader; "HMS Referral Header"."Telephone No. 1")
                {
                }
                column(Email_HMSReferralHeader; "HMS Referral Header".Email)
                {
                }
                column(PatientRefNo_HMSReferralHeader; "HMS Referral Header"."Patient Ref. No.")
                {
                }
                column(Diagnosis_HMSReferralHeader; "HMS Referral Header".Diagnosis)
                {
                }
                column(StudentNo_HMSReferralHeader; "HMS Referral Header"."Student No")
                {
                }
                column(ADMNo_HMSReferralHeader; "HMS Referral Header"."ADM No")
                {
                }
                column(HospitalName_HMSReferralHeader; "HMS Referral Header"."Hospital Name")
                {
                }
            }
            dataitem("HMS Treatment Referral"; "HMS Treatment Referral")
            {
                DataItemLink = "Treatment No." = field("Treatment No.");
                column(ReportForNavId_8; 8)
                {
                }
                column(TreatmentNo_HMSTreatmentReferral; "HMS Treatment Referral"."Treatment No.")
                {
                }
                column(HospitalNo_HMSTreatmentReferral; "HMS Treatment Referral"."Hospital No.")
                {
                }
                column(HospitalName_HMSTreatmentReferral; "HMS Treatment Referral"."Hospital Name")
                {
                }
                column(DateReferred_HMSTreatmentReferral; "HMS Treatment Referral"."Date Referred")
                {
                }
                column(Contactperson_HMSTreatmentReferral; "HMS Treatment Referral"."Contact person")
                {
                }
                column(ReferralReason_HMSTreatmentReferral; "HMS Treatment Referral"."Referral Reason")
                {
                }
                column(ReferralRemarks_HMSTreatmentReferral; "HMS Treatment Referral"."Referral Remarks")
                {
                }
                column(Status_HMSTreatmentReferral; "HMS Treatment Referral".Status)
                {
                }
                column(ClinicalHistoryTreatment_HMSTreatmentReferral; "HMS Treatment Referral"."Clinical History & Treatment")
                {
                }
                column(FindingsonExamInvestigtn_HMSTreatmentReferral; "HMS Treatment Referral"."Findings on Exam & Investigtn")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Patient.Reset();
                PatientName := '';
                Age := '';
                Gender := '';

                if Patient.Get("Patient No.") then begin
                    PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                    Gender := Format(Patient.Gender);
                    PFNo := Patient."Patient No.";
                end;

                DoctorName := '';
                Doctor.Reset();
                if Doctor.Get("HMS Treatment Form Header"."Doctor ID") then
                    //  Doctor.CALCFIELDS(Doctor."Doctor's Name");
                    DoctorName := Doctor."Doctors Name";
                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Form Header"."Treatment No.");
                // HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Chief Complaints");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            // Nt[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                ObjSigns.Reset();
                ObjSigns.SetRange(ObjSigns."Treatment No.", "HMS Treatment Form Header"."Treatment No.");
                if ObjSigns.Find('-') then
                    repeat
                        Exam := (ObjSigns.System + ' - ' + ObjSigns."Sign Description") + '   |' + Exam;
                    until ObjSigns.Next() = 0;

                Objlab.Reset();
                Objlab.SetRange(Objlab."Treatment No.", "HMS Treatment Form Header"."Treatment No.");
                if Objlab.Find('-') then
                    repeat
                        Labworks := (Objlab."Laboratory Test Package Name") + '   |' + Labworks;
                    until Objlab.Next() = 0;
            end;

            trigger OnPreDataItem()
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
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
        Company: Record "Company Information";
        HMSNotes: Record "hms Notes";
        ObjSigns: Record "HMS Observation Signs";
        Patient: Record "HMS Patient";
        Doctor: Record "HMS Setup Doctor";
        Objlab: Record "HMS Treatment Form Laboratory";
        PFNo: Code[20];
        i: Integer;
        Age: Text[100];
        DoctorName: Text[100];
        Gender: Text[100];
        PatientName: Text[100];
        Exam: Text[500];
        Labworks: Text[500];
        Nt: array[10] of Text[500];
}
