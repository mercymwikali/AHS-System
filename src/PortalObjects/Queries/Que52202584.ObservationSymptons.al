namespace HMISBC.HMISBC;

query 52202584 "HMS Observation Symptoms"
{
    Caption = 'Observation Symptoms';
    QueryType = Normal;

    elements
    {
        dataitem(HMSObservationSymptoms; "HMS Observation Symptoms")
        {
            column(Characteristics; Characteristics)
            {
            }
            column(DateTaken; "Date Taken")
            {
            }
            column(Description; Description)
            {
            }
            column("Duration"; "Duration")
            {
            }
            column(SymptomCode; "Symptom Code")
            {
            }
            column(SymptomDescription; "Symptom Description")
            {
            }
            column(System; System)
            {
            }
            column(TreatmentNo; "Treatment No.")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
