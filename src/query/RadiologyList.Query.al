Query 85198 "Radiology List"
{
    OrderBy = descending(Radiology_Date), descending(Radiology_No);

    elements
    {
        dataitem(HMS_Radiology_Form_Header; "HMS Radiology Form Header")
        {
            column(Radiology_No; "Radiology No.")
            {
            }
            column(Radiology_Date; "Radiology Date")
            {
            }
            column(Radiology_Time; "Radiology Time")
            {
            }
            column(Radiology_Area; "Radiology Area")
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
            column(Status; Status)
            {
            }
            column(Link_No; "Link No.")
            {
            }
            column(Link_Type; "Link Type")
            {
            }
            column(No_Series; "No. Series")
            {
            }
            column(Supervisor_ID; "Supervisor ID")
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
            column(Patient_Ref_No; "Patient Ref. No.")
            {
            }
            column(Doctor_Name; "Doctor Name")
            {
            }
            column(Search_Names; "Search Names")
            {
            }
            dataitem(HMS_Patient; "HMS Patient")
            {
                DataItemLink = "Patient No." = HMS_Radiology_Form_Header."Patient No.";
                column(Search_Name; "Search Name")
                {
                }
                column(Patient_Type; "Patient Type")
                {
                }
                column(Insurance_No; "Insurance No.")
                {
                }
                column(Insurance_Name; "Insurance Name")
                {
                }
                column(Age_in_Years; "Age in Years")
                {
                }
            }
        }
    }
}
