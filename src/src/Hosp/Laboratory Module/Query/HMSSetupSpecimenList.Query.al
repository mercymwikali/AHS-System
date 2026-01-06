namespace HMISBC.HMISBC;

query 52202646 "HMS Setup Specimen List"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Legacies';
    APIVersion = 'v1.0';
    EntityName = 'HMSSetupSpecimen';
    EntitySetName = 'HMSSetupSpecimen';
    QueryType = API;
    
    elements
    {
        dataitem(hmsSetupSpecimen; "HMS Setup Specimen")
        {
            column("code"; "Code")
            {
            }
            column(description; Description)
            {
            }
            column(desirableLevel; "Desirable level")
            {
            }
            column(highRisk; "High Risk")
            {
            }
            column(maxRange; "Max Range")
            {
            }
            column(minRange; "Min Range")
            {
            }
            column(normalRanges; "Normal Ranges")
            {
            }
            column(resultType; "Result Type")
            {
            }
            column(systemId; SystemId)
            {
            }
            column(units; Units)
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
