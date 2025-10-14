Query 52202454 "Leave Requistions"
{
    elements
    {
        dataitem(HR_Leave_Requisition; "HR Leave Application")
        {
            column(No; "No.")
            {
            }
            column("Date"; "Application Date")
            {
            }
            column(Reliever_Name; "Reliever Name")
            {
            }
            column(Return_Date; "Return Date")
            {
            }
            column(Status; Status)
            {
            }
            column(Leave_Type; "Leave Type")
            {
            }
            column(Starting_Date; "Starting Date")
            {
            }
            column(End_Date; "End Date")
            {
            }
            column(Applied_Days; "Applied Days")
            {
            }
            column(Department_Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Purpose; Purpose)
            {
            }
            column(LeavePeriod; "Leave Period")
            {
            }

            column(Employee_Name; "Employee Name")
            {
            }
            column(Employee_No; "Employee No")
            {
            }
            column(RelieverNo; "Reliever No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(UserID; "User ID")
            {
            }

            column(Employee_Dept; "Employee Dept")
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin
        SetFilter(End_Date, '%1..%2', Today, Today + 1000);
    end;
}
