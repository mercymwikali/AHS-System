Query 52202523 "Pharmacy Returns"
{
    OrderBy = descending(Pharmacy_Date);

    elements
    {
        dataitem(HMS_Pharmacy_Line; "HMS Pharmacy Line")
        {
            column(Pharmacy_No; "Pharmacy No.")
            {
            }
            column(No; "No.")
            {
            }
            column(Drug_Name; "Drug Name")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Measuring_Unit; "Measuring Unit")
            {
            }
            column(Unit_Price; "Unit Price")
            {
            }
            column(Actual_Qty; "Actual Qty")
            {
            }
            column(Issued_Quantity; "Issued Quantity")
            {
            }
            column(Issued_Units; "Issued Units")
            {
            }
            column(Issued_Price; "Issued Price")
            {
            }
            column(Dosage; Dosage)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Pharmacy; Pharmacy)
            {
            }
            column(Remaining; Remaining)
            {
            }
            column(Drugs_Category; "Drugs Category")
            {
            }
            column(Invoiced; Invoiced)
            {
            }
            column(Paid; Paid)
            {
            }
            column(Link_Code; "Link Code")
            {
            }
            column(Posted_Doc_No; "Posted Doc No")
            {
            }
            column(Location; Location)
            {
            }
            column(Balance; Balance)
            {
            }
            column(Take; Take)
            {
            }
            column(Route; Route)
            {
            }
            column(Frequency; Frequency)
            {
            }
            column(Number_of_Days; "Number of Days")
            {
            }
            column(Returns_Quantity; "Returns Quantity")
            {
            }
            column(Reversed; Reversed)
            {
            }
            column(line_no; "line no")
            {
            }
            column(Total_Price; "Total Price")
            {
            }
            dataitem(HMS_Pharmacy_Header; "HMS Pharmacy Header")
            {
                DataItemLink = "Pharmacy No." = HMS_Pharmacy_Line."Pharmacy No.";
                column(Patient_No; "Patient No.")
                {
                }
                column(Search_Name; "Search Name")
                {
                }
                column(Pharmacy_Date; "Pharmacy Date")
                {
                }
                column(Request_Area; "Request Area")
                {
                }
                column(Insurance_No; "Insurance No")
                {
                }
                column(Patient_Type; "Patient Type")
                {
                }
                column(Cash_Sale; "Cash Sale")
                {
                }
                column(Transaction_Type; "Transaction Type")
                {
                }
                column(Issuing_Location; "Issuing Location")
                {
                }
                column(Status; Status)
                {
                }
            }
        }
    }
}
