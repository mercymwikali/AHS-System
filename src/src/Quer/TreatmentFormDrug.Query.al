Query 52202506 "Treatment Form Drug"
{
    elements
    {
        dataitem(HMS_Treatment_Form_Drug; "HMS Treatment Form Drug")
        {
            column(Treatment_No; "Treatment No.")
            {
            }
            column(Drug_No; "Drug No.")
            {
            }
            column(Drug_Name; "Drug Name")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Unit_Of_Measure; "Unit Of Measure")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Pharmacy_Code; "Pharmacy Code")
            {
            }
            column(Actual_Quantity; "Actual Quantity")
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(Issued; Issued)
            {
            }
            column(Take; Take)
            {
            }
            column(Marked_as_Incompatible; "Marked as Incompatible")
            {
            }
            column(Product_Group; "Product Group")
            {
            }
            column(Route; Route)
            {
            }
            column(Frequency; Frequency)
            {
            }
            column(Dosage; Dosage)
            {
            }
            column(Number_of_Days; "Number of Days")
            {
            }
            column(IP_Status; "IP Status")
            {
            }
            column(Inpatient; Inpatient)
            {
            }
            column(Stopped_by; "Stopped by")
            {
            }
            column(Stopped_Date; "Stopped Date")
            {
            }
            column(Unit_Price; "Unit Price")
            {
            }
            column(Prescription_Dose; "Prescription Dose")
            {
            }
            column(Date_Taken; "Date Taken")
            {
            }
            column(Status; Status)
            {
            }
            column(Lline_No; "Lline No")
            {
            }
            column(Total_Price; "Total Price")
            {
            }
            column(Branch; Branch)
            {
            }
            column(Remaining_Days; "Remaining Days")
            {
            }
            column(Prescribed_By; "Prescribed By")
            {
            }
            column(Prescribed_By_name; "Prescribed By name")
            {
            }
            column(Patient_No; "Patient No")
            {
            }
            column(Patient_Names; "Patient Names")
            {
            }
            column(Date_Prescribed; "Date Prescribed")
            {
            }
            column(Sent_Date; "Sent Date")
            {
            }
            column(Pharmacy_Type; "Pharmacy Type")
            {
            }
            dataitem(User; User)
            {
                DataItemLink = "User Name" = HMS_Treatment_Form_Drug."Stopped by";
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
