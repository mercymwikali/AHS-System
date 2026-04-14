table 85025 "HR Leave Application"
{
    DrillDownPageID = "HR Leave Application List";
    LookupPageID = "HR Leave Application List";

    fields
    {
        field(50000; "No."; Code[20])
        {
        }
        field(50001; "Application Date"; Date)
        {
        }
        field(50002; "Employee No"; Code[30])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin

                if Emp.Get("Employee No") then begin
                    Emp.CalcFields(Emp."Leave Balance");
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Leave Balance" := Emp."Leave Balance";
                    "Shortcut Dimension 2 Code" := Emp."Shortcut Dimension 2 Code";
                end;

            end;
        }
        field(50003; "Employee Name"; Text[100])
        {
        }
        field(50004; "Shortcut Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            CaptionClass = '1,2,1';
        }
        field(50005; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            CaptionClass = '1,2,2';
        }
        field(50006; "Applied Days"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin

                CalcFields("Availlable Days");

                if (("Availlable Days" = 0) or ("Applied Days" > "Availlable Days")) then
                    Error('Applied days must not be more than leave balance.');
            end;
        }
        field(50007; "Starting Date"; Date)
        {
            trigger OnValidate()
            var
                LeaveManagement: Codeunit "Leave Management";
            begin
                if not LeaveManagement.DetermineIfIncludesNonWorking("Leave Type") then
                    if LeaveManagement.FnDetermineNonWorking("Starting Date") <> '' then
                        Error('You cannot have a non working day as a working');
            end;
        }
        field(50008; "End Date"; Date)
        {
            trigger OnValidate()
            var
                LeaveManagement: Codeunit "Leave Management";
            begin
                if "End Date" <> 0D then begin
                    TESTFIELD("Starting Date");
                    TESTFIELD("Leave Type");
                    TestField("End Date");

                    //Calculate no of days
                    "Applied Days" := LeaveManagement.FnCalculateDaysApplied("Leave Type", "Starting Date", "End Date");
                    "Return Date" := LeaveManagement.DetermineLeaveReturnDate("Leave Type", "End Date");
                end;
            end;
        }
        field(50009; Purpose; Text[200])
        {
        }
        field(50010; "Leave Type"; Code[20])
        {
            TableRelation = "Leave Types".Code;

            trigger OnValidate()
            begin
                CalcFields("Availlable Days");
                if Emp.Get("Employee No") then begin
                    Emp.CalcFields(Emp."Leave Balance");
                    "Leave Balance" := Emp."Leave Balance";
                end;
            end;
        }
        field(50011; "Leave Balance"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(50012; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50013; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Cancelled,Posted';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Cancelled,Posted;
        }
        field(50014; "User ID"; Code[30])
        {
        }
        field(50015; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR".Code;

            trigger OnValidate()
            begin
                TestField(Status, Status::Open);
            end;
        }
        field(50016; Posted; Boolean)
        {
        }
        field(50017; "Posted By"; Code[20])
        {
        }
        field(50018; "Posting Date"; Date)
        {
        }
        field(50019; "Process Leave Allowance"; Boolean)
        {
        }
        field(50020; "Availlable Days"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger"."No. of Days" where("Employee No" = field("Employee No"),
                                                                     "Leave Type" = field("Leave Type")));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(50021; "Return Date"; Date)
        {
        }
        field(50022; "Reliever No."; Code[30])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if Emp3.Get("Reliever No.") then
                    "Reliever Name" := Emp3."First Name" + ' ' + Emp3."Middle Name" + ' ' + Emp3."Last Name";
            end;
        }
        field(50023; "Reliever Name"; Text[250])
        {
        }
        field(50024; "Employee Dept"; Code[50])
        {
            CalcFormula = lookup("HR-Employee"."Shortcut Dimension 2 Code" where("No." = field("Employee No")));
            FieldClass = FlowField;
        }
        field(50025; HOD; Code[20])
        {
            CalcFormula = lookup("Dimension Value".HOD where(Code = field("Shortcut Dimension 2 Code")));
            FieldClass = FlowField;
        }
        field(50026; "Approver ID"; Code[20])
        {
            CalcFormula = lookup("HR-Employee"."User ID" where("No." = field(HOD)));
            FieldClass = FlowField;
        }
        field(50027; "Leave Period"; Code[20])
        {
            TableRelation = "HR Leave Calendar".Code;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        // IF Status<>Status::Open THEN ERROR('You can only delete a document if its status is still Open!')
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            GenLedgerSetup.Get();
            GenLedgerSetup.TestField(GenLedgerSetup."Leave Application Nos.");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Leave Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "User ID" := UserId;
        "Application Date" := Today;
        Status := Status::Open;

        if usersetup.Get(UserId) then begin
            if usersetup."Employee No." = '' then
                Error('You are not authorized to use the leave application page. Please consult the system administrator.');
            if Employee.Get(CopyStr(usersetup."Employee No.", 4, ((StrLen(usersetup."Employee No.")) - 3))) then begin
                "Employee No" := Employee."No.";
                Validate("Employee No");
                "Shortcut Dimension 1 Code" := usersetup."Global Dimension 1 Code";
                "Shortcut Dimension 2 Code" := usersetup."Global Dimension 2 Code";
                "Application Date" := Today;
            end;
        end;
    end;

    var
        BaseCalendar: Record "Base Calendar Change2";
        dates: Record Date;
        Emp: Record "HR-Employee";
        Emp3: Record "HR-Employee";
        Employee: Record "HR-Employee";
        EmpLeaveApps: Record "HR Leave Application";
        GeneralOptions: Record "HR Setup";
        GenLedgerSetup: Record "HR Setup";
        LeaveTypes: Record "Leave Types";
        objPeriod: Record "prPayroll Periods";
        usersetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ReturnDateLoop: Boolean;
        PayPeriod: Date;
        varDaysApplied: Integer;

    procedure DetermineIfIsNonWorking(var bcDate: Date; var ltype: Record "Leave Types") ItsNonWorking: Boolean
    var
        dates: Record Date;
    begin
        Clear(ItsNonWorking);
        GeneralOptions.Find('-');
        //One off Hollidays like Good Friday
        BaseCalendar.Reset();
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar.Date, bcDate);
        if BaseCalendar.Find('-') then
            if BaseCalendar.Nonworking = true then
                ItsNonWorking := true;

        // For Annual Holidays
        BaseCalendar.Reset();
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."recurring system"::"Annual Recurring");
        if BaseCalendar.Find('-') then
            repeat
                if ((Date2dmy(bcDate, 1) = BaseCalendar."Date Day") and (Date2dmy(bcDate, 2) = BaseCalendar."Date Month")) then
                    if BaseCalendar.Nonworking = true then
                        ItsNonWorking := true;
            until BaseCalendar.Next() = 0;

        if ItsNonWorking = false then begin
            // Check if its a weekend
            dates.Reset();
            dates.SetRange(dates."Period Type", dates."period type"::Date);
            dates.SetRange(dates."Period Start", bcDate);
            if dates.Find('-') then
                //if date is a sunday
                if dates."Period Name" = 'Sunday' then begin
                    //check if Leave includes sunday
                    if ltype."Inclusive of Sunday" = false then
                        ItsNonWorking := true;
                end else
                    if dates."Period Name" = 'Saturday' then
                        //check if Leave includes sato
                        if ltype."Inclusive of Saturday" = false then
                            ItsNonWorking := true;
        end;
    end;

    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[10]): Boolean
    begin
        if LeaveTypes.Get(fLeaveCode) then
            if LeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
    end;

    procedure DetermineLeaveReturnDate(var fBeginDate: Date; var fDays: Decimal) fReturnDate: Date
    var
        ltype: Record "Leave Types";
    begin
        ltype.Reset();
        if ltype.Get("Leave Type") then;
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
            if DetermineIfIncludesNonWorking("Leave Type") = false then begin
                fReturnDate := CalcDate('1D', fReturnDate);
                if DetermineIfIsNonWorking(fReturnDate, ltype) then
                    varDaysApplied := varDaysApplied + 1
                else
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied + 1
            end
            else begin
                fReturnDate := CalcDate('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;

    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    var
        ltype: Record "Leave Types";
    begin
        if ltype.Get("Leave Type") then;
        ReturnDateLoop := true;
        fEndDate := fDate;
        if fEndDate <> 0D then begin
            fEndDate := CalcDate('1D', fEndDate);
            while (ReturnDateLoop) do
                if DetermineIfIsNonWorking(fEndDate, ltype) then
                    fEndDate := CalcDate('-1D', fEndDate)
                else
                    ReturnDateLoop := false;
        end;
        exit(fEndDate);
    end;

    procedure GetPayPeriod()
    begin
        objPeriod.Reset();
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then
            PayPeriod := objPeriod."Date Opened";
    end;

    procedure CalcEndDate(SDate: Date; LDays: Integer) LEndDate: Date
    var
        ltype: Record "Leave Types";
        EndLeave: Boolean;
        DayCount: Integer;
    begin
        ltype.Reset();
        if ltype.Get("Leave Type") then;
        SDate := SDate - 1;
        if not DetermineIfIsNonWorking(SDate, ltype) then begin
            DayCount := 1;
            SDate := SDate + 1;
        end
        else
            DayCount := 1;

        EndLeave := false;
        while EndLeave = false do begin
            if not DetermineIfIsNonWorking(SDate, ltype) then
                DayCount := DayCount + 1;
            SDate := SDate + 1;
            if DayCount > LDays then
                EndLeave := true;
        end;
        LEndDate := SDate - 1;

        while DetermineIfIsNonWorking(LEndDate, ltype) = true do
            LEndDate := LEndDate + 1;
    end;

    procedure CalcReturnDate(EndDate: Date) RDate: Date
    var
        ltype: Record "Leave Types";
    begin
        if ltype.Get("Leave Type") then;

        /*  EndLeave:=FALSE;
         EndDate:=EndDate+1;
         LEndDate:=EndDate;
         CLEAR(DayCount);
         WHILE EndLeave=FALSE DO BEGIN
         IF NOT DetermineIfIsNonWorking(EndDate,ltype) THEN BEGIN
         DayCount:=DayCount+1;
         EndDate:=EndDate+1;

         END ELSE BEGIN
         EndLeave:=TRUE;
         END;
         END;
           */
        RDate := EndDate + 1;
        while DetermineIfIsNonWorking(RDate, ltype) = true do
            RDate := RDate + 1;
    end;

    procedure GetDate(var Applied_Dayes: Integer; var Start_Date: Date)
    begin
        /*clear(DaysCount);
        clear(NewDate);
         NewDate:=Start_Date;
        repeat
        DaysCount:=DaysCount+1;
        Last_is_WotkingDay:=false;
        until (() AND ()) */
    end;

    procedure ItsHolliday(var Start_Date: Date) holliday: Boolean
    var
        baseCal: Record "Base Calendar Change";
        bool_Non_Working: Boolean;
        days: Integer;
        Months: Integer;
    begin
        Clear(days);
        Clear(Months);
        Clear(bool_Non_Working);
        days := Date2dmy(Start_Date, 1);
        Months := Date2dmy(Start_Date, 2);
        baseCal.Reset();
        baseCal.SetFilter(baseCal."Recurring System", '=%1', baseCal."recurring system"::"Annual Recurring");
        if baseCal.Find('-') then
            repeat
                if ((Months = Date2dmy(baseCal.Date, 1)) and (days = Date2dmy(baseCal.Date, 1))) then
                    bool_Non_Working := true;
            until ((((Months = Date2dmy(baseCal.Date, 1)) and (days = Date2dmy(baseCal.Date, 1)))) or (baseCal.Next() = 0));
    end;

    procedure ItsSunday(var Start_Date: Date; var LeaveType: Integer)
    begin
    end;
}
