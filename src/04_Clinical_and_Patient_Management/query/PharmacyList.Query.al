Query 85104 "Pharmacy List"
{
    OrderBy = descending(Pharmacy_Date), descending(Pharmacy_No);

    elements
    {
        dataitem(HMS_Pharmacy_Header; "HMS Pharmacy Header")
        {
            column(Pharmacy_No; "Pharmacy No.")
            {
            }
            column(Pharmacy_Date; "Pharmacy Date")
            {
            }
            column(Pharmacy_Time; "Pharmacy Time")
            {
            }
            column(Walkin; Walkin)
            {
            }
            column(Search_Name; "Search Name")
            {
            }
            column(Request_Area; "Request Area")
            {
            }
            column(Patient_No; "Patient No.")
            {
            }
            column(Bill_To_Customer_No; "Bill To Customer No.")
            {
            }
            column(Issued_By; "Issued By")
            {
            }
            column(Link_Type; "Link Type")
            {
            }
            column(Link_No; "Link No.")
            {
            }
            column(Status; Status)
            {
            }
            column(No_Series; "No. Series")
            {
            }
            column(Surname; Surname)
            {
            }
            column(Middle_Name; "Middle Name")
            {
            }
            column(Last_Name; "Last Name")
            {
            }
            column(ID_Number; "ID Number")
            {
            }
            column(Correspondence_Address_1; "Correspondence Address 1")
            {
            }
            column(Telephone_No_1; "Telephone No. 1")
            {
            }
            column(Email; Email)
            {
            }
            column(Patient_Type; "Patient Type")
            {
            }
            column(ADM_No; "ADM No")
            {
            }
            column(Student_No; "Student No.")
            {
            }
            column(Employee_No; "Employee No.")
            {
            }
            column(Transaction_Type; "Transaction Type")
            {
            }
            column(Issuing_Location; "Issuing Location")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Age; Age)
            {
            }
            column(User_Id; "User Id")
            {
            }
            column(Doctor_ID; "Doctor ID")
            {
            }
            column(Receptionist; Receptionist)
            {
            }
            column(Total_Price; "Total Price")
            {
            }
            column(Visit_Total; "Visit Total")
            {
            }
            column(Total_Receipts; "Total Receipts")
            {
            }
            column(InPatient; InPatient)
            {
            }
            column(Branch; Branch)
            {
            }
            column(Global_Dimension1; "Global Dimension 1 Code")
            {
            }// REFACTOR: Use The branch that is not a flow field for reporting purposes. Inpatient too
        }
    }
}
