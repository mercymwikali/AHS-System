namespace HMISBC.HMISBC;

query 52202645 "Treatment Laboratory Lines"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'HMSTreatmentFormLaboratory';
    EntitySetName = 'HMSTreatmentFormLaboratory';
    QueryType = API;
    
    elements
    {
        dataitem(hmsTreatmentFormLaboratory; "HMS Treatment Form Laboratory")
        {
            column(branch; Branch)
            {
            }
            column(briefHistory; "Brief History")
            {
            }
            column(dateDue; "Date Due")
            {
            }
            column(dateTaken; "Date Taken")
            {
            }
            column(diagnosis; Diagnosis)
            {
            }
            column(labNo; "Lab No")
            {
            }
            column(laboratoryTestPackageCode; "Laboratory Test Package Code")
            {
            }
            column(laboratoryTestPackageName; "Laboratory Test Package Name")
            {
            }
            column(lineNo; "Line No")
            {
            }
            column(results; Results)
            {
            }
            column(specimen; Specimen)
            {
            }
            column(status; Status)
            {
            }
            column(systemId; SystemId)
            {
            }
            column(test; Test)
            {
            }
            column("time"; "Time")
            {
            }
            column(treatmentNo; "Treatment No.")
            {
            }
            column(uuid; UUID)
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
