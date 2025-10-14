namespace PTL.HMISBC;
using PTL.HRMIS;
using System.Utilities;
using Microsoft.Foundation.NoSeries;

codeunit 52202467 "Leave Management"
{
    var
        HRSetup: Record "HR Setup";
        HRLeaveLedger: Record "HR Leave Ledger";
        HREmployee: Record "HR-Employee";
        HRLeaveCalendar: Record "HR Leave Calendar";
        HRLeaveNonWorkingDays: Record "HR Leave Non Working Days";
        LeaveTypes: Record "Leave Types";

    procedure PostLeaveApplication(Application: Record "HR Leave Application"): Boolean
    begin
        if Application.Status <> Application.Status::Released then
            Error('The Document Approval is not Complete');

        Application.TestField("Employee No");
        Application.TestField("Applied Days");
        Application.TestField("Starting Date");

        HRLeaveLedger.Init();
        HRLeaveLedger."Document No" := Application."No.";
        HRLeaveLedger."Leave Period" := Date2DWY(Today, 3);//TODO: refactor to get leave calendar code   
        HRLeaveLedger."Transaction Date" := Application."Application Date";
        HRLeaveLedger."Employee No" := Application."Employee No";
        HRLeaveLedger."Leave Type" := Application."Leave Type";
        HRLeaveLedger."No. of Days" := -Application."Applied Days";
        HRLeaveLedger."Transaction Description" := Application.Purpose;
        HRLeaveLedger."Entry Type" := HRLeaveLedger."Entry Type"::Application;
        HRLeaveLedger."Created By" := Format(UserId);
        HRLeaveLedger."Transaction Type" := HRLeaveLedger."Transaction Type"::Application;
        HRLeaveLedger.Insert(true);

        Application.Posted := true;
        Application."Posted By" := Format(UserId);
        Application."Posting Date" := Today;
        Application.Modify();

        if HREmployee.Get(Application."Employee No") then begin
            HREmployee."Current Leave No" := Application."No.";
            HREmployee.Modify();
        end;
        Message('Leave Posted Successfully');
    end;

    procedure FnCloseOpenLeaveCalendar(oldCalendarCode: Record "HR Leave Calendar"): Boolean
    begin
        // 1. Close Leave Entries
        HRLeaveLedger.Reset();
        HRLeaveLedger.SetRange(Closed, false);
        HRLeaveLedger.SetRange("Calendar Code", oldCalendarCode.Code);
        // HRLeaveLedger.SetRange(Posted, true);
        if HRLeaveLedger.FindSet(true) then
            repeat
                HRLeaveLedger.Closed := true;
                HRLeaveLedger.Modify();
            until HRLeaveLedger.Next() = 0;

        // 2. Close Leave CalendarHRLeaveCalendar.Reset();
        HRLeaveCalendar.SetRange("Global Dimension 1 Code", oldCalendarCode."Global Dimension 1 Code");
        HRLeaveCalendar.SetRange(Current, true);
        if HRLeaveCalendar.FindSet() then
            HRLeaveCalendar.ModifyAll(Current, false);

        Commit();
    end;

    procedure FnCreateNewCalendar(OldCalendarCode: Record "HR Leave Calendar") NewCalendarCode: Code[20]
    var
        NoSeriesManagement: Codeunit NoSeriesManagement;
        NewCalendarStartDate: Date;
        NewCalendarEndDate: Date;
    begin
        // 1. Increment Calendar Code using No series

        NewCalendarCode := IncStr(OldCalendarCode.Code);
        // 2. Increment Calendar Start and End Date from old calendar code
        NewCalendarStartDate := CalcDate('<+1Y>', OldCalendarCode."Start Date");
        NewCalendarEndDate := CalcDate('<+1Y>', OldCalendarCode."End Date");


        // 3. Check All Other Calendars are closed
        // 4. Insert New Calendar Record
        HRLeaveCalendar.Init();
        HRLeaveCalendar.Code := NewCalendarCode;
        HRLeaveCalendar.Description := OldCalendarCode.Description;
        HRLeaveCalendar."Start Date" := NewCalendarStartDate;
        HRLeaveCalendar."End Date" := NewCalendarEndDate;
        HRLeaveCalendar."Global Dimension 1 Code" := OldCalendarCode."Global Dimension 1 Code";
        HRLeaveCalendar.Current := true;
        HRLeaveCalendar.Insert();
        Commit();
    end;

    procedure FnCopyRecurringLeaveHolidays(oldCalendarCode: Code[20]; NewCalendarCode: Code[20])
    var
        LeaveNonWorkingDays: Record "HR Leave Non Working Days";
    begin
        HRLeaveNonWorkingDays.Reset();
        HRLeaveNonWorkingDays.SetRange("Calender Code", oldCalendarCode);
        HRLeaveNonWorkingDays.SetRange(Recurring, true);
        if HRLeaveNonWorkingDays.FindSet() then
            repeat
                LeaveNonWorkingDays.Init();
                LeaveNonWorkingDays."Calender Code" := NewCalendarCode;
                LeaveNonWorkingDays.Date := CalcDate('<+1Y>', HRLeaveNonWorkingDays.Date);
                LeaveNonWorkingDays.Reason := HRLeaveNonWorkingDays.Reason;
                LeaveNonWorkingDays.Recurring := true;
                LeaveNonWorkingDays.Insert()
            until HRLeaveNonWorkingDays.Next() = 0;
    end;

    procedure FnGenerateCalendarLines(NewCalendarCode: Record "HR Leave Calendar"): Boolean
    var
        HRCalendarLines: Record "HR Leave Calendar Lines";
        Date: Record Date;
        TEXT0025Lbl: label 'Saturday';
        TEXT0026Lbl: label 'Sunday';
    begin
        // 1. Check if Holiday List is updated
        HRLeaveNonWorkingDays.Reset();
        HRLeaveNonWorkingDays.SetRange(HRLeaveNonWorkingDays."Calender Code", NewCalendarCode.Code);
        HRLeaveNonWorkingDays.SetRange(Date, NewCalendarCode."Start Date", NewCalendarCode."End Date");
        if not HRLeaveNonWorkingDays.IsEmpty then begin

            // 2. Insert Leave Calendar Lines Using dates Object
            Date.Reset();
            Date.SetRange(Date."Period Type", Date."period type"::Date);
            Date.SetRange(Date."Period Start", NewCalendarCode."Start Date", NewCalendarCode."End Date");
            if Date.FindSet() then begin
                HRCalendarLines.Reset();
                HRCalendarLines.SetRange(Code, NewCalendarCode.Code);
                HRCalendarLines.DeleteAll();

                repeat
                    HRCalendarLines.Init();

                    HRCalendarLines.Code := NewCalendarCode.Code;
                    HRCalendarLines.Date := Date."Period Start";
                    // e.g 01-01-15
                    HRCalendarLines.Day := Date."Period Name";         // e.g Thursday
                    HRCalendarLines.Reason := FnDetermineNonWorking(Date."Period Start");
                    if HRCalendarLines.Reason <> '' then
                        HRCalendarLines."Non Working" := true;

                    //Saturday
                    if (Date."Period Name" = TEXT0025Lbl) and not (HRCalendarLines."Non Working") then begin
                        HRCalendarLines."Non Working" := false;
                        HRCalendarLines.Reason := TEXT0025Lbl;
                    end;
                    //Sunday
                    if (Date."Period Name" = TEXT0026Lbl) and not (HRCalendarLines."Non Working") then begin
                        HRCalendarLines."Non Working" := true;
                        HRCalendarLines.Reason := TEXT0026Lbl;
                    end;

                    HRCalendarLines.Insert();
                until Date.Next() = 0;
            end;
        end;
    end;

    procedure FnCarryForwardLeaveDays(NewCalendarCode: Record "HR Leave Calendar"; OldCalendar: Record "HR Leave Calendar"): Boolean
    var
        LeaveBal: Decimal;
        LineNo: Integer;
    begin
        // 1. Check Leave Types for those with Balance Type <> ignore
        // 2. Insert Leave Allocation Entries in New Calendar
        LineNo := 0;

        HRLeaveLedger.Reset();
        if HRLeaveLedger.FindLast() then
            LineNo := HRLeaveLedger."Entry No."; // Get last entry no

        HREmployee.Reset();
        HREmployee.SetRange(Status, HREmployee."Status 1"::Active);
        HREmployee.SetRange("Shortcut Dimension 1 Code", NewCalendarCode."Global Dimension 1 Code");
        if HREmployee.FindSet() then
            repeat
                LeaveBal := 0;

                HRLeaveLedger.Reset();
                HRLeaveLedger.SetRange(HRLeaveLedger."Employee No", HREmployee."No.");
                HRLeaveLedger.SetRange(Closed, true);
                HRLeaveLedger.SetRange("Leave Type", 'ANNUAL');
                HRLeaveLedger.SetRange("Calendar Code", OldCalendar."Global Dimension 1 Code");
                if HRLeaveLedger.FindSet() then begin
                    HRLeaveLedger.CalcSums("No. Of days");
                    LeaveBal := HRLeaveLedger."No. Of days";
                end;

                LineNo := LineNo + 1;

                if LeaveBal > 0 then begin
                    // Insert Negative Adjustment
                    HRLeaveLedger.Init();
                    HRLeaveLedger."Entry No." := LineNo;
                    HRLeaveLedger."Calendar Code" := OldCalendar.Code;
                    HRLeaveLedger."Employee No" := HREmployee."No.";
                    HRLeaveLedger.Validate("Employee No");
                    HRLeaveLedger."Entry Type" := HRLeaveLedger."Entry Type"::Allocation;
                    HRLeaveLedger."Transaction Type" := HRLeaveLedger."Transaction Type"::"Negative Adjustment";
                    HRLeaveLedger."No. Of days" := LeaveBal * -1;
                    HRLeaveLedger."Transaction Description" := 'Annual' + ' Leave Days Reset ';
                    HRLeaveLedger."Created By" := Format(UserId);
                    HRLeaveLedger."Leave Type" := 'Annual';
                    HRLeaveLedger."Document No" := 'BATCH-' + 'Reset' + '-Leave';
                    HRLeaveLedger."Posting Source" := HRLeaveLedger."posting source"::Batch;
                    HRLeaveLedger."Transaction Date" := OldCalendar."End Date";
                    HRLeaveLedger.Insert();

                    // Insert Positive Adjustment Carry Forward
                    HRLeaveLedger.Init();
                    HRLeaveLedger."Entry No." := LineNo + 1;
                    HRLeaveLedger."Calendar Code" := NewCalendarCode.Code;
                    HRLeaveLedger."Employee No" := HREmployee."No.";
                    HRLeaveLedger.Validate("Employee No");
                    HRLeaveLedger."Entry Type" := HRLeaveLedger."Entry Type"::Allocation;
                    HRLeaveLedger."Transaction Type" := HRLeaveLedger."Transaction Type"::"Carry Forward";
                    HRLeaveLedger."No. Of days" := LeaveBal;
                    HRLeaveLedger."Transaction Description" := 'Annual' + ' Leave Days Carry Forward ';
                    HRLeaveLedger."Created By" := Format(UserId);
                    HRLeaveLedger."Leave Type" := 'Annual';
                    HRLeaveLedger."Document No" := 'BATCH-' + 'Annual' + '-Leave';
                    HRLeaveLedger."Posting Source" := HRLeaveLedger."posting source"::Batch;
                    HRLeaveLedger."Transaction Date" := NewCalendarCode."Start Date";
                    // HRLeaveLedger.Posted := true;
                    HRLeaveLedger.Insert();
                end;
            until HREmployee.Next() = 0;
    end;

    procedure FnResetLeaveDays(oldCalendarCode: Record "HR Leave Calendar"; NewCalendarCode: Record "HR Leave Calendar"; projectCode: Code[30]): Boolean
    var
        HREmployee: Record "HR-Employee";
        LeaveTypes: Record "Leave Types";
        leaveBal: Decimal;
        LnNo: Integer;
    begin
        leaveBal := 0;

        HRLeaveLedger.Reset();
        if HRLeaveLedger.FindLast() then
            LnNo := HRLeaveLedger."Entry No."; // Get last entry no

        LeaveTypes.Reset();
        LeaveTypes.SetRange(Balance, LeaveTypes.Balance::Ignore);
        if LeaveTypes.FindSet() then
            repeat
                // Get All Active Employees
                HREmployee.Reset();
                HREmployee.SetRange(Status, HREmployee."Status 1"::Active);
                if LeaveTypes.Gender <> LeaveTypes.Gender::Both then
                    HREmployee.SetRange(Gender, LeaveTypes.Gender); // Handles gender based leave types              
                if HREmployee.FindSet() then
                    repeat
                        LnNo += 1;
                        leaveBal := 0;
                        // 1. Check if Leave Allocation Exists
                        HRLeaveLedger.Reset();
                        HRLeaveLedger.SetRange(HRLeaveLedger."Employee No", HREmployee."No.");
                        HRLeaveLedger.SetRange("Leave Type", LeaveTypes.Code);
                        HRLeaveLedger.SetRange("Calendar Code", oldCalendarCode.Code);
                        if HRLeaveLedger.FindSet() then begin
                            HRLeaveLedger.CalcSums("No. Of days");
                            leaveBal := HRLeaveLedger."No. Of days";
                        end;

                        if leaveBal > 0 then begin
                            // insert new leave allocation entry
                            HRLeaveLedger.Init();
                            HRLeaveLedger."Entry No." := LnNo;
                            HRLeaveLedger."Calendar Code" := oldCalendarCode.code;
                            HRLeaveLedger."Employee No" := HREmployee."No.";
                            HRLeaveLedger.Validate("Employee No");
                            HRLeaveLedger."Entry Type" := HRLeaveLedger."Entry Type"::Reset;
                            HRLeaveLedger."Transaction Type" := HRLeaveLedger."Transaction Type"::"Negative Adjustment";
                            HRLeaveLedger."No. Of days" := leaveBal * -1;
                            HRLeaveLedger."Transaction Description" := LeaveTypes.Code + ' Leave Days Reset ';
                            HRLeaveLedger."Created By" := Format(UserId);
                            HRLeaveLedger."Leave Type" := LeaveTypes.Code;
                            HRLeaveLedger."Document No" := 'BATCH-' + LeaveTypes.Code + '-Leave';
                            HRLeaveLedger."Posting Source" := HRLeaveLedger."posting source"::Batch;
                            HRLeaveLedger."Transaction Date" := oldCalendarCode."End Date";
                            // HRLeaveLedger.Posted := true;
                            HRLeaveLedger.Insert();
                        end;
                    until HREmployee.Next() = 0;
            until LeaveTypes.Next() = 0;
    end;

    procedure FnAutoAllocateLeaveDays(NewCalendarCode: Record "HR Leave Calendar"): Boolean
    var
        hrEmployees: Record "HR-Employee";
        LnNo: Integer;
    begin
        // 1. Check For Leave Types with Balance Type = Ignore
        // 2. Insert Leave Allocation Entries

        HRLeaveLedger.Reset();
        if HRLeaveLedger.FindLast() then
            LnNo := HRLeaveLedger."Entry No."; // Get last entry no

        // Get Leave Types to Allocate Sick, Maternity, Paternity..
        LeaveTypes.Reset();
        LeaveTypes.SetFilter(Days, '<>%1', 0);
        LeaveTypes.SetRange(Balance, LeaveTypes.Balance::Ignore);
        if LeaveTypes.FindSet() then
            repeat
                // Get All Active Employees
                hrEmployees.Reset();
                hrEmployees.SetRange(Status, hrEmployees."Status 1"::Active);
                // hrEmployees.SetRange("Global Dimension 1 Code", NewCalendarCode."Global Dimension 1 Code");
                if LeaveTypes.Gender <> LeaveTypes.Gender::Both then
                    hrEmployees.SetRange(Gender, LeaveTypes.Gender); // Handles Gender Specific Leave types. Marternity, parternity

                if hrEmployees.FindSet() then
                    repeat
                        LnNo += 1;
                        // Insert New Allocation Entry
                        HRLeaveLedger.Init();
                        HRLeaveLedger."Entry No." := LnNo;
                        HRLeaveLedger."Calendar Code" := NewCalendarCode.Code;
                        HRLeaveLedger."Employee No" := hrEmployees."No.";
                        HRLeaveLedger.Validate("Employee No");
                        HRLeaveLedger."Transaction Date" := NewCalendarCode."Start Date";
                        HRLeaveLedger."Entry Type" := HRLeaveLedger."Entry Type"::Allocation;
                        HRLeaveLedger."Transaction Type" := HRLeaveLedger."Transaction Type"::Allocation;
                        HRLeaveLedger."No. Of days" := LeaveTypes.Days;
                        HRLeaveLedger."Transaction Description" := LeaveTypes.Code + ' Leave Allocation ';
                        HRLeaveLedger."Created By" := Format(UserId);
                        HRLeaveLedger."Leave Type" := LeaveTypes.Code;
                        HRLeaveLedger."Document No" := 'BATCH-' + LeaveTypes.Code + '-Leave';
                        HRLeaveLedger."Posting Source" := HRLeaveLedger."posting source"::Batch;
                        HRLeaveLedger.Insert();
                    until hrEmployees.Next() = 0;
            until LeaveTypes.Next() = 0;
    end;

    /* procedure SendSuccessfullLeaveGeneratedNotification(ProjectCode: Code[30])
    var
        EmailSender: Record "Email Sender";
        UserSetup: Record "User Setup";
    begin
        // Send Email to project manage that a new calendar has been generated.
        ProjectManagement.Reset();
        ProjectManagement.SetRange("Global Dimension 1 Code", ProjectCode);
        if ProjectManagement.FindFirst() then begin

            EmailSender.Init();
            EmailSender.Code := EmailSender.getNextNo();

            EmailSender.Subject := 'New Leave Calendar Generated';
            EmailSender."Message Desc 1" := 'A new Leave Calendar has been generated for your project ' + ProjectManagement."Project Name";
            EmailSender."Date Created" := CurrentDateTime;
            UserSetup.Reset();
            UserSetup.SetRange(UserName, ProjectManagement."Project Manager");
            if UserSetup.FindFirst() then begin
                EmailSender."Receiver Email" := UserSetup."E-Mail";
                EmailSender.Insert();
            end;
        end;

    end; */

    procedure FnDetermineNonWorking(currDate: Date) isNonWorking: Text[40];
    var
        HRNonWorkingDays: Record "HR Leave Calendar Lines";
    begin
        isNonWorking := '';

        HRNonWorkingDays.Reset();
        HRNonWorkingDays.SetRange(Date, currDate);
        if HRNonWorkingDays.FindFirst() then
            isNonWorking := HRNonWorkingDays.Reason;

        exit(isNonWorking);
    end;

    procedure DetermineIfIncludesNonWorking(fLeaveCode: Code[20]): Boolean
    begin
        if LeaveTypes.Get(fLeaveCode) then
            if LeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
    end;

    procedure FnCalculateDaysApplied(leaveType: Code[20]; StartDate: Date; EndDate: Date) DaysApplied: Integer
    var
        HRLeaveCalendarLines: Record "HR Leave Calendar Lines";
        nonWorking: Integer;
    begin
        DaysApplied := 0;
        nonWorking := 0;

        HRLeaveCalendarLines.Reset();
        HRLeaveCalendarLines.SetRange(Date, StartDate, EndDate);
        HRLeaveCalendarLines.SetRange("Non Working", true);
        nonWorking := HRLeaveCalendarLines.Count();

        HRLeaveCalendarLines.Reset();
        HRLeaveCalendarLines.SetRange(Date, StartDate, EndDate);
        DaysApplied := HRLeaveCalendarLines.Count();

        if not DetermineIfIncludesNonWorking(leaveType) then
            DaysApplied := DaysApplied - nonWorking;


        exit(DaysApplied);
    end;

    procedure DetermineLeaveReturnDate(leaveType: Code[20]; endDate: Date) fReturnDate: Date
    var
        HRLeaveCalendarLines: Record "HR Leave Calendar Lines";
    begin
        fReturnDate := CalcDate('<+1D>', endDate);

        if not DetermineIfIncludesNonWorking(leaveType) then begin
            HRLeaveCalendarLines.Reset();
            HRLeaveCalendarLines.SetRange("Non Working", false);
            HRLeaveCalendarLines.SetFilter(Date, '%1..', fReturnDate);
            if HRLeaveCalendarLines.FindFirst() then
                fReturnDate := HRLeaveCalendarLines.Date;
        end;

        exit(fReturnDate);
    end;
}
