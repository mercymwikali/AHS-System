namespace HMISBC.HMISBC;

query 52202643 "HMS Lab Setup"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'HMSSetupLabTest';
    EntitySetName = 'HMSSetupLabTest';
    QueryType = API;
    
    elements
    {
        dataitem(hmsSetupLabTest; "HMS Setup Lab Test")
        {
            column(amount; Amount)
            {
            }
            column("code"; "Code")
            {
            }
            column(department; Department)
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
            column(measurementProc; MeasurementProc)
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
