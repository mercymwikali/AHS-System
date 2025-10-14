namespace PTL.HRMIS;

using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.Dimension;

table 52203100 "HR Leave Calendar"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
            Editable = true;
        }
        field(2; "Created By"; Text[100])
        {
        }
        field(3; "Start Date"; Date)
        {
        }
        field(4; "End Date"; Date)
        {
        }
        field(5; Current; Boolean)
        {
            // Editable = false;
        }
        field(6; Description; Text[100])
        {
        }
        field(7; "No Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(8; "Global Dimension 1 Code"; Code[30])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    // trigger OnDelete()
    // var
    //     ERR_CALENDAR_DELETE: label 'You cannot Delete this Calendar [ %1  ] because there are [ %2 ]  Postings assocaited to it in  HR Leave Allocation Entries';
    //     HRLeaveCalendarLines: Record "HR Leave Calendar Lines";
    //     HRLeaveNonWorkingDays: Record "HR Leave Non Working Days";
    // begin

    //     HRLeaveAllocation.Reset();
    //     HRLeaveAllocation.SetRange("Calendar Code", Code);
    //     if not HRLeaveAllocation.IsEmpty then
    //         Error(ERR_CALENDAR_DELETE, Code, HRLeaveAllocation.Count);

    //     HRLeaveNonWorkingDays.Reset();
    //     HRLeaveNonWorkingDays.SetRange(HRLeaveNonWorkingDays."Calender Code", Code);
    //     HRLeaveNonWorkingDays.DeleteAll();

    //     HRLeaveCalendarLines.Reset();
    //     HRLeaveCalendarLines.SetRange(HRLeaveCalendarLines.Code, Code);
    //     HRLeaveCalendarLines.DeleteAll();
    // end;

    // trigger OnInsert()
    // var
    //     TheTable: Record "HR Leave Calendar";
    // begin
    //     IF "Code" = '' THEN BEGIN
    //         TheTable.RESET();
    //         IF TheTable.FINDLAST() THEN
    //             Code := INCSTR(TheTable.Code)
    //         ELSE
    //             "Code" := 'CAL-00001';
    //     END;
    // end;

    // var
    //     HRLeaveAllocation: Record "HR Leave Allocation";
}
