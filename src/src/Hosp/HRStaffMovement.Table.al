Table 52202830 "HR Staff Movement"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "Employee No"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if Emp.Get("Employee No") then begin
                    Emp.CalcFields(Emp."Leave Balance");
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;
            end;
        }
        field(4; "Employee Name"; Text[100])
        {
        }
        field(5; "Campus Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(6; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(7; "Reporting Reasons"; Option)
        {
            OptionCaption = ' ,Reporting for duty on first appointment,Reporting for duty from paid/Sabbatical leave,Reporting for duty from study leave,Reporting for duty from unpaid leave of absence,Reporting for duty from unauthorized absence';
            OptionMembers = " ","Reporting for duty on first appointment","Reporting for duty from paid/Sabbatical leave","Reporting for duty from study leave","Reporting for duty from unpaid leave of absence","Reporting for duty from unauthorized absence";
        }
        field(8; "Reporting Date"; Date)
        {
            trigger OnValidate()
            begin
                dates.Reset();
                dates.SetRange(dates."Period Start", "Reporting Date");
                dates.SetFilter(dates."Period Type", '=%1', dates."period type"::Date);
                if dates.Find('-') then
                    if ((dates."Period Name" = 'Sunday') or (dates."Period Name" = 'Saturday')) then
                        if (dates."Period Name" = 'Sunday') then
                            Error('You can not report on a Sunday')
                        else
                            if (dates."Period Name" = 'Saturday') then
                                Error('You can not report on a Saturday');

                BaseCalendar.Reset();
                BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
                BaseCalendar.SetRange(BaseCalendar.Date, "Reporting Date");
                if BaseCalendar.Find('-') then
                    repeat
                        if BaseCalendar.Nonworking = true then
                            if BaseCalendar.Description <> '' then
                                Error('You can not Report on a Holiday - ''' + BaseCalendar.Description + '''')
                            else
                                Error('You can not Report on a Holiday');
                    until BaseCalendar.Next() = 0;

                // For Annual Holidays
                BaseCalendar.Reset();
                BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
                BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."recurring system"::"Annual Recurring");
                if BaseCalendar.Find('-') then
                    repeat
                        if ((Date2dmy("Reporting Date", 1) = BaseCalendar."Date Day") and (Date2dmy("Reporting Date", 2) = BaseCalendar."Date Month")) then
                            if BaseCalendar.Nonworking = true then
                                if BaseCalendar.Description <> '' then
                                    Error('You can not Report on a Holiday - ''' + BaseCalendar.Description + '''')
                                else
                                    Error('You can not Report on a Holiday');
                    until BaseCalendar.Next() = 0;
            end;
        }
        field(9; "Absent Reasons"; Option)
        {
            OptionCaption = ' ,Study leave as from,Unpaid leave as from,Unauthorized absence as from,Beyond the approved leave';
            OptionMembers = " ","Study leave as from","Unpaid leave as from","Unauthorized absence as from","Beyond the approved leave";
        }
        field(10; "Absent From Date"; Date)
        {
        }
        field(11; "Release Staff"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(12; "Duties While Staff Is Away"; Text[250])
        {
        }
        field(13; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Cancelled,Posted';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Cancelled,Posted;
        }
        field(15; "User ID"; Code[30])
        {
        }
        field(16; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center BR".Code;

            trigger OnValidate()
            begin

                TestField(Status, Status::Open);
                // if not UserMgt.CheckRespCenter(1, "Responsibility Center") then
                //     Error(
                //       Text001,
                //RespCenter.TableCaption, UserMgt.GetPurchasesFilter);
                /*
               "Location Code" := UserMgt.GetLocation(1,'',"Responsibility Center");
               IF "Location Code" = '' THEN BEGIN
                 IF InvtSetup.GET THEN
                   "Inbound Whse. Handling Time" := InvtSetup."Inbound Whse. Handling Time";
               END ELSE BEGIN
                 IF Location.GET("Location Code") THEN;
                 "Inbound Whse. Handling Time" := Location."Inbound Whse. Handling Time";
               END;

               UpdateShipToAddress;
                  */
                /*
             CreateDim(
               DATABASE::"Responsibility Center","Responsibility Center",
               DATABASE::Vendor,"Pay-to Vendor No.",
               DATABASE::"Salesperson/Purchaser","Purchaser Code",
               DATABASE::Campaign,"Campaign No.");

             IF xRec."Responsibility Center" <> "Responsibility Center" THEN BEGIN
               RecreatePurchLines(FIELDCAPTION("Responsibility Center"));
               "Assigned User ID" := '';
             END;
               */
            end;
        }
        field(17; Posted; Boolean)
        {
        }
        field(18; "Posted By"; Code[20])
        {
        }
        field(19; "Posting Date"; Date)
        {
        }
        field(20; "Process Leave Allowance"; Boolean)
        {
        }
        field(21; "Availlable Days"; Decimal)
        {
            CalcFormula = sum("HR Leave Ledger"."No. of Days" where("Employee No" = field("Employee No")));
            DecimalPlaces = 0 : 0;
            FieldClass = FlowField;
        }
        field(22; "Return Date"; Date)
        {
        }
        field(23; "Reliever No."; Code[30])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                if Emp3.Get("Reliever No.") then
                    "Reliever Name" := Emp3."First Name" + ' ' + Emp3."Middle Name" + ' ' + Emp3."Last Name";
            end;
        }
        field(24; "Reliever Name"; Text[250])
        {
        }
        field(25; "Staff Movement Type"; Option)
        {
            OptionCaption = 'Release Of Staff,Resumption Of Staff';
            OptionMembers = "Release Of Staff","Resumption Of Staff";
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
        if Status <> Status::Open then
            Error('You can only delete a document if its status is still Open!')
    end;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            GenLedgerSetup.Get();
            GenLedgerSetup.TestField(GenLedgerSetup."Staff Application Nos.");
            NoSeriesMgt.InitSeries(GenLedgerSetup."Staff Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "User ID" := UserId;
        Date := Today;
        Status := Status::Open;

        if usersetup.Get(UserId) then begin
            if usersetup."Staff No" = '' then
                Error('You are not authorized to use the Staff Movement page. Please consult the system administrator.');
            if Employee.Get(CopyStr(usersetup."Staff No", 4, ((StrLen(usersetup."Staff No")) - 3))) then begin
                "Employee No" := Employee."No.";
                Validate("Employee No");
                "Campus Code" := usersetup."Global Dimension 1 Code";
                "Department Code" := usersetup."Global Dimension 2 Code";
                Date := Today;
            end;
        end;
    end;

    var
        BaseCalendar: Record "Base Calendar Change2";
        dates: Record Date;
        Emp: Record "HR-Employee";
        Emp3: Record "HR-Employee";
        Employee: Record "HR-Employee";
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
        if ltype.Get("Release Staff") then;
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
            if DetermineIfIncludesNonWorking("Release Staff") = false then begin
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
        if ltype.Get("Release Staff") then;
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
        if ltype.Get("Release Staff") then;
        SDate := SDate - 1;
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
        if ltype.Get("Release Staff") then;

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
