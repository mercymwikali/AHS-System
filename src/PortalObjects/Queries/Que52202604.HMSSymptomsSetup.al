namespace HMISBC.HMISBC;

query 52202604 "HMS Symptoms Setup"
{
    Caption = 'HMS Symptoms Setup';
    QueryType = Normal;

    elements
    {
        dataitem(HMSSymptomsSetup; "HMS Symptoms Setup")
        {
            column(SymptomName; "Symptom Name")
            {
            }
            column(SymptomCode; "Syptom Code")
            {
            }
            column(Treatmentno; "Treatment no")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
