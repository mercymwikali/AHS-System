Report 52202631 "HMS Physio Evalution Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HMSPhysioEvalutionForm.rdl';

    dataset
    {
        dataitem("HMS Physiotheraphy Form Header"; "HMS Physiotheraphy Form Header")
        {
            column(ReportForNavId_2; 2)
            {
            }
            column(Diagnosis_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header".Diagnosis)
            {
            }
            column(SurnameName_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header"."Surname Name")
            {
            }
            column(LastName_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header"."Last Name")
            {
            }
            column(ADMNo_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header"."ADM No")
            {
            }
            column(FrequencyDuration_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header"."Frequency/Duration")
            {
            }
            column(Status_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header".Status)
            {
            }
            column(Completed_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header".Completed)
            {
            }
            column(NextAppointmentDate_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header"."Next Appointment Date")
            {
            }
            column(No_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header"."No.")
            {
            }
            column(Type_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header".Type)
            {
            }
            column(PhysioDate_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header"."Physio Date")
            {
            }
            column(PhysioTime_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header"."Physio Time")
            {
            }
            column(PhysioUserID_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header"."Physio User ID")
            {
            }
            column(PhysioRemarks_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header"."Physio Remarks")
            {
            }
            column(PatientNo_HMSPhysiotheraphyFormHeader; "HMS Physiotheraphy Form Header"."Patient No.")
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
            dataitem("HMS Physio Evalution Form2"; "HMS Physio Evalution Form")
            {
                DataItemLink = "Physio No" = field("No.");
                DataItemTableView = where(Type = filter("Investigations & Findings"));
                column(ReportForNavId_59; 59)
                {
                }
                column(PhysioNo_HMSPhysioEvalutionForm2; "HMS Physio Evalution Form2"."Physio No")
                {
                }
                column(Type_HMSPhysioEvalutionForm2; "HMS Physio Evalution Form2".Type)
                {
                }
                column(SubType_HMSPhysioEvalutionForm2; "HMS Physio Evalution Form2".SubType)
                {
                }
                column(Description_HMSPhysioEvalutionForm2; "HMS Physio Evalution Form2".Description)
                {
                }
            }
            dataitem("HMS Physio Evalution Form"; "HMS Physio Evalution Form")
            {
                DataItemLink = "Physio No" = field("No.");
                DataItemTableView = where(Type = filter(Treatment));
                column(ReportForNavId_16; 16)
                {
                }
                column(PhysioNo_HMSPhysioEvalutionForm; "HMS Physio Evalution Form"."Physio No")
                {
                }
                column(Line_HMSPhysioEvalutionForm; "HMS Physio Evalution Form".Line)
                {
                }
                column(Type_HMSPhysioEvalutionForm; "HMS Physio Evalution Form".Type)
                {
                }
                column(SubType_HMSPhysioEvalutionForm; "HMS Physio Evalution Form".SubType)
                {
                }
                column(Description_HMSPhysioEvalutionForm; "HMS Physio Evalution Form".Description)
                {
                }
                column(PatientNo_HMSPhysioEvalutionForm; "HMS Physio Evalution Form"."Patient No")
                {
                }
            }
            dataitem("HMS Observation Signs"; "HMS Observation Signs")
            {
                DataItemLink = "Treatment No." = field("No.");
                column(ReportForNavId_54; 54)
                {
                }
                column(TreatmentNo_HMSObservationSigns; "HMS Observation Signs"."Treatment No.")
                {
                }
                column(SignCode_HMSObservationSigns; "HMS Observation Signs"."Sign Code")
                {
                }
                column(SignDescription_HMSObservationSigns; "HMS Observation Signs"."Sign Description")
                {
                }
                column(System_HMSObservationSigns; "HMS Observation Signs".System)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                TreatHD.Reset();
                TreatHD.SetRange(TreatHD."No.", "HMS Physiotheraphy Form Header"."No.");
                if TreatHD.Find('-') then begin
                    strNm := HMSCU.GetPatientName(TreatHD."Patient No.");
                    strAddress := HMSCU.GetPatientAddress(TreatHD."Patient No.");
                    strResident := HMSCU.GetPatientResidence(TreatHD."Patient No.");
                    strDateofBirth := HMSCU.GetPatientDOB(TreatHD."Patient No.");
                    //strDOA:=FORMAT() ;
                    strSex := HMSCU.GetPatientGender(TreatHD."Patient No.");
                    strTel := HMSCU.GetPatientTel(TreatHD."Patient No.");
                    strAge := HMSCU.GetPatientAge(TreatHD."Patient No.");
                    PatNo := TreatHD."Patient No.";
                end;

                HMSNotes.Reset();
                HMSNotes.SetRange(HMSNotes.TreatmentNo, "HMS Physiotheraphy Form Header"."No.");
                HMSNotes.SetRange(HMSNotes."Notes Type", HMSNotes."notes type"::"Patient History");
                if HMSNotes.Find('-') then
                    repeat
                        if i < 11 then begin
                            i := i + 1;
                            // TODO : Notes is a blob field. Need to refactor to use RichTextContent
                            // Nt[i] := HMSNotes.Notes
                        end;
                    until HMSNotes.Next() = 0;
                TreatmentFormProcess.Reset();
                TreatmentFormProcess.SetRange(TreatmentFormProcess."Treatment No.", "HMS Physiotheraphy Form Header"."No.");
                if TreatmentFormProcess.Find('-') then
                    repeat
                        if TreatmentFormProcess."Blood Pressure" <> '' then
                            PB := TreatmentFormProcess."Blood Pressure";
                        if TreatmentFormProcess.Temperature <> 0 then
                            Temp := format(TreatmentFormProcess.Temperature);
                        if TreatmentFormProcess."Pulse Rate" <> '' then
                            Pulse := TreatmentFormProcess."Pulse Rate";
                        if TreatmentFormProcess.Weight <> 0 then
                            Wt := format(TreatmentFormProcess.Weight);
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
        TreatHD: Record "HMS Physiotheraphy Form Header";
        TreatmentFormProcess: Record "HMS Treatment Form Process";
        HMSCU: Codeunit "HMS Patient-integration";
        O2: Code[20];
        PatNo: Code[20];
        PB: Code[20];
        Pulse: Code[20];
        Resp: Code[20];
        Temp: Code[20];
        Wt: Code[20];
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
