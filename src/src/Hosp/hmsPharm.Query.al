Query 52202559 hmsPharm
{
    elements
    {
        dataitem(HMS_Pharmacy_Header; "HMS Pharmacy Header")
        {
            DataItemTableFilter = Status = filter(Completed);
            SqlJoinType = LeftOuterJoin;
            column(Insurance_Code; "Insurance No")
            {
            }
            column(Pharmacy_Date; "Pharmacy Date")
            {
            }
            column(Patient_No; "Patient No.")
            {
            }
            column("Count")
            {
                Method = Count;
            }
        }
    }
}
