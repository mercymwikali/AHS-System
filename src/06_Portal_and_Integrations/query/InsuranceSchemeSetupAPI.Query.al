namespace PTL.HMIS;

query 85080 "Insurance Scheme Setup API"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';
    QueryType = API;
    
    elements
    {
        dataitem(insuranceSchemeSetup; "Insurance Scheme Setup")
        {
            column(insuranceCode; "Insurance Code")
            {
            }
            column(schemeName; "Scheme Name")
            {
            }
            column(lineNo; "Line No")
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
