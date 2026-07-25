Query 85193 "Physiotherapy List"
{
    elements
    {
        dataitem(HMS_Physiotheraphy_Form_Header; "HMS Physiotheraphy Form Header")
        {
            column(No; "No.")
            {
            }
            column(Type; Type)
            {
            }
            column(Physio_Date; "Physio Date")
            {
            }
            column(Physio_Time; "Physio Time")
            {
            }
            column(Physio_User_ID; "Physio User ID")
            {
            }
            column(Physio_Remarks; "Physio Remarks")
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
            column(Frequency_Duration; "Frequency/Duration")
            {
            }
            dataitem(HMS_Patient; "HMS Patient")
            {
                DataItemLink = "Patient No." = HMS_Physiotheraphy_Form_Header."Patient No.";
                column(Search_Name; "Search Name")
                {
                }
            }
        }
    }
}
