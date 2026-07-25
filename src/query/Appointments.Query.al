Query 85132 Appointments
{
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
            column(SystemId; SystemId)
            {
            }
            
            dataitem(HMS_Patient; "HMS Patient")
            {
                DataItemLink = "Patient No." = HMS_Appointment_Form_Header."Patient No.";
                column(Surname; Surname)
                {
                }
                column(Middle_Name; "Middle Name")
                {
                }
                column(Last_Name; "Last Name")
                {
                }
                column(Search_Name; "Search Name")
                {
                }
                column(Names; Names)
                {
                }
            }
        }
    }
}
