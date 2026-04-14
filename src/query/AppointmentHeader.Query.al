namespace HMISBC.HMISBC;

query 85019 "Appointment Header"
{
    Caption = 'Appointment Header';
    QueryType = Normal;

    elements
    {
        dataitem(HMSAppointmentFormHeader; "HMS Appointment Form Header")
        {
            column(GlobalDimension1; "Global Dimension 1")
            {
            }
            column(InsuranceName; "Insurance Name")
            {
            }
            column(InvoinceNo; "Invoince No")
            {
            }
            column(MembershipNo; "Membership No")
            {
            }
            column(visitType; visitType)
            {
            }
            column(isTherapy; isTherapy)
            {
            }
            column(TotalBilled; "Total Billed")
            {
            }
            column(TotalReceipts; "Total Receipts")
            {
            }

            column(AgeinYears; "Age in Years")
            {
            }
            column(AppTemp; "App Temp")
            {
            }
            column(AppointmentDate; "Appointment Date")
            {
            }
            column(AppointmentNo; "Appointment No.")
            {
            }
            column(AppointmentTime; "Appointment Time")
            {
            }
            column(AppointmentType; "Appointment Type")
            {
            }
            column(BookedBy; "Booked By")
            {
            }
            column(Branch; Branch)
            {
            }
            column(DispatchDate; "Dispatch Date")
            {
            }
            column(DispatchTime; "Dispatch Time")
            {
            }
            column(DispatchTo; "Dispatch To")
            {
            }
            column(Doctor; Doctor)
            {
            }
            column(DoctorTimeIn; "Doctor Time In")
            {
            }
            column(DoctorTimeOut; "Doctor Time Out")
            {
            }
            column(DoctorsName; "Doctors Name")
            {
            }
            column(Emergency; Emergency)
            {
            }
            column(EmployeeNo; "Employee No.")
            {
            }
            column(Gender; Gender)
            {
            }
            column(ImagingTimeIn; "Imaging Time In")
            {
            }
            column(ImagingTimeOut; "Imaging Time Out")
            {
            }
            column(InsuranceMemberNo; "Insurance Member No")
            {
            }
            column(InsuranceNo; "Insurance No")
            {
            }
            column(InvoiceCount; "Invoice Count")
            {
            }
            column(InvoiceNo; "Invoice No")
            {
            }
            column(InvoicePosted; "Invoice Posted")
            {
            }
            column(InvoicePostedBy; "Invoice Posted By")
            {
            }
            column(InvoicePostedOn; "Invoice Posted On")
            {
            }
            column(LabTimeIn; "Lab Time In")
            {
            }
            column(LabTimeOut; "Lab Time Out")
            {
            }
            column(LinkNo; "Link No")
            {
            }
            column(MVCNo; "MVC No.")
            {
            }
            column(Minor; Minor)
            {
            }
            column(NHIFLOUAmount; "Insurance LOU Amount")
            {
            }
            column(NHIFProcedureCode; "NHIF Procedure Code")
            {
            }
            column(Names; Names)
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(PatientCategory; "Patient Category")
            {
            }
            column(PatientNames; "Patient Names")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(PatientType; "Patient Type")
            {
            }
            column(PendingInvoice; "Pending Invoice")
            {
            }
            column(PharmacyAmount; "Pharmacy Amount")
            {
            }
            column(PharmacyTimeIn; "Pharmacy Time In")
            {
            }
            column(PharmacyTimeOut; "Pharmacy Time Out")
            {
            }
            column(PhoneNo; "Phone No")
            {
            }
            column(Physio; Physio)
            {
            }
            column(ReOpened; "Re-Opened")
            {
            }
            column(ReOpenedDate; "Re-Opened Date")
            {
            }
            column(ReOpenedUserID; "Re-Opened UserID")
            {
            }
            column(ReAppointmentDate; "ReAppointment Date")
            {
            }
            column(ReAppointmentDoctorID; "ReAppointment Doctor ID")
            {
            }
            column(ReAppointmentNo; "ReAppointment No.")
            {
            }
            column(ReAppointmentTime; "ReAppointment Time")
            {
            }
            column(ReAppointmentTypeCode; "ReAppointment Type Code")
            {
            }
            column(RelativeNo; "Relative No.")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(SearchNames; SearchNames)
            {
            }
            column(SettlementType; "Settlement Type")
            {
            }
            column(SmarkLinkBalance; "SmarkLink Balance")
            {
            }
            column(SpecialClinics; "Special Clinics")
            {
            }
            column(Status; Status)
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column("Time"; "Time")
            {
            }
            column(TriageTimeIn; "Triage Time In")
            {
            }
            column(TriageTimeout; "Triage Time out")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(WaitingAt; "Waiting At")
            {
            }
            column(imported; imported)
            {
            }
            column(Adm_No;"Adm No.")    
            {
            }
            
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
