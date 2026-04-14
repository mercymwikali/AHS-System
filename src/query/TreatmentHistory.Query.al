Query 85217 "Treatment History"
{
    OrderBy = descending(Treatment_Date), descending(Treatment_Time);

    elements
    {
        dataitem(HMS_Treatment_Form_Header; "HMS Treatment Form Header")
        {
            column(Treatment_No; "Treatment No.")
            {
            }
            column(Treatment_Type; "Treatment Type")
            {
            }
            column(Treatment_Date; "Treatment Date")
            {
            }
            column(Treatment_Time; "Treatment Time")
            {
            }
            column(ID_Number; "ID Number")
            {
            }
            column(Doctor_ID; "Doctor ID")
            {
            }
            column(Patient_No; "Patient No.")
            {
            }
            column(Employee_No; "Employee No.")
            {
            }
            column(Doctor_Notes; "Doctor Notes")
            {
            }
            column(Status; Status)
            {
            }
            column(Treatment_Location; "Treatment Location")
            {
            }
            column(Patient_Type; "Patient Type")
            {
            }
            column(Surname; Surname)
            {
            }
            column(Middle_Name; "Middle Name")
            {
            }
            column(Last_Name; "Last Name")
            {
            }
            column(Correspondence_Address_1; "Correspondence Address 1")
            {
            }
            column(Email; Email)
            {
            }
            column(Patient_Name; "Patient Name")
            {
            }
            column(Settlement_Type; "Settlement Type")
            {
            }
            column(Membership_No; "Membership No")
            {
            }
            column(Insurance_Name; "Insurance Name")
            {
            }
            column(Adm_No; "Adm No.")
            {
            }
            column(Triage_Notes; "Triage Notes")
            {
            }
            column(Link_No; "Link No.")
            {
            }
            column(Off_Duty_Comments; "Off Duty Comments")
            {
            }
            column(Light_Duty_Days; "Light Duty Days")
            {
            }
            column(Next_Appointment_Date; "Next Appointment Date")
            {
            }
            column(Off_Duty_Days; "Off Duty Days")
            {
            }
            column(Off_Duty; "Off Duty")
            {
            }
            column(Sick_Off_Start_Date; "Sick Off Start Date")
            {
            }
            column(Sick_Off_End_Date; "Sick Off End Date")
            {
            }
            column(Link_Type; "Link Type")
            {
            }
            column(Clinic; Clinic)
            {
            }
            column(Waiting_At; "Waiting At")
            {
            }
            column(Color_Code; "Color Code")
            {
            }
            column(Special_Clinics; "Special Clinics")
            {
            }
            dataitem(HMS_Patient; "HMS Patient")
            {
                DataItemLink = "Patient No." = HMS_Treatment_Form_Header."Patient No.";
                column(Search_Name; "Search Name")
                {
                }
                column(Age_in_Years; "Age in Years")
                {
                }
                column(Old_File_No; "Old File No")
                {
                }
                column(File_No; "File No")
                {
                }
                column(Branch; "Global Dimension 1 Code")
                {
                }
                column(Inpatient; Inpatient)
                {
                }
                column(Telephone_No_1; "Telephone No. 1")
                {
                }
                dataitem(HMS_Setup_Doctor; "HMS Setup Doctor")
                {
                    DataItemLink = "Doctor ID" = HMS_Treatment_Form_Header."Doctor ID";
                    column(Doctors_Name; "Doctors Name")
                    {
                    }
                }
            }
        }
    }
}
