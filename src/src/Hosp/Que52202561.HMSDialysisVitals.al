query 52202561 "HMS Dialysis Vitals"
{
    Caption = 'HMS Dialysis Vitals';
    QueryType = Normal;

    elements
    {
        dataitem(HMSDialysisVitals; "HMS Dialysis Vitals")
        {
            column(ArtP; "Art P")
            {
            }
            column(BloodPressure; "Blood Pressure")
            {
            }
            column(Cond; Cond)
            {
            }
            column(DialysisNo; "Dialysis No")
            {
            }
            column(Heparin; Heparin)
            {
            }
            column(LineNo; "Line No")
            {
            }
            column(ObservationDate; "Observation Date")
            {
            }
            column(ObservationTime; "Observation Time")
            {
            }
            column(PSpeed; "P Speed")
            {
            }
            column(PatientNo; "Patient No")
            {
            }
            column(PulseRate; "Pulse Rate")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Temp; Temp)
            {
            }
            column(TreatmentNo; "Treatment No")
            {
            }
            column(UFRate; "UF Rate")
            {
            }
            column(UFVol; "UF Vol")
            {
            }
            column(VenP; "Ven P")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}
