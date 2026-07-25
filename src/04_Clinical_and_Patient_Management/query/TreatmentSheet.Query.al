Query 85219 "Treatment Sheet"
{
    elements
    {
        dataitem(HMS_Admission_Drug_Nurse; "HMS Admission Drug Nurse")
        {
            column(Admission_No; "Admission No.")
            {
            }
            column(Drug_No; "Drug No.")
            {
            }
            column(Drug_Name; "Drug Name")
            {
            }
            column(Issued_Time; "Issued Time")
            {
            }
            column(Issued_By; "Issued By")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Pharmacy_Code; "Pharmacy Code")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Unit_Of_Measure; "Unit Of Measure")
            {
            }
            column(Marked_as_Incompatible; "Marked as Incompatible")
            {
            }
            column(Dosage; Dosage)
            {
            }
            column(Issued_Date; "Issued Date")
            {
            }
            column(Issued; Issued)
            {
            }
            dataitem(User; User)
            {
                DataItemLink = "User Name" = HMS_Admission_Drug_Nurse."Issued By";
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
