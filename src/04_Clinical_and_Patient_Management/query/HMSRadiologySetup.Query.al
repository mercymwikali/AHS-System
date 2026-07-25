namespace HMISBC.HMISBC;

query 85011 "HMS Radiology  Setup "
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'HMSSetupRadiologyType';
    EntitySetName = 'HMSSetupRadiologyType';
    QueryType = API;
    
    elements
    {
        dataitem(hmsSetupRadiologyType; "HMS Setup Radiology Type")
        {
            column(amount; Amount)
            {
            }
            column("code"; "Code")
            {
            }
            column(description; Description)
            {
            }
            column(gLAccount; "G/L Account")
            {
            }
            column(insuranceAmount; "Insurance Amount")
            {
            }
            column(radiologySection; "Radiology Section")
            {
            }
            column(systemId; SystemId)
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
