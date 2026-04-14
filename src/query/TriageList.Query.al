namespace HMISBC.HMISBC;

query 85028 "Triage List"
{
    Caption = 'Triage List';
    QueryType = Normal;

    elements
    {
        dataitem(HMSObservationFormHeader; "HMS Observation Form Header")
        {

            column(Branch; Branch)
            {
            }
            column(Closed; Closed)
            {
            }
            column(Completed; Completed)
            {
            }
            column(Doctor; Doctor)
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }
            column(InPatient; InPatient)
            {
            }
            column(LinkNo; "Link No.")
            {
            }
            column(LinkType; "Link Type")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(ObservationDate; "Observation Date")
            {
            }
            column(ObservationNo; "Observation No.")
            {
            }
            column(ObservationRemarks; "Observation Remarks")
            {
            }
            column(ObservationRemarks2; "Observation Remarks2")
            {
            }
            column(ObservationTime; "Observation Time")
            {
            }
            column(ObservationType; "Observation Type")
            {
            }
            column(ObservationUserID; "Observation User ID")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(Physio; Physio)
            {
            }
            column(RelativeNo; "Relative No.")
            {
            }
            column(SpecialClinics; "Special Clinics")
            {
            }
            column(Status; Status)
            {
            }
            column(StatusRemarks; "TCA Status Remarks")
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(TreatmentNo; "Treatment No")
            {
            }
            column(UrgencyStatus; "Urgency Status")
            {
            }
            column(Names;Names)
            {        
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
