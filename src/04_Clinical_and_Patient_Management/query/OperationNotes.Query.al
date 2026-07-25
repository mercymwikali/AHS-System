Query 85182 "Operation Notes"
{
    OrderBy = ascending(Line_no), descending(Notes_Date), descending(Notes_Time);

    elements
    {
        dataitem(HMS_Operational_Notes; "HMS Operational Notes")
        {
            column(Theatre_No; "Theatre No.")
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
            column(notesType; notesType)
            {
            }
            column(Line_no; "Line no")
            {
            }
            dataitem(User; User)
            {
                DataItemLink = "User Name" = HMS_Operational_Notes."Nurse ID";
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
