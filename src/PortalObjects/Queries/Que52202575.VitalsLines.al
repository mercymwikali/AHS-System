namespace HMISBC.HMISBC;

query 52202575 "Vitals Lines"
{
    Caption = 'Vitals Lines';
    QueryType = Normal;

    elements
    {
        dataitem(HMSObservationFormLineProc; "HMS Observation Form Line Proc")
        {
            column(BMI; BMI)
            {
            }
            column(BloodPressure; "Blood Pressure")
            {
            }
            column(DateCreated; "Date Created")
            {
            }
            column(DateTaken; "Date Taken")
            {
            }
            column(Height; Height)
            {
            }
            column(LineNo; "Line No")
            {
            }
            column(ObservationNo; "Observation No.")
            {
            }
            column(Pain; Pain)
            {
            }
            column(PatientName; "Patient Name")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(PulseRate; "Pulse Rate")
            {
            }
            column(RespirationRate; "Respiration Rate")
            {
            }
            column(SP02; SP02)
            {
            }
            column(Temperature; Temperature)
            {
            }
            column("Time"; "Time")
            {
            }
            column("Type"; "Type")
            {
            }
            column(UniqueId; UniqueId)
            {
            }
            column(SystolicBp; "Systolic Bp")
            {
            }
            column(DiastolicBp; "Diastolic Bp")
            {
            }

            column(Weight; Weight)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
