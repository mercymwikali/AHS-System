Query 52202496 "Admission List"
{
    OrderBy = descending(Admission_Date);

    elements
    {
        dataitem(HMS_Admission_Form_Header; "HMS Admission Form Header")
        {
            //DataItemTableFilter = Status=const(Admitted);
            column(Admission_No; "Admission No.")
            {
            }
            column(Admission_Date; "Admission Date")
            {
            }
            column(Admission_Time; "Admission Time")
            {
            }
            column(Admission_Area; "Admission Area")
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
            column(Ward; Ward)
            {
            }
            column(Bed; Bed)
            {
            }
            column(Doctor; Doctor)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(NextAppointmentComments; "Next Appointment Comments")
            {
            }

            column(Status; Status)
            {
            }
            column(Link_Type; "Link Type")
            {
            }
            column(Link_No; "Link No.")
            {
            }
            column(Admission_Reason; "Admission Reason")
            {
            }
            column(ID_Number; "ID Number")
            {
            }
            column(Counselling; Counselling)
            {
            }
            column(Counselling_Status; "Counselling Status")
            {
            }
            column(Branch; Branch)
            {
            }
            column(Age_in_Years; "Age in Years")
            {
            }
            column(Date_OF_Birth; "Date OF Birth")
            {
            }
            column(WardRoom; "Ward Room")
            {
            }
            column(DischargedDate; "Discharged Date")
            {
            }
            column(Cormobidities; Cormobidities)
            {
            }
            column(NextAppointmentDate; "Next Appointment Date")
            {
            }
            column(NextApointmentSlot; "Next Apointment Slot")
            {
            }
            column(NextAppointmentTime; "Next Appointment Time")
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
            column(PatientName; "Patient Name")
            {
            }
            column(SickOffEndDate; "Sick Off End Date")
            {
            }
            column(SickOffStartDate; "Sick Off Start Date")
            {
            }
            column(SearchName; "Search Name")
            {
            }
            column(Exists_In_Discharge; "Exists In Discharge")
            {
            }
            column(Final_Diagnosis;"Final Diagnosis")
            {                
            }
            column(Final_Diagnosis_Name;"Final Diagnosis Name")
            {                
            }
            column(CreatedBy; "Created By")
            {
            }
            column(DischargedBy; "Discharged By")
            {
            }
            column(ModifiedBy; "Modified By")
            {
            }
            column(isTranscription; isTranscription)
            {
            }
            column(TranscribedFileNo; "Transcribed File No")
            {
            }
            column(ClinicVisited; "Clinic Visited")
            {
            }

            column(Resident_Doctor;"Resident Doctor")
            {                
            }

            dataitem(HMS_Patient; "HMS Patient")
            {
                DataItemLink = "Patient No." = HMS_Admission_Form_Header."Patient No.";
                column(Search_Name; "Search Name")
                {
                }
                dataitem(HMS_Setup_Doctor; "HMS Setup Doctor")
                {
                    DataItemLink = "Doctor ID" = HMS_Admission_Form_Header.Doctor;
                    column(Doctors_Name; "Doctors Name")
                    {
                    }
                }
            }
        }
    }
}
