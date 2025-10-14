Query 52202521 DoctorsQueue
{
    OrderBy = ascending(Date), ascending(Time);

    elements
    {
        dataitem(HMS_Doctor_Queue; "HMS Doctor Queue")
        {
            column(Patient_No; "Patient No")
            {
            }
            column(Visit_No; "Visit No")
            {
            }
            column(Document_No; "Document No")
            {
            }
            column(Type; Type)
            {
            }
            column(Doctor_ID; "Doctor ID")
            {
            }
            column(Status; Status)
            {
            }
            column(Date; Date)
            {
            }
            column(Time; Time)
            {
            }
            dataitem(User_Setup; "User Setup")
            {
                DataItemLink = "Doctor ID" = HMS_Doctor_Queue."Doctor ID";
                column(User_ID; "User ID")
                {
                }
                dataitem(HMS_Patient; "HMS Patient")
                {
                    DataItemLink = "Patient No." = HMS_Doctor_Queue."Patient No";
                    column(Search_Name; "Search Name")
                    {
                    }
                }
            }
        }
    }
}
