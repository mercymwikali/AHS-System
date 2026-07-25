Query 85202 "Theatre List"
{
    OrderBy = descending(Theatre_Date), descending(Theatre_Time);

    elements
    {
        dataitem(HMS_Theatre_Form_Header; "HMS Theatre Form Header")
        {
            column(No; "No.")
            {
            }
            column(Type; Type)
            {
            }
            column(Theatre_Date; "Theatre Date")
            {
            }
            column(Theatre_Time; "Theatre Time")
            {
            }
            column(Surgery_Code; "Surgery Code")
            {
            }
            column(Surgery; Surgery)
            {
            }
            column(Patient_No; "Patient No.")
            {
            }
            column(Student_No; "Student No.")
            {
            }
            column(Employee_No; "Employee No.")
            {
            }
            column(Relative_No; "Relative No.")
            {
            }
            column(Link_Type; "Link Type")
            {
            }
            column(Link_No; "Link No.")
            {
            }
            column(No_Series; "No. Series")
            {
            }
            column(Closed; Closed)
            {
            }
            column(Status; Status)
            {
            }
            column(Completed; Completed)
            {
            }
            column(Next_Appointment_Date; "Next Appointment Date")
            {
            }
            column(Surname_Name; "Surname Name")
            {
            }
            column(Last_Name; "Last Name")
            {
            }
            column(ADM_No; "ADM No")
            {
            }
            column(Surgeon_Notes; "Surgeon Notes")
            {
            }
            column(Operation_Notes; "Operation Notes")
            {
            }
            column(Nurse_Notes; "Nurse Notes")
            {
            }
            column(Treatment_Notes; "Treatment Notes")
            {
            }
            column(Doctor_ID; "Doctor ID")
            {
            }
            column(Circulating_Nurse_ID; "Circulating Nurse ID")
            {
            }
            column(Anaesthetist_ID; "Anaesthetist ID")
            {
            }
            column(Instructions; Instructions)
            {
            }
            column(Scrub_Nurse; "Scrub Nurse")
            {
            }
            column(Pre_op_Diagnosis; "Pre-op Diagnosis")
            {
            }
            column(Post_op_Diagnosis; "Post-op Diagnosis")
            {
            }
            column(Theatre_Procedure; "Theatre Procedure")
            {
            }
            column(Start_Time; "Start Time")
            {
            }
            column(End_Time; "End Time")
            {
            }
            column(Theatre_Assistant; "Theatre Assistant")
            {
            }
            column(Incision; Incision)
            {
            }
            column(Estimated_Blood_Loss; "Estimated Blood Loss")
            {
            }
            column(Anaesthesia; Anaesthesia)
            {
            }
            column(Anaesthetist_Name; "Anaesthetist Name")
            {
            }
            column("Count"; "Count")
            {
            }
            dataitem(HMS_Patient; "HMS Patient")
            {
                DataItemLink = "Patient No." = HMS_Theatre_Form_Header."Patient No.";
                column(Search_Name; "Search Name")
                {
                }
                dataitem(HMS_Setup_Doctor; "HMS Setup Doctor")
                {
                    DataItemLink = "Doctor ID" = HMS_Theatre_Form_Header."Doctor ID";
                    column(Doctors_Name; "Doctors Name")
                    {
                    }
                }
            }
        }
    }
}
