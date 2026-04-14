query 85224 Therapy
{
    Caption = 'Therapy';
    QueryType = Normal;

    elements
    {
        dataitem(HMSTherapyFormHeader; "HMS Therapy Form Header")
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
            column(TherapyDate; "Therapy Date")
            {
            }
            column(Therapy_Type; "Therapy Type")
            {
            }
            column(Therapy_Description; "Therapy Description")
            {
            }
            column(TherapyNotes; "Therapy Notes")
            {
            }
            column(TherapyRemarks; "Therapy Remarks")
            {
            }
            column(TherapySession; "Therapy Session")
            {
            }
            column(TherapyTime; "Therapy Time")
            {
            }
            column(TherapyUserID; "Therapy User ID")
            {
            }
            column(Doctor; Doctor)
            {
            }
            column(EmployeeNo; "Employee No.")
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
            column(No; "Treatment No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(PatientNo; "Patient No.")
            {
            }
            column(RelativeNo; "Relative No.")
            {
            }
            column(Search_Name; Search_Name)
            {
            }
            column(Status; Status)
            {
            }
            column(StudentNo; "Student No.")
            {
            }
            column(TreatmentNotes; "Treatment Notes")
            {
            }
            column("Type"; "Type")
            {
            }
            column(Treatment_No_; "Treatment No.")
            {
            }
            dataitem(HMS_Patient; "HMS Patient")
            {
                DataItemLink = "Patient No." = HMSTherapyFormHeader."Patient No.";
                column(Search_Names; "Search Name")
                {
                }
                column(Patient_Type; "Patient Type")
                {
                }
                column(Insurance_No_; "Insurance No.")
                {
                }
                column(Insurance_Name; "Insurance Name")
                {
                }
                column(Scheme_Name; "Scheme Name")
                {
                }
                column(Date_Of_Birth; "Date Of Birth")
                {
                }
                column(Age_in_Years; "Age in Years")
                {
                }
                column(Gender; Gender)
                {
                }
                column(ID_Number; "ID Number")
                {
                }
                column(CurrentAdmNo; "Current Adm No")
                {
                }
                dataitem(HMS_Setup_Doctor; "HMS Setup Doctor")
                {
                    DataItemLink = "Doctor ID" = HMSTherapyFormHeader.Doctor;
                    column(Doctors_Name; "Doctors Name")
                    {
                    }
                }
            }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}
