Query 85139 "Dialysis List"
{
    OrderBy = descending(Dialysis_Date), ascending(Dialysis_Time);

    elements
    {
        dataitem(HMS_Dialysis_Form_Header; "HMS Therapy Form Header")
        {
            column(No; "Treatment No.")
            {
            }
            column(Type; Type)
            {
            }
            column(Dialysis_Date; "Therapy Date")
            {
            }
            column(Dialysis_Time; "Therapy Time")
            {
            }
            column(Dialysis_User_ID; "Therapy User ID")
            {
            }
            column(Dialysis_Remarks; "Therapy Remarks")
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
            column(Treatment_Notes; "Treatment Notes")
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
            column(Dialysis_Notes; "Therapy Notes")
            {
            }
            column(Doctor; Doctor)
            {
            }
            dataitem(HMS_Patient; "HMS Patient")
            {
                DataItemLink = "Patient No." = HMS_Dialysis_Form_Header."Patient No.";
                column(Search_Name; "Search Name")
                {
                }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                dataitem(HMS_Setup_Doctor; "HMS Setup Doctor")
                {
                    DataItemLink = "Doctor ID" = HMS_Dialysis_Form_Header.Doctor;
                    column(Doctors_Name; "Doctors Name")
                    {
                    }
                }
            }
        }
    }
}
