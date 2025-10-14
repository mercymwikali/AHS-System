Page 52203074 "HR Leave Application List"
{
    Editable = false;
    PageType = List;
    SourceTable = "HR Leave Application";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec."Application Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(EmployeeNo; Rec."Employee No")
                {
                    ToolTip = 'Specifies the value of the Employee No field.';
                }
                field(EmployeeName; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(CampusCode; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Campus Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(AppliedDays; Rec."Applied Days")
                {
                    ToolTip = 'Specifies the value of the Applied Days field.';
                }
                field(StartingDate; Rec."Starting Date")
                {
                    ToolTip = 'Specifies the value of the Starting Date field.';
                }
                field(EndDate; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    ToolTip = 'Specifies the value of the Purpose field.';
                }
                field(LeaveType; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.';
                }
                field(LeaveBalance; Rec."Leave Balance")
                {
                    ToolTip = 'Specifies the value of the Leave Balance field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(UserID; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field(PostedBy; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(ProcessLeaveAllowance; Rec."Process Leave Allowance")
                {
                    ToolTip = 'Specifies the value of the Process Leave Allowance field.';
                }
                field(AvaillableDays; Rec."Availlable Days")
                {
                    ToolTip = 'Specifies the value of the Availlable Days field.';
                }
                field(ReturnDate; Rec."Return Date")
                {
                    ToolTip = 'Specifies the value of the Return Date field.';
                }
            }
        }
    }

    actions
    {
    }
}
