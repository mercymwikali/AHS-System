namespace PTL.HMISBC;

report 85008 "HR Leave Application Form"
{
    ApplicationArea = All;
    Caption = 'HR Leave Application Form';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Leave/LeaveApplicationForm.rdl';
    dataset
    {
        dataitem(HRLeaveApplication; "HR Leave Application")
        {
            column(No; "No.")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(EmployeeNo; "Employee No")
            {
            }
            column(EmployeeName; "Employee Name")
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(AppliedDays; "Applied Days")
            {
            }
            column(StartingDate; "Starting Date")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(Purpose; Purpose)
            {
            }
            column(LeaveType; "Leave Type")
            {
            }
            column(LeaveBalance; "Leave Balance")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(Status; Status)
            {
            }
            column(UserID; "User ID")
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(Posted; Posted)
            {
            }
            column(PostedBy; "Posted By")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(ProcessLeaveAllowance; "Process Leave Allowance")
            {
            }
            column(AvaillableDays; "Availlable Days")
            {
            }
            column(ReturnDate; "Return Date")
            {
            }
            column(RelieverNo; "Reliever No.")
            {
            }
            column(RelieverName; "Reliever Name")
            {
            }
            column(EmployeeDept; "Employee Dept")
            {
            }
            column(HOD; HOD)
            {
            }
            column(ApproverID; "Approver ID")
            {
            }
            column(LeavePeriod; "Leave Period")
            {
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
