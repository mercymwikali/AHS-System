report 85168 "HMS HaemoDialysis Chart"
{
    Caption = 'HMS HaemoDialysis Chart';
    dataset
    {
        dataitem(DialysisPatientInfo; "Dialysis Patient Info")
        {
            column(Access; Access)
            {
            }
            column(BP; BP)
            {
            }
            column(Bicarbonate; Bicarbonate)
            {
            }
            column(Calcium; Calcium)
            {
            }
            column(Clinic; Clinic)
            {
            }
            column(Conductivity; Conductivity)
            {
            }
            column(CreatedDate; "Created Date")
            {
            }
            column(CreationTime; "Creation Time")
            {
            }
            column(Dialysate; Dialysate)
            {
            }
            column(DialysisEndTime; "Dialysis End Time")
            {
            }
            column(DialysisHours; "Dialysis Hours")
            {
            }
            column(DialysisStartTime; "Dialysis Start Time")
            {
            }
            column(Dialyzer; Dialyzer)
            {
            }
            column(HR; HR)
            {
            }
            column(Height; Height)
            {
            }
            column(HeparinLD; "Heparin LD")
            {
            }
            column(HeparinMD; "Heparin MD")
            {
            }
            column(KV; "K+V")
            {
            }
            column(LineNo; LineNo)
            {
            }
            column(Notes; Notes)
            {
            }
            column(NotesType; "Notes Type")
            {
            }
            column(NurseCommencingDialysis; "Nurse Commencing Dialysis")
            {
            }
            column(NurseDisconnectingDialysis; "Nurse Disconnecting Dialysis")
            {
            }
            column(PatientNo; PatientNo)
            {
            }
            column(PostDialysisBp; "Post Dialysis Bp")
            {
            }
            column(PostDialysisHR; "Post Dialysis HR")
            {
            }
            column(PostDialysisWeight; "Post Dialysis Weight")
            {
            }
            column(Potassium; Potassium)
            {
            }
            column(PreDialysisWeight; "Pre-Dialysis Weight")
            {
            }
            column(Sodium; Sodium)
            {
            }
            column(TreatmentDate; "Treatment Date")
            {
            }
            column(TreatmentTime; "Treatment Time")
            {
            }
            column(TreatmentNo; TreatmentNo)
            {
            }
            column(UFSet; "UF Set")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(WeightGain; "Weight Gain")
            {
            }
            column(AcidConc_DialysisPatientInfo; "Acid Conc")
            {
            }
            column(Bolus_DialysisPatientInfo; Bolus)
            {
            }
            column(BolusRate_DialysisPatientInfo; "Bolus Rate")
            {
            }
            column(Cannulla_DialysisPatientInfo; Cannulla)
            {
            }
            column(UFGoal_DialysisPatientInfo; "UF Goal")
            {
            }
            column(PreviousWeight_DialysisPatientInfo; "Previous Weight")
            {
            }
            column(patName; patName)
            { }
            column(Ward; Ward)
            { }
            column(Nurse; Nurse)
            { }
            column(Nurse2; Nurse2)
            { }
            column(Condition; Condition)
            {
            }
            dataitem("HMS Dialysis Vitals"; "HMS Dialysis Vitals")
            {
                DataItemLink = "Treatment No" = field(TreatmentNo);
                column(ArtP_HMSDialysisVitals; "Art P")
                {
                }
                column(BloodPressure_HMSDialysisVitals; "Blood Pressure")
                {
                }
                column(Cond_HMSDialysisVitals; Cond)
                {
                }
                column(DialysisNo_HMSDialysisVitals; "Dialysis No")
                {
                }
                column(Heparin_HMSDialysisVitals; Heparin)
                {
                }
                column(LineNo_HMSDialysisVitals; "Line No")
                {
                }
                column(ObservationDate_HMSDialysisVitals; "Observation Date")
                {
                }
                column(ObservationTime_HMSDialysisVitals; "Observation Time")
                {
                }
                column(PSpeed_HMSDialysisVitals; "P Speed")
                {
                }
                column(PatientNo_HMSDialysisVitals; "Patient No")
                {
                }
                column(PulseRate_HMSDialysisVitals; "Pulse Rate")
                {
                }
                column(Remarks_HMSDialysisVitals; Remarks)
                {
                }
                column(Temp_HMSDialysisVitals; Temp)
                {
                }
                column(TreatmentNo_HMSDialysisVitals; "Treatment No")
                {
                }
                column(UFRate_HMSDialysisVitals; "UF Rate")
                {
                }
                column(UFVol_HMSDialysisVitals; "UF Vol")
                {
                }
                column(VenP_HMSDialysisVitals; "Ven P")
                {
                }
            }
            trigger
             OnAfterGetRecord()
            begin
                if Hmspat.Get(DialysisPatientInfo.PatientNo) then
                    patName := Hmspat."Search Name";
                Age := Hmspat."Age in Years";
                if HRemp.Get(DialysisPatientInfo."Nurse Commencing Dialysis") then
                    Nurse := HRemp."Search Name";
                if HRemp.Get(DialysisPatientInfo."Nurse Disconnecting Dialysis") then
                    Nurse2 := HRemp."Search Name";
                Disch.Reset();
                Disch.SetRange(Disch."Admission No", DialysisPatientInfo.TreatmentNo);
                if Disch.Find('-') then
                    Condition := Disch."Patient Condition";
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        Disch: Record "HMS Discharge Summary";
        Hmspat: Record "HMS Patient";
        HRemp: Record "HR-Employee";
        Age: Integer;
        Condition: Text;
        Nurse: Text;
        Nurse2: Text;
        patName: Text;
        Ward: Text;
}
