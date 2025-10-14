namespace PTL.HMISBC;

enum 52202446 "Transcription Encounter Type"
{
    Extensible = true;
    
    value(0; Outpatient)
    {
        Caption = 'Outpatient';
    }
    value(1; Inpatient)
    {
        Caption = 'Inpatient';
    }
}
