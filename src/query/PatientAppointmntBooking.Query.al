namespace PTL.HMIS;

query 85084 "Patient Appointmnt Booking"
{
    Caption = 'Patient Appointmnt Booking';
    QueryType = Normal;
    
    elements
    {
        dataitem(HMSPatientAppointmntBookng; "HMS Patient Appointmnt Bookng")
        {
            column(AppointmentBookingNo; "Appointment Booking No")
            {
            }
            column(AppointmentDate; "Appointment Date")
            {
            }
            column(AppointmentTime; "Appointment Time")
            {
            }
            column(PatientNo; "Patient No")
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
            column(SearchName; "Search Name")
            {
            }
            column(DoctorID; "Doctor ID")
            {
            }
            column(DoctorsName; "Doctors Name")
            {
            }
            column(AppointmentType; "Appointment Type")
            {
            }
            column(AppointmentReason; "Appointment Reason")
            {
            }
            column(ApppointmentRemarks; "Apppointment Remarks")
            {
            }
            column(TCADate; "TCA Date")
            {
            }
            column(TCATime; "TCA Time")
            {
            }
            column(VisitNo; "Visit No")
            {
            }
            column(TreatmentNo; "Treatment No")
            {
            }
            column(BookedBy; "Booked By")
            {
            }
            column(BookedDate; "Booked Date")
            {
            }
            column(BookedTime; "Booked Time")
            {
            }
            column(Status; Status)
            {
            }
            column(Notified; Notified)
            {
            }
            column(NotifiedDate; "Notified Date")
            {
            }
            column(TelephoneNo; "Telephone No")
            {
            }
            column(TherapySession; "Therapy Session")
            {
            }
            column(TherapyType; "Therapy Type")
            {
            }
            column(DialysisMachineName; "Dialysis Machine Name")
            {
            }
            column(Branch; Branch)
            {
            }
            column(Section; Section)
            {
            }
            column(Ward; Ward)
            {
            }
            column(Bed; Bed)
            {
            }
            column(BookedSessions; "Booked Sessions")
            {
            }
            column(AppointmentSlot; "Appointment Slot")
            {
            }
            column(Reminder; Reminder)
            {
            }
            column(ReminderUnit; "Reminder Unit")
            {
            }
            column(NotificationOption; "Notification Option")
            {
            }
            column(SourceNo; "Source No")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
