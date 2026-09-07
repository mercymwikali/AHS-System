Query 85132 Appointments
{
            QueryType =API;
            APIPublisher = 'AHS';
            APIGroup = 'HMS';
EntityName = 'HMSAppointmentFormHeader';
EntitySetName = 'Appointments';
    OrderBy = descending(Appointment_Date);


    elements
    {
        dataitem(HMS_Appointment_Form_Header; "HMS Appointment Form Header")
        {
            column(Appointment_No; "Appointment No.")
            {
            }
            column(Appointment_Date; "Appointment Date")
            {
            }
            column(Appointment_Time; "Appointment Time")
            {
            }
            column(Appointment_Type; "Appointment Type")
            {
            }
            column(Patient_Type; "Patient Type")
            {
            }
            column(Patient_No; "Patient No.")
            {
            }
            column(Employee_No; "Employee No.")
            {
            }
            column(Relative_No; "Relative No.")
            {
            }
            column(Doctor; Doctor)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Status; Status)
            {
            }
            column(ReAppointment_No; "ReAppointment No.")
            {
            }
            column(ReAppointment_Date; "ReAppointment Date")
            {
            }
            column(ReAppointment_Time; "ReAppointment Time")
            {
            }
            column(ReAppointment_Type_Code; "ReAppointment Type Code")
            {
            }
            column(ReAppointment_Doctor_ID; "ReAppointment Doctor ID")
            {
            }
            column(Settlement_Type; "Settlement Type")
            {
            }
            column(Treatment_Status; "Treatment Status")
            {
            }
            column(User_ID; "User ID")
            {
            }
            column(Membership_No; "Membership No")
            {
            }
            column(Insurance_Name; "Insurance Name")
            {
            }
            column(Insurance_No; "Insurance No")
            {
            }
            column(Dispatch_To; "Dispatch To")
            {
            }
            column(Dispatch_Date; "Dispatch Date")
            {
            }
            column(Dispatch_Time; "Dispatch Time")
            {
            }
            column(Insurance_Member_No; "Insurance Member No")
            {
            }
            column(AdmNo; "Adm No.")
            {
            }
            column(AgeinYears; "Age in Years")
            {
            }
            column(AppTemp; "App Temp")
            {
            }
            column(Appointmentcount; "Appointment count")
            {
            }
            column(BookedBy; "Booked By")
            {
            }
            column(Branch; Branch)
            {
            }
            column(Chargescount; "Charges count")
            {
            }
            column(ConsultationAmount; "Consultation Amount")
            {
            }
            column(DoctorAppointmentcount; "Doctor Appointment count")
            {
            }
            column(DoctorLastAppointmentDate; "Doctor Last Appointment Date")
            {
            }
            column(DoctorName; "Doctor Name")
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
            column(Gender; Gender)
            {
            }
            column(GlobalDimension1; "Global Dimension 1")
            {
            }
            column(ImagingTimeIn; "Imaging Time In")
            {
            }
            column(ImagingTimeOut; "Imaging Time Out")
            {
            }
            column(InsuranceLOUAmount; "Insurance LOU Amount")
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
            column(Invoicecount; "Invoice count")
            {
            }
            column(InvoinceNo; "Invoince No")
            {
            }
            column(LabTimeIn; "Lab Time In")
            {
            }
            column(LabTimeOut; "Lab Time Out")
            {
            }
            column(LaboratoryAmount; "Laboratory Amount")
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
            column(NHIFProcedureCode; "NHIF Procedure Code")
            {
            }       
            column(ObservationAmount; "Observation Amount")
            {
            }
            column(PatientCategory; "Patient Category")
            {
            }
            column(PatientNames; "Patient Names")
            {
            }
            column(PatientTypeLk; "Patient Type Lk")
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
            column(Pharmacycount; "Pharmacy count")
            {
            }
            column(PhoneNo; "Phone No")
            {
            }
            column(Physio; Physio)
            {
            }
            column(PhysioAmount; "Physio Amount")
            {
            }
            column(PostedInvoiceNo; "Posted Invoice No")
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
            column(SearchNames; SearchNames)
            {
            }
            column(SmarkLinkBalance; "SmarkLink Balance")
            {
            }
            column(SpecialClinics; "Special Clinics")
            {
            }
           
           
            column(SystemId; SystemId)
            {
            }
           
            column(TelephoneNo; "Telephone No.")
            {
            }
            column(TherapyTimeIn; "Therapy Time In")
            {
            }
            column("Time"; "Time")
            {
            }
            
            column(TranscribedBy; "Transcribed By")
            {
            }
            column(TranscribedDate; "Transcribed Date")
            {
            }
            column(TreatmentNo; "Treatment No")
            {
            }
            column(TriageTimeIn; "Triage Time In")
            {
            }
            column(TriageTimeout; "Triage Time out")
            {
            }
            
            column(WaitingAt; "Waiting At")
            {
            }
            
            column(isTherapy; isTherapy)
            {
            }
            column(isTranscription; isTranscription)
            {
            }
            column(OTPRecordedDate; "OTP Recorded Date")
            {
            }
            column(SHAAuthorizationCode; "SHA Authorization Code")
            {
            }
            column(SHAAuthorizationStatus; "SHA Authorization Status")
            {
            }
            column(SHAClaimStatus; "SHA Claim Status")
            {
            }
            column(SHAAuthorizationGUID; "SHA Authorization GUID")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(SHAAuthorizationID; "SHA Authorization ID")
            {
            }
            column(SHAInvoiceID; "SHA Invoice ID")
            {
            }
            column(SHAInvoiceNumber; "SHA Invoice Number")
            {
            }
            column(SHASchemeCode; "SHA Scheme Code")
            {
            }
            column(SHASchemeName; "SHA Scheme Name")
            {
            }
            column(SHAServiceType; "SHA Service Type")
            {
            }
            column(SHAVisitID; "SHA Visit ID")
            {
            }
            column(SHAVisitNumber; "SHA Visit Number")
            {
            }
           
            column(SHAVisitStart; "SHA Visit Start")
            {
            }
            column(SHAPatientCRID; "SHA Patient CR ID")
            {
            }
            
            // dataitem(HMS_Patient; "HMS Patient")
            // {
            //     DataItemLink = "Patient No." = HMS_Appointment_Form_Header."Patient No.";
            //     column(Surname; Surname)
            //     {
            //     }
            //     column(Middle_Name; "Middle Name")
            //     {
            //     }
            //     column(Last_Name; "Last Name")
            //     {
            //     }
            //     column(Search_Name; "Search Name")
            //     {
            //     }
            //     column(Names; Names)
            //     {
            //     }
            // }
        }
    }
}
