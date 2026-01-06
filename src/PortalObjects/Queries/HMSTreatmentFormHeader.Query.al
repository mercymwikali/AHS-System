namespace HMISBC.HMISBC;

query 52202599 "HMS Treatment Form Header"
{
    Caption = 'HMS Treatment Form Header';
    QueryType = Normal;

    elements
    {
        dataitem(HMSTreatmentFormHeader; "HMS Treatment Form Header")
        {
            column(Branch; Branch)
            {
            }
            column(Clinic; Clinic)
            {
            }
            column(ColorCode; "Color Code")
            {
            }
            column(Direct; Direct)
            {
            }
            column(DoctorID; "Doctor ID")
            {
            }
            column(DoctorNotes; "Doctor Notes")
            {
            }
            column(DoctorsName; "Doctor's Name")
            {
            }
            column(Email; Email)
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }
            column(InPatient; InPatient)
            {
            }
            column(InjectionStatus; "Injection Status")
            {
            }
            column(LabStatus; "Lab Status")
            {
            }
            column(LightDutyDays; "Light Duty Days")
            {
            }
            column(LinkNo; "Link No.")
            {
            }
            column(LinkType; "Link Type")
            {
            }
            column(NextAppointmentDate; "Next Appointment Date")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(ObservationNo; "Observation No")
            {
            }
            column(OffDuty; "Off Duty")
            {
            }
            column(OffDutyComments; "Off Duty Comments")
            {
            }
            column(OffDutyDays; "Off Duty Days")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(PatientName; "Patient Name")
            {
            }
            column(PharmacyStatus; "Pharmacy Status")
            {
            }
            column(RadiologyStatus; "Radiology Status")
            {
            }
            column(RelativeNo; "Relative No.")
            {
            }
            column(SickOffEndDate; "Sick Off End Date")
            {
            }
            column(SickOffStartDate; "Sick Off Start Date")
            {
            }
            column(SpecialClinics; "Special Clinics")
            {
            }
            column(Status; Status)
            {
            }
            column(StatusRemarks; "Status Remarks")
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(TreatmentDate; "Treatment Date")
            {
            }
            column(TreatmentLocation; "Treatment Location")
            {
            }
            column(TreatmentNo; "Treatment No.")
            {
            }
            column(TreatmentTime; "Treatment Time")
            {
            }
            column(TreatmentType; "Treatment Type")
            {
            }
            column(TriageNotes; "Triage Notes")
            {
            }
            column(NextAppointmentTime; "Next Appointment Time")
            {
            }
            column(isTherapy; isTherapy)
            {
            }
            column(UrgencyStatus; "Urgency Status")
            {
            }
            column(AppointmentNo; "Appointment No")
            {
            }
            column(AdmNo; "Adm No.")
            {
            }
            column(NextAppointmentComments; "Next Appointment Comments")
            {
            }
            column(TranscribedFileNo; "Transcribed File No")
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(ClinicVisited; "Clinic Visited")
            {
            }
            column(isTranscription; isTranscription)
            {
            }
            column(ModifiedBy; "Modified By")
            {
            }

            column(Resident_Doctor;"Resident Doctor")
            {
                
            }
            
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
