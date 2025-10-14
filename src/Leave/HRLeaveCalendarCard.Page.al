namespace PTL.HRMIS;

using System.Utilities;
using PTL.HMISBC;

page 52203239 "HR Leave Calendar Card"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Functions';
    SourceTable = "HR Leave Calendar";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    CaptionClass = '1,1,1';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(StartDate; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field(EndDate; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
                field(Current; Rec.Current)
                {
                    ToolTip = 'Specifies the value of the Current field.';
                }
            }
            part(Control1102755000; "HR Leave Calendar Lines")
            {
                SubPageLink = Code = field(Code);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Non Working Days")
                {
                    Image = CalendarMachine;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HR Leave Non Working Days";
                    RunPageLink = "Calender Code" = field(Code);
                    ToolTip = 'Executes the Non Working Days action.';
                }
                action(RegenerateCalendarLines)
                {
                    Image = CalendarMachine;
                    Caption = 'Regenerate Calendar Lines';
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Executes the Regenerate Calendar Lines Action';
                    trigger OnAction()
                    var
                        LeaveCalendarOperations: Codeunit "Leave Management";
                    begin
                        rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        if Confirm('You should Regenerate Calendar Lines after Updating the holidays list. Continue?', false) = true then
                            if LeaveCalendarOperations.FnGenerateCalendarLines(Rec) then
                                Message('Successfully Generated');
                    end;
                }
            }
        }
    }



    /* local procedure HREmployeeLeveCarryForward(CalenderCode: Code[20]; vstartDate: Date; vendDate: Date; Project: Code[30])
    var
        HREmp: Record "HR-Employee";
        EmpLeaveAlloc: Record "HR Leave Allocation";
        HRLeaveCalendar: Record "HR Leave Calendar";
        LeaveBal: Decimal;
        LineNo: Integer;
    begin
        LineNo := 0;
        HREmp.Reset();
        HREmp.SetRange(Status, HREmp.Status::Active);
        HREmp.SetRange("Global Dimension 1 Code", Project);
        if HREmp.Find('-') then
            repeat
                HRLeaveCalendar.Reset();
                HRLeaveCalendar.SetRange("Global Dimension 1 Code", HREmp."Global Dimension 1 Code");
                HRLeaveCalendar.SetRange(Current, true);
                if HRLeaveCalendar.FindFirst() then begin
                    LeaveBal := 0;
                    EmpLeaveAlloc.Reset();
                    EmpLeaveAlloc.SetRange("No.", HREmp."No.");
                    EmpLeaveAlloc.SetRange(Closed, false);
                    EmpLeaveAlloc.SetRange("Leave Type", 'ANNUAL');
                    EmpLeaveAlloc.SetRange("Calendar Code", HRLeaveCalendar.Code);
                    if EmpLeaveAlloc.Find('-') then begin
                        LineNo := LineNo + 1;
                        EmpLeaveAlloc."Entry No." := LineNo;
                        EmpLeaveAlloc."Calendar Code" := CalenderCode;
                        EmpLeaveAlloc."No." := HREmp."No.";
                        EmpLeaveAlloc."Staff Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                        EmpLeaveAlloc."Posting Date" := Today;
                        EmpLeaveAlloc."Entry Type" := EmpLeaveAlloc."Entry Type"::"Positive Adjustment";
                        EmpLeaveAlloc."Posting Type" := EmpLeaveAlloc."Posting Type"::"Carry Forward";

                        EmpLeaveAlloc.CalcSums("No. Of days");
                        LeaveBal := LeaveBal + EmpLeaveAlloc."No. Of days";
                        // if LeaveBal > 15 then
                        //     EmpLeaveAlloc."No. Of days" := 15
                        // else
                        EmpLeaveAlloc."No. Of days" := LeaveBal;

                        EmpLeaveAlloc."Leave Type" := 'ANNUAL';

                        EmpLeaveAlloc."Posting Description" := 'Leave Carry forward Allocation - ' + Format(Today);
                        EmpLeaveAlloc."Posted By" := Format(UserId);

                        // EmpLeaveAlloc.Posted := false;
                        EmpLeaveAlloc."Calendar Start Date" := vstartDate;
                        EmpLeaveAlloc."Calendar End Date" := vendDate;
                        EmpLeaveAlloc."Document No." := 'BATCH-' + CalenderCode;
                        EmpLeaveAlloc."Posting Source" := EmpLeaveAlloc."posting source"::Batch;
                        EmpLeaveAlloc.Posted := true;
                        EmpLeaveAlloc.Insert(true);

                        CloseLeaveEntries(HREmp."No.", CalenderCode, Project);
                    end;
                end;
            until HREmp.Next() = 0;
    end; */

    /* local procedure AutoAllocateLeave()
    var
        LeaveTypes: Record "Leave Types";
        hrLeaveallocation: Record "HR Leave Allocation";
        hrEmployees: Record "HR-Employee";
        LnNo: Integer;
        Progress: Label '%1 Leave Records %2 of %3';
    begin
        
        // Clear(TotalCounter);
        Window.Open(MsgLabel2);

        hrLeaveallocation.Reset();
        if hrLeaveallocation.FindLast() then
            LnNo := hrLeaveallocation."Entry No.";

        // Get Leave Types to Allocate Sick, Maternity, Paternity..
        LeaveTypes.Reset();
        LeaveTypes.SetFilter(Days, '<>%1', 0);
        LeaveTypes.SetRange(Balance, LeaveTypes.Balance::Ignore);
        if LeaveTypes.FindSet() then
            repeat
                LnNo += 1;
                // Get All Active Employees
                Clear(EntryCounter);
                hrEmployees.Reset();
                hrEmployees.SetRange(Status, hrEmployees.Status::Active);
                hrEmployees.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                if LeaveTypes.Gender <> LeaveTypes.Gender::Both then
                    hrEmployees.SetRange(Gender, LeaveTypes.Gender); // Handles Gender Specific Leave types. Marternity, parternity
                TotalCounter := hrEmployees.CountApprox;
                if hrEmployees.FindSet() then
                    repeat
                        EntryCounter += 1;
                        Window.Update(1, StrSubstNo(Progress, LeaveTypes.Code, EntryCounter, TotalCounter));
                        hrLeaveallocation.Init();
                        hrLeaveallocation."Entry No." := LnNo;
                        hrLeaveallocation."Calendar Code" := Rec.Code;
                        hrLeaveallocation."No." := hrEmployees."No.";
                        hrLeaveallocation."Staff Name" := hrEmployees."First Name" + ' ' + hrEmployees."Middle Name" + ' ' + hrEmployees."Last Name";
                        hrLeaveallocation."Posting Date" := Today;
                        hrLeaveallocation."Entry Type" := hrLeaveallocation."Entry Type"::"Positive Adjustment";
                        hrLeaveallocation."Posting Type" := hrLeaveallocation."Posting Type"::Normal;
                        hrLeaveallocation."No. Of days" := LeaveTypes.Days;
                        hrLeaveallocation."Posting Description" := LeaveTypes.Code + ' Leave Allocation ' + Format(Date2DMY(Today, 3));
                        hrLeaveallocation."Posted By" := Format(UserId);
                        hrLeaveallocation."Leave Type" := LeaveTypes.Code;
                        hrLeaveallocation."Document No." := 'BATCH-' + LeaveTypes.Code + '-Leave';
                        hrLeaveallocation."Posting Source" := hrLeaveallocation."posting source"::Batch;
                        hrLeaveallocation."Calendar Start Date" := Rec."Start Date";
                        hrLeaveallocation."Calendar End Date" := Rec."End Date";
                        hrLeaveallocation."Global Dimension 1 Code" := hrEmployees."Global Dimension 1 Code";
                        hrLeaveallocation.Insert();

                        PostLeaveAllocation.PostLeaveAllocation(hrLeaveallocation."Entry No.", hrEmployees."No.", LeaveTypes.Code, Rec.Code);

                    until hrEmployees.Next() = 0;
            until LeaveTypes.Next() = 0;

        Window.Close();
    end; */
}
