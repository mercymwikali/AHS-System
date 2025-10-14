namespace PTL.Hospital;

report 52202693 "Validate patient name"
{
    ApplicationArea = All;
    Caption = 'Validate patient name';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(HMSPatient; "HMS Patient")
        {
            column(PatientNo; "Patient No.")
            {
            }
            column(Surname; Surname)
            {
            }
            column(MiddleName; "Middle Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            trigger OnAfterGetRecord()
            var
                HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
                HMSObservationFormHeader: Record "HMS Observation Form Header";
                HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
            begin
                HMSAppointmentFormHeader.Reset();
                HMSAppointmentFormHeader.SetRange("Patient No.", HMSPatient."Patient No.");
                if HMSAppointmentFormHeader.FindSet() then
                    repeat
                        HMSAppointmentFormHeader.Validate("Patient No.");
                        HMSAppointmentFormHeader.Modify();
                    until HMSAppointmentFormHeader.next = 0;
                    
                HMSTreatmentFormHeader.Reset();
                HMSTreatmentFormHeader.SetRange("Patient No.", HMSPatient."Patient No.");
                if HMSTreatmentFormHeader.FindSet() then
                    repeat
                        HMSTreatmentFormHeader.Validate("Patient No.");
                        HMSTreatmentFormHeader.Modify();
                    until HMSTreatmentFormHeader.next = 0;

                HMSObservationFormHeader.Reset();
                HMSObservationFormHeader.SetRange("Patient No.", HMSPatient."Patient No.");
                if HMSObservationFormHeader.FindSet() then
                    repeat
                        HMSObservationFormHeader.Validate("Patient No.");
                        HMSObservationFormHeader.Modify();
                    until HMSObservationFormHeader.next = 0;


            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
