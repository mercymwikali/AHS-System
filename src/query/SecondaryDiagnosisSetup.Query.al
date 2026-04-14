namespace HMISBC.HMISBC;

query 85069 "Secondary Diagnosis Setup"
{
    Caption = 'Secondary Diagnosis Setup';
    QueryType = Normal;
    
    elements
    {
        dataitem(HMSSecondaryDiagnosisSetup; "HMS Secondary Diagnosis Setup")
        {
            column(Description; Description)
            {
            }
            column(Diagnosis; Diagnosis)
            {
            }
            column(DiagnosisCode; "Diagnosis Code")
            {
            }
            column(FemaleCounter; "Female Counter")
            {
            }
            column(MOHCode; "MOH Code")
            {
            }
            column(MOHDescription; "MOH Description")
            {
            }
            column(MaleCounter; "Male Counter")
            {
            }
            column(SystemId; SystemId)
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
