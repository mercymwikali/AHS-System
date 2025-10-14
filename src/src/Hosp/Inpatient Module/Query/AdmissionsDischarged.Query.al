namespace PTL.HMIS;

query 52202626 "Admissions Discharged"
{
    APIGroup = 'hmis';
    APIPublisher = 'ptl';
    APIVersion = 'v1.0';
    EntityName = 'admissionHeader';
    EntitySetName = 'admissionHeader';
    QueryType = API;
    
    elements
    {
        dataitem(hmsAdmissionFormHeader; "HMS Admission Form Header")
        {
            DataItemTableFilter = Status = filter(Discharged);
            column(admissionNo; "Admission No.")
            {
            }
            column(admissionDate; "Admission Date")
            {
            }
            column(admissionTime; "Admission Time")
            {
            }
            column(admissionArea; "Admission Area")
            {
            }
            column(patientNo; "Patient No.")
            {
            }
            column(ward; Ward)
            {
            }
            column(bed; Bed)
            {
            }
            column(doctor; Doctor)
            {
            }
            column(status; Status)
            {
            }
            column(linkNo; "Link No.")
            {
            }
            column(admissionReason; "Admission Reason")
            {
            }
            column(existsInDischarge; "Exists In Discharge")
            {
            }
            column(expectedDateOfDischarge; "Expected Date of Discharge")
            {
            }
            column(diagnosisCode; "Diagnosis Code")
            {
            }
            column(wardRoom; "Ward Room")
            {
            }
            column(nextAppointmentDate; "Next Appointment Date")
            {
            }
            column(nextApointmentSlot; "Next Apointment Slot")
            {
            }
            column(nextAppointmentTime; "Next Appointment Time")
            {
            }
            column(finalDiagnosis; "Final Diagnosis")
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
