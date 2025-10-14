namespace HMISBC.HMISBC;

query 52202590 "Visitor Management"
{
    Caption = 'Visitor Management';
    QueryType = Normal;

    elements
    {
        dataitem(SecVisitorManagement; "Sec-Visitor Management")
        {
            column(ActionRecommended; "Action Recommended")
            {
            }
            column(ActionTaken; "Action Taken")
            {
            }
            column(CarRegNumber; "Car Reg. Number")
            {
            }
            column(ClearedBy; "Cleared By")
            {
            }
            column(ClearedByTime; "Cleared By Time")
            {
            }
            column(ClearedDate; "Cleared Date")
            {
            }
            column(CreatedDate; "Created Date")
            {
            }
            column(CreatedTime; "Created Time")
            {
            }
            column(Department; Department)
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(IDNumber; "ID Number")
            {
            }
            column(IncidentCategory; "Incident Category")
            {
            }
            column(IncidentDetails; "Incident Details")
            {
            }
            column(IncidentNumber; "Incident Number")
            {
            }
            column(IncidentReported; "Incident Reported")
            {
            }
            column(IncidentWitness; "Incident Witness")
            {
            }
            column(InitiatedBy; "Initiated By")
            {
            }
            column(InitiatedByTime; "Initiated By Time")
            {
            }
            column(InitiatedDate; "Initiated Date")
            {
            }
            column(No; No)
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(PersonToSee; "Person To See")
            {
            }
            column(PhoneNumber; "Phone Number")
            {
            }
            column(PurposeofVisit; "Purpose of Visit")
            {
            }
            column(Status; Status)
            {
            }
            column(Patient_No_; "Patient No.")
            {

            }
            column(VisitorCarRegNumber; "Visitor Car Reg Number")
            {
            }
            column(VisitorCategory; "Visitor Category")
            {
            }
            column(VisitorName; "Visitor Name")
            {
            }
            column(VisitorNumber; "Visitor Number")
            {
            }
            column(VisitorPassNo; "Visitor Pass No.")
            {
            }
            column(WitnessContacts; "Witness Contacts")
            {
            }
            column(WitnessID; "Witness ID")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(MiddleName; "Middle Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(ReasonForVisit; "Reason For Visit")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
