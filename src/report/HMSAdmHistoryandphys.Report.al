Report 85070 "HMS Adm History and phys"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSAdmHistoryandphys.rdl';

    dataset
    {
        dataitem("HMS Treatment Admission"; "HMS Treatment Admission")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(DateOfAdmission_HMSTreatmentAdmission; "HMS Treatment Admission"."Date Of Admission")
            {
            }
            column(AdmissionReason_HMSTreatmentAdmission; "HMS Treatment Admission"."Admission Reason")
            {
            }
            column(AdmissionRemarks_HMSTreatmentAdmission; "HMS Treatment Admission"."Admission Remarks")
            {
            }
            column(PastMedicalHistory_HMSTreatmentAdmission; "HMS Treatment Admission"."Past Medical History")
            {
            }
            column(PastSurgicalHistory_HMSTreatmentAdmission; "HMS Treatment Admission"."Past Surgical History")
            {
            }
            column(SocialHistory_HMSTreatmentAdmission; "HMS Treatment Admission"."Social History")
            {
            }
            column(Reviewsofsystems_HMSTreatmentAdmission; "HMS Treatment Admission"."Reviews of systems")
            {
            }
            column(Investigations_HMSTreatmentAdmission; "HMS Treatment Admission".Investigations)
            {
            }
            column(Assessmentandplan_HMSTreatmentAdmission; "HMS Treatment Admission"."Assessment and plan")
            {
            }
            column(Names; strNm)
            {
            }
            column(DOB; strDateofBirth)
            {
            }
            column(Sex; strSex)
            {
            }
            column(Residence; strResident)
            {
            }
            column(Address; strAddress)
            {
            }
            column(DOA; strDOA)
            {
            }
            column(Age; strAge)
            {
            }
            column(Tel; strTel)
            {
            }
            column(PatNo; PatNo)
            {
            }
            column(Logo; CompInf.Picture)
            {
            }
            column(CompName; CompInf.Name)
            {
            }
            column(Adress; CompInf.Address)
            {
            }
            column(Adress2; CompInf."Address 2")
            {
            }
            column(Phone; CompInf."Phone No.")
            {
            }
            column(PB; PB)
            {
            }
            column(Temp; Temp)
            {
            }
            column(Pulse; Pulse)
            {
            }
            column(Resp; Resp)
            {
            }
            column(Wt; Wt)
            {
            }
            column(O2; O2)
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
            dataitem("HMS Treatment Admission Notes"; "HMS Treatment Admission Notes")
            {
                DataItemLink = "Treatment No" = field("Treatment No.");
                column(ReportForNavId_41; 41)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // HMSTreatmentAdmissionNotes.RESET;
                    // HMSTreatmentAdmissionNotes.SETRANGE(HMSTreatmentAdmissionNotes."Treatment No","HMS Treatment Admission Notes"."Treatment No");
                    // HMSTreatmentAdmissionNotes.SETRANGE(HMSTreatmentAdmissionNotes."Notes Type",HMSTreatmentAdmissionNotes."Notes Type"::"Past Medical History");
                    // IF HMSTreatmentAdmissionNotes.FIND('-') THEN BEGIN
                    //  REPEAT
                    //   IF i<11 THEN BEGIN
                    //   i:=i+1;
                    //   Nts[i]:=HMSTreatmentAdmissionNotes.Notes
                    //   END;
                    //  UNTIL HMSTreatmentAdmissionNotes.NEXT=0;
                    // END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TreatHD.Reset();
                TreatHD.SetRange(TreatHD."Treatment No.", "HMS Treatment Admission"."Treatment No.");
                if TreatHD.Find('-') then begin
                    strNm := HMSCU.GetPatientName(TreatHD."Patient No.");
                    strAddress := HMSCU.GetPatientAddress(TreatHD."Patient No.");
                    strResident := HMSCU.GetPatientResidence(TreatHD."Patient No.");
                    strDateofBirth := HMSCU.GetPatientDOB(TreatHD."Patient No.");
                    strDOA := Format("HMS Treatment Admission"."Date Of Admission");
                    strSex := HMSCU.GetPatientGender(TreatHD."Patient No.");
                    strTel := HMSCU.GetPatientTel(TreatHD."Patient No.");
                    strAge := HMSCU.GetPatientAge(TreatHD."Patient No.");
                    PatNo := TreatHD."Patient No.";
                end;

                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Treatment Admission"."Treatment No.");
                HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Patient History");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            // Nt[i] := HMSNotes.Notes TODO : Notes is a blob field. Need to refactor to use RichTextContent
                        end;
                    until HMSNotes.Next() = 0;
                TreatmentFormProcess.Reset();
                TreatmentFormProcess.SetRange(TreatmentFormProcess."Treatment No.", "HMS Treatment Admission"."Treatment No.");
                if TreatmentFormProcess.Find('-') then
                    repeat
                        if TreatmentFormProcess."Blood Pressure" <> '' then
                            PB := TreatmentFormProcess."Blood Pressure";
                        if TreatmentFormProcess.Temperature <> 0 then
                            Temp := TreatmentFormProcess.Temperature;
                        if TreatmentFormProcess."Pulse Rate" <> '' then
                            Pulse := TreatmentFormProcess."Pulse Rate";
                        if TreatmentFormProcess.Weight <> 0 then
                            Wt := TreatmentFormProcess.Weight;
                        if TreatmentFormProcess.SP02 <> '' then
                            O2 := TreatmentFormProcess.SP02;
                    until TreatmentFormProcess.Next() = 0;
            end;

            trigger OnPreDataItem()
            begin
                CompInf.Get();
                CompInf.CalcFields(Picture);
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
        CompInf: Record "Company Information";
        HMSNotes: Record "hms Notes";
        TreatHD: Record "HMS Treatment Form Header";
        TreatmentFormProcess: Record "HMS Treatment Form Process";
        HMSCU: Codeunit "HMS Patient-integration";
        O2: Code[20];
        PatNo: Code[20];
        PB: Code[20];
        Pulse: Code[20];
        Resp: Code[20];
        Temp: Decimal;
        Wt: Decimal;
        i: Integer;
        strAddress: Text;
        strAge: Text;
        strDateofBirth: Text;
        strDOA: Text;
        strNm: Text;
        strResident: Text;
        strSex: Text;
        strTel: Text;
        Nt: array[10] of Text[500];
}
