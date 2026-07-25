Query 85176 "Nurse Notes"
{
    OrderBy = descending(Notes_Date);

    elements
    {
        dataitem(HMS_Admission_Form_Nurse; "HMS Admission Form Nurse")
        {
            column(Admission_No; "Admission No.")
            {
            }
            column(Nurse_ID; "Nurse ID")
            {
            }
            column(Notes_Date; "Notes Date")
            {
            }
            column(Notes_Time; "Notes Time")
            {
            }
            column(Notes; Notes)
            {
            }
            column(Type; Type)
            {
            }
            column(Drugs; Drugs)
            {
            }
            column(Routine; Routine)
            {
            }
            column(Dose; Dose)
            {
            }
            column(Nurse_Type; "Nurse Type")
            {
            }
            dataitem(User; User)
            {
                DataItemLink = "User Name" = HMS_Admission_Form_Nurse."Nurse ID";
                column(User_Name; "User Name")
                {
                }
                column(Full_Name; "Full Name")
                {
                }
            }
        }
    }
}
