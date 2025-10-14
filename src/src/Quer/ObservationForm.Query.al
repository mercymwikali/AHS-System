Query 52202500 "Observation Form"
{
    OrderBy = descending(Observation_Date), descending(Observation_No);

    elements
    {
        dataitem(HMS_Observation_Form_Header; "HMS Observation Form Header")
        {
            column(Observation_No; "Observation No.")
            {
            }
            column(Observation_Type; "Observation Type")
            {
            }
            column(Observation_Date; "Observation Date")
            {
            }
            column(Observation_Time; "Observation Time")
            {
            }
            column(Observation_User_ID; "Observation User ID")
            {
            }
            column(Observation_Remarks; "Observation Remarks")
            {
            }
            column(Patient_No; "Patient No.")
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
            column(Patient_Name; "Patient Name")
            {
            }
            column(Observation_Remarks2; "Observation Remarks2")
            {
            }
            column(Doctor; Doctor)
            {
            }
            column(Names; Names)
            {
            }
            column(Queued_Doc; "Queued Doc")
            {
            }
            column(Treatment_No; "Treatment No")
            {
            }
            column(Doctor_Name; "Doctor Name")
            {
            }
            column(Special_Clinics; "Special Clinics")
            {
            }
            dataitem(HMS_Patient; "HMS Patient")
            {
                DataItemLink = "Patient No." = HMS_Observation_Form_Header."Patient No.";
                column(Surname; Surname)
                {
                }
                column(Middle_Name; "Middle Name")
                {
                }
                column(Last_Name; "Last Name")
                {
                }
                column(Patient_Type; "Patient Type")
                {
                }
                column(Search_Name; "Search Name")
                {
                }
                column(Age_in_Years; "Age in Years")
                {
                }
                column(Branch; "Global Dimension 1 Code")
                {
                }
                column(Insurance_Name; "Insurance Name")
                {
                }
                dataitem(HMS_Appointment_Form_Header; "HMS Appointment Form Header")
                {
                    DataItemLink = "Appointment No." = HMS_Observation_Form_Header."Link No.";
                    column(Waiting_At; "Waiting At")
                    {
                    }
                }
            }
        }
    }
}
