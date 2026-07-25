namespace HospitalSystem.HospitalSystem;

query 85225 HMSCarePlan
{
    APIGroup = 'apiGroup';
    APIPublisher = 'publisherName';
    APIVersion = 'v1.0';
    EntityName = 'entityName';
    EntitySetName = 'entitySetName';
    QueryType = API;
    
    elements
    {
        dataitem(nursingCarePlan; "Nursing Care Plan")
        {
            column(admissionNo; "Admission No.")
            {
            }
            column(createdBy; "Created By")
            {
            }
            column(dateTaken; "Date Taken")
            {
            }
            column(evaluation; Evaluation)
            {
            }
            column(implementation; Implementation)
            {
            }
            column(nursingDiagnosis; "Nursing Diagnosis")
            {
            }
            column(patientName; "Patient Name")
            {
            }
            column(patientNo; "Patient No.")
            {
            }
            column(physicalAssessmetMSA; "Physical Assessmet(MSA)")
            {
            }
            column(plan; Plan)
            {
            }
            column(rationale; Rationale)
            {
            }
            column(staffName; StaffName)
            {
            }
            column(systemId; SystemId)
            {
            }
            column(timeTaken; "Time Taken")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
