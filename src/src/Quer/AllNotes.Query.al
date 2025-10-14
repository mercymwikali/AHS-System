Query 52202424 "All Notes"
{
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
            column(Doctor_ID; "Doctor ID")
            {
            }
            column(Patient_No; "Patient No.")
            {
            }
            column(Settlement_Type; "Settlement Type")
            {
            }
            column(Membership_No; "Membership No")
            {
            }
            dataitem(hms_Notes; "hms Notes")
            {
                DataItemLink = TreatmentNo = HMS_Treatment_Form_Header."Treatment No.";
                SqlJoinType = LeftOuterJoin;
                column(LineNo; LineNo)
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
                column(Created_Date; "Created Date")
                {
                }
                dataitem(HMS_Treatment_Form_Laboratory; "HMS Treatment Form Laboratory")
                {
                    DataItemLink = "Treatment No." = HMS_Treatment_Form_Header."Treatment No.";
                    SqlJoinType = LeftOuterJoin;
                    column(Laboratory_Test_Package_Code; "Laboratory Test Package Code")
                    {
                    }
                    column(Laboratory_Test_Package_Name; "Laboratory Test Package Name")
                    {
                    }
                    dataitem(HMS_Treatment_Form_Drug; "HMS Treatment Form Drug")
                    {
                        DataItemLink = "Treatment No." = HMS_Treatment_Form_Header."Treatment No.";
                        SqlJoinType = LeftOuterJoin;
                        column(Drug_No; "Drug No.")
                        {
                        }
                        column(Drug_Name; "Drug Name")
                        {
                        }
                        column(Quantity; Quantity)
                        {
                        }
                        column(Remarks; Remarks)
                        {
                        }
                        column(Actual_Quantity; "Actual Quantity")
                        {
                        }
                    }
                }
            }
        }
    }
}
