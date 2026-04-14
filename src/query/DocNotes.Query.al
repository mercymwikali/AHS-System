Query 85143 DocNotes
{
    OrderBy = ascending(LineNo), descending(Created_Date);

    elements
    {
        dataitem(hms_Notes; "hms Notes")
        {
            column(LineNo; LineNo)
            {
            }
            column(TreatmentNo; TreatmentNo)
            {
            }
            column(PatientNo; "Patient No")
            {
            }
            column(Treatment_Date; "Treatment Date")
            {
            }
            column(Treatment_Time; "Treatment Time")
            {
            }
            column(Notes; Notes)
            {
            }
            column(Notes_Type; "Notes Type")
            {
            }
            column(User_ID; "User ID")
            {
            }
            column(Creation_Time; "Creation Time")
            {
            }
            column(Clinic; Clinic)
            {
            }
            column(Creation_DateTime; "Creation DateTime")
            {
            }
            column(Created_Date; "Created Date")
            {
            }
            dataitem(User; User)
            {
                DataItemLink = "User Name" = hms_Notes."User ID";
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
