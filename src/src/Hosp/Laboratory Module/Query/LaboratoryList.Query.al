Query 52202517 "Laboratory List"
{
    OrderBy = descending(Laboratory_Date), descending(Laboratory_No);

    elements
    {
        dataitem(HMS_Laboratory_Form_Header; "HMS Laboratory Form Header")
        {
            column(Laboratory_No; "Laboratory No.")
            {
            }
            column(Laboratory_Date; "Laboratory Date")
            {
            }
            column(Laboratory_Time; "Laboratory Time")
            {
            }
            column(Patient_No; "Patient No.")
            {
            }
            column(Student_No; "Student No.")
            {
            }
            column(Employee_No; "Employee No.")
            {
            }
            column(Relative_No; "Relative No.")
            {
            }
            column(Scheduled_Date; "Scheduled Date")
            {
            }
            column(Scheduled_Time; "Scheduled Time")
            {
            }
            column(Supervisor_ID; "Supervisor ID")
            {
            }
            column(Status; Status)
            {
            }
            column(Link_Type; "Link Type")
            {
            }
            column(Link_No; "Link No.")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Request_Area; "Request Area")
            {
            }
            column(No_Series; "No. Series")
            {
            }
            column(Patient_Type; "Patient Type")
            {
            }
            column(Lab_Reference_No; "Lab. Reference No.")
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
            column(Patient_Ref_No; "Patient Ref. No.")
            {
            }
            column(Settlement_Type; "Settlement Type")
            {
            }
            column(Cash_Sale; "Cash Sale")
            {
            }
            column(ADM_No; "ADM No.")
            {
            }
            column(Memeber_No; "Memeber No")
            {
            }
            column(Receipt_Count; "Receipt Count")
            {
            }
            column(Open_Charges; "Open Charges")
            {
            }
            column(Doctor_ID; "Doctor ID")
            {
            }
            column(Walk_In; "Walk-In")
            {
            }
            column(Test_Voided; "Test Voided")
            {
            }
            column(Reason_For_Voiding; "Reason For Voiding")
            {
            }
            column(Sampled_Received; "Sampled Received")
            {
            }
            column(Received_by; "Received by")
            {
            }
            column(Inpatient; Inpatient)
            {
            }
             column(SystemId; SystemId)
            {
            }
            dataitem(HMS_Patient; "HMS Patient")
            {
                DataItemLink = "Patient No." = HMS_Laboratory_Form_Header."Patient No.";
                column(Search_Name; "Search Name")
                {
                }
                column(Membership_No; "Membership No")
                {
                }
                column(Age_in_Years; "Age in Years")
                {
                }
                column(Insurance_No; "Insurance No.")
                {
                }
                column(Branch; "Global Dimension 1 Code")
                {
                }
                column(Insurance_Name; "Insurance Name")
                {
                }
                dataitem(HMS_Setup_Doctor; "HMS Setup Doctor")
                {
                    DataItemLink = "Doctor ID" = HMS_Laboratory_Form_Header."Doctor ID";
                    column(Doctors_Name; "Doctors Name")
                    {
                    }
                }
            }
        }
    }
}
