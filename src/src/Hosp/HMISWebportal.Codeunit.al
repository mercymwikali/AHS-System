Codeunit 52202442 "HMIS Webportal"
{
    Permissions = TableData "Approval Entry" = imd,
                  TableData "Approval Comment Line" = imd,
                  TableData "Posted Approval Entry" = imd,
                  TableData "Posted Approval Comment Line" = imd,
                  TableData "Overdue Approval Entry" = imd;

    trigger OnRun()
    begin
    end;

    var
        "Approvals management": Codeunit "Approvals Mgmt.";
        //ApprovalMgt: Codeunit UnknownCodeunit439;
        "HR Leave Application": Record "HR Leave Application";
        LeaveT: Record "HR Leave Application";
        "Employee Card": Record "HR-Employee";
        "Supervisor Card": Record "User Setup";
        HREmp: Record "HR-Employee";
        HRLeaveTypes: Record "Leave Types";
        dAlloc: Decimal;
        dEarnd: Decimal;
        dTaken: Decimal;
        dLeft: Decimal;
        cReimbsd: Decimal;
        cPerDay: Decimal;
        cbf: Decimal;
        varDaysApplied: Integer;
        HRLeaveApp: Record "HR Leave Application";
        HRSetup: Record "HR Setup";
        BaseCalendarChange: Record "Base Calendar Change";
        ReturnDateLoop: Boolean;
        LeaveGjline: Record "HR Employee Leave Journal";
        "LineNo.": Integer;
        HRLeave: Record "HR Leave Application";
        ApprovalMgtNotification: Codeunit "Notification Management";
        ApprovalEntry: Record "Approval Entry";
        ApprovalEntry_2: Record "Approval Entry";
        "Supervisor ID": Text;
        ApprovalSetup: Record "Approval Workflow Wizard";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NextLeaveApplicationNo: Code[20];
        filename: Text[100];
        "User Setup": Record "User Setup";
        "Salary Card": Record "prSalary Card";
        Customer: Record Customer;
        objCustomer: Record Customer;
        EmployeeUserId: Text;
        SupervisorId: Text;
        PeriodTrans: Record "prPeriod Transactions";
        BaseCalendar: Record "Base Calendar Change";
        test: Boolean;
        testDate: Date;
        GeneralOptions: Record "HR Setup";
        ltype: Record "Leave Types";
        dates: Record Date;
        LeaveTypes: Record "Leave Types";
        // ApprovalMgt1: Codeunit UnknownCodeunit70134706;
        LeaveEntry: Record "HR Leave Ledger";
        StoreRequisition: Record "Store Requistion Header";
        StoreRequestedLines: Record "Store Requistion Lines";
        StoreRequisition_2: Record "Store Requistion Header";
        TransportRequisition: Record "FLT-Transport Requisition";
        HRTravellingStaff: Record "FLT-Travel Requisition Staff";
        TransportRequisition_2: Record "FLT-Transport Requisition";
        ImprestRequisition: Record "Imprest Header";
        ImprestRequisitionLines: Record "Imprest Lines";
        CashOfficeSetup: Record "Cash Office Setup";
        "HR Staff Requisition": Record "HR Staff Requisition";
        objPurchaseHeader: Record "Purchase Header";
        objPurchaseLine: Record "Purchase Line";
        objPayableSetup: Record "Purchases & Payables Setup";
        objApprovalCommentLine: Record "Approval Comment Line";
        objHRJobApplicants: Record Applicants;
        objDimValues: Record "Dimension Value";
        objAcademicYear: Record "prPension Details";
        objReceipt: Record "HR Qualifications";
        objImprestSurrender: Record "Imprest Surrender Header";
        objCashOfficeSetup: Record "Cash Office Setup";
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        FILESPATH: Text[200];
        FILESPATHTEST: text[200];
        ObjPatient: Record "HMS Patient";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        objAppointment: Record "HMS Appointment Form Header";
        objNurseNote: Record "HMS Admission Form Nurse";
        objPatCharges: Record "HMS Patient Charges";
        HMSSetup: Record "HMS Setup";
        NewNo: Code[20];
        TreatmentHeader: Record "HMS Appointment Form Header";
        PharmHeader: Record "HMS Pharmacy Header";
        LabHeader: Record "HMS Laboratory Form Header";
        labheader2: Record "HMS Laboratory Form Header";
        ObservHeader: Record "HMS Observation Form Header";
        PhysioHeader: Record "HMS Observation Form Header";
        docHeader: Record "HMS Treatment Form Header";
        DocLabRequestLines: Record "HMS Laboratory Test Line";
        AdmissionHeader: Record "HMS Admission Form Header";
        LabTestLines: Record "HMS Laboratory Test Line";
        HMSCharges: Record "HMS Charges";
        HMSPatientsCharges: Record "HMS Patient Charges";
        AppType: Record "HMS Setup Appointment Type";
        DoctorsRec: Record "HMS Setup Doctor";
        Patient: Record "HMS Patient";
        ObjSigns: Record "HMS Observation Signs";
        ObjSymptons: Record "HMS Observation Symptoms";
        ObjLab: Record "HMS Treatment Form Laboratory";
        HMSTreatH: Record "HMS Treatment Form Laboratory";
        Labec: Record "HMS Setup Lab Test";
        ObjTheatre: Record "HMS Treatment Form Header";
        DaysBtwnTodayAndLastVisit: Integer;
        ObjObservInjection: Record "HMS Observation Form Injection";
        ObservProcess: Record "HMS Observation Form Line Proc";
        ObjDiagnosis: Record "HMS Treatment Form Diagnosis";
        ObjInjection: Record "HMS Treatment Form Injection";
        ObjPrescription: Record "HMS Treatment Form Drug";
        ObjAdmission: Record "HMS Treatment Admission";
        ObjReferral: Record "HMS Treatment Form Radiology";
        ObjRadiology: Record "HMS Treatment Form Radiology";
        TreatmentLine: Record "HMS Treatment Form Process";
        ObsLine: Record "HMS Observation Form Line Proc";
        Immunization: Record "HMS Patient Immunization";
        ImmuneSetup: Record "HMS Setup Immunization";
        objNotes: Record "hms Notes";
        DrugPrescribe: Record "HMS Admission Drug Prescribe";
        AdmissionLine: Record "HMS Admission Drug Prescribe";
        PharmLine: Record "HMS Pharmacy Line";
        LineNo: Integer;
        ObservationH: Record "HMS Observation Form Header";
        TransferHeader: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        ObjItem: Record Item;
        RadiologyLines: Record "HMS Radiology Form Line";
        LaboratoryLines: Record "HMS Laboratory Test Line";
        ObjSpecimen: Record "HMS Setup Specimen";
        ObjMeasuring: Record "HMS Setup Measuring Unit";
        RadiologyHeader: Record "HMS Radiology Form Header";
        StaffClaims: Record "Staff Claims Header";
        OperationalNotes: Record "hms Notes";
        DischargeSummary: Record "HMS Treatment Form Header";
        AdmissionDischargeHeader: Record "HMS Admission Discharge Header";
        HMSQue: Record "HMS Doctor Queue";
        UserSetUpPortal: Record "User Setup";
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ItemJnlLine: Record "Item Journal Line";
        Location: Record Location;
        TransShptHeader: Record "Transfer Shipment Header";
        TransShptLine: Record "Transfer Shipment Line";
        TransHeader: Record "Transfer Header";
        TransLine: Record "Transfer Line";
        TransLine2: Record "Transfer Line";
        WhseRqst: Record "Warehouse Request";
        WhseShptHeader: Record "Warehouse Shipment Header";
        TempWhseShptHeader: Record "Warehouse Shipment Header" temporary;
        WhseShptLine: Record "Warehouse Shipment Line";
        PostedWhseShptHeader: Record "Posted Whse. Shipment Header";
        PostedWhseShptLine: Record "Posted Whse. Shipment Line";
        TempWhseSplitSpecification: Record "Tracking Specification" temporary;
        TempHandlingSpecification: Record "Tracking Specification" temporary;
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        DimMgt: Codeunit DimensionManagement;
        WhseTransferRelease: Codeunit "Whse.-Transfer Release";
        ReserveTransLine: Codeunit "Transfer Line-Reserve";
        WhsePostShpt: Codeunit "Whse.-Post Shipment";
        InvtAdjmt: Codeunit "Inventory Adjustment";
        SourceCode: Code[10];
        HideValidationDialog: Boolean;
        HeaderDeleted: Boolean;
        WhseShip: Boolean;
        WhsePosting: Boolean;
        InvtPickPutaway: Boolean;
        WhseReference: Integer;
        OriginalQuantity: Decimal;
        OriginalQuantityBase: Decimal;
        Text001: label 'There is nothing to post.';
        Text002: label 'Warehouse handling is required for Transfer order = %1, %2 = %3.';
        Text003: label 'Posting transfer lines     #2######';
        Text004: label 'Transfer Order %1';
        Text005: label 'The combination of dimensions used in transfer order %1 is blocked. %2';
        Text006: label 'The combination of dimensions used in transfer order %1, line no. %2 is blocked. %3';
        Text007: label 'The dimensions that are used in transfer order %1, line no. %2 are not valid. %3.';
        Text008: label 'This order must be a complete shipment.';
        Text009: label 'Item %1 is not in inventory.';
        WhseReceive: Boolean;
        WhseRcptHeader: Record "Warehouse Receipt Header";
        TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary;
        WhseRcptLine: Record "Warehouse Receipt Line";
        PostedWhseRcptHeader: Record "Posted Whse. Receipt Header";
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        WhseEntry: Record "Warehouse Entry";
        TempItemEntryRelation2: Record "Item Entry Relation" temporary;
        TransRcptHeader: Record "Transfer Receipt Header";
        TransRcptLine: Record "Transfer Receipt Line";
        WhsePostRcpt: Codeunit "Whse.-Post Receipt";
        TransRcptHeader2: Record "Transfer Shipment Header";
        TransRcptLine2: Record "Transfer Shipment Line";
        ValueEntry: Record "Value Entry";
        ObjPhysioTreat: Record "HMS Physio Treatment";
        PhysioTypes: Record "HMS Physio Line Process";
        LabResults: Record "HMS Laboratory Results Entry";
        LabResults2: Record "HMS Laboratory Results Entry";
        LabResultsEntry: Record "HMS Laboratory Results Entry";
        PharmacyLine: Record "HMS Pharmacy Line";
        PhysioEvalution: Record "HMS Physio Line Process";
        OutpatientPro: Record "hms Notes";
        ObjUser: Record User;
        LabParameters: Record "HMS Lab Parameters setup";

    procedure HRLeaveValidateDaysApplied(EmployeeNo: Text; "Leave Type": Text; "Days Applied": Integer)
    begin
        HREmp.Get(EmployeeNo);
        if "Days Applied" < 0 then
            Error('Days applied cannot be less than zero');

        if "Leave Type" = 'ANNUAL' then begin
            //HRGetLeaveStatics(EmployeeNo,"Leave Type");
            // IF "Days Applied">dLeft THEN
            if "Days Applied" > 90 then
                Error('Days applied cannot exceed Employee leave balance for this leave');
        end else begin
            HRLeaveTypes.Reset;
            HRLeaveTypes.SetRange(HRLeaveTypes.Code, "Leave Type");
            if HRLeaveTypes.Find('-') then begin
                if "Days Applied" > HRLeaveTypes.Days then
                    Error('Days applied cannot exceed leave balance for this leave');
            end;

        end;

        //IF "Leave Type" = 'MATERNITY' THEN
        //HRLeaveTypes.RESET;
        //HRLeaveTypes.SETRANGE(HRLeaveTypes.Code,"Leave Type");
        //IF HRLeaveTypes.FIND('-') THEN BEGIN
        //IF "Days Applied" < HRLeaveTypes.Days THEN
        //ERROR('Days applied cannot be less than '+FORMAT(HRLeaveTypes.Days));
        //END;
    end;

    procedure DetermineLeaveReturnDate(fBeginDate: Date; fDays: Decimal; "Leave Type": Code[50]) fReturnDate: Date
    begin
        varDaysApplied := fDays;
        fReturnDate := fBeginDate;
        repeat
            if DetermineIfIncludesNonWorking("Leave Type") = false then begin
                fReturnDate := CalcDate('1D', fReturnDate);
                if DetermineIfIsNonWorking(fReturnDate) then
                    varDaysApplied := varDaysApplied + 1
                else
                    varDaysApplied := varDaysApplied;
                varDaysApplied := varDaysApplied - 1
            end
            else begin
                fReturnDate := CalcDate('1D', fReturnDate);
                varDaysApplied := varDaysApplied - 1;
            end;
        until varDaysApplied = 0;
        exit(fReturnDate);
    end;

    procedure DetermineIfIncludesNonWorking(var fLeaveCode: Code[50]): Boolean
    begin
        if HRLeaveTypes.Get(fLeaveCode) then begin
            if HRLeaveTypes."Inclusive of Non Working Days" = true then
                exit(true);
        end;
    end;

    procedure DetermineIfIsNonWorking(var bcDate: Date) Isnonworking: Boolean
    begin

        //HRSetup.FIND('-');
        //HRSetup.TESTFIELD(HRSetup."Base Calendar");
        BaseCalendarChange.SetFilter(BaseCalendarChange."Base Calendar Code", HRSetup."Base Calendar");
        BaseCalendarChange.SetRange(BaseCalendarChange.Date, bcDate);

        if BaseCalendarChange.Find('-') then begin
            if BaseCalendarChange.Nonworking = false then
                Error('Start date can only be a Working Day Date');
            exit(true);
        end;
    end;

    procedure DeterminethisLeaveEndDate(var fDate: Date) fEndDate: Date
    begin
        ReturnDateLoop := true;
        fEndDate := fDate;
        if fEndDate <> 0D then begin
            fEndDate := CalcDate('-1D', fEndDate);
            while (ReturnDateLoop) do begin
                if DetermineIfIsNonWorking(fEndDate) then
                    fEndDate := CalcDate('-1D', fEndDate)
                else
                    ReturnDateLoop := false;
            end
        end;
        exit(fEndDate);
    end;

    procedure CalcEndDate(SDate: Date; LDays: Integer; "Leave Type": Text) LEndDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
    begin
        SDate := SDate;
        EndLeave := false;
        DayCount := 1;
        while EndLeave = false do begin
            if not DetermineIfIsNonWorking(SDate) then
                DayCount := DayCount + 1;
            SDate := SDate + 1;
            if DayCount > LDays then
                EndLeave := true;
        end;
        LEndDate := SDate - 1;

        while DetermineIfIsNonWorking(LEndDate) = true do begin
            LEndDate := LEndDate + 1;
        end;
    end;

    procedure CalcReturnDate(EndDate: Date; "Leave Type": Text) RDate: Date
    var
        EndLeave: Boolean;
        DayCount: Integer;
        LEndDate: Date;
    begin
        if ltype.Get("Leave Type") then begin
        end;
        RDate := EndDate + 1;
        while DetermineIfIsNonWorking(RDate) = true do begin
            RDate := RDate + 1;
        end;
    end;

    procedure ValidateStartDate("Starting Date": Date)
    begin
        dates.Reset;
        dates.SetRange(dates."Period Start", "Starting Date");
        dates.SetFilter(dates."Period Type", '=%1', dates."period type"::Date);
        if dates.Find('-') then
            /* IF ((dates."Period Name"='Sunday') OR (dates."Period Name"='Saturday')) THEN BEGIN
             IF (dates."Period Name"='Sunday') THEN ERROR('You can not start your leave on a Sunday')
             ELSE IF (dates."Period Name"='Saturday') THEN ERROR('You can not start your leave on a Saturday')
             END;*/

        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar.Date, "Starting Date");
        if BaseCalendar.Find('-') then begin
            repeat
                if BaseCalendar.Nonworking = true then begin
                    if BaseCalendar.Description <> '' then
                        Error('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                    else
                        Error('You can not start your Leave on a Holiday');
                end;
            until BaseCalendar.Next = 0;
        end;

        // For Annual Holidays
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."recurring system"::"Annual Recurring");
        if BaseCalendar.Find('-') then begin
            repeat
                if (("Starting Date" = BaseCalendar.Date)) then begin
                    if BaseCalendar.Nonworking = true then begin
                        if BaseCalendar.Description <> '' then
                            Error('You can not start your Leave on a Holiday - ''' + BaseCalendar.Description + '''')
                        else
                            Error('You can not start your Leave on a Holiday');
                    end;
                end;
            until BaseCalendar.Next = 0;
        end;

    end;

    procedure StoreRequisitionCreate("Employee No": Text; RequestType: Option; "Date Required": Date; "Campus Code": Text; "Dept Code": Text; Description: Text; ResponsiblityCenter: Code[20])
    var
        NextApplicationNo: Text;
        status: Option;
    begin
        StoreRequisition.Init;
        NextApplicationNo := NoSeriesMgt.GetNextNo('SRN', 0D, true);

        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", "Employee No");
        if "Employee Card".Find('-')
        then begin
            StoreRequisition."User ID" := "Employee Card"."User ID";
            StoreRequisition."Requester ID" := "Employee Card"."User ID";
            StoreRequisition."Request Description" := Description;
        end;
        StoreRequisition."No." := NextApplicationNo;
        StoreRequisition."Request date" := Today;
        StoreRequisition."Required Date" := "Date Required";
        StoreRequisition."Requisition Type" := RequestType;
        // StoreRequisition."Global Dimension 1 Code":="Dept Code";
        // StoreRequisition.VALIDATE(StoreRequisition."Global Dimension 1 Code");
        StoreRequisition."Shortcut Dimension 2 Code" := "Dept Code";
        StoreRequisition.Validate(StoreRequisition."Shortcut Dimension 2 Code");
        StoreRequisition.Status := StoreRequisition.Status::Open;
        StoreRequisition."Responsibility Center" := ResponsiblityCenter;
        StoreRequisition."No. Series" := 'STORE';
        StoreRequisition."Employee No" := "Employee No";
        status := StoreRequisition.Status;

        StoreRequisition.Insert;
    end;

    procedure StoreRequisitionLines("Requisition No": Text; ItemNo: Text; Qnty: Decimal; Description: Text)
    begin
        StoreRequisition.Reset;
        StoreRequestedLines.Init;
        StoreRequestedLines.Type := StoreRequestedLines.Type::Item;
        StoreRequestedLines."Requistion No" := "Requisition No";
        StoreRequestedLines."No." := ItemNo;
        StoreRequestedLines.Description := Description;
        StoreRequestedLines.Quantity := Qnty;
        StoreRequestedLines.Validate(StoreRequestedLines.Quantity);
        StoreRequestedLines."Quantity Requested" := Qnty;
        StoreRequestedLines.Validate(StoreRequestedLines."No.");
        StoreRequestedLines.Validate(StoreRequestedLines."Unit Cost");
        StoreRequestedLines.Validate(StoreRequestedLines."Quantity Requested");
        //StoreRequestedLines.CheckStocklevel;
        StoreRequestedLines.Insert;
    end;

    procedure StoreRequsitionRemoveLine(LineNo: Integer)
    begin
        StoreRequestedLines.Reset;
        StoreRequestedLines.SetRange(StoreRequestedLines."Line No.", LineNo);
        if StoreRequestedLines.Find('-') then begin
            StoreRequestedLines.Delete;
        end;
    end;

    procedure StoreRequistionLineUpdate(LineNo: Integer; Qnty: Decimal)
    begin
        StoreRequestedLines.Reset;
        StoreRequestedLines.SetRange(StoreRequestedLines."Line No.", LineNo);
        if StoreRequestedLines.Find('-') then begin
            StoreRequestedLines.Quantity := Qnty;
            StoreRequestedLines.Validate(StoreRequestedLines.Quantity);
            StoreRequestedLines."Quantity Requested" := Qnty;
            StoreRequestedLines.Validate(StoreRequestedLines."Quantity Requested");
            StoreRequestedLines.Modify;
            Message('Record successfully updated');
        end;
    end;

    procedure StoreRequisitionApprovalRequest(ReqNo: Text)
    var
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        tableNo: Integer;
    begin
        StoreRequisition.Reset;
        StoreRequisition.SetRange(StoreRequisition."No.", ReqNo);
        if StoreRequisition.Find('-') then begin
            VarVariant := StoreRequisition;
            if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                CustomApprovals.OnSendDocForApproval(VarVariant);
        end;
    end;

    procedure TransportRequisitionCreate("Employee No": Text; Destination: Text; CommenceFrom: Text; "Date of Trip": Date; Purpose: Text; "No of Days": Integer; "No of Passengers": Integer; "Request Type": Option; "Travel Type": Option; ResponsibilityCenter: Code[20])
    var
        NextTransportApplicationNo: Text;
    begin
        TransportRequisition.Init;
        NextTransportApplicationNo := NoSeriesMgt.GetNextNo('TR', 0D, true);
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", "Employee No");

        if "Employee Card".Find('-')
        then begin
            TransportRequisition."Requested By" := "Employee Card"."User ID";
            TransportRequisition.Department := "Employee Card"."Shortcut Dimension 2 Code";
            TransportRequisition.Name := "Employee Card"."Search Name";
            "Supervisor Card".Reset;
            "Supervisor Card".SetRange("Supervisor Card"."User ID", "Employee Card"."User ID");
            if "Supervisor Card".Find('-')
            then begin
                SupervisorId := "Supervisor Card"."Approver ID";
            end;
        end;

        TransportRequisition."Transport Requisition No" := NextTransportApplicationNo;
        TransportRequisition.Commencement := CommenceFrom;
        TransportRequisition.Destination := Destination;
        TransportRequisition."Date of Request" := Today;
        TransportRequisition."Time Requested" := Time;
        TransportRequisition."Date of Trip" := "Date of Trip";
        TransportRequisition."Purpose of Trip" := Purpose;
        TransportRequisition."No. Series" := 'TR';
        TransportRequisition."Responsibility Center" := ResponsibilityCenter;

        TransportRequisition."No of Days Requested" := "No of Days";
        TransportRequisition."No Of Passangers" := "No of Passengers";
        TransportRequisition.Insert;
    end;

    procedure TravelRequisitionApprovalRequest(ReqNo: Text)
    var
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        ApprovalMgt: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
    begin
        TransportRequisition.Reset;
        TransportRequisition.SetRange(TransportRequisition."Transport Requisition No", ReqNo);
        if TransportRequisition.Find('-')
        then begin
            VarVariant := TransportRequisition;
            ApprovalMgt.OnSendDocForApproval(VarVariant);
        end;
    end;

    procedure ImprestRequisitionCreate("Employee No": Text; SchoolCode: Text; "Date Required": Date; "Campus Code": Text; "Dept Code": Text; Description: Text; ResponsibilityCenter: Code[20])
    var
        NextApplicationNo: Text;
        status: Option;
    begin
        ImprestRequisition.Init;
        NextApplicationNo := NoSeriesMgt.GetNextNo('IMP', 0D, true);
        //MESSAGE(NextApplicationNo);


        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", "Employee No");
        if "Employee Card".Find('-')
        then begin
            ImprestRequisition."Requested By" := "Employee Card"."User ID";
            ImprestRequisition.Purpose := Description;
            objCustomer.Reset;
            //objCustomer.SETRANGE(objCustomer."Employee Job Group","Employee No");
            objCustomer.SetRange(objCustomer."No.", "Employee No");
            objCustomer.SetRange(objCustomer."Customer Posting Group", 'STAFF-IMP');
            if objCustomer.Find('-') then
                ImprestRequisition."Account No." := objCustomer."No.";
        end;


        ImprestRequisition."No." := NextApplicationNo;
        ImprestRequisition.Date := Today;
        ImprestRequisition."Global Dimension 1 Code" := "Dept Code";
        ImprestRequisition.Validate(ImprestRequisition."Global Dimension 1 Code");
        ImprestRequisition."Shortcut Dimension 2 Code" := "Campus Code";
        ImprestRequisition.Validate(ImprestRequisition."Shortcut Dimension 2 Code");
        ImprestRequisition."Shortcut Dimension 3 Code" := SchoolCode;
        ImprestRequisition.Validate(ImprestRequisition."Shortcut Dimension 4 Code");
        ImprestRequisition."Account Type" := ImprestRequisition."account type"::Customer;
        ImprestRequisition."Employee No." := "Employee No";

        ImprestRequisition.Validate(ImprestRequisition."Account No.");
        ImprestRequisition."Responsibility Center" := ResponsibilityCenter;
        ImprestRequisition.Status := ImprestRequisition.Status::Pending;
        ImprestRequisition."No. Series" := 'IMPREST';
        ImprestRequisition.Insert;
    end;

    procedure ImprestRequisitionLinesCreate("Requisition No": Text; ItemNo: Text; ReqAmount: Decimal)
    begin
        ImprestRequisitionLines.Init;
        ImprestRequisitionLines.No := "Requisition No";
        ImprestRequisitionLines."Advance Type" := ItemNo;
        //ImprestRequisitionLines."Account No:":=ItemNo;
        ImprestRequisitionLines.Validate(ImprestRequisitionLines.No);
        ImprestRequisitionLines.Amount := ReqAmount;
        ImprestRequisitionLines.Validate(ImprestRequisitionLines."Advance Type");

        ImprestRequisitionLines.Insert(true);
    end;

    procedure ImprestRequistionLineUpdate(ReqNo: Text; AccountNo: Text; ReqAmount: Decimal)
    begin
        ImprestRequisitionLines.Reset;
        ImprestRequisitionLines.SetRange(ImprestRequisitionLines.No, ReqNo);
        ImprestRequisitionLines.SetRange(ImprestRequisitionLines."Account No:", AccountNo);
        if ImprestRequisitionLines.Find('-') then begin
            ImprestRequisitionLines.Amount := ReqAmount;
            ImprestRequisitionLines.Modify;
            Message('Record successfully updated');
        end;
    end;

    procedure ImprestRequsitionRemoveLine(ReqNo: Text; AccountNo: Text)
    begin
        ImprestRequisitionLines.Reset;
        ImprestRequisitionLines.SetRange(ImprestRequisitionLines.No, ReqNo);
        ImprestRequisitionLines.SetRange(ImprestRequisitionLines."Account No:", AccountNo);
        if ImprestRequisitionLines.Find('-') then begin
            ImprestRequisitionLines.Delete;
        end;
    end;

    procedure ImprestRequisitionApprovalRequest(ReqNo: Text)
    var
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        tableNo: Integer;
    begin
        ImprestRequisition.Reset;
        ImprestRequisition.SetRange(ImprestRequisition."No.", ReqNo);
        if ImprestRequisition.Find('-') then begin
            VarVariant := ImprestRequisition;
            if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                CustomApprovals.OnSendDocForApproval(VarVariant);
        end;
    end;

    procedure ImprestRequisitionCancelRequest(ImprestNo: Text)
    begin
        ImprestRequisition.Reset;
        ImprestRequisition.SetRange(ImprestRequisition."No.", ImprestNo);
        if ImprestRequisition.Find('-') then begin
            VarVariant := ImprestRequisition;
            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
        end;
    end;

    procedure DocumentApprovals("Document No": Text; "Supervisor ID param": Text)
    var
        ApprovalMgt: Codeunit "Custom Approvals Codeunit";
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Document No");
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", "Supervisor ID param");
        //mESSAGE("Supervisor ID param");
        if ApprovalEntry.Find('-') then
            //  ApprovalMgt.ApproveApprovalRequest(ApprovalEntry);
            "Approvals management".ApproveApprovalRequests(ApprovalEntry);
    end;

    procedure PurchaseRequisitionCreate("Employee No": Text; "Campus Code": Text; "Dept Code": Text; Description: Text; ResponsiblityCenter: Code[20]; Vendor: Text)
    var
        NextApplicationNo: Text;
        status: Option;
    begin
        objPayableSetup.Get();
        objPayableSetup.TestField(objPayableSetup."Quote Nos.");

        objPurchaseHeader.Init;
        NextApplicationNo := NoSeriesMgt.GetNextNo(objPayableSetup."Quote Nos.", 0D, true);
        objPurchaseHeader."No." := NextApplicationNo;
        objPurchaseHeader."Buy-from Vendor No." := Vendor;
        objPurchaseHeader."Pay-to Vendor No." := Vendor;
        objPurchaseHeader."Document Type" := objPurchaseHeader."document type"::Quote;
        objPurchaseHeader.SetHideValidationDialog(true);
        objPurchaseHeader.Validate(objPurchaseHeader."Buy-from Vendor No.");
        objPurchaseHeader.Validate(objPurchaseHeader."Pay-to Vendor No.");
        objPurchaseHeader."Requested Receipt Date" := Today;
        objPurchaseHeader."Order Date" := Today;
        objPurchaseHeader."Document Date" := Today;
        objPurchaseHeader."No. Series" := objPayableSetup."Quote Nos.";
        objPurchaseHeader."Posting No. Series" := objPayableSetup."Posted Invoice Nos.";
        objPurchaseHeader."Receiving No. Series" := objPayableSetup."Posted Receipt Nos.";
        objPurchaseHeader.Validate(objPurchaseHeader."No. Series");
        objPurchaseHeader."Posting Description" := Description;
        objPurchaseHeader."Shortcut Dimension 1 Code" := "Dept Code";
        objPurchaseHeader."Shortcut Dimension 2 Code" := "Campus Code";
        objPurchaseHeader."Responsibility Center" := ResponsiblityCenter;
        objPurchaseHeader."Due Date" := Today;
        objPurchaseHeader.DocApprovalType := 1;
        objPurchaseHeader."Employee No." := "Employee No";

        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", "Employee No");

        if "Employee Card".Find('-')
        then begin
            objPurchaseHeader."Assigned User ID" := "Employee Card"."User ID";
        end;
        objPurchaseHeader.Insert;

        objPurchaseHeader.Reset;
        objPurchaseHeader.SetRange(objPurchaseHeader."No.", NextApplicationNo);
        if objPurchaseHeader.Find('-') then begin
            objPurchaseHeader.Validate(objPurchaseHeader."Shortcut Dimension 2 Code");
            objPurchaseHeader.Validate(objPurchaseHeader."Shortcut Dimension 1 Code");
            objPurchaseHeader.Modify;
        end;
    end;

    procedure PurchaseRequisitionLines("Requisition No": Text; ItemNo: Text; Qnty: Decimal; Description: Text; LineType: Option " ","G/L Account",Item,,"Fixed Asset","Charge (Item)"; Location: Text; UnitCost: Decimal)
    begin
        objPurchaseHeader.Reset;
        objPurchaseLine.Reset;
        objPurchaseLine.SetRange(objPurchaseLine."Document Type", objPurchaseLine."document type"::Quote);
        objPurchaseLine.SetFilter(objPurchaseLine."Document No.", "Requisition No");
        if objPurchaseLine.FindLast then
            "LineNo." := objPurchaseLine."Line No.";

        objPurchaseLine.Init;
        objPurchaseLine."Line No." := "LineNo." + 1;
        objPurchaseLine."Document Type" := objPurchaseLine."document type"::Quote;
        objPurchaseLine."Document No." := "Requisition No";
        objPurchaseLine.Type := LineType;
        objPurchaseLine."No." := ItemNo;
        objPurchaseLine.Validate(objPurchaseLine."No.");
        objPurchaseLine.Quantity := Qnty;
        objPurchaseLine."Direct Unit Cost" := UnitCost;
        objPurchaseLine."Location Code" := Location;
        objPurchaseLine.Validate(objPurchaseLine.Quantity);
        objPurchaseLine.Insert(true);
    end;

    procedure PurchaseRequisitionApprovalRequest(ReqNo: Text)
    var
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        tableNo: Integer;
    begin
        objPurchaseHeader.Reset;
        Message(ReqNo);
        objPurchaseHeader.SetRange(objPurchaseHeader."No.", ReqNo);
        if objPurchaseHeader.Find('-')
        then begin
            State := State::Open;
            if objPurchaseHeader.Status <> objPurchaseHeader.Status::Open then State := State::"Pending Approval";
            DocType := Doctype::Quote;
            Clear(tableNo);
            tableNo := 38;
            Message(objPurchaseHeader."Assigned User ID");
            //ApprovalMgt.SendApproval(tableNo,objPurchaseHeader."No.",DocType,State,objPurchaseHeader."Assigned User ID",objPurchaseHeader."Responsibility Center");
            if ApprovalsMgmt.CheckPurchaseApprovalPossible(objPurchaseHeader) then
                ApprovalsMgmt.OnSendPurchaseDocForApproval(objPurchaseHeader);

        end;
    end;

    procedure PurchaseRequsitionRemoveLine(LineNo: Integer)
    begin
        objPurchaseLine.Reset;
        objPurchaseLine.SetRange(objPurchaseLine."Line No.", LineNo);
        if objPurchaseLine.Find('-') then begin
            objPurchaseLine.Delete;
        end;
    end;

    procedure PurchaseRequistionLineUpdate(LineNo: Integer; Qnty: Decimal)
    begin
        objPurchaseLine.Reset;
        objPurchaseLine.SetRange(objPurchaseLine."Line No.", LineNo);
        if objPurchaseLine.Find('-') then begin
            objPurchaseLine.Quantity := Qnty;
            objPurchaseLine.Validate(objPurchaseLine.Quantity);
            objPurchaseLine.Modify;
            Message('Record successfully updated');
        end;
    end;

    procedure ApprovalDocument(DocumentNo: Code[20]; WebUser: Code[20])
    var
        ApprovalMgt: Codeunit "Approvals Mgmt.";
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocumentNo);
        if ApprovalEntry.Find('-') then
            ApprovalMgt.ApproveApprovalRequests(ApprovalEntry);
    end;

    procedure DocumentRejections("Document No": Text; "Supervisor ID param": Text)
    var
        ApprovalMgt: Codeunit "Approvals Mgmt.";
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Document No");
        if ApprovalEntry.Find('-') then
            ApprovalMgt.RejectApprovalRequests(ApprovalEntry);
        //ApprovalMgt1.RejectApprovalRequest(ApprovalEntry,"Supervisor ID param");
    end;

    procedure DocumentRejectionCommentLine(DocumentNo: Code[20]; CommentLineText: Text[80]; WebUser: Code[20]; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition","Staff Update",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary; "Table ID": Integer)
    var
        NextDocNumber: Integer;
    begin
        objApprovalCommentLine.Reset;
        objApprovalCommentLine.SetCurrentkey("Entry No.");
        if objApprovalCommentLine.FindLast then
            NextDocNumber := objApprovalCommentLine."Entry No." + 1;

        objApprovalCommentLine.Init;
        objApprovalCommentLine."Entry No." := NextDocNumber;
        objApprovalCommentLine."Table ID" := "Table ID";
        objApprovalCommentLine."Document Type" := DocumentType;
        objApprovalCommentLine."Document No." := DocumentNo;
        objApprovalCommentLine."User ID" := WebUser;
        objApprovalCommentLine.Comment := CommentLineText;
        objApprovalCommentLine."Date and Time" := CurrentDatetime;


        objApprovalCommentLine.Insert;
    end;

    procedure fnReturnNoSeries(NoSeriesCode: Text) NextApplicationNo: Text
    begin
        NextApplicationNo := NoSeriesMgt.GetNextNo(NoSeriesCode, 0D, true);
        exit(NextApplicationNo);
    end;

    procedure fnImprestSurrender("Imprest No": Code[40]; StaffNo: Code[100])
    begin
        objImprestSurrender.Init;
        objCashOfficeSetup.Get();

        objImprestSurrender.No := NoSeriesMgt.GetNextNo(objCashOfficeSetup."Imprest Surrender No", 0D, true);
        objImprestSurrender."Surrender Date" := Today;
        objImprestSurrender.Cashier := fnGetUserId(StaffNo);
        objImprestSurrender."Received From" := fnGetUserSearchName(StaffNo);
        objImprestSurrender."Account No." := fnGetUserImprestAccount(StaffNo);
        objImprestSurrender."No. Series" := objCashOfficeSetup."Imprest Surrender No";
        objImprestSurrender."Account Type" := objImprestSurrender."account type"::Customer;
        objImprestSurrender."Employee No" := StaffNo;
        objImprestSurrender.Validate(objImprestSurrender."Imprest Issue Doc. No");
        objImprestSurrender.Validate(objImprestSurrender.Type);
        objImprestSurrender.Validate(objImprestSurrender."Shortcut Dimension 3 Code");
        objImprestSurrender.Validate(objImprestSurrender."Shortcut Dimension 4 Code");

        objImprestSurrender.Insert;
    end;

    local procedure fnGetUserId(StaffNo: Code[50]) staff_userid: Code[100]
    begin
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", StaffNo);

        if "Employee Card".Find('-')
        then begin
            staff_userid := "Employee Card"."User ID";
        end;
        exit(staff_userid)
    end;

    local procedure fnGetUserSearchName(StaffNo: Code[100]) SearchName: Text
    begin
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", StaffNo);

        if "Employee Card".Find('-')
        then begin
            SearchName := "Employee Card"."Search Name";
        end;
        exit(SearchName)
    end;

    procedure fnGetUserImprestAccount(StaffNo: Code[100]) AccountNo: Text
    begin
        objCustomer.Reset;
        objCustomer.SetRange(objCustomer."Employee Job Group", StaffNo);
        objCustomer.SetRange(objCustomer."Customer Posting Group", 'IMPREST');
        if objCustomer.Find('-') then begin
            AccountNo := objCustomer."No.";
        end;
        exit(AccountNo);
    end;

    procedure FnUpdateEmployeeInfo(employeeNo: Code[30]; cellularNo: Text[30]; phoneNumber: Text[30]; personalEmail: Text[50]; city: Text[20]; postalCode: Text[20]; postalAddress: Text[20])
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."No.", employeeNo);
        if HREmp.Find('-') then begin
            HREmp."Cellular Phone Number" := cellularNo;
            HREmp."Home Phone Number" := phoneNumber;
            HREmp."E-Mail" := personalEmail;
            HREmp.City := city;
            HREmp."Post Code" := postalCode;
            HREmp."Postal Address" := postalAddress;
            HREmp.Modify;
        end;
    end;

    procedure IsPasswordChanged(StdNo: Code[20]) ReturnValue: Boolean
    begin
        objCustomer.Reset;
        objCustomer.SetRange(objCustomer."No.", StdNo);
        if objCustomer.Find('-') then begin
            if objCustomer.Password <> '' then begin
                exit(true);
            end
            else begin
                exit(false);
            end;
        end;
    end;

    procedure SubmitPassword(StdNo: Code[20]; Password: Text[20])
    begin
        objCustomer.Reset;
        objCustomer.SetRange(objCustomer."No.", StdNo);
        if objCustomer.Find('-') then
            objCustomer.Password := Password;
        objCustomer.Modify(true);
    end;

    procedure GetProfilePicture(StaffNo: Text) BaseImage: Text
    var
        ToFile: Text;
        IStream: InStream;
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
    begin
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", StaffNo);

        if "Employee Card".Find('-') then begin
            if "Employee Card".Picture.Hasvalue then begin
                "Employee Card".CalcFields(Picture);
                "Employee Card".Picture.CreateInstream(IStream);
                MemoryStream := MemoryStream.MemoryStream();
                CopyStream(MemoryStream, IStream);
                Bytes := MemoryStream.GetBuffer();
                BaseImage := Convert.ToBase64String(Bytes);
            end;
        end;
    end;

    procedure GetProfilePictureStudent(StudentNo: Text) BaseImage: Text
    var
        ToFile: Text;
        IStream: InStream;
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
    begin
        Customer.Reset;
        Customer.SetRange(Customer."No.", StudentNo);

        if Customer.Find('-') then begin

            if Customer.Image.Hasvalue then begin
                Customer.CalcFields(Image);
                //Customer.Image.CreateInstream(IStream);
                MemoryStream := MemoryStream.MemoryStream();
                CopyStream(MemoryStream, IStream);
                Bytes := MemoryStream.GetBuffer();
                BaseImage := Convert.ToBase64String(Bytes);
            end;
        end;
    end;

    procedure InsertPatient(EmployeeNo: Text; Sname: Text; Fname: Text; Mname: Text; gender: Option; Dob: Date; Marital: Option; Id: Text; Address: Text; PostalCode: Text; City: Text; Phone: Text; Email: Text; Nationality: Text; Bloodgrp: Text; NextkinName: Text; NextkinRelationship: Text; NextkinContact: Text; InsuranceNo: Text; InsuranceName: Text; InsuranceMemberNo: Text; PatientType: Option) NewNo: Text
    begin
        NewNo := NoSeriesMgt.GetNextNo('PAT', 0D, true);
        ObjPatient.Init();
        ObjPatient."Patient No." := NewNo;
        ObjPatient.Validate("Patient No.");
        ObjPatient."Date Registered" := Today;
        ObjPatient."Patient Type" := PatientType;
        ObjPatient.Validate("Patient Type");
        ObjPatient."Employee No." := EmployeeNo;
        ObjPatient.Surname := Sname;
        ObjPatient.Validate(Surname);
        ObjPatient."Middle Name" := Fname;
        ObjPatient.Validate("Middle Name");
        ObjPatient."Last Name" := Mname;
        ObjPatient.Validate("Last Name");
        ObjPatient.Gender := gender;
        ObjPatient."Date Of Birth" := Dob;
        ObjPatient."Marital Status" := Marital;
        ObjPatient."ID Number" := Id;
        ObjPatient.Validate("ID Number");
        ObjPatient."Correspondence Address 1" := Address;
        ObjPatient."Correspondence Address 2" := PostalCode;
        ObjPatient."Correspondence Address 3" := City;
        ObjPatient."Telephone No. 1" := Phone;
        ObjPatient.Validate("Telephone No. 1");
        ObjPatient.Email := Email;
        ObjPatient.Nationality := Nationality;
        ObjPatient."Blood Group" := Bloodgrp;
        //ObjPatient."Next Of kin Full Name" :=NextkinName;
        //ObjPatient."Next of kin Relationship" :=NextkinRelationship;
        //ObjPatient."Next Of kin Address 1" :=Address;
        //ObjPatient."Next Of kin Address 2" :=NextkinContact;
        ObjPatient."Insurance No." := InsuranceNo;
        ObjPatient."Insurance Name" := InsuranceName;
        ObjPatient."Membership No" := InsuranceMemberNo;
        ObjPatient.Validate("Patient Ref. No.");
        ObjPatient.Validate(Surname);
        ObjPatient.Validate("Middle Name");
        ObjPatient.Validate("Last Name");
        ObjPatient.Insert;
    end;

    procedure InsertAppointment(PatientType: Option; PatientNo: Text; EmployeeNo: Text; doctor: Text; Remark: Text; Settlement: Option; InsuranceNo: Text; InsuranceName: Text; InsMemberNo: Text) AppointmentNo: Text
    begin
        DaysBtwnTodayAndLastVisit := isLastVisitDayWithin7days(PatientNo);
        objAppointment.Init();
        AppointmentNo := NoSeriesMgt.GetNextNo('HOSP-APP', 0D, true);
        objAppointment."Appointment No." := AppointmentNo;
        objAppointment."Appointment Date" := Today;
        objAppointment."Appointment Time" := Time;
        if DaysBtwnTodayAndLastVisit <= 7 then
            objAppointment."Appointment Type" := 'REVIEW' else
            objAppointment."Appointment Type" := 'NORMAL';
        //objAppointment."Appointment Type" :=AppType;
        objAppointment."Patient Type" := PatientType;
        objAppointment."Patient No." := PatientNo;
        objAppointment."Employee No." := EmployeeNo;
        objAppointment.Doctor := doctor;
        //objAppointment."MCC No." :=Remark;
        objAppointment."No. Series" := 'HOSP-APP';
        //IF PatientType=objAppointment."Patient Type"::Corporate THEN objAppointment."Settlement Type":=objAppointment."Settlement Type"::Credit;
        objAppointment."Settlement Type" := Settlement;
        //objAppointment."Insurance No" :=InsuranceNo;
        objAppointment."Insurance Name" := InsuranceName;
        //objAppointment."Insurance Member No":=InsMemberNo;
        objAppointment.Insert;

        ObjPatient.Reset;
        ObjPatient.SetRange("Patient No.", PatientNo);
        if ObjPatient.Find('-') then
            //ObjPatient."Active Visit No" :=AppointmentNo;
            ObjPatient.Modify;
    end;

    procedure InsertNurseNotes(AdmissionNo: Text; NurseId: Text; Notes: Text; NotesDate: Date; NotesTime: Time; NurseType: Option)
    begin
        objNurseNote.Init;
        objNurseNote."Admission No." := AdmissionNo;
        objNurseNote."Nurse ID" := NurseId;
        objNurseNote."Notes Date" := NotesDate;
        objNurseNote."Notes Time" := NotesTime;
        objNurseNote.Notes := Notes;
        objNurseNote.Type := objNurseNote.Type::"Drug Given";
        //objNurseNote."Nurse Type" :=NurseType;
        //objNurseNote.Drugs := Drugs;
        //objNurseNote.Dose :=Dose;
        //objNurseNote.Routine :=Routine;
        objNurseNote.Insert;
    end;

    procedure InsertPatCharges(PatientNo: Text; TreatmentNo: Text; DeptCode: Text; TransactType: Text; Description: Text; Amount: Decimal; RevenueCenter: Text; Transctioncode: Text; Quantity: Integer; Remarks: Text; Doctor: Text; staffno: Text; billsection: Option)
    var
        hmsPat: Record "HMS Patient";
    begin
        objPatCharges.Init;
        objPatCharges."Patient No." := PatientNo;
        objPatCharges."Treatment No." := TreatmentNo;
        ObjPatient.SetRange("Patient No.", PatientNo);
        if ObjPatient.Find('-') then
            //objPatCharges."Shortcut Dimension 1 Code" :=ObjPatient."Global Dimension 1 Code";

            //objPatCharges.VALIDATE("Shortcut Dimension 1 Code");
            HMSCharges.SetRange(HMSCharges.Code, Transctioncode);
        if HMSCharges.Find('-') then begin
            //  objPatCharges."Transaction Type" := HMSCharges."Transaction Type";
            objPatCharges.Validate("Transaction Type");
            objPatCharges.Amount := HMSCharges.Amount;
            //objPatCharges."Reccuring Type" :=HMSCharges."Reccuring Type";

            objPatCharges.Date := Today;
            objPatCharges.Description := Description;
            objPatCharges.Code := Transctioncode;
            hmsPat.Reset;
            hmsPat.SetRange(hmsPat."Patient No.", PatientNo);
            if hmsPat.Find('-') then begin
                //  objPatCharges."Visit No" := hmsPat."Active Visit No";
                //objPatCharges."Appointment No" := hmsPat."Active Visit No";
            end;


            //Amount;
            //objPatCharges."Invoice ID" :=TreatmentNo;

            //objPatCharges."Shortcut Dimension 2 Code" :=RevenueCenter;

            objPatCharges.Validate(Code);
            objPatCharges.Quantity := Quantity;
            objPatCharges.Validate(Amount);
            objPatCharges.Validate(Quantity);
            objPatCharges.Remarks := Remarks;
            //objPatCharges."Doctor ID" :=Doctor;
            //objPatCharges.VALIDATE("Doctor ID");
            objPatCharges.Validate("Apply to");
            //objPatCharges.VALIDATE("Invoice ID");
            //objPatCharges."User ID":=staffno;

            objPatCharges."Bill Section" := billsection;
            objPatCharges.Insert;
        end;
    end;

    procedure UpdateChargeAmount(PatientNo: Text; ChargeCode: Text; Amount: Decimal; Quantity: Integer)
    var
        hmsPat: Record "HMS Patient";
    begin
        hmsPat.Reset;
        hmsPat.SetRange(hmsPat."Patient No.", PatientNo);
        if hmsPat.Find('-') then begin
            //objPatCharges.SETRANGE(objPatCharges."Visit No", hmsPat."Active Visit No");
            objPatCharges.SetRange(objPatCharges."Patient No.", PatientNo);
            objPatCharges.SetRange(objPatCharges.Code, ChargeCode);
            if objPatCharges.Find('-') then begin
                objPatCharges.Amount := Amount;
                objPatCharges.Quantity := Quantity;
                //objPatCharges."Total Amount" :=Amount*Quantity;
                objPatCharges.Modify;
            end;
        end;
    end;

    procedure InsertObservation(SettlementType: Option; PatientNo: Text; AppointmentNo: Text; Doctor: Text)
    var
        AppointmentType: Text;
    begin
        ObjPatient.RESET;
        ObjPatient.SETRANGE(ObjPatient."Patient No.", PatientNo);
        IF ObjPatient.FIND('-') THEN BEGIN
            ObjPatient.Activated := TRUE;
            ObjPatient."Active Visit No" := AppointmentNo;
            IF ObjPatient."Date Of Birth" <> 0D THEN BEGIN
                ObjPatient."Age in Years" := DATE2DMY(TODAY, 3) - DATE2DMY(ObjPatient."Date Of Birth", 3);
            END;
            ObjPatient.MODIFY;


            objAppointment.SETRANGE(objAppointment."Appointment No.", AppointmentNo);
            IF objAppointment.FIND('-')
              THEN
                AppointmentType := objAppointment."Appointment Type";

            HMSSetup.RESET;
            HMSSetup.GET();
            EmployeeUserId := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, TRUE);
            NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, TRUE);


            ObservHeader.INIT;
            ObservHeader."Observation No." := NewNo;
            ObservHeader."Patient No." := PatientNo;
            ObservHeader."Observation Date" := TODAY;
            ObservHeader."Observation Time" := TIME;
            //ObservHeader."Request Area"::Doctor;
            ObservHeader."Treatment No" := EmployeeUserId;
            ObservHeader.Doctor := Doctor;
            ObservHeader."Link Type" := 'Observation';
            ObservHeader."Link No." := AppointmentNo;
            ObservHeader.INSERT;

            IF ObjPatient."Patient Type" <> ObjPatient."Patient Type2"::Student THEN BEGIN
                IF AppType.GET(AppointmentType) THEN BEGIN
                    DoctorsRec.RESET;
                    DoctorsRec.SETRANGE(DoctorsRec."Doctor ID", Doctor);
                    IF DoctorsRec.FIND('-') THEN
                        DoctorsRec.TESTFIELD("Consultation Code");
                    HMSPatientsCharges.INIT;
                    HMSPatientsCharges."Line No" := 1;
                    HMSPatientsCharges."Patient No." := PatientNo;
                    HMSPatientsCharges."Link No" := NewNo;
                    HMSPatientsCharges."Treatment No." := NewNo;
                    HMSPatientsCharges."Transaction Type" := 'DOCTORS FEES';
                    HMSPatientsCharges.VALIDATE("Transaction Type");
                    HMSPatientsCharges."Appointment No." := AppointmentNo;
                    HMSPatientsCharges.Code := DoctorsRec."Consultation Code";
                    HMSPatientsCharges.Description := DoctorsRec."Consultation Code" + ' - ' + DoctorsRec."Doctor ID";
                    HMSCharges.GET(DoctorsRec."Consultation Code");
                    HMSPatientsCharges.Amount := HMSCharges.Amount;
                    HMSPatientsCharges.VALIDATE(Amount);
                    HMSPatientsCharges.Date := TODAY;
                    HMSPatientsCharges."Shortcut Dimension 1 Code" := HMSCharges."Shortcut Dimension 1 Code";
                    HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
                    HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Appointment;
                    HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
                    HMSPatientsCharges.INSERT;
                END;
            END;


            objAppointment.SETRANGE("Appointment No.", AppointmentNo);
            IF objAppointment.FIND('-') THEN BEGIN
                objAppointment."Dispatch To" := objAppointment."Dispatch To";
                objAppointment."Dispatch Date" := TODAY;
                objAppointment."Dispatch Time" := TIME;
                objAppointment."Waiting At" := objAppointment."Waiting At";
                objAppointment.Status := objAppointment.Status::Dispatched;
                objAppointment."Link No" := NewNo;
                objAppointment.MODIFY;
            END;


            docHeader.INIT;
            docHeader."Treatment No." := EmployeeUserId;
            docHeader."Treatment Date" := TODAY;
            docHeader."Treatment Time" := TIME;
            docHeader."Doctor ID" := Doctor;
            docHeader.VALIDATE("Doctor ID");
            docHeader."Patient No." := ObjPatient."Patient No.";
            docHeader."Student No." := ObjPatient."Employee No.";
            docHeader."Employee No." := ObjPatient."Employee No.";
            docHeader.Direct := TRUE;
            docHeader."Link No." := AppointmentNo;
            docHeader.Clinic := objAppointment."Special Clinics";

            docHeader."Link Type" := 'Outpatient';

            docHeader.INSERT;
        END;

    end;

    procedure InsertObservationSigns(Treatmentno: Text; SignCode: Text; System: Text; Description: Text)
    begin
        ObjSigns.Init;
        ObjSigns."Treatment No." := Treatmentno;
        ObjSigns."Sign Code" := SignCode;
        ObjSigns.System := System;
        ObjSigns."Sign Description" := Description;
        ObjSigns.Insert;
    end;

    procedure InsertObservationSymptons(TreatmentNo: Text; SymptomCode: Text; SymptomDescription: Text; System: Text; Duration: Text; Description: Text; Characteristics: Text)
    begin
        ObjSymptons.Init;
        ObjSymptons."Treatment No." := TreatmentNo;
        ObjSymptons."Symptom Code" := SymptomCode;
        ObjSymptons."Symptom Description" := SymptomDescription;
        ObjSymptons.System := System;
        ObjSymptons.Duration := Duration;
        ObjSymptons.Description := Description;
        ObjSymptons.Characteristics := Characteristics;
        ObjSymptons.Insert;
    end;

    procedure InsertTreatLab(TreatmentNo: Text; LabtestCode: Text; LabtestName: Text; BriefHistory: Text)
    begin
        ObjLab.Init;
        ObjLab."Treatment No." := TreatmentNo;
        ObjLab."Laboratory Test Package Code" := LabtestCode;
        ObjLab.Validate("Laboratory Test Package Code");
        ObjLab."Laboratory Test Package Name" := LabtestName;
        ObjLab."Date Due" := Today;
        ObjLab.Status := ObjLab.Status::New;
        //ObjLab."Brief History" :=BriefHistory;
        ObjLab.Insert;
    end;

    procedure InsertTreatTheatre(TreatmetNo: Text; ProcessNo: Text; ProcessName: Text; Remarks: Text; Doctor: Text; Anaesthesist: Text; TheatreTime: Time; TheatreProcedure: Option)
    begin
        /*ObjTheatre.INIT;
        ObjTheatre."Treatment No." :=TreatmetNo;
        ObjTheatre."Process No." := ProcessNo;
        ObjTheatre."Process Name" :=ProcessName;
        ObjTheatre."Process Mandatory" :=TRUE;
        ObjTheatre."Process Remarks" :=Remarks;
        ObjTheatre."Procedure" :=TheatreProcedure;
        ObjTheatre.Doctor :=Doctor;
        ObjTheatre."Theatre Date" :=TODAY;
        ObjTheatre."Theatre Time" :=TheatreTime;
        ObjTheatre.Anaesthesist :=Anaesthesist;
        ObjTheatre.Status :=ObjTheatre.Status::New;
        ObjTheatre.INSERT;*/

    end;

    local procedure isLastVisitDayWithin7days(PatientNo: Text) lastVisitDay: Integer
    var
        appointments: Record "HMS Appointment Form Header";
    begin
        lastVisitDay := 999;

        appointments.Reset;
        appointments.SetRange(appointments."Patient No.", PatientNo);
        appointments.SetCurrentkey("Appointment No.");
        if appointments.Find('+') then begin
            lastVisitDay := Today - appointments."Appointment Date";
        end;
    end;

    local procedure testfields(PatientNo: Text)
    begin
        /*IF "Walk-in"=FALSE THEN BEGIN
          TESTFIELD("ID Number");
          TESTFIELD(Surname);
          TESTFIELD("Middle Name");
          TESTFIELD(Gender);
          TESTFIELD("Date Of Birth");
          TESTFIELD(Nationality);
          IF "Patient Type"="Patient Type"::Corporate THEN TESTFIELD("Insurance No.") ELSE "Insurance No." := '';
          TESTFIELD("Next of kin Relationship");
          TESTFIELD("Next Of kin Full Name");
          TESTFIELD("Next Of kin Address 1");
          VALIDATE("ID Number");
          IF ValidCharacters("ID Number") = FALSE THEN ERROR('ID Number Tibim');
        
        END;*/

    end;

    local procedure ValidCharacters(control: Text) valid: Boolean
    var
        NewStrings: Text;
    begin
        valid := true;

        if StrLen(control) = 1 then valid := false;

        NewStrings := DelChr(control, '=', '!@#$%^&*()_+|}{":;''?>><,./-');
        if NewStrings = '' then valid := false;
    end;

    procedure isLastVisitOpen(PatientNo: Text) lastVisitOpen: Boolean
    var
        appointments: Record "HMS Appointment Form Header";
    begin
        lastVisitOpen := false;

        appointments.Reset;
        appointments.SetRange(appointments."Patient No.", PatientNo);
        appointments.SetRange(appointments.Status, appointments.Status::New);
        appointments.SetCurrentkey("Appointment No.");
        if appointments.Find('+') then begin
            lastVisitOpen := true;
        end;
    end;

    procedure DipatchtoDoctor(SettlementType: Option; Doctor: Text; PatientNo: Text; AppointmentNo: Text; ObservationNo: Text; TreatmentNo: Text)
    var
        AppointmentType: Text;
        TriageNotes: Text;
    begin
        objAppointment.SetRange(objAppointment."Appointment No.", AppointmentNo);
        if objAppointment.Find('-')
          then
            AppointmentType := objAppointment."Appointment Type";

        ObservHeader.SetRange(ObservHeader."Observation No.", ObservationNo);
        if ObservHeader.Find('-')
          then
            TriageNotes := ObservHeader."Observation Remarks";




        /*     ObsLine.Reset;
            ObsLine.SetRange(ObsLine."Observation No.", ObservationNo);
            if ObsLine.Find('-') then begin
                repeat
                    TreatmentLine.Init;
                    TreatmentLine."Treatment No." := TreatmentNo;
                    //TreatmentLine.Type:=TreatmentLine.Type::Triage;
                    TreatmentLine."No." := ObsLine."Process No.";
                    TreatmentLine.Mandatory := ObsLine."Process Mandatory";
                    TreatmentLine.Remarks := ObsLine."Process Remarks";
                    TreatmentLine.Results := ObsLine."Process Result";
                    TreatmentLine."Date Created" := CurrentDatetime;
                    TreatmentLine.Performed := true;
                    TreatmentLine.Insert;
                until ObsLine.Next = 0;
            end; */
        // Update Queue
        docHeader.Get(TreatmentNo);
        Patient.Get(PatientNo);
        HMSQue.Init;
        HMSQue."Patient No" := PatientNo;
        HMSQue."Visit No" := Patient."Active Visit No";
        HMSQue."Document No" := TreatmentNo;
        HMSQue.Type := 'CONSULTATION';
        HMSQue."Queue Type" := 'DISPATCH';
        HMSQue."Doctor ID" := docHeader."Doctor ID";
        HMSQue.Date := Today;
        HMSQue.Time := Time;
        HMSQue.Insert;

        //  IF AppType.GET(AppointmentType) THEN BEGIN
        //    DoctorsRec.RESET;
        //   DoctorsRec.SETRANGE(DoctorsRec."Doctor ID",Doctor);
        //   IF DoctorsRec.FIND('-') THEN
        //    DoctorsRec.TESTFIELD("Consultation Code");
        //        HMSPatientsCharges.RESET;
        //      HMSPatientsCharges.SETRANGE(HMSPatientsCharges."Patient No.",PatientNo);
        //      HMSPatientsCharges.SETRANGE(HMSPatientsCharges."Appointment No.",AppointmentNo);
        //      IF HMSPatientsCharges.FIND('-') THEN BEGIN
        //        REPEAT
        //        HMSPatientsCharges.VALIDATE(HMSPatientsCharges."Transaction Type");
        //        HMSPatientsCharges."Doctor ID":=Doctor;
        //        HMSPatientsCharges.Date:=TODAY;
        //        HMSPatientsCharges."Bill Section":=HMSPatientsCharges."Bill Section"::Appointment;
        //        HMSPatientsCharges.MODIFY;
        //
        //        UNTIL HMSPatientsCharges.NEXT=0;
        //      END;
        //  END;
        ObservHeader.SetRange(ObservHeader."Link No.", AppointmentNo);
        if ObservHeader.Find('-') then begin
            ObservHeader.Status := ObservHeader.Status::Closed;
            ObservHeader.Closed := true;
            ObservHeader.Modify;
        end;

        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := Time;
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Link No" := NewNo;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Triage Time out" := CurrentDatetime;
            objAppointment."Doctor Time In" := CurrentDatetime;
            objAppointment.Modify;
        end;
    end;

    procedure DipatchtoDoctorOptical(SettlementType: Option; Doctor: Text; PatientNo: Text; AppointmentNo: Text; ObservationNo: Text)
    var
        AppointmentType: Text;
        TriageNotes: Text;
    begin
        objAppointment.SetRange(objAppointment."Appointment No.", AppointmentNo);
        if objAppointment.Find('-')
          then
            AppointmentType := objAppointment."Appointment Type";

        ObservHeader.SetRange(ObservHeader."Observation No.", ObservationNo);
        if ObservHeader.Find('-')
          then
            TriageNotes := ObservHeader."Observation Remarks";



        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
        if SettlementType = objAppointment."settlement type"::Insurance then
            testfields(objAppointment."Insurance Member No");
        docHeader.Init;
        docHeader."Treatment No." := NewNo;
        docHeader."Treatment Date" := Today;
        docHeader."Treatment Time" := Time;
        docHeader."Doctor ID" := Doctor;
        docHeader."Patient No." := PatientNo;
        //docHeader."Student No.":="Student No.";
        //docHeader."Employee No.":="Employee No.";
        //docHeader."Relative No.":="Relative No.";
        docHeader.Direct := true;
        docHeader."Link No." := AppointmentNo;
        docHeader."Triage Notes" := TriageNotes;
        //docHeader.Clinic:= docHeader.Clinic;
        //:=LabHeader."Request Area"::Doctor;
        docHeader."Link Type" := 'Outpatient';
        // docHeader."Link No.":=TreatmentHeader."Appointment No.";
        docHeader.Insert;
        //END;
        /*   ObsLine.Reset;
          ObsLine.SetRange(ObsLine."Observation No.", ObservationNo);
          if ObsLine.Find('-') then begin
              repeat
                  TreatmentLine.Init;
                  TreatmentLine."Treatment No." := NewNo;
                  TreatmentLine.Type := TreatmentLine.Type::Triage;
                  TreatmentLine."No." := ObsLine."Process No.";
                  TreatmentLine.Mandatory := ObsLine."Process Mandatory";
                  TreatmentLine.Remarks := ObsLine."Process Remarks";
                  TreatmentLine.Results := ObsLine."Process Result";
                  TreatmentLine."Date Created" := CurrentDatetime;
                  TreatmentLine.Performed := true;
                  TreatmentLine.Insert;
              until ObsLine.Next = 0;
          end; */
        // Update Queue
        Patient.Get(PatientNo);
        HMSQue.Init;
        HMSQue."Patient No" := PatientNo;
        HMSQue."Visit No" := Patient."Active Visit No";
        HMSQue."Document No" := NewNo;
        HMSQue.Type := 'CONSULTATION';
        HMSQue."Queue Type" := 'DISPATCH';
        HMSQue."Doctor ID" := Doctor;
        HMSQue.Date := Today;
        HMSQue.Time := Time;
        HMSQue.Insert;

        if AppType.Get(AppointmentType) then begin
            DoctorsRec.Reset;
            DoctorsRec.SetRange(DoctorsRec."User ID", Doctor);
            if DoctorsRec.Find('-') then
                // DoctorsRec.TESTFIELD("Consultation Code");
                HMSPatientsCharges.Reset;
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Appointment No.", AppointmentNo);
            if HMSPatientsCharges.Find('-') then begin
                repeat
                    HMSPatientsCharges.Validate(HMSPatientsCharges."Transaction Type");
                    // HMSPatientsCharges."Doctor ID":=Doctor;
                    HMSPatientsCharges.Date := Today;
                    HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Appointment;
                    HMSPatientsCharges.Modify;

                until HMSPatientsCharges.Next = 0;
            end;
        end;
        ObservHeader.SetRange(ObservHeader."Link No.", AppointmentNo);
        if ObservHeader.Find('-') then begin
            ObservHeader.Status := ObservHeader.Status::Closed;
            ObservHeader.Closed := true;
            ObservHeader.Modify;
        end;

        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := Time;
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Triage Time out" := CurrentDatetime;
            objAppointment."Doctor Time In" := CurrentDatetime;
            objAppointment."Link No" := NewNo;
            objAppointment.Modify;
        end;
    end;

    procedure DipatchtoDoctorDental(SettlementType: Option; Doctor: Text; PatientNo: Text; AppointmentNo: Text; ObservationNo: Text)
    var
        AppointmentType: Text;
        TriageNotes: Text;
    begin
        objAppointment.SetRange(objAppointment."Appointment No.", AppointmentNo);
        if objAppointment.Find('-')
          then
            AppointmentType := objAppointment."Appointment Type";

        ObservHeader.SetRange(ObservHeader."Observation No.", ObservationNo);
        if ObservHeader.Find('-')
          then
            TriageNotes := ObservHeader."Observation Remarks";



        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
        if SettlementType = objAppointment."settlement type"::Insurance then
            testfields(objAppointment."Insurance Member No");
        docHeader.Init;
        docHeader."Treatment No." := NewNo;
        docHeader."Treatment Date" := Today;
        docHeader."Treatment Time" := Time;
        docHeader."Doctor ID" := Doctor;
        docHeader."Patient No." := PatientNo;
        //docHeader."Student No.":="Student No.";
        //docHeader."Employee No.":="Employee No.";
        //docHeader."Relative No.":="Relative No.";
        docHeader.Direct := true;
        docHeader."Link No." := AppointmentNo;
        docHeader."Triage Notes" := TriageNotes;
        // docHeader.Clinic:= docHeader.Clinic;
        //:=LabHeader."Request Area"::Doctor;
        docHeader."Link Type" := 'Outpatient';
        // docHeader."Link No.":=TreatmentHeader."Appointment No.";
        docHeader.Insert;
        //END;
        /*      ObsLine.Reset;
             ObsLine.SetRange(ObsLine."Observation No.", ObservationNo);
             if ObsLine.Find('-') then begin
                 repeat
                     TreatmentLine.Init;
                     TreatmentLine."Treatment No." := NewNo;
                     TreatmentLine.Type := TreatmentLine.Type::Triage;
                     TreatmentLine."No." := ObsLine."Process No.";
                     TreatmentLine.Mandatory := ObsLine."Process Mandatory";
                     TreatmentLine.Remarks := ObsLine."Process Remarks";
                     TreatmentLine.Results := ObsLine."Process Result";
                     TreatmentLine."Date Created" := CurrentDatetime;
                     TreatmentLine.Performed := true;
                     TreatmentLine.Insert;
                 until ObsLine.Next = 0;
             end; */
        // Update Queue
        Patient.Get(PatientNo);
        HMSQue.Init;
        HMSQue."Patient No" := PatientNo;
        HMSQue."Visit No" := Patient."Active Visit No";
        HMSQue."Document No" := NewNo;
        HMSQue.Type := 'CONSULTATION';
        HMSQue."Queue Type" := 'DISPATCH';
        HMSQue."Doctor ID" := Doctor;
        HMSQue.Date := Today;
        HMSQue.Time := Time;
        HMSQue.Insert;

        if AppType.Get(AppointmentType) then begin
            DoctorsRec.Reset;
            DoctorsRec.SetRange(DoctorsRec."User ID", Doctor);
            if DoctorsRec.Find('-') then
                //  DoctorsRec.TESTFIELD("Consultation Code");
                HMSPatientsCharges.Reset;
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Appointment No.", AppointmentNo);
            if HMSPatientsCharges.Find('-') then begin
                repeat
                    HMSPatientsCharges.Validate(HMSPatientsCharges."Transaction Type");
                    //HMSPatientsCharges."Doctor ID":=Doctor;
                    HMSPatientsCharges.Date := Today;
                    HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Appointment;
                    HMSPatientsCharges.Modify;

                until HMSPatientsCharges.Next = 0;
            end;
        end;
        ObservHeader.SetRange(ObservHeader."Link No.", AppointmentNo);
        if ObservHeader.Find('-') then begin
            ObservHeader.Status := ObservHeader.Status::Closed;
            ObservHeader.Closed := true;
            ObservHeader.Modify;
        end;

        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := Time;
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Triage Time out" := CurrentDatetime;
            objAppointment."Doctor Time In" := CurrentDatetime;
            objAppointment."Link No" := NewNo;
            objAppointment.Modify;
        end;
    end;

    procedure DipatchtoDoctorSpecialist(SettlementType: Option; Doctor: Text; PatientNo: Text; AppointmentNo: Text; ObservationNo: Text)
    var
        AppointmentType: Text;
        TriageNotes: Text;
    begin
        objAppointment.SetRange(objAppointment."Appointment No.", AppointmentNo);
        if objAppointment.Find('-')
          then
            AppointmentType := objAppointment."Appointment Type";

        ObservHeader.SetRange(ObservHeader."Observation No.", ObservationNo);
        if ObservHeader.Find('-')
          then
            TriageNotes := ObservHeader."Observation Remarks";



        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
        if SettlementType = objAppointment."settlement type"::Insurance then
            testfields(objAppointment."Insurance Member No");
        docHeader.Init;
        docHeader."Treatment No." := NewNo;
        docHeader."Treatment Date" := Today;
        docHeader."Treatment Time" := Time;
        docHeader."Doctor ID" := Doctor;
        docHeader."Patient No." := PatientNo;
        //docHeader."Student No.":="Student No.";
        //docHeader."Employee No.":="Employee No.";
        //docHeader."Relative No.":="Relative No.";
        docHeader.Direct := true;
        docHeader."Link No." := AppointmentNo;
        docHeader."Triage Notes" := TriageNotes;
        // docHeader.Clinic:= docHeader.Clinic;
        //:=LabHeader."Request Area"::Doctor;
        docHeader."Link Type" := 'Outpatient';
        // docHeader."Link No.":=TreatmentHeader."Appointment No.";
        docHeader.Insert;
        //END;
        /*    ObsLine.Reset;
           ObsLine.SetRange(ObsLine."Observation No.", ObservationNo);
           if ObsLine.Find('-') then begin
               repeat
                   TreatmentLine.Init;
                   TreatmentLine."Treatment No." := NewNo;
                   TreatmentLine.Type := TreatmentLine.Type::Triage;
                   TreatmentLine."No." := ObsLine."Process No.";
                   TreatmentLine.Mandatory := ObsLine."Process Mandatory";
                   TreatmentLine.Remarks := ObsLine."Process Remarks";
                   TreatmentLine.Results := ObsLine."Process Result";
                   TreatmentLine."Date Created" := CurrentDatetime;
                   TreatmentLine.Performed := true;
                   TreatmentLine.Insert;
               until ObsLine.Next = 0;
           end; */
        // Update Queue
        Patient.Get(PatientNo);
        HMSQue.Init;
        HMSQue."Patient No" := PatientNo;
        HMSQue."Visit No" := Patient."Active Visit No";
        HMSQue."Document No" := NewNo;
        HMSQue.Type := 'CONSULTATION';
        HMSQue."Queue Type" := 'DISPATCH';
        HMSQue."Doctor ID" := Doctor;
        HMSQue.Date := Today;
        HMSQue.Time := Time;
        HMSQue.Insert;

        if AppType.Get(AppointmentType) then begin
            DoctorsRec.Reset;
            DoctorsRec.SetRange(DoctorsRec."User ID", Doctor);
            if DoctorsRec.Find('-') then
                //DoctorsRec.TESTFIELD("Consultation Code");
                HMSPatientsCharges.Reset;
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Appointment No.", AppointmentNo);
            if HMSPatientsCharges.Find('-') then begin
                repeat
                    HMSPatientsCharges.Validate(HMSPatientsCharges."Transaction Type");
                    //HMSPatientsCharges."Doctor ID":=Doctor;
                    HMSPatientsCharges.Date := Today;
                    HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Appointment;
                    HMSPatientsCharges.Modify;

                until HMSPatientsCharges.Next = 0;
            end;
        end;
        ObservHeader.SetRange(ObservHeader."Link No.", AppointmentNo);
        if ObservHeader.Find('-') then begin
            ObservHeader.Status := ObservHeader.Status::Closed;
            ObservHeader.Closed := true;
            ObservHeader.Modify;
        end;

        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := Time;
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Triage Time out" := CurrentDatetime;
            objAppointment."Doctor Time In" := CurrentDatetime;
            objAppointment."Link No" := NewNo;
            objAppointment.Modify;
        end;
    end;

    procedure DispatchToLab(SettlementType: Option; Doctor: Text; PatientNo: Text; AppointmentNo: Text)
    var
        AppointmentType: Text;
    begin
        objAppointment.SetRange(objAppointment."Appointment No.", AppointmentNo);
        if objAppointment.Find('-')
          then
            AppointmentType := objAppointment."Appointment Type";
        /*
        DocLabRequestLines.RESET;
        DocLabRequestLines.SETRANGE(DocLabRequestLines."Laboratory No.",AppointmentNo);
        IF DocLabRequestLines.FIND('-') THEN BEGIN
          //Procees
        END ELSE BEGIN
          ERROR('Please enter the lab tests to be done so as to proceed');
        END;*/

        //IF CONFIRM('Send Laboratory Test Request Now?',FALSE)=TRUE THEN
        //  BEGIN
        // IF SettlementType =objAppointment."Settlement Type"::Insurance THEN BEGIN
        //TESTFIELD("Insurance Member No");
        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Lab Test Request Nos", 0D, true);
        TreatmentHeader.Reset;
        TreatmentHeader.Get(AppointmentNo);
        LabHeader.Reset;
        LabHeader.Init;
        LabHeader."Laboratory No." := NewNo;
        LabHeader."Laboratory Date" := Today;
        LabHeader."Laboratory Time" := Time;
        LabHeader."Patient No." := TreatmentHeader."Patient No.";
        //LabHeader."Student No.":=TreatmentHeader."Student No.";
        //LabHeader."Employee No.":=TreatmentHeader."Employee No.";
        //LabHeader."Relative No.":=TreatmentHeader."Relative No.";
        LabHeader."Request Area" := LabHeader."request area"::Doctor;
        LabHeader."Link Type" := 'Appointment';
        LabHeader."Link No." := TreatmentHeader."Appointment No.";
        labheader2.Reset;
        labheader2.SetRange(labheader2."Link No.", TreatmentHeader."Appointment No.");
        if labheader2.Find('-') then begin
            if Confirm('Record already exist,Confirm Continue?') then LabHeader.Insert;
        end
        else begin
            LabHeader.Insert;
        end;
        DocLabRequestLines.Reset;
        DocLabRequestLines.SetRange(DocLabRequestLines."Laboratory No.", AppointmentNo);
        //DocLabRequestLines.SETRANGE(DocLabRequestLines.Status,DocLabRequestLines.Status::New);
        if DocLabRequestLines.Find('-') then begin
            repeat

                LabTestLines.Init;
                LabTestLines."Laboratory No." := NewNo;
                LabTestLines."Laboratory Test Code" := DocLabRequestLines."Laboratory Test Code";
                LabTestLines."Specimen Code" := DocLabRequestLines."Specimen Code";
                LabTestLines."Measuring Unit Code" := DocLabRequestLines."Measuring Unit Code";
                LabTestLines."Laboratory Test Name" := DocLabRequestLines."Laboratory Test Name";
                LabTestLines."Specimen Name" := DocLabRequestLines."Specimen Name";
                LabTestLines.Insert;

            until DocLabRequestLines.Next = 0;
        end;

        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := Time;
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Link No" := NewNo;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Triage Time out" := CurrentDatetime;
            objAppointment."Lab Time In" := CurrentDatetime;
            objAppointment.Modify;
        end;
        //END;
        //END;

    end;

    procedure DispatchToRadiology(SettlementType: Option; Doctor: Text; PatientNo: Text; AppointmentNo: Text)
    var
        AppointmentType: Text;
    begin
        objAppointment.SetRange(objAppointment."Appointment No.", AppointmentNo);
        if objAppointment.Find('-')
          then
            AppointmentType := objAppointment."Appointment Type";

        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Radiology Nos", 0D, true);
        RadiologyHeader.Reset;
        RadiologyHeader.Init;
        RadiologyHeader."Radiology No." := NewNo;
        RadiologyHeader."Radiology Date" := Today;
        RadiologyHeader."Radiology Time" := Time;
        RadiologyHeader."Radiology Area" := RadiologyHeader."radiology area"::Doctor;
        RadiologyHeader."Patient No." := PatientNo;
        ObjPatient.SetRange(ObjPatient."Patient No.", PatientNo);
        if ObjPatient.Find('-') then
            RadiologyHeader."Link No." := NewNo;
        RadiologyHeader."Search Names" := ObjPatient."Search Name";
        RadiologyHeader.Surname := ObjPatient.Surname;
        RadiologyHeader."Middle Name" := ObjPatient."Middle Name";
        RadiologyHeader."Last Name" := ObjPatient."Last Name";
        RadiologyHeader."ID Number" := ObjPatient."ID Number";
        RadiologyHeader."Correspondence Address 1" := ObjPatient."Correspondence Address 1";
        RadiologyHeader.Email := ObjPatient.Email;
        RadiologyHeader.Status := RadiologyHeader.Status::New;
        RadiologyHeader."Link Type" := 'Doctor';
        RadiologyHeader.Insert();

        //END;
        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := Time;
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Link No" := NewNo;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Triage Time out" := CurrentDatetime;
            objAppointment."Imaging Time In" := CurrentDatetime;
            objAppointment.Modify;
        end;
    end;

    procedure DispatchToPharmacy(SettlementType: Option; Doctor: Text; PatientNo: Text; AppointmentNo: Text)
    var
        AppointmentType: Text;
    begin
        objAppointment.SetRange(objAppointment."Appointment No.", AppointmentNo);
        if objAppointment.Find('-')
          then
            AppointmentType := objAppointment."Appointment Type";


        if Confirm('Alert Pharmacy About Prescription?') = false then begin exit end;
        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", 0D, true);

        /*Get the treatment from the database*/
        TreatmentHeader.Reset;
        if TreatmentHeader.Get(AppointmentNo) then begin
            PharmHeader.Reset;
            PharmHeader.Init;
            PharmHeader."Pharmacy No." := NewNo;
            PharmHeader."Pharmacy Date" := Today;
            PharmHeader."Pharmacy Time" := Time;
            PharmHeader."Request Area" := PharmHeader."request area"::Doctor;
            PharmHeader."Patient No." := TreatmentHeader."Patient No.";
            PharmHeader."Student No." := TreatmentHeader."Student No.";
            PharmHeader."Employee No." := TreatmentHeader."Employee No.";
            PharmHeader."Relative No." := TreatmentHeader."Relative No.";
            PharmHeader."Link Type" := 'Appointment';
            PharmHeader."Link No." := TreatmentHeader."Appointment No.";
            PharmHeader.Insert();

            objAppointment.SetRange("Appointment No.", AppointmentNo);
            if objAppointment.Find('-') then begin
                objAppointment."Dispatch To" := objAppointment."dispatch to";
                objAppointment."Dispatch Date" := Today;
                objAppointment."Dispatch Time" := Time;
                objAppointment.Status := objAppointment.Status::Dispatched;
                objAppointment."Waiting At" := objAppointment."waiting at";
                objAppointment."Triage Time out" := CurrentDatetime;
                objAppointment."Pharmacy Time In" := CurrentDatetime;

                objAppointment.Modify;
            end;

            Message('The Prescription has been sent to the Pharmacy for Issuance');
        end;

    end;

    procedure DispatchToPhysio(SettlementType: Option; Doctor: Text; PatientNo: Text; AppointmentNo: Text)
    var
        AppointmentType: Text;
    begin
        /*objAppointment.RESET;
        objAppointment.SETRANGE(objAppointment."Appointment No.",AppointmentNo);
        IF objAppointment.FIND('-')
          THEN  AppointmentType :=objAppointment."Appointment Type";
        
         HMSSetup.RESET;
            HMSSetup.GET();
            NewNo:=NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos",0D,TRUE);
            TreatmentHeader.RESET;
            TreatmentHeader.GET(AppointmentNo);
            LabHeader.RESET;
            LabHeader.INIT;
              PhysioHeader."No.":=NewNo;
              PhysioHeader."Physio Date":=TODAY;
              PhysioHeader."Physio Time":=TIME;
              PhysioHeader."Patient No.":=TreatmentHeader."Patient No.";
              PhysioHeader."Link Type":='Observation';
              PhysioHeader."Link No.":=TreatmentHeader."Appointment No.";
              PhysioHeader.INSERT;
        
        
          objAppointment.SETRANGE("Appointment No." ,AppointmentNo);
          IF objAppointment.FIND('-') THEN BEGIN
          objAppointment."Dispatch To":=objAppointment."dispatch to";
          objAppointment."Dispatch Date":=TODAY;
          objAppointment."Dispatch Time":=TIME;
          objAppointment.Status:=objAppointment.Status::Dispatched;
        
          objAppointment.MODIFY;
          END;
          */

    end;

    procedure DispatchToDirectAdmission(SettlementType: Option; Doctor: Text; PatientNo: Text; AppointmentNo: Text)
    var
        AppointmentType: Text;
    begin

        objAppointment.Reset;
        objAppointment.SetRange(objAppointment."Appointment No.", AppointmentNo);
        if objAppointment.Find('-')
          then
            AppointmentType := objAppointment."Appointment Type";

        Patient.Reset;
        Patient.SetRange(Patient."Patient No.", PatientNo);
        Patient.SetRange(Patient.Inpatient, true);
        if Patient.Find('-') then Error('the patient is in the wards currently no need to re-admit');


        if Confirm('Send the admission request?', false) = false then begin exit end;

        //------------------------------------------------------------------------
        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
        if SettlementType = objAppointment."settlement type"::Insurance then begin
            //TESTFIELD("Insurance Member No");
            docHeader.Init;
            docHeader."Treatment No." := NewNo;
            docHeader."Treatment Date" := Today;
            docHeader."Treatment Time" := Time;
            docHeader."Doctor ID" := Doctor;
            docHeader."Treatment Type" := docHeader."treatment type"::Inpatient;
            docHeader."Patient No." := PatientNo;
            docHeader.Direct := true;
            docHeader."Link No." := AppointmentNo;
            //:=LabHeader."Request Area"::Doctor;
            docHeader."Link Type" := 'InPatient';
            //      docHeader."Link No.":=TreatmentHeader."Appointment No.";
            docHeader.Insert;
        end;
        if AppType.Get(AppointmentType) then begin
            DoctorsRec.Reset;
            DoctorsRec.SetRange(DoctorsRec."Doctor ID");
            if DoctorsRec.Find('-') then
                DoctorsRec.TestField("Consultation Code");
            HMSPatientsCharges.Init;
            HMSPatientsCharges."Line No" := 1;
            HMSPatientsCharges."Patient No." := PatientNo;

            HMSPatientsCharges."Link No" := NewNo;
            HMSPatientsCharges."Treatment No." := NewNo;
            HMSPatientsCharges."Appointment No." := AppointmentNo;
            HMSPatientsCharges.Code := DoctorsRec."Consultation Code";
            HMSPatientsCharges.Description := DoctorsRec."Consultation Code" + ' - ' + DoctorsRec."Doctor ID";
            HMSCharges.Get(DoctorsRec."Consultation Code");
            HMSPatientsCharges.Amount := HMSCharges.Amount;
            HMSPatientsCharges.Date := Today;
            ObjPatient.SetRange("Patient No.", PatientNo);
            if ObjPatient.Find('-') then
                HMSPatientsCharges."Shortcut Dimension 1 Code" := ObjPatient."Global Dimension 1 Code";
            HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
            HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Appointment;
            HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
            HMSPatientsCharges.Insert;
        end;

        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := Time;
            objAppointment."User ID" := UserId;
            objAppointment.Status := objAppointment.Status::Dispatched;

            objAppointment.Modify;
        end;


        //--------------------------------------------------------------------------


        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Admission Request Nos", 0D, true);

        begin

            AdmissionHeader.Reset;
            AdmissionHeader.Init;
            AdmissionHeader."Admission No." := NewNo;
            AdmissionHeader."Admission Date" := Today;
            AdmissionHeader."Admission Time" := Time;
            AdmissionHeader."Admission Area" := AdmissionHeader."admission area"::Referral;
            AdmissionHeader."Patient No." := PatientNo;
            AdmissionHeader.Doctor := Doctor;
            AdmissionHeader.Validate(Doctor);
            AdmissionHeader.Remarks := 'Refferal';
            AdmissionHeader."Admission Reason" := 'Referall';
            AdmissionHeader."Link Type" := 'refferal';
            AdmissionHeader."Link No." := docHeader."Treatment No.";
            AdmissionHeader.Insert();
        end;
    end;

    procedure InsertObservationInjection(ObservationNo: Text; InjectionNo: Text; Quantity: Decimal; InjectionName: Text)
    begin
        ObjObservInjection.Init;
        ObjObservInjection."Observation No." := ObservationNo;
        ObjObservInjection."Injection No." := InjectionNo;
        ObjObservInjection.Validate("Injection No.");
        ObjObservInjection."Injection Date" := Today;
        ObjObservInjection."Injection Time" := Time;
        //ObjObservInjection."Injection Remarks" :=Remarks;
        //ObjObservInjection."Item No.":=ItemNo;
        ObjObservInjection.Quantity := Quantity;
        ObjObservInjection."Injection Name" := InjectionName;
        ObjObservInjection.Insert;
    end;

    procedure InsertObservationProcess(ObservationNo: Text; ProcessNo: Text; ProcessName: Text; Mandatory: Boolean; Remarks: Text; Result: Text)
    begin
        /* ObservProcess.Reset;
        ObservProcess.SetRange("Observation No.", ObservationNo);
        ObservProcess.SetRange("Process No.", ProcessNo);
        if ObservProcess.Find('-') then begin

            ObservProcess.Init;
            ObservProcess."Observation No." := ObservationNo;
            ObservProcess."Process No." := ProcessNo;
            ObservProcess."Process Name" := ProcessName;
            ObservProcess."Process Mandatory" := Mandatory;
            ObservProcess."Process Remarks" := Remarks;
            ObservProcess."Process Result" := Result;
            ObservProcess.Modify;
        end
        else begin
            ObservProcess.Init;
            ObservProcess."Observation No." := ObservationNo;
            ObservProcess."Process No." := ProcessNo;
            ObservProcess."Process Name" := ProcessName;
            ObservProcess."Process Mandatory" := Mandatory;
            ObservProcess."Process Remarks" := Remarks;
            ObservProcess."Process Result" := Result;
            ObservProcess.Insert;
        end; */
    end;

    procedure InsertObservationProcessDoc(TreatmentNo: Text; ProcessNo: Text; Remarks: Text; Result: Text)

    begin
        /*
       TreatmentLine.Init;
       TreatmentLine."Treatment No." := TreatmentNo;
       TreatmentLine.Type := TreatmentLine.Type::Diagnosis;
       TreatmentLine."No." := ProcessNo;
       TreatmentLine.Mandatory := true;
       TreatmentLine.Remarks := Remarks;
       TreatmentLine.Results := Result;
       TreatmentLine.Performed := true;
       TreatmentLine."Date Created" := CurrentDatetime;
       TreatmentLine.Insert;
   end;

   procedure InsertTriageNotes(ObservationNo: Text; Notes: Text; Remarks: Text; TreatmentNo: Text)
   begin
       ObservHeader.Reset;
       ObservHeader.SetRange("Observation No.", ObservationNo);
       if ObservHeader.Find('-') then
           ObservHeader."Observation Remarks2" := Remarks;
       ObservHeader."Observation Remarks" := Notes;
       ObservHeader.Modify;

       docHeader.Reset;
       docHeader.SetRange("Treatment No.", TreatmentNo);
       if docHeader.Find('-') then
           docHeader."Triage Notes" := Notes + Remarks; */
        //
    end;

    procedure InsertDiagnosis(TreamentNo: Text; DiagnosisNo: Text; Confirmed: Boolean; PatientNo: Text; Doctor: Text; Remarks: Text; DiagnosisType: Option)
    begin
        ObjDiagnosis.Init;
        ObjDiagnosis."Treatment No." := TreamentNo;
        ObjDiagnosis."Diagnosis No." := DiagnosisNo;
        ObjDiagnosis.Validate("Diagnosis No.");
        ObjDiagnosis.Confirmed := Confirmed;
        ObjDiagnosis."Patient No" := PatientNo;
        ObjDiagnosis."Diagnosis Date" := Today;
        ObjDiagnosis.Doctor := Doctor;
        ObjDiagnosis.Remarks := Remarks;
        ObjDiagnosis."Diagnosis Type" := DiagnosisType;
        ObjDiagnosis.Insert;
    end;

    procedure InsertInjection(TreatmentNo: Text; InjectionNo: Text; Remarks: Text; Quantity: Decimal; Location: Text; Duration: Text)
    begin
        ObjInjection.Init;
        ObjInjection."Treatment No." := TreatmentNo;
        ObjInjection."Injection No." := InjectionNo;
        ObjInjection.Validate("Injection No.");
        ObjInjection."Injection Remarks" := Remarks;
        ObjInjection."Injection Quantity" := Quantity;
        ObjInjection.Location := Location;
        ObjInjection.Duration := Duration;
        ObjInjection.Insert;
    end;

    procedure InsertPrescription(TreatmentNo: Text; DrugNo: Text; Remarks: Text; Location: Text; Frequency: Integer; NoofDays: Integer; Take: Decimal; Dosage: Text; Route: Integer; PrescriptionDose: Text; Qty: Decimal)
    var
        objItem: Record Item;
    begin
        ObjPrescription.Init;
        ObjPrescription."Treatment No." := TreatmentNo;
        //ObjPrescription."Product Group" :=ProductGroup;
        ObjPrescription."Drug No." := DrugNo;
        ObjPrescription.Validate("Drug No.");
        ObjPrescription.Frequency := Frequency;
        ObjPrescription.Take := Take;
        ObjPrescription.Dosage := Dosage;

        //IF objItem.GET(DrugNo) THEN ObjPrescription.Route := objItem.Route;
        ObjPrescription.Route := Route;
        ObjPrescription."Number of Days" := NoofDays;
        //ObjPrescription.VALIDATE(Frequency);
        //ObjPrescription.VALIDATE(Take);
        //ObjPrescription.VALIDATE("Number of Days");
        ObjPrescription.Quantity := Qty;
        ObjPrescription.Validate(Quantity);
        ObjPrescription.Remarks := Remarks;
        Evaluate(ObjPrescription."Prescription Dose", PrescriptionDose);
        ObjPrescription."Pharmacy Code" := Location;
        ObjPrescription.Insert;
    end;

    procedure InsertAdmission(TreatmentNo: Text; Reason: Text; Remarks: Text; PastMedicalHisto: Text; PastSurgicalHisto: Text; SocialHistory: Text; Reviewsofsystems: Text; Investigations: Text; Assessmentplan: Text)
    begin
        ObjAdmission.Init;
        ObjAdmission."Treatment No." := TreatmentNo;
        ObjAdmission."Date Of Admission" := Today;
        ObjAdmission."Admission Reason" := Reason;
        ObjAdmission."Admission Remarks" := Remarks;
        ObjAdmission."Past Medical History" := PastMedicalHisto;
        ObjAdmission."Past Surgical History" := PastSurgicalHisto;
        ObjAdmission."Social History" := SocialHistory;
        ObjAdmission."Reviews of systems" := Reviewsofsystems;
        ObjAdmission.Investigations := Investigations;
        ObjAdmission."Assessment and plan" := Assessmentplan;
        ObjAdmission.Status := ObjAdmission.Status::New;
        ObjAdmission.Insert;
    end;

    procedure InsertReferral(TreatmentNo: Text; HospitalNo: Text; HospitalName: Text; Reason: Text; Remarks: Text; ClinicalHistory: Text; FindingsonExam: Text)
    begin
        /*ObjReferral.INIT;
        ObjReferral."Treatment No." :=TreatmentNo;
        ObjReferral."Hospital No." :=HospitalNo;
        ObjReferral."Hospital Name" :=HospitalName;
        ObjReferral."Date Referred" :=TODAY;
        ObjReferral."Referral Reason" :=Reason;
        ObjReferral."Referral Remarks" :=Remarks;
        ObjReferral.Status :=ObjReferral.Status::Referred;
        ObjReferral."Clinical History & Treatment" :=ClinicalHistory;
        ObjReferral."Findings on Exam & Investigtn" :=FindingsonExam;
        ObjReferral.INSERT;*/

    end;

    procedure InsertRadiology(TreatmentNo: Text; RadiologyCode: Text; RequiredInvestigation: Text; PreviousInvestigation: Text)
    begin
        ObjRadiology.Init;
        ObjRadiology."Treatment No." := TreatmentNo;
        ObjRadiology."Radiology Type Code" := RadiologyCode;
        ObjRadiology.Validate("Radiology Type Code");
        ObjRadiology."Date Due" := Today;
        ObjRadiology."Required Investigation" := RequiredInvestigation;
        ObjRadiology."Previous Investigation" := PreviousInvestigation;
        ObjRadiology.Insert;
    end;

    procedure UpdateDoctorNotes(TreatmentNo: Text; DoctorNotes: Text)
    begin
        docHeader.Reset;
        docHeader.SetRange("Treatment No.", TreatmentNo);
        if docHeader.Find('-') then begin
            docHeader."Doctor Notes" := DoctorNotes;
            docHeader.Modify;
        end;
    end;

    procedure MarkTreatmentComplete(TreatmentNo: Text; PatientNo: Text)
    var
        observeno: Text;
    begin
        docHeader.Reset;
        docHeader.SetRange("Treatment No.", TreatmentNo);
        if docHeader.Find('-') then begin
            observeno := docHeader."Link No.";
            docHeader.Status := docHeader.Status::Completed;
            docHeader.Modify;

            Patient.Reset;
            Patient.SetRange(Patient."Patient No.", PatientNo);
            if Patient.Find('-') then begin
                Patient.Activated := false;
                Patient.Modify;

                objAppointment.SetRange("Appointment No.", Patient."Active Visit No");
                if objAppointment.Find('-') then begin
                    objAppointment."Dispatch To" := objAppointment."dispatch to";
                    objAppointment."Dispatch Date" := Today;
                    objAppointment."Dispatch Time" := Time;
                    objAppointment.Status := objAppointment.Status::Dispatched;
                    objAppointment."Waiting At" := objAppointment."waiting at";
                    objAppointment."Doctor Time Out" := CurrentDatetime;
                    objAppointment."Pharmacy Time In" := CurrentDatetime;

                    objAppointment.Modify;
                end;
            end;


            ObservHeader.Reset;
            ObservHeader.SetRange(ObservHeader."Patient No.", PatientNo);
            ObservHeader.SetRange(ObservHeader."Observation No.", observeno);
            if ObservHeader.Find('-') then begin
                ObservHeader.Status := ObservHeader.Status::Closed;
                ObservHeader.Modify;
            end;
        end;
    end;

    procedure PrescribeDrugs(TreatmentNo: Code[20])
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Drug";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
    begin

        HMSSetup.Reset;
        HMSSetup.Get();

        /*Get the treatment from the database*/
        TreatmentHeader.Reset;
        if TreatmentHeader.Get(TreatmentNo) then begin
            PharmHeader.Reset;
            PharmHeader.SetRange(PharmHeader."Treatment No.", TreatmentNo);
            PharmHeader.SetRange(PharmHeader.Status, PharmHeader.Status::New);
            if PharmHeader.Find('-') then begin
                NewNo := PharmHeader."Pharmacy No.";
            end else begin
                NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", 0D, true);

                PharmHeader.Init;
                PharmHeader."Pharmacy No." := NewNo;
                PharmHeader."Pharmacy Date" := Today;
                PharmHeader."Pharmacy Time" := Time;
                PharmHeader."Request Area" := PharmHeader."request area"::Doctor;
                PharmHeader."Patient No." := TreatmentHeader."Patient No.";
                PharmHeader."Student No." := TreatmentHeader."Student No.";
                PharmHeader."Employee No." := TreatmentHeader."Employee No.";
                PharmHeader."Relative No." := TreatmentHeader."Relative No.";
                PharmHeader."Link Type" := 'Doctor';
                PharmHeader."Link No." := TreatmentHeader."Link No.";
                PharmHeader."Treatment No." := TreatmentNo;
                PharmHeader.Insert();
            end;
            TreatmentLine.Reset;
            TreatmentLine.SetRange(TreatmentLine."Treatment No.", TreatmentNo);
            TreatmentLine.SetRange(TreatmentLine.Status, TreatmentLine.Status::New);
            if TreatmentLine.Find('-') then begin
                repeat
                    PharmLine.Init;
                    PharmLine."Pharmacy No." := NewNo;
                    PharmLine."No." := TreatmentLine."Drug No.";
                    PharmLine.Validate("No.");
                    PharmLine.Quantity := TreatmentLine.Quantity;
                    PharmLine."Issued Quantity" := TreatmentLine.Quantity;
                    PharmLine."Issued Units" := TreatmentLine.Quantity;
                    PharmLine."Issued Price" := DrugPrice(TreatmentLine."Drug No.");
                    PharmLine.Validate(PharmLine.Quantity);
                    PharmLine."Measuring Unit" := TreatmentLine."Unit Of Measure";
                    PharmLine.Validate(PharmLine.Quantity);
                    PharmLine.Dosage := TreatmentLine.Dosage;
                    //PharmLine.VALIDATE(Dosage);
                    PharmLine.Take := TreatmentLine.Take;
                    //PharmLine.VALIDATE(Take);
                    PharmLine."Number of Days" := TreatmentLine."Number of Days";
                    PharmLine.Frequency := TreatmentLine.Frequency;
                    PharmLine.Pharmacy := TreatmentLine."Pharmacy Code";
                    PharmLine."Link Code" := TreatmentHeader."Link No.";
                    PharmLine.Remarks := TreatmentLine.Remarks;
                    PharmLine."Prescription Dose" := TreatmentLine."Prescription Dose";

                    PharmLine.Insert();
                    TreatmentLine.Issued := true;
                    TreatmentLine.Posted := true;
                    TreatmentLine.Status := TreatmentLine.Status::Forwarded;
                    TreatmentLine.Modify;
                until TreatmentLine.Next = 0;
            end;
            objAppointment.SetRange("Appointment No.", TreatmentHeader."Link No.");
            if objAppointment.Find('-') then begin
                objAppointment."Dispatch To" := objAppointment."dispatch to";
                objAppointment."Dispatch Date" := Today;
                objAppointment."Dispatch Time" := Time;
                objAppointment.Status := objAppointment.Status::Dispatched;
                objAppointment."Waiting At" := objAppointment."waiting at";
                objAppointment."Doctor Time Out" := CurrentDatetime;
                objAppointment."Pharmacy Time In" := CurrentDatetime;

                objAppointment.Modify;
            end;
        end;

    end;

    local procedure DrugPrice(parItem: Code[20]) Sprice: Decimal
    var
        objItem: Record Item;
    begin
        if objItem.Get(parItem) then Sprice := objItem."Unit Price";
    end;

    procedure RequestAdmission(TreatmentNo: Code[20])
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Drug";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
    begin

        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Admission Request Nos", 0D, true);

        TreatmentHeader.Reset;
        if TreatmentHeader.Get(TreatmentNo) then begin
            Patient.Reset;
            Patient.SetRange(Patient."Patient No.", TreatmentHeader."Patient No.");
            Patient.SetRange(Patient.Inpatient, true);
            if Patient.Find('-') then Error('The patient is in the wards currently no need to re-admit');

            AdmissionHeader.Reset;
            AdmissionHeader.Init;
            AdmissionHeader."Admission No." := NewNo;
            AdmissionHeader."Admission Date" := Today;
            AdmissionHeader."Admission Time" := Time;
            AdmissionHeader."Admission Area" := AdmissionHeader."admission area"::Doctor;
            AdmissionHeader."Patient No." := TreatmentHeader."Patient No.";
            AdmissionHeader."Employee No." := TreatmentHeader."Treatment No.";
            AdmissionHeader."Relative No." := TreatmentHeader."Relative No.";
            // AdmissionHeader.Ward:="Ward No.";
            //  AdmissionHeader.Bed:="Bed No.";
            AdmissionHeader.Doctor := TreatmentHeader."Doctor ID";
            AdmissionHeader.Validate(Doctor);
            //  AdmissionHeader.Remarks:="Admission Remarks";
            //  AdmissionHeader."Admission Reason":="Admission Reason";
            AdmissionHeader."Student No." := TreatmentHeader."Student No.";
            AdmissionHeader."Link Type" := 'Doctor';
            AdmissionHeader."Link No." := TreatmentHeader."Treatment No.";
            AdmissionHeader.Insert();
            Message('The Admission Request has been sent');
        end;
    end;

    procedure RequestLab(TreatmentNo: Code[20])
    var
        LabHeader: Record "HMS Laboratory Form Header";
        LabLine: Record "HMS Laboratory Test Line";
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Observation Form Injection";
        Tests: Record "HMS Setup Lab Package Test";
        SpecimenList: Record "HMS Setup Test Specimen";
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
        DocLabRequestLines: Record "HMS Treatment Form Laboratory";
        LabTestLines: Record "HMS Laboratory Test Line";
        Labsetup: Record "HMS Setup Lab Test";
        LabSpecimenSetup: Record "HMS Setup Test Specimen";
        labheader2: Record "HMS Laboratory Form Header";
    begin
        HMSSetup.Reset;
        HMSSetup.Get();



        TreatmentHeader.Reset;
        TreatmentHeader.Get(TreatmentNo);
        LabHeader.Reset;
        LabHeader.SetRange(LabHeader."Patient No.", TreatmentHeader."Patient No.");
        LabHeader.SetRange(LabHeader."Laboratory Date", Today);
        LabHeader.SetRange(LabHeader.Status, LabHeader.Status::New);
        if LabHeader.Find('-') then begin
            NewNo := LabHeader."Laboratory No.";
        end else begin
            NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Lab Test Request Nos", 0D, true);
            LabHeader.Init;
            LabHeader."Laboratory No." := NewNo;
            LabHeader."Laboratory Date" := Today;
            LabHeader."Laboratory Time" := Time;
            LabHeader."Patient No." := TreatmentHeader."Patient No.";
            LabHeader."Request Area" := LabHeader."request area"::Doctor;
            LabHeader."Link Type" := 'Treatment';
            LabHeader."Link No." := TreatmentHeader."Treatment No.";
            LabHeader."Doctor ID" := TreatmentHeader."Doctor ID";
            LabHeader.Insert;
            Patient.Get(LabHeader."Patient No.");
            HMSQue.Init;
            HMSQue."Patient No" := LabHeader."Patient No.";
            HMSQue."Visit No" := Patient."Active Visit No";
            HMSQue."Document No" := LabHeader."Laboratory No.";
            HMSQue.Type := 'LABORATORY';
            HMSQue."Queue Type" := 'DISPATCH';
            HMSQue."Doctor ID" := LabHeader."Doctor ID";
            HMSQue.Date := Today;
            HMSQue.Time := Time;
            HMSQue.Insert;

        end;

        DocLabRequestLines.Reset;
        DocLabRequestLines.SetRange(DocLabRequestLines."Treatment No.", TreatmentNo);
        DocLabRequestLines.SetRange(DocLabRequestLines.Status, DocLabRequestLines.Status::New);
        if DocLabRequestLines.Find('-') then begin
            repeat
                DocLabRequestLines.Status := DocLabRequestLines.Status::Forwarded;
                DocLabRequestLines.Modify;

                LabTestLines.Init;
                LabTestLines."Laboratory No." := LabHeader."Laboratory No.";
                //LabTestLines."Laboratory Test Code":=LabSpecimenSetup.Test;
                LabTestLines."Laboratory Test Code" := DocLabRequestLines."Laboratory Test Package Code";
                LabTestLines."Specimen Code" := LabSpecimenSetup.Specimen;
                LabTestLines."Measuring Unit Code" := LabSpecimenSetup."Measuring Unit";
                //LabTestLines."Laboratory Test Name":=LabSpecimenSetup."Test Name";
                LabTestLines."Laboratory Test Name" := DocLabRequestLines."Laboratory Test Package Name";

                LabTestLines.Insert;

            until DocLabRequestLines.Next = 0;
        end
        else begin
            Error('Nothing to Forward!');
        end;
        objAppointment.SetRange("Appointment No.", TreatmentHeader."Link No.");
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := Time;
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Doctor Time Out" := CurrentDatetime;
            objAppointment."Lab Time In" := CurrentDatetime;

            objAppointment.Modify;
        end;
    end;

    procedure RequestRadiology(TreatmentNo: Code[20])
    var
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Radiology";
        RadiologyHeader: Record "HMS Radiology Form Header";
        RadiologyLine: Record "HMS Radiology Form Line";
        NewNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HMSSetup: Record "HMS Setup";
    begin
        HMSSetup.Reset;
        HMSSetup.Get();

        TreatmentHeader.Reset;
        if TreatmentHeader.Get(TreatmentNo) then begin


            RadiologyHeader.Reset;
            RadiologyHeader.SetRange(RadiologyHeader."Patient No.", TreatmentHeader."Patient No.");
            RadiologyHeader.SetRange(RadiologyHeader."Radiology Date", Today);
            if RadiologyHeader.Find('-') then begin
                NewNo := RadiologyHeader."Radiology No.";
            end else begin
                NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Radiology Nos", 0D, true);
                RadiologyHeader.Init;
                RadiologyHeader."Radiology No." := NewNo;
                RadiologyHeader."Radiology Date" := Today;
                RadiologyHeader."Radiology Time" := Time;
                RadiologyHeader."Radiology Area" := RadiologyHeader."radiology area"::Doctor;
                RadiologyHeader."Patient No." := TreatmentHeader."Patient No.";
                RadiologyHeader."Link No." := TreatmentHeader."Treatment No.";
                RadiologyHeader."Doctor ID" := TreatmentHeader."Doctor ID";
                RadiologyHeader."Link Type" := 'Doctor';
                RadiologyHeader.Insert();

                Patient.Get(RadiologyHeader."Patient No.");
                HMSQue.Init;
                HMSQue."Patient No" := RadiologyHeader."Patient No.";
                HMSQue."Visit No" := Patient."Active Visit No";
                HMSQue."Document No" := RadiologyHeader."Radiology No.";
                HMSQue.Type := 'RADIOLOGY';
                HMSQue."Queue Type" := 'DISPATCH';
                HMSQue."Doctor ID" := RadiologyHeader."Doctor ID";
                HMSQue.Date := Today;
                HMSQue.Time := Time;
                HMSQue.Insert;
            end;
            /*Insert the lines*/
            TreatmentLine.Reset;
            TreatmentLine.SetRange(TreatmentLine."Treatment No.", TreatmentNo);
            TreatmentLine.SetRange(TreatmentLine.Status, TreatmentLine.Status::New);
            if TreatmentLine.Find('-') then begin
                repeat
                    RadiologyLine.Reset;
                    RadiologyLine.Init;
                    RadiologyLine."Radiology no." := NewNo;
                    RadiologyLine."Radiology Type Code" := TreatmentLine."Radiology Type Code";
                    RadiologyLine."Clinical Summary &  Diagnosis" := TreatmentLine."Clinical Summary &  Diagnosis";
                    RadiologyLine."Required Investigation" := TreatmentLine."Required Investigation";
                    RadiologyLine."Previous Investigation" := TreatmentLine."Previous Investigation";
                    RadiologyLine.Insert();
                    TreatmentLine.Status := TreatmentLine.Status::Forwarded;
                    TreatmentLine.Modify;

                until TreatmentLine.Next = 0;
            end;
            objAppointment.SetRange("Appointment No.", TreatmentHeader."Link No.");
            if objAppointment.Find('-') then begin
                objAppointment."Dispatch To" := objAppointment."dispatch to";
                objAppointment."Dispatch Date" := Today;
                objAppointment."Dispatch Time" := Time;
                objAppointment.Status := objAppointment.Status::Dispatched;
                objAppointment."Waiting At" := objAppointment."waiting at";
                objAppointment."Doctor Time Out" := CurrentDatetime;
                objAppointment."Imaging Time In" := CurrentDatetime;

                objAppointment.Modify;
            end;
        end;

    end;

    procedure RequestReferral(TreatmentNo: Code[20]; HospNo: Code[20]; ReffReasons: Text[100]; ReffRemarks: Text[100])
    var
        Referral: Record "HMS Referral Header";
        TreatmentHeader: Record "HMS Treatment Form Header";
    begin
        TreatmentHeader.Reset;
        if TreatmentHeader.Get(TreatmentNo) then begin
            Referral.Init;
            Referral."Treatment no." := TreatmentNo;
            Referral."Hospital No." := HospNo;
            Referral."Patient No." := TreatmentHeader."Patient No.";
            Referral."Date Referred" := Today;
            Referral."Referral Reason" := ReffReasons;
            Referral."Referral Remarks" := ReffRemarks;
            Referral.Insert();
        end;
    end;

    procedure InsertImmunization(TreatmentNo: Text; ImmunizationCode: Text; PatientNo: Text)
    begin
        Immunization.Init;
        Immunization."Treatment No" := TreatmentNo;
        Immunization."Immunization Code" := ImmunizationCode;
        Immunization."Patient No." := PatientNo;
        Immunization.Validate("Immunization Code");
        ImmuneSetup.Get(ImmunizationCode);
        Immunization."Immunization Name" := ImmuneSetup.Description;
        Immunization."Immunization Date" := Today;
        Immunization.Validate("Patient No.");
        Immunization.Insert;
    end;

    procedure InsertDoctorsNotes(TreatmentNo: Code[30]; PatientNo: Code[30]; Notes: Text; TreatmentDate: Date; "docUSER ID": Code[30])
    begin
        objNotes.SetRange(objNotes."Patient No", PatientNo);
        objNotes.SetRange(objNotes.TreatmentNo, TreatmentNo);
        objNotes.SetRange(objNotes."Treatment Date", TreatmentDate);
        objNotes.SetRange(objNotes."User ID", "docUSER ID");
        // objNotes.SetRange(// objNotes.Notes, Notes);
        objNotes.SetRange(objNotes."Notes Type", objNotes."notes type"::DoctorsNotes);
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := Time;
            // objNotes.Notes := Notes;
            objNotes."Notes Type" := objNotes."notes type"::DoctorsNotes;
            objNotes."User ID" := "docUSER ID";
            objNotes."Created Date" := Today;
            objNotes.Insert;
        end;
    end;

    procedure InsertMedicalReport(TreatmentNo: Code[30]; PatientNo: Code[30]; Notes: Text; TreatmentDate: Date; "docUSER ID": Code[30])
    begin
        objNotes.SetRange(objNotes."Patient No", PatientNo);
        objNotes.SetRange(objNotes.TreatmentNo, TreatmentNo);
        objNotes.SetRange(objNotes."Treatment Date", TreatmentDate);
        objNotes.SetRange(objNotes."User ID", "docUSER ID");
        // objNotes.SetRange(objNotes.Notes, Notes);
        objNotes.SetRange(objNotes."Notes Type", objNotes."notes type"::MedicalReport);
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := Time;
            // objNotes.Notes := Notes;
            objNotes."Notes Type" := objNotes."notes type"::MedicalReport;
            objNotes."User ID" := "docUSER ID";
            objNotes."Created Date" := Today;
            objNotes.Insert;
        end;
    end;

    procedure InsertHistoryPresentIllness(TreatmentNo: Code[30]; PatientNo: Code[30]; Notes: Text; TreatmentDate: Date; "docUSER ID": Code[30])
    begin
        objNotes.SetRange(objNotes."Patient No", PatientNo);
        objNotes.SetRange(objNotes.TreatmentNo, TreatmentNo);
        objNotes.SetRange(objNotes."Treatment Date", TreatmentDate);
        objNotes.SetRange(objNotes."User ID", "docUSER ID");
        // objNotes.SetRange(objNotes.Notes, Notes); TODO : Blob implementation
        objNotes.SetRange(objNotes."Notes Type", objNotes."notes type"::"Patient History");
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := Time;
            // objNotes.Notes := Notes;
            objNotes."Notes Type" := objNotes."notes type"::"Patient History";
            objNotes."User ID" := "docUSER ID";
            objNotes."Created Date" := Today;
            objNotes.Insert;
        end;
        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);
        if docHeader.Find('-') then begin
            if docHeader."Doctor's Name" = '' then begin

                DoctorsRec.Get(docHeader."Doctor ID");
                docHeader."Doctor's Name" := DoctorsRec."Doctors Name";
                docHeader.Modify;
            end;
        end;
    end;

    procedure InsertTreatmentPlan(TreatmentNo: Code[30]; PatientNo: Code[30]; Notes: Text; TreatmentDate: Date; "docUSER ID": Code[30])
    begin
        objNotes.SetRange(objNotes."Patient No", PatientNo);
        objNotes.SetRange(objNotes.TreatmentNo, TreatmentNo);
        objNotes.SetRange(objNotes."Treatment Date", TreatmentDate);
        objNotes.SetRange(objNotes."User ID", "docUSER ID");
        // objNotes.SetRange(objNotes.Notes, Notes);
        objNotes.SetRange(objNotes."Notes Type", objNotes."notes type"::"Treatment Plan");
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := Time;
            // objNotes.Notes := Notes;
            objNotes."Notes Type" := objNotes."notes type"::"Treatment Plan";
            objNotes."User ID" := "docUSER ID";
            objNotes."Created Date" := Today;
            objNotes.Insert;
        end;
        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);
        if docHeader.Find('-') then begin
            if docHeader."Doctor's Name" = '' then begin

                DoctorsRec.Get(docHeader."Doctor ID");
                docHeader."Doctor's Name" := DoctorsRec."Doctors Name";
                docHeader.Modify;
            end;
        end;
    end;

    procedure DeleteDoctorsNotes(TreatmentNo: Code[20]; PatientNo: Code[20]; "docUSER ID": Text; NotesType: Option)
    var
        objNotes: Record "hms Notes";
    begin
        objNotes.Reset;
        objNotes.SetRange(objNotes."Patient No", PatientNo);
        objNotes.SetRange(objNotes.TreatmentNo, TreatmentNo);
        objNotes.SetRange(objNotes."Notes Type", NotesType);
        //objNotes.SETRANGE(objNotes."User ID" ,"docUSER ID");
        if objNotes.Find('-') then objNotes.DeleteAll;
    end;

    procedure InsertPatientNotes(TreatmentNo: Code[30]; PatientNo: Code[30]; Notes: Text; TreatmentDate: Date; "docUSER ID": Code[30]; NotesTyp: Option; Clinic: Option)
    begin
        objNotes.SetRange(objNotes."Patient No", PatientNo);
        objNotes.SetRange(objNotes.TreatmentNo, TreatmentNo);
        objNotes.SetRange(objNotes."Treatment Date", TreatmentDate);
        objNotes.SetRange(objNotes."User ID", "docUSER ID");
        // objNotes.SetRange(objNotes.Notes, Notes);
        objNotes.SetRange(objNotes."Notes Type", NotesTyp);
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := Time;
            // objNotes.Notes := Notes;
            objNotes."Notes Type" := NotesTyp;
            objNotes."User ID" := "docUSER ID";
            objNotes."Created Date" := Today;
            //objNotes.Clinic := Clinic;
            objNotes.Insert;
        end;

        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);
        if docHeader.Find('-') then begin
            if docHeader."Doctor's Name" = '' then begin

                DoctorsRec.Get(docHeader."Doctor ID");
                docHeader."Doctor's Name" := DoctorsRec."Doctors Name";
                docHeader.Modify;
            end;
        end;
    end;

    procedure InsertDrugPrescribe(ObservationNo: Text; DrugNo: Text; Quantity: Integer; User: Text; Transacttyp: Text; Location: Text; Dateposted: Date)
    begin
        DrugPrescribe.Init;
        DrugPrescribe."Admission No." := ObservationNo;
        DrugPrescribe."Drug No." := DrugNo;
        DrugPrescribe.Validate("Drug No.");
        DrugPrescribe."Date Created" := Today;
        DrugPrescribe."Posted Date" := Dateposted;
        DrugPrescribe."Posting Date" := Dateposted;
        DrugPrescribe."Location Code" := Location;
        DrugPrescribe.Quantity := Quantity;
        DrugPrescribe.Validate(Quantity);
        DrugPrescribe."Transaction Type" := Transacttyp;
        DrugPrescribe."Created By" := User;
        DrugPrescribe.Insert;
    end;

    procedure PrescribeDrugsTriage(ObservationNo: Code[20]; DrugNo: Text)
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
        TreatmentHeader: Record "HMS Appointment Form Header";
        TreatmentLine: Record "HMS Treatment Form Injection";
        PharmHeader: Record "HMS Radiology Form Header";
        PharmLine: Record "HMS Radiology Form Line";
    begin
        AdmissionLine.Reset;
        AdmissionLine.SetRange(AdmissionLine."Admission No.", ObservationNo);
        AdmissionLine.SetRange(AdmissionLine.Posted, false);
        AdmissionLine.SetRange(AdmissionLine."Drug No.", DrugNo);
        if AdmissionLine.Find('-') then begin
            repeat
                AdmissionLine.TestField("Drug No.");
                AdmissionLine.TestField("Location Code");
                AdmissionLine.TestField("Transaction Type");
                if AdmissionLine.Quantity = 0 then Error('Please enter Quantity in all Lines');
                if AdmissionLine."Unit Price" = 0 then Error('Please enter Unit Price in all Lines');


            until AdmissionLine.Next = 0;
        end;
        PostConsumablesItems(ObservationNo, DrugNo);
        if AdmissionHeader.Get(ObservationNo) then begin
            PrescribeDrugsPrescrip(AdmissionHeader."Patient No.", ObservationNo);
        end;
        if PhysioHeader.Get(ObservationNo) then begin
            PrescribeDrugsPrescrip(PhysioHeader."Patient No.", ObservationNo);
        end;
        if ObservationH.Get(ObservationNo) then begin
            PrescribeDrugsPrescrip(ObservationH."Patient No.", ObservationNo);
        end;
    end;

    procedure PrescribeDrugsInpatient(ObservationNo: Code[20]; DrugNo: Text)
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
        TreatmentHeader: Record "HMS Appointment Form Header";
        TreatmentLine: Record "HMS Treatment Form Injection";
        PharmHeader: Record "HMS Radiology Form Header";
        PharmLine: Record "HMS Radiology Form Line";
    begin
        AdmissionLine.Reset;
        AdmissionLine.SetRange(AdmissionLine."Admission No.", ObservationNo);
        AdmissionLine.SetRange(AdmissionLine.Posted, false);
        AdmissionLine.SetRange(AdmissionLine."Drug No.", DrugNo);
        if AdmissionLine.Find('-') then begin
            repeat
                AdmissionLine.TestField("Drug No.");
                AdmissionLine.TestField("Location Code");
                AdmissionLine.TestField("Transaction Type");
                if AdmissionLine.Quantity = 0 then Error('Please enter Quantity in all Lines');
                if AdmissionLine."Unit Price" = 0 then Error('Please enter Unit Price in all Lines');


            until AdmissionLine.Next = 0;
        end;
        PostConsumablesItems(ObservationNo, DrugNo);
        AdmissionHeader.Reset;
        AdmissionHeader.SetRange(AdmissionHeader."Admission No.", ObservationNo);
        //IF AdmissionHeader.GET(ObservationNo) THEN BEGIN
        if AdmissionHeader.Find('-') then begin
            PrescribeDrugsPrescrip(AdmissionHeader."Patient No.", ObservationNo);
        end else
            if ObservationH.Get(ObservationNo) then begin
                PrescribeDrugsPrescrip(ObservationH."Patient No.", ObservationNo);
            end else
                if PhysioHeader.Get(ObservationNo) then begin
                    PrescribeDrugsPrescrip(PhysioHeader."Patient No.", ObservationNo);
                    //       END ELSE
                    //    IF TheaterForm.GET(ObservationNo) THEN BEGIN
                    //    PrescribeDrugsPrescrip(TheaterForm."Patient No.",ObservationNo);
                end else
                    if
           objAppointment.Get(ObservationNo) then begin
                        PrescribeDrugsPrescrip(objAppointment."Patient No.", ObservationNo);
                    end;
    end;

    procedure GenerateInvoice(PatientNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsPat: Record "HMS Patient";
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        hmsPat.Reset;
        hmsPat.SetRange(hmsPat."Patient No.", PatientNo);
        if hmsPat.Find('-') then
            HMSPatientsCharges.Reset;
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Visit No", hmsPat."Active Visit No");
        //HMSPatientsCharges.SETRANGE(HMSPatientsCharges."Admission No", AdmissionNo);

        if HMSPatientsCharges.Find('-') then begin
            Report.SaveAsPdf(70134759, filename, HMSPatientsCharges);
        end;
        exit(filename);
    end;

    procedure GenerateInvoicebyVisit(PatientNo: Text; filenameFromApp: Text; VisitNo: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        HMSPatientsCharges.Reset;
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Visit No", VisitNo);

        if HMSPatientsCharges.Find('-') then begin
            Report.SaveAsPdf(70134759, filename, HMSPatientsCharges);
        end;
        exit(filename);
    end;

    procedure InsertPatientWalkin(EmployeeNo: Text; Sname: Text; Fname: Text; Mname: Text; gender: Option; Dob: Date; Marital: Option; Id: Text; Address: Text; PostalCode: Text; City: Text; Phone: Text; Email: Text; Nationality: Text; Bloodgrp: Text; NextkinName: Text; NextkinRelationship: Text; NextkinContact: Text; InsuranceNo: Text; InsuranceName: Text; InsuranceMemberNo: Text; Branch: Text) patientid: Text
    begin
        ObjPatient.Init();
        ObjPatient."Patient No." := NoSeriesMgt.GetNextNo('WALKIN', 0D, true);
        patientid := ObjPatient."Patient No.";
        ObjPatient.Validate("Patient No.");
        ObjPatient."Date Registered" := Today;
        ObjPatient."Patient Type" := 2;
        //ObjPatient.VALIDATE("Patient Type");
        ObjPatient."Employee No." := EmployeeNo;
        ObjPatient.Surname := Sname;
        ObjPatient.Validate(Surname);
        ObjPatient."Middle Name" := Fname;
        ObjPatient.Validate("Middle Name");
        ObjPatient."Last Name" := Mname;
        ObjPatient.Validate("Last Name");
        ObjPatient.Gender := gender;
        ObjPatient."Global Dimension 1 Code" := Branch;
        ObjPatient."Date Of Birth" := Dob;
        ObjPatient."Marital Status" := Marital;
        ObjPatient."ID Number" := Id;
        ObjPatient."Walk-in" := true;
        //ObjPatient.VALIDATE("ID Number");
        ObjPatient."Correspondence Address 1" := Address;
        ObjPatient."Correspondence Address 2" := PostalCode;
        ObjPatient."Correspondence Address 3" := City;
        ObjPatient."Telephone No. 1" := Phone;
        ObjPatient.Email := Email;
        ObjPatient.Nationality := Nationality;
        ObjPatient."Blood Group" := Bloodgrp;
        ObjPatient."Next Of kin Full Name" := NextkinName;
        ObjPatient."Next of kin Relationship" := NextkinRelationship;
        ObjPatient."Next Of kin Address 1" := Address;
        ObjPatient."Next Of kin Address 2" := NextkinContact;
        ObjPatient."Insurance No." := InsuranceNo;
        ObjPatient."Insurance Name" := InsuranceName;
        ObjPatient."Membership No" := InsuranceMemberNo;
        ObjPatient.Validate("Patient Ref. No.");
        ObjPatient.Insert;
    end;

    procedure PostConsumablesItems(ObservationNo: Text; DrugNo: Text)
    var
        ItemJnlLine: Record "Item Journal Line";
    begin

        HMSSetup.Reset;
        HMSSetup.Get();
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
        if ItemJnlLine.Find('-') then ItemJnlLine.DeleteAll;

        AdmissionLine.Reset;
        AdmissionLine.SetRange(AdmissionLine."Admission No.", ObservationNo);
        AdmissionLine.SetRange(AdmissionLine.Posted, false);
        AdmissionLine.SetRange(AdmissionLine."Drug No.", DrugNo);
        if AdmissionLine.Find('-') then begin
            repeat
                AdmissionLine.CalcFields("Inventory Group");
                if AdmissionLine."Inventory Group" <> 'DRUG' then begin
                    LineNo := LineNo + 1;
                    ItemJnlLine.Init;
                    ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                    ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                    ItemJnlLine."Line No." := LineNo;
                    ItemJnlLine."Posting Date" := Today;
                    ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::Sale;
                    ItemJnlLine."Document No." := ObservationNo + ':' + AdmissionLine."Drug No.";
                    ItemJnlLine."Item No." := AdmissionLine."Drug No.";
                    ItemJnlLine.Validate(ItemJnlLine."Item No.");
                    ItemJnlLine."Location Code" := AdmissionLine."Location Code";
                    ItemJnlLine.Validate(ItemJnlLine."Location Code");
                    ItemJnlLine.Quantity := AdmissionLine.Quantity;
                    ItemJnlLine.Validate(ItemJnlLine.Quantity);
                    ItemJnlLine."Unit of Measure Code" := AdmissionLine."Unit Of Measure";
                    ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
                    ItemJnlLine."Unit Amount" := AdmissionLine."Unit Price";
                    //ItemJnlLine."Shortcut Dimension 1 Code":='PHARMACY';
                    ItemJnlLine."Shortcut Dimension 2 Code" := 'PHARMACY';
                    // ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount");
                    ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                    ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                    ItemJnlLine.Insert();
                end;

            until AdmissionLine.Next = 0;
            ItemJnlLine.Reset;
            ItemJnlLine.SetRange("Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
            ItemJnlLine.SetRange("Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
            if ItemJnlLine.Find('-') then
                Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);

            AdmissionLine.Reset;
            AdmissionLine.SetRange(AdmissionLine."Admission No.", ObservationNo);
            AdmissionLine.SetRange(AdmissionLine.Posted, false);
            AdmissionLine.SetRange(AdmissionLine."Drug No.", DrugNo);
            if AdmissionLine.Find('-') then begin
                repeat
                    AdmissionLine.CalcFields("Inventory Group");
                    if AdmissionLine."Inventory Group" <> 'DRUG' then begin
                        if ObservationH.Get(ObservationNo) then begin
                            ChargePatient(AdmissionLine."Admission No.", AdmissionLine."Drug No.", AdmissionLine."Line No", AdmissionLine."Transaction Type", ObservationH."Patient No.", ObservationH."Link No.");
                        end else
                            if AdmissionHeader.Get(ObservationNo) then begin
                                ChargePatient(AdmissionLine."Admission No.", AdmissionLine."Drug No.", AdmissionLine."Line No", AdmissionLine."Transaction Type", AdmissionHeader."Patient No.", AdmissionHeader."Link No.");
                                //        END ELSE IF  TheaterForm.GET(ObservationNo) THEN BEGIN
                                //        ChargePatient(AdmissionLine."Admission No.",AdmissionLine."Drug No.",AdmissionLine."Line No",AdmissionLine."Transaction Type",TheaterForm."Patient No.",TheaterForm."No.");
                            end else
                                if
                        objAppointment.Get(ObservationNo) then begin
                                    ChargePatient(AdmissionLine."Admission No.", AdmissionLine."Drug No.", AdmissionLine."Line No", AdmissionLine."Transaction Type", objAppointment."Patient No.", objAppointment."Appointment No.");
                                end;
                        AdmissionLine.Posted := true;
                        AdmissionLine."Posted By" := UserId;
                        AdmissionLine."Posted Date" := Today;
                        AdmissionLine.Modify;
                    end;
                until AdmissionLine.Next = 0;
            end;

        end;
    end;

    local procedure ChargePatient(AdmNo: Code[20]; DrugNo: Code[20]; LineNo: Integer; TranType: Code[20]; PatientNo: Code[20]; LinkNo: Code[20])
    var
        HMSPatientsCharges: Record "HMS Patient Charges";
    begin

        AdmissionLine.Reset;
        AdmissionLine.SetRange(AdmissionLine."Admission No.", AdmNo);
        AdmissionLine.SetRange(AdmissionLine."Line No", LineNo);
        AdmissionLine.SetRange(AdmissionLine."Drug No.", DrugNo);
        if AdmissionLine.Find('-') then begin
            // AdmissionHeader.GET(AdmissionLine."Admission No.");
            HMSPatientsCharges.Init;
            HMSPatientsCharges."Line No" := LineNo;
            HMSPatientsCharges."Patient No." := PatientNo;
            ObjPatient.SetRange(ObjPatient."Patient No.", PatientNo);
            if ObjPatient.Find('-') then
                HMSPatientsCharges."Shortcut Dimension 1 Code" := ObjPatient."Global Dimension 1 Code";
            HMSPatientsCharges."Shortcut Dimension 2 Code" := 'PHARMACY';
            HMSPatientsCharges."Transaction Type" := AdmissionLine."Transaction Type";
            HMSPatientsCharges.Validate("Transaction Type");
            HMSPatientsCharges."Link No" := LinkNo;
            HMSPatientsCharges."Treatment No." := LinkNo;
            HMSPatientsCharges."Appointment No." := LinkNo;
            HMSPatientsCharges.Code := DrugNo;
            HMSPatientsCharges.Description := AdmissionLine."Drug Name";
            HMSPatientsCharges.Amount := AdmissionLine."Unit Price";
            HMSPatientsCharges.Quantity := AdmissionLine.Quantity;
            HMSPatientsCharges.Validate(Quantity);
            HMSPatientsCharges.Validate(Amount);
            HMSPatientsCharges.Date := Today;
            HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Admissions;
            //HMSPatientsCharges."Shortcut Dimension 1 Code" := 'PHARMACY';
            HMSPatientsCharges."Shortcut Dimension 2 Code" := 'PHARMACY';
            // Patient.SETRANGE("Patient No.", PatientNo);
            //IF Patient.FIND('-') THEN
            HMSPatientsCharges."Visit No" := ObjPatient."Active Visit No";
            HMSPatientsCharges.Insert;
        end;
        //END;
    end;

    local procedure PrescribeDrugsPrescrip(PatientNo: Code[20]; ObservationNo: Text)
    begin

        AdmissionLine.Reset;
        AdmissionLine.SetRange(AdmissionLine."Admission No.", ObservationNo);
        AdmissionLine.SetRange(AdmissionLine.Posted, false);
        AdmissionLine.SetFilter(AdmissionLine."Inventory Group", 'DRUGS');
        if AdmissionLine.Find('-') then begin
            HMSSetup.Reset;
            HMSSetup.Get();
            NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", 0D, true);

            /*Get the treatment from the database*/
            AdmissionHeader.Reset;
            //  IF AdmissionHeader.GET("Admission No.") THEN
            //   BEGIN
            PharmHeader.Reset;
            PharmHeader.Init;
            PharmHeader."Pharmacy No." := NewNo;
            PharmHeader."Pharmacy Date" := Today;
            PharmHeader."Pharmacy Time" := Time;
            PharmHeader."Request Area" := PharmHeader."request area"::Doctor;
            PharmHeader."Patient No." := PatientNo;
            /*PharmHeader."Student No.":=AdmissionHeader."Student No.";
            PharmHeader."Employee No.":=AdmissionHeader."Employee No.";
            PharmHeader."Relative No.":=AdmissionHeader."Relative No.";*/
            PharmHeader."Issuing Location" := AdmissionLine."Location Code";
            PharmHeader."Transaction Type" := AdmissionLine."Transaction Type";
            PharmHeader."Link Type" := 'Admission';
            PharmHeader."Link No." := ObservationNo;
            PharmHeader.Status := PharmHeader.Status::New;

            PharmHeader.Insert();

            repeat

                PharmLine.Init;
                PharmLine.Location := AdmissionLine."Location Code";
                PharmLine."Pharmacy No." := NewNo;
                PharmLine."No." := AdmissionLine."Drug No.";
                PharmLine.Quantity := AdmissionLine.Quantity;
                PharmLine.Validate(PharmLine.Quantity);
                PharmLine."Measuring Unit" := AdmissionLine."Unit Of Measure";
                PharmLine.Validate(PharmLine.Quantity);
                PharmLine.Dosage := AdmissionLine.Dosage;
                PharmLine.Pharmacy := AdmissionLine."Location Code";
                PharmLine.Insert();

                //AdmissionLine.Posted,FALSE
                AdmissionLine.Posted := true;
                AdmissionLine."Posted By" := UserId;
                AdmissionLine."Posted Date" := Today;
                AdmissionLine.Modify;
            until AdmissionLine.Next = 0;
        end;
        // END;

    end;

    procedure InsertTransferHeader(From: Text; TransferTo: Text; Department: Text; Revenuecode: Text; employeeno: Text) TrNo: Text
    begin
        TransferHeader.Init;
        TrNo := NoSeriesMgt.GetNextNo('TR_ORD', 0D, true);
        TransferHeader."No." := TrNo;

        TransferHeader."Transfer-from Code" := From;

        TransferHeader."Transfer-to Code" := TransferTo;

        TransferHeader.Status := TransferHeader.Status::Open;
        TransferHeader."Shipment Date" := Today;
        TransferHeader."Receipt Date" := Today;
        TransferHeader."Shortcut Dimension 1 Code" := Department;
        TransferHeader."Shortcut Dimension 2 Code" := Revenuecode;
        TransferHeader."In-Transit Code" := 'IN-Transit';
        TransferHeader."Assigned User ID" := 'REALE1\' + employeeno;
        //TransferHeader.Comment := comment;

        if Location.Get(From) then begin
            TransferHeader."Transfer-from Name" := Location.Name;
            TransferHeader."Transfer-from Name 2" := Location."Name 2";
            TransferHeader."Transfer-from Address" := Location.Address;
            TransferHeader."Transfer-from Address 2" := Location."Address 2";
            TransferHeader."Transfer-from Post Code" := Location."Post Code";
            TransferHeader."Transfer-from City" := Location.City;
            TransferHeader."Transfer-from County" := Location.County;
            TransferHeader."Trsf.-from Country/Region Code" := Location."Country/Region Code";
            TransferHeader."Transfer-from Contact" := Location.Contact;
            TransferHeader."Outbound Whse. Handling Time" := Location."Outbound Whse. Handling Time";
        end;
        if Location.Get(TransferTo) then begin
            TransferHeader."Transfer-to Name" := Location.Name;
            TransferHeader."Transfer-to Name 2" := Location."Name 2";
            TransferHeader."Transfer-to Address" := Location.Address;
            TransferHeader."Transfer-to Address 2" := Location."Address 2";
            TransferHeader."Transfer-to Post Code" := Location."Post Code";
            TransferHeader."Transfer-to City" := Location.City;
            TransferHeader."Transfer-to County" := Location.County;
            TransferHeader."Trsf.-to Country/Region Code" := Location."Country/Region Code";
            TransferHeader."Transfer-to Contact" := Location.Contact;
        end;

        TransferHeader.Validate("Transfer-to Code");
        TransferHeader.Validate("Transfer-to Post Code");
        TransferHeader.Validate("Transfer-to City");

        TransferHeader.Validate("No.");
        TransferHeader.Validate("Transfer-from Code");
        TransferHeader.Validate("Transfer-from Post Code");
        TransferHeader.Validate("Transfer-from City");
        TransferHeader.Insert;
    end;

    procedure InsertTransferLine(TransferNo: Text; ItemNo: Text; quantity: Decimal)
    begin
        TransferHeader.Reset;
        TransferHeader.SetRange("No.", TransferNo);

        if TransferHeader.Find('-') then begin
            ObjItem.Get(ItemNo);
            TransferLine.Reset;
            TransferLine.SetFilter(TransferLine."Document No.", TransferNo);
            if TransferLine.FindLast then
                "LineNo." := TransferLine."Line No.";

            TransferLine.Init;
            TransferLine."Document No." := TransferNo;
            TransferLine."Item No." := ItemNo;
            TransferLine."Line No." := "LineNo." + 1000;
            TransferLine.Validate("Item No.");
            TransferLine.Quantity := quantity;
            TransferLine.Status := TransferLine.Status::Open;
            TransferLine.Description := ObjItem.Description;
            TransferLine."Description 2" := ObjItem."Description 2";
            TransferLine."Shortcut Dimension 1 Code" := TransferHeader."Shortcut Dimension 1 Code";
            TransferLine."Shortcut Dimension 2 Code" := TransferHeader."Shortcut Dimension 2 Code";
            TransferLine.Validate(Quantity);
            TransferLine."Qty. to Ship" := quantity;
            TransferLine."Shipment Date" := Today;
            TransferLine."Receipt Date" := Today;
            TransferLine.Insert;
        end;
    end;

    procedure InsertRadiologyLines(RadiologyNo: Text; RadiologyCode: Text; RequiredInvestigation: Text; PreviousInvestigation: Text; employee: Text)
    begin
        RadiologyLines.Init;
        RadiologyLines."Radiology no." := RadiologyNo;
        RadiologyLines."Radiology Type Code" := RadiologyCode;
        RadiologyLines.Validate("Radiology Type Code");
        RadiologyLines."Performed Date" := Today;
        RadiologyLines."Performed Time" := Time;
        RadiologyLines."Required Investigation" := RequiredInvestigation;
        RadiologyLines."Previous Investigation" := PreviousInvestigation;
        RadiologyLines."Assigned User ID" := employee;
        //RadiologyLines.
        RadiologyLines.Insert;
    end;

    procedure DeleteRadiologytreatLine(TreatmentNo: Text; RadiologyCode: Text)
    begin
        ObjRadiology.Reset;
        ObjRadiology.SetRange("Treatment No.", TreatmentNo);
        ObjRadiology.SetRange("Radiology Type Code", RadiologyCode);
        //ObjRadiology.SETRANGE(Status,ObjRadiology.Status::New);
        if ObjRadiology.Find('-') then begin
            ObjRadiology.Delete;
        end;
        RadiologyHeader.SetRange("Link No.", TreatmentNo);
        if RadiologyHeader.Find('-') then begin
            RadiologyLines.SetRange("Radiology no.", RadiologyHeader."Radiology No.");
            RadiologyLines.SetRange("Radiology Type Code", RadiologyCode);
            if RadiologyLines.Find('-') then begin
                RadiologyLines.Delete;

            end;
        end;
    end;

    procedure DeleteLabtreatLine(TreatmentNo: Text; LabCode: Text)
    begin
        ObjLab.Reset;
        ObjLab.SetRange("Treatment No.", TreatmentNo);
        ObjLab.SetRange("Laboratory Test Package Code", LabCode);
        //ObjLab.SETRANGE(Status,ObjLab.Status::New);
        if ObjLab.Find('-') then begin
            ObjLab.Delete;
        end;

        LabHeader.SetRange("Link No.", TreatmentNo);
        if LabHeader.Find('-') then begin
            LaboratoryLines.SetRange("Laboratory No.", LabHeader."Laboratory No.");
            LaboratoryLines.SetRange("Laboratory Test Code", LabCode);
            if LaboratoryLines.Find('-') then begin
                LaboratoryLines.Delete;

            end;
        end;
        docHeader.Get(TreatmentNo);
        ObjPatient.SetRange("Patient No.", docHeader."Patient No.");
        if ObjPatient.Find('-') then
            HMSPatientsCharges.Reset;
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", docHeader."Patient No.");
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Visit No", docHeader."Link No.");
        HMSPatientsCharges.SetRange(HMSPatientsCharges.Code, LabCode);
        HMSPatientsCharges.SetRange(HMSPatientsCharges.Date, Today);
        if HMSPatientsCharges.Find('-') then
            HMSPatientsCharges.Delete;
    end;

    procedure DeletePrescriptiontreatLine(TreatmentNo: Text; Drugno: Text)
    begin

        ObjPrescription.Reset;
        ObjPrescription.SetRange("Treatment No.", TreatmentNo);
        ObjPrescription.SetRange("Drug No.", Drugno);
        //ObjPrescription.SETRANGE(ObjPrescription.Status,ObjPrescription.Status::New);
        //ObjPrescription.SETRANGE(ObjPrescription.Issued,FALSE);
        if ObjPrescription.Find('-') then begin
            if ObjPrescription.Status <> ObjPrescription.Status::Completed then
                ObjPrescription.Delete;


            PharmHeader.SetRange("Treatment No.", TreatmentNo);
            PharmHeader.SetRange(PharmHeader.Status, PharmHeader.Status::New);
            if PharmHeader.Find('-') then begin
                PharmLine.SetRange(PharmLine."Pharmacy No.", PharmHeader."Pharmacy No.");
                PharmLine.SetRange(PharmLine."No.", Drugno);
                if PharmLine.Find('-') then begin
                    PharmLine.Delete;

                end;
                PharmLine.SetRange(PharmLine."Pharmacy No.", PharmHeader."Pharmacy No.");
                if PharmLine.Find('-') then begin
                    if PharmLine.Count = 0 then
                        PharmHeader.Delete;


                end;
            end;
        end;
    end;

    procedure DeleteDiagnosistreatLine(TreatmentNo: Text; "Code": Text)
    begin
        ObjDiagnosis.Reset;
        ObjDiagnosis.SetRange("Treatment No.", TreatmentNo);
        ObjDiagnosis.SetRange("Diagnosis Code", Code);
        if ObjDiagnosis.Find('-') then begin
            ObjDiagnosis.Delete;
        end;
    end;

    procedure DeleteAdmissiontreatLine(TreatmentNo: Text; "Code": Text)
    begin
        ObjAdmission.Reset;
        ObjAdmission.SetRange("Treatment No.", TreatmentNo);
        //ObjAdmission.SETRANGE(Status,ObjAdmission.Status::New);
        ObjAdmission.SetRange("Admission Reason", Code);

        if ObjAdmission.Find('-') then begin
            ObjAdmission.Delete;
        end;
    end;

    procedure InsertLabLines(LabNo: Text; LabTestCode: Text; SpecimenCode: Text; UnitCode: Text; employee: Text; Remarks: Text)
    begin
        LaboratoryLines.Init;
        LaboratoryLines."Laboratory No." := LabNo;
        LaboratoryLines."Laboratory Test Code" := LabTestCode;
        Labec.Get(LabTestCode);
        LaboratoryLines.Validate("Laboratory Test Code");
        LaboratoryLines."Collection Date" := Today;
        LaboratoryLines."Collection Time" := Time;
        //LaboratoryLines."Specimen Code" :=SpecimenCode;
        //ObjSpecimen.GET(SpecimenCode);
        //LaboratoryLines."Measuring Unit Code" :=UnitCode;
        //ObjMeasuring.GET(UnitCode);
        LaboratoryLines."Assigned User ID" := employee;
        LaboratoryLines.Remarks := Remarks;
        LaboratoryLines."Laboratory Test Name" := Labec.Description;
        //LaboratoryLines."Specimen Name" :=ObjSpecimen.Description;
        //LaboratoryLines."Measuring Unit Name" :=ObjMeasuring.Description;
        LaboratoryLines.Insert;
    end;

    procedure MarkLaboratoryComplete(LabNo: Text)
    begin
        LabHeader.Reset;
        LabHeader.SetRange("Laboratory No.", LabNo);
        if LabHeader.Find('-') then begin
            LabHeader.Status := LabHeader.Status::Completed;
            LabHeader."Completion Date" := Today;
            LabHeader."Completion Time" := Time;
            LabHeader.Modify;

            // Update Queue
            Patient.Get(LabHeader."Patient No.");
            HMSQue.Init;
            HMSQue."Patient No" := LabHeader."Patient No.";
            HMSQue."Visit No" := Patient."Active Visit No";
            HMSQue."Document No" := LabHeader."Laboratory No.";
            HMSQue.Type := 'LAB RESULTS';
            HMSQue."Queue Type" := 'RESULTS';
            HMSQue."Doctor ID" := LabHeader."Doctor ID";
            HMSQue.Date := Today;
            HMSQue.Time := Time;
            HMSQue.Insert;
        end;
        LabTestLines.Reset;
        LabTestLines.SetRange("Laboratory No.", LabNo);
        if LabTestLines.Find('-') then begin
            repeat
                LabTestLines.Completed := true;
                LabTestLines."Collection Date" := Today;
                LabTestLines."Collection Time" := Time;
                LabTestLines.Modify;
            until LabTestLines.Next = 0;
        end;
        ObjLab.Reset;
        ObjLab.SetRange(ObjLab."Treatment No.", LabHeader."Link No.");
        if ObjLab.Find('-') then
            ObjLab.Status := ObjLab.Status::Completed;
        ObjLab.Modify;
        TreatmentHeader.Get(LabHeader."Link No.");
        objAppointment.SetRange("Appointment No.", TreatmentHeader."Link No");
        if objAppointment.Find('-') then begin
            // objAppointment."Dispatch To":=objAppointment."dispatch to";
            // objAppointment."Dispatch Date":=TODAY;
            //objAppointment."Dispatch Time":=TIME;
            // objAppointment.Status:=objAppointment.Status::Dispatched;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Lab Time Out" := CurrentDatetime;
            objAppointment."Doctor Time In" := CurrentDatetime;

            objAppointment.Modify;
        end;
    end;

    procedure MarkRadiologyComplete(RadiologyNo: Text)
    begin
        RadiologyHeader.Reset;
        RadiologyHeader.SetRange("Radiology No.", RadiologyNo);
        if RadiologyHeader.Find('-') then begin
            RadiologyHeader.Status := RadiologyHeader.Status::Completed;
            RadiologyHeader.Modify;

            // Update Queue
            Patient.Get(RadiologyHeader."Patient No.");
            HMSQue.Init;
            HMSQue."Patient No" := RadiologyHeader."Patient No.";
            HMSQue."Visit No" := Patient."Active Visit No";
            HMSQue."Document No" := RadiologyHeader."Radiology No.";
            HMSQue.Type := 'RADIOLOGY';
            HMSQue."Queue Type" := 'RESULTS';
            HMSQue."Doctor ID" := RadiologyHeader."Doctor ID";
            HMSQue.Date := Today;
            HMSQue.Time := Time;
            HMSQue.Insert;

            TreatmentHeader.Get(RadiologyHeader."Link No.");
            objAppointment.SetRange("Appointment No.", TreatmentHeader."Link No");
            if objAppointment.Find('-') then begin
                // objAppointment."Dispatch To":=objAppointment."dispatch to";
                // objAppointment."Dispatch Date":=TODAY;
                //objAppointment."Dispatch Time":=TIME;
                // objAppointment.Status:=objAppointment.Status::Dispatched;
                objAppointment."Waiting At" := objAppointment."waiting at";
                objAppointment."Lab Time Out" := CurrentDatetime;
                objAppointment."Doctor Time In" := CurrentDatetime;

                objAppointment.Modify;
            end;
        end;
    end;

    procedure InsertStaffClaims(EmployeeNo: Text; Deptcode: Text; costcode: Text; Responsibility: Text; Purpose: Text)
    begin
        StaffClaims.Init;
        StaffClaims."No." := NoSeriesMgt.GetNextNo('CLAIM', 0D, true);
        StaffClaims.Date := Today;
        HREmp.Get(EmployeeNo);
        StaffClaims.Payee := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        StaffClaims."On Behalf Of" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        StaffClaims."Global Dimension 1 Code" := Deptcode;
        StaffClaims.Validate("Global Dimension 1 Code");
        StaffClaims.Status := StaffClaims.Status::Pending;
        StaffClaims."Payment Type" := StaffClaims."payment type"::Imprest;
        StaffClaims."Shortcut Dimension 2 Code" := costcode;
        StaffClaims.Validate("Shortcut Dimension 2 Code");
        StaffClaims."No. Series" := 'CLAIM';
        StaffClaims."Responsibility Center" := Responsibility;
        StaffClaims."Account Type" := StaffClaims."account type"::Customer;
        StaffClaims."Account No." := EmployeeNo;
        StaffClaims."Pay Mode" := StaffClaims."pay mode"::Cash;
        StaffClaims."Document Type" := StaffClaims."document type"::"Payment Voucher";
        StaffClaims."Surrender Status" := StaffClaims."surrender status"::" ";
        StaffClaims.Purpose := Purpose;
        StaffClaims.Insert;
    end;

    procedure InsertOperationalNotes(TheatreNo: Text; EmployeeId: Text; Notes: Text; NotesType: Option)
    begin
        /*OperationalNotes.INIT;
        OperationalNotes."Theatre No." :=TheatreNo;
        OperationalNotes."Nurse ID":= EmployeeId;
        OperationalNotes."Notes Date" :=TODAY;
        OperationalNotes."Notes Time" :=TIME;
        OperationalNotes.Notes :=Notes;
        OperationalNotes.notesType :=NotesType;
        OperationalNotes.INSERT;*/

    end;

    procedure InsertTheatreForm(TheatreNo: Text; Surgery: Text; PatientNo: Text; Doctor: Text; Incision: Text; EstimtdBloodLoss: Text; "Count": Option; Anaesthesia: Text)
    begin
        /*TheaterForm.SETRANGE("No.",TheatreNo);
        IF TheaterForm.FIND('-') THEN BEGIN
        TheaterForm."No. Series" :='HOSP-THEAT';
        TheaterForm.Incision :=Incision;
        TheaterForm."Estimated Blood Loss" :=EstimtdBloodLoss;
        TheaterForm.Count :=Count;
        TheaterForm.Anaesthesia :=Anaesthesia;
        TheaterForm.MODIFY;
        END
        ELSE BEGIN
        TheaterForm.INIT;
        TheaterForm."No." :=NoSeriesMgt.GetNextNo('HOSP-THEAT',0D,TRUE); ;
        TheaterForm.Type :=TheaterForm.Type::Admission;
        TheaterForm."Theatre Date" :=TODAY;
        TheaterForm."Theatre Time" :=TIME;
        TheaterForm."Surgery Code" :=Surgery;
        TheaterForm.VALIDATE("Surgery Code");
        TheaterForm."Patient No." :=PatientNo;
        TheaterForm."Link Type" :='TREATMENT';
        TheaterForm."Link No." :='';
        TheaterForm."No. Series" :='HOSP-THEAT';
        TheaterForm.Status :=TheaterForm.Status::New;
        TheaterForm."Doctor ID" :=Doctor;
        TheaterForm."Theatre Procedure" :=TheaterForm."Theatre Procedure"::" " ;
        TheaterForm.Incision :=Incision;
        TheaterForm."Estimated Blood Loss" :=EstimtdBloodLoss;
        TheaterForm.Count :=Count;
        ObjPatient.SETRANGE("Patient No.", PatientNo);
        IF ObjPatient.FIND('-') THEN
        TheaterForm."Surname Name" :=ObjPatient.Surname;
        TheaterForm."Last Name" :=ObjPatient."Last Name";
        TheaterForm."ADM No" :='';
        TheaterForm.Anaesthesia :=Anaesthesia;
        TheaterForm.INSERT;
        END;
        */

    end;

    procedure GenerateTheatreNotes(TheatreNo: Text; filenameFromApp: Text) filename: Text
    begin
        /*filename :=FILESPATH+filenameFromApp;
         IF EXISTS(filename) THEN
          ERASE(filename);
        
        
        TheaterForm.RESET;
        TheaterForm.SETRANGE(TheaterForm."No.",TheatreNo);
        
        
        IF TheaterForm.FIND('-') THEN BEGIN
        REPORT.SAVEASPDF(70134833,filename,TheaterForm);
         END;
        EXIT(filename);*/

    end;

    procedure GenerateRadiologyPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        ObjRadiology.Reset;
        ObjRadiology.SetRange(ObjRadiology."Treatment No.", TreatmentNo);


        if ObjRadiology.Find('-') then begin
            Report.SaveAsPdf(70135111, filename, ObjRadiology);
        end;
        exit(filename);
    end;

    procedure GeneratePrescriptionPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        ObjPrescription.Reset;
        ObjPrescription.SetRange(ObjPrescription."Treatment No.", TreatmentNo);


        if ObjPrescription.Find('-') then begin
            Report.SaveAsPdf(70135515, filename, ObjPrescription);
        end;
        exit(filename);
    end;

    procedure SaveSickoff(TreatmentNo: Text; Offdutydays: Decimal; lightdutydays: Decimal; Comments: Text; NextAppointmentDate: Date; StartDate: Date; EndDate: Date)
    begin
        docHeader.SetRange("Treatment No.", TreatmentNo);
        if docHeader.Find('-') then begin
            docHeader."Off Duty Days" := Offdutydays;
            docHeader."Light Duty Days" := lightdutydays;
            docHeader."Off Duty Comments" := Comments;
            docHeader."Next Appointment Date" := NextAppointmentDate;
            docHeader."Off Duty" := true;
            docHeader."Sick Off Start Date" := StartDate;
            docHeader."Sick Off End Date" := EndDate;
            docHeader.Modify;
        end;
    end;

    procedure GenerateSickoffPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(70135515, filename, docHeader);
        end;
        exit(filename);
    end;

    procedure SendToTheatre(TreatmentNo: Text)
    begin
        /*HMSSetup.RESET;
            HMSSetup.GET();
            NewNo:=NoSeriesMgt.GetNextNo('HOSP-THEAT',0D,TRUE);
            docHeader.RESET;
            docHeader.GET(TreatmentNo);
        THeader.RESET;
        THeader.SETRANGE(THeader."Treatment No.",TreatmentNo);
        THeader.SETRANGE(THeader.Status,THeader.Status::New);
        IF THeader.FIND('-') THEN BEGIN
          REPEAT
            THeader2.RESET;
            THeader2.INIT;
              THeader2."No." :=NewNo;
              THeader2."Theatre Date":=TODAY;
              THeader2."Theatre Time":=TIME;
              THeader2."Patient No.":=docHeader."Patient No.";
              THeader2."Surgery Code" :=THeader."Process No.";
              THeader2.Surgery :=THeader."Process Name";
              THeader2."Relative No.":=docHeader."Relative No.";
              THeader2."Link Type":='Treatment';
              THeader2."Link No.":=docHeader."Treatment No.";
              THeader2."No. Series":='HOSP-THEAT';
              THeader2."Doctor ID" :=THeader.Doctor;
              THeader2."Anaesthetist ID" :=THeader.Anaesthesist;
              THeader2.Instructions :=THeader.Instructions;
              THeader2.INSERT;
           UNTIL THeader.NEXT=0;
              END;
           {THeader2.RESET;
           THeader2.SETRANGE(THeader2."Link No.",docHeader."Treatment No.");
           IF THeader2.FIND('-') THEN
             BEGIN
               IF CONFIRM('Record already exist,Confirm Continue?') THEN   THeader.INSERT;
             END
           ELSE
             BEGIN
              THeader.INSERT;
             END;}
        TLine.RESET;
        TLine.SETRANGE(TLine."Treatment No.",TreatmentNo);
        TLine.SETRANGE(TLine.Status,TLine.Status::New);
        IF TLine.FIND('-') THEN BEGIN
          REPEAT
          TLine.Status:=TLine.Status::Forwarded;
          TLine.MODIFY;
        
                  TTestLines.INIT;
                   TTestLines."No." :=THeader2."No.";
                   TTestLines."Process No." :=TLine."Process No.";
                   TTestLines."Process Name":= TLine."Process Name";
        
                   TTestLines.INSERT;
        
           UNTIL TLine.NEXT=0;
        END;*/

    end;

    procedure InsertDischargeSummary(DischargeCode: Text; Type: Option; Description: Text; TreatmentNo: Text; PatientNo: Text; ReviewDate: Date)
    begin
        /*DischargeSummary.INIT;
        DischargeSummary."Discharge Code" :=DischargeCode;
        DischargeSummary.Type :=Type;
        DischargeSummary.Description :=Description;
        DischargeSummary.TreatmentNo :=TreatmentNo;
        DischargeSummary.PatientNo :=PatientNo;
        DischargeSummary."Review Date" :=ReviewDate;
        DischargeSummary.INSERT;*/

    end;

    procedure DeletePrescriptionAdmissionDrug(AdmissionNo: Text; Drugno: Text)
    begin
        DrugPrescribe.Reset;
        DrugPrescribe.SetRange("Admission No.", AdmissionNo);
        DrugPrescribe.SetRange("Drug No.", Drugno);
        DrugPrescribe.SetRange(DrugPrescribe.Posted, false);
        if DrugPrescribe.Find('-') then begin
            DrugPrescribe.Delete;
        end;
    end;

    procedure GenerateDischargeSummaryPrintout(AdmissionNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        AdmissionDischargeHeader.Reset;
        AdmissionDischargeHeader.SetRange(AdmissionDischargeHeader."Admission No.", AdmissionNo);


        if AdmissionDischargeHeader.Find('-') then begin
            Report.SaveAsPdf(70135077, filename, AdmissionDischargeHeader);
        end;
        exit(filename);
    end;

    procedure GenerateAdmissionPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        ObjAdmission.Reset;
        ObjAdmission.SetRange(ObjAdmission."Treatment No.", TreatmentNo);


        if ObjAdmission.Find('-') then begin
            Report.SaveAsPdf(70134904, filename, ObjAdmission);
        end;
        exit(filename);
    end;

    procedure GenerateTreatmentHistoPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(70135102, filename, docHeader);
        end;
        exit(filename);
    end;

    procedure GenerateMedicalReport(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(70134832, filename, docHeader);
        end;
        exit(filename);
    end;

    procedure SelectDiagnosis(TreamentNo: Text) diagnosis: Boolean
    begin
        diagnosis := false;
        ObjDiagnosis.Reset;
        ObjDiagnosis.SetRange("Treatment No.", TreamentNo);
        //ObjDiagnosis.SETRANGE("Diagnosis Type" , ObjDiagnosis."Diagnosis Type"::"Pre-Diagnosis");
        if ObjDiagnosis.Find('-') then begin
            diagnosis := true
        end;
    end;

    procedure SendtoDischarge(TreatmentNo: Text; AdmissionNo: Text)
    begin
        /*DischargeSummary.RESET;
        DischargeSummary.SETRANGE("Discharge Code",AdmissionNo);
        IF DischargeSummary.FIND ('-') THEN
        docHeader.GET(TreatmentNo);
        AdmissionHeader.GET(AdmissionNo);
        AdmissionDischargeHeader.INIT;
        AdmissionDischargeHeader."Admission No." :=AdmissionNo;
        AdmissionDischargeHeader."Patient No." :=AdmissionHeader."Patient No.";
        AdmissionDischargeHeader."Discharge Date" :=TODAY;
        AdmissionDischargeHeader."Discharge Time" :=TIME;
        AdmissionDischargeHeader."Date of Admission" :=AdmissionHeader."Admission Date";
        AdmissionDischargeHeader."Time Of Admission" :=AdmissionHeader."Admission Time";
        AdmissionDischargeHeader."Ward No." :=AdmissionHeader.Ward;
        AdmissionDischargeHeader."Bed No." :=AdmissionHeader.Bed;
        //AdmissionDischargeHeader."Discharge Type" :=AdmissionDischargeHeader."Discharge Type"::
        AdmissionDischargeHeader."Patient Type" :=docHeader."Patient Type";
        AdmissionDischargeHeader."Doctor ID" :=AdmissionHeader.Doctor;
        AdmissionDischargeHeader.Remarks :='Discharged by doctor ' +docHeader."Doctor ID";
        AdmissionDischargeHeader.Status :=AdmissionDischargeHeader.Status::New;
        AdmissionDischargeHeader.INSERT;
        */

    end;

    procedure CountDoctorQue(DocID: Text) DocQue: Integer
    begin
        DocQue := 0;
        UserSetUpPortal.SetRange("User ID", DocID);
        // UserSetUpPortal.SETRANGE("Doctor ID",'<>%1','');
        if UserSetUpPortal.Find('-')
          then begin
            HMSQue.Reset;
            //HMSQue.SETRANGE("Doctor ID", UserSetUpPortal."Doctor ID");
            HMSQue.SetRange(Status, HMSQue.Status::Open);
            if HMSQue.Find('-') then
                DocQue := HMSQue.Count;
        end;
    end;

    procedure CountApprovals(Approver: Text) CountApprovals: Integer
    begin
        CountApprovals := 0;
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Approver ID", Approver);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.Find('-') then
            CountApprovals := ApprovalEntry.Count;
    end;

    procedure UpdateDocque(DocumentNo: Text)
    begin
        HMSQue.Reset;
        HMSQue.SetRange("Document No", DocumentNo);
        HMSQue.SetRange(Status, HMSQue.Status::Open);
        if HMSQue.Find('-') then begin
            HMSQue.Status := HMSQue.Status::Closed;
            HMSQue.Modify;
        end;
    end;

    procedure CheckUserSetup(EmployeeID: Text) Userexists: Boolean
    begin
        Userexists := false;
        ObjUser.Reset;
        ObjUser.SetRange("User Name", EmployeeID);
        if ObjUser.Find('-') then
            Userexists := true;
    end;

    procedure CancelPurchaseRequisition(DocNo: Text)
    begin
        objPurchaseHeader.Reset;
        objPurchaseHeader.SetRange("No.", DocNo);
        objPurchaseHeader.SetRange(Status, objPurchaseHeader.Status::"Pending Approval");
        if objPurchaseHeader.Find('-') then begin
            objPurchaseHeader.Status := objPurchaseHeader.Status::Open;
            objPurchaseHeader.Modify;
            ApprovalsMgmt.OnCancelPurchaseApprovalRequest(objPurchaseHeader);

        end;
    end;

    procedure PostDrugIssuance(PharmacyNo: Text)
    var
        PatientName: Text[100];
        ItemJnlLine: Record "Item Journal Line";
        LineNo: Integer;
        HMSSetup: Record "HMS Setup";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        Patient: Record "HMS Patient";
        TreatmentLine: Record "HMS Treatment Form Drug";
        ValueEntry: Record "Value Entry";
        HMSPatientsCharges: Record "HMS Patient Charges";
        objItem: Record Item;
        AppH: Record "HMS Appointment Form Header";
        UserRec: Record "User Setup";
        PatientCharge: Record "HMS Patient Charges";
    begin

        PharmHeader.Get(PharmacyNo);
        testfields(PharmHeader."Transaction Type");
        if AppH.Get(PharmHeader."Link No.") then
            Patient.Reset;
        Patient.SetRange(Patient."Patient No.", PharmHeader."Patient No.");
        Patient.SetRange(Patient.Inpatient, false);
        if Patient.Find('-') then begin
            if AppH."Settlement Type" = AppH."settlement type"::Cash then
                PharmHeader."Cash Sale" := true;
            Patient.Activated := true;
            Patient."Active Visit No" := AppH."Appointment No.";
            Patient.Modify;
            PharmHeader.Modify;
        end;


        PostItems(PharmacyNo);

        //IF "Cash Sale"=FALSE THEN
        PatientCharge.Reset;
        PatientCharge.SetRange(PatientCharge."Patient No.", PharmHeader."Patient No.");
        PatientCharge.SetRange(PatientCharge."Link No", PharmacyNo);
        if PatientCharge.Find('-') then begin
            //Do nothing
        end else
            ChargePatient2(PharmacyNo);

        /*IF CONFIRM('Do you want to print the labels')=TRUE THEN
          BEGIN
            PharmLine.RESET;
            PharmLine.SETRANGE(PharmLine."Pharmacy No.",PharmacyNo);
            IF PharmLine.FIND('-') THEN
              //REPEAT
                REPORT.RUN(70135183,FALSE,FALSE,PharmLine);
              //UNTIL PharmLine.NEXT=0;
          END;*/

    end;

    procedure PostItems(PharmacyNo: Text)
    var
        PatientName: Text[100];
        ItemJnlLine: Record "Item Journal Line";
        LineNo: Integer;
        HMSSetup: Record "HMS Setup";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        Patient: Record "HMS Patient";
        TreatmentLine: Record "HMS Treatment Form Drug";
        ValueEntry: Record "Value Entry";
        HMSPatientsCharges: Record "HMS Patient Charges";
        objItem: Record Item;
        AppH: Record "HMS Appointment Form Header";
        UserRec: Record "User Setup";
        PatientCharge: Record "HMS Patient Charges";
    begin

        PharmHeader.Get(PharmacyNo);
        //IF CONFIRM('Do you wish to post the record?',FALSE)=FALSE THEN BEGIN EXIT END;
        if PharmHeader."Cash Sale" = true then begin
            PharmHeader.CalcFields(PharmHeader."Receipt Count");
            if PharmHeader."Receipt Count" = 0 then Error('Please note that the selected Record has not been receipted');
        end;


        HMSSetup.Reset;
        HMSSetup.Get();
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
        if ItemJnlLine.Find('-') then ItemJnlLine.DeleteAll;
        LineNo := 0;
        PharmLine.Reset;
        PharmLine.SetRange(PharmLine."Pharmacy No.", PharmacyNo);
        if PharmLine.Find('-') then begin
            repeat
                PharmLine.TestField(PharmLine.Location);
                LineNo := LineNo + 1000;
                ItemJnlLine.Init;
                ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                ItemJnlLine."Line No." := LineNo;
                ItemJnlLine."Posting Date" := Today;
                ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::Sale;
                ItemJnlLine."Document No." := PharmLine."Pharmacy No." + ':' + PharmLine."No.";
                ItemJnlLine."Item No." := PharmLine."No.";
                ItemJnlLine.Validate(ItemJnlLine."Item No.");
                ItemJnlLine."Location Code" := PharmLine.Location;
                ItemJnlLine.Validate(ItemJnlLine."Location Code");
                ItemJnlLine.Quantity := PharmLine.Quantity;
                ItemJnlLine.Validate(ItemJnlLine.Quantity);
                ItemJnlLine."Unit of Measure Code" := PharmLine."Measuring Unit";
                ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
                ItemJnlLine."Unit Amount" := PharmLine."Unit Price";
                ItemJnlLine."Shortcut Dimension 1 Code" := 'PHARMACY';
                ItemJnlLine."Shortcut Dimension 2 Code" := 'PHARMACY';
                // ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount");
                ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                ItemJnlLine.Insert();
                PharmLine.Remaining := PharmLine.Remaining - PharmLine.Quantity;
                PharmLine.Modify;
                LineNo := LineNo + 1;
                /*Update the treatment lines*/
                TreatmentLine.Reset;
                TreatmentLine.SetRange(TreatmentLine."Treatment No.", PharmHeader."Link No.");
                TreatmentLine.SetRange(TreatmentLine."Drug No.", PharmLine."No.");
                if TreatmentLine.Find('-') then begin
                    TreatmentLine.Issued := true;
                    TreatmentLine.Modify;
                end;

                //---------------------------------------
                objItem.Reset;
                objItem.SetRange(objItem."No.", PharmLine."No.");
                if objItem.Find('-') then begin
                    objItem."Unit Price" := PharmLine."Unit Price";

                    //          objItem.Dosage:=TreatmentLine.Dosage;
                    //          objItem.Take := TreatmentLine.Take;
                    //          objItem."Number of Days":=TreatmentLine."Number of Days";
                    //          objItem.Frequency := TreatmentLine.Frequency;
                    //          objItem.MODIFY;
                    //          objItem.MODIFY;
                end;

            until PharmLine.Next = 0;
            ItemJnlLine.Reset;
            ItemJnlLine.SetRange("Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
            ItemJnlLine.SetRange("Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
            if ItemJnlLine.Find('-') then
                Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);
            //ERROR('Mtg');
            PharmHeader.Status := PharmHeader.Status::Completed;
            PharmHeader.Modify;

            TreatmentHeader.Get(PharmHeader."Link No.");
            objAppointment.SetRange("Appointment No.", TreatmentHeader."Link No");
            if objAppointment.Find('-') then begin
                // objAppointment."Dispatch To":=objAppointment."dispatch to";
                // objAppointment."Dispatch Date":=TODAY;
                //objAppointment."Dispatch Time":=TIME;
                // objAppointment.Status:=objAppointment.Status::Dispatched;
                objAppointment."Waiting At" := objAppointment."waiting at";
                objAppointment."Pharmacy Time Out" := CurrentDatetime;
                //objAppointment."Doctor Time In" := CURRENTDATETIME;

                objAppointment.Modify;
            end;
        end;

    end;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.Reset;
        PatientName := '';
        if Patient.Get(PatientNo) then begin
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
        end;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        //xRec := Rec;
        //GetPatientName("Patient No.",PatientName);
    end;

    local procedure ChargePatient2(PharmacyNo: Text)
    begin
        //IF "Cash Sale"=FALSE THEN  BEGIN

        PharmHeader.Get(PharmacyNo);
        PharmLine.Reset;
        PharmLine.SetRange(PharmLine."Pharmacy No.", PharmacyNo);
        if PharmLine.Find('-') then begin
            repeat
                HMSPatientsCharges.Init;
                HMSPatientsCharges."Line No" := PharmLine."line no";
                HMSPatientsCharges."Patient No." := PharmHeader."Patient No.";
                HMSPatientsCharges."Transaction Type" := PharmHeader."Transaction Type";
                HMSPatientsCharges.Validate("Transaction Type");
                HMSPatientsCharges."Link No" := PharmHeader."Pharmacy No.";
                HMSPatientsCharges."Treatment No." := PharmHeader."Link No.";
                HMSPatientsCharges."Appointment No." := PharmHeader."Link No.";
                HMSPatientsCharges.Code := PharmLine."No.";
                PharmLine.CalcFields(PharmLine."Drug Name");
                HMSPatientsCharges.Description := PharmLine."Drug Name";
                if PharmLine."Unit Price" = 0 then Error('Kindly enter the issued price');
                HMSPatientsCharges.Quantity := PharmLine.Quantity;
                HMSPatientsCharges.Validate(Quantity);
                HMSPatientsCharges.Amount := PharmLine."Unit Price";
                HMSPatientsCharges.Validate(Amount);
                HMSPatientsCharges.Date := Today;
                HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Pharmacy;

                HMSPatientsCharges."Shortcut Dimension 2 Code" := 'PHARMACY';
                Patient.SetRange("Patient No.", PharmHeader."Patient No.");
                if Patient.Find('-') then begin
                    HMSPatientsCharges."Admission No" := Patient."Current Adm No";
                    HMSPatientsCharges."Visit No" := Patient."Active Visit No";
                    HMSPatientsCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                end;

                HMSPatientsCharges.Insert;
            until PharmLine.Next = 0;
        end;
    end;

    procedure PostPharmacyReturn(PharmacyNo: Text; DrugNo: Text)
    begin


        if PharmHeader.Get(PharmacyNo) then begin
            if PharmHeader."Cash Sale" = true then begin
                PharmHeader.CalcFields("Receipt Count");
                if PharmHeader."Receipt Count" = 0 then Error('Please note that the selected Record has not been receipted');
            end;

            ReturnStock(PharmacyNo);
            ReverseChargePatient;
        end;
    end;

    local procedure ReverseChargePatient()
    begin
        //IF "Cash Sale"=FALSE THEN  BEGIN
        HMSPatientsCharges.Reset;
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PharmHeader."Patient No.");
        HMSPatientsCharges.SetRange(HMSPatientsCharges.Code, PharmLine."No.");
        HMSPatientsCharges.SetRange(HMSPatientsCharges.Date, PharmHeader."Pharmacy Date");
        if HMSPatientsCharges.Find('-') then begin
            HMSPatientsCharges.Delete;
        end;
    end;

    local procedure ReturnStock(PharmacyNo: Text)
    var
        TreatmentLine: Record "HMS Treatment Form Drug";
    begin
        HMSSetup.Reset;
        HMSSetup.Get();
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
        if ItemJnlLine.Find('-') then ItemJnlLine.DeleteAll;
        LineNo := 0;
        PharmLine.Reset;
        PharmLine.SetRange(PharmLine."Pharmacy No.", PharmacyNo);
        //PharmLine.SETFILTER(PharmLine."Returns Quantity",'>%1',0);
        if PharmLine.Find('-') then begin

            repeat
                if PharmLine."Returns Quantity" > 1 then begin
                    if PharmLine."Issued Quantity" < PharmLine."Issued Quantity" then Error('You cannot return more than you gave issued');
                    if PharmLine.Quantity < PharmLine.Quantity then Error('You cannot return more than you gave issued');
                    if PharmLine."Issued Units" < PharmLine."Issued Units" then Error('You cannot return more than you gave issued');


                    PharmLine.TestField(PharmLine.Location);
                    LineNo := LineNo + 1000;
                    ItemJnlLine.Init;
                    ItemJnlLine."Journal Template Name" := HMSSetup."Pharmacy Item Journal Template";
                    ItemJnlLine."Journal Batch Name" := HMSSetup."Pharmacy Item Journal Batch";
                    ItemJnlLine."Line No." := LineNo;
                    ItemJnlLine."Posting Date" := Today;
                    ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::"Positive Adjmt.";
                    ItemJnlLine."Document No." := PharmLine."Pharmacy No." + ':' + PharmLine."No.";
                    ItemJnlLine."Item No." := PharmLine."No.";
                    ItemJnlLine.Validate(ItemJnlLine."Item No.");
                    ItemJnlLine."Location Code" := PharmLine.Location;
                    ItemJnlLine.Validate(ItemJnlLine."Location Code");
                    if PharmLine."Returns Quantity" <= 0 then Error('Please enter returns quantity');
                    ItemJnlLine.Quantity := PharmLine."Returns Quantity";
                    ItemJnlLine.Validate(ItemJnlLine.Quantity);
                    ItemJnlLine."Unit of Measure Code" := PharmLine."Measuring Unit";
                    ItemJnlLine.Validate(ItemJnlLine."Unit of Measure Code");
                    ItemJnlLine."Unit Amount" := PharmLine."Unit Price";
                    ItemJnlLine."Shortcut Dimension 1 Code" := 'PHARMACY';
                    ItemJnlLine."Shortcut Dimension 2 Code" := 'PHARMACY';
                    // ItemJnlLine.VALIDATE(ItemJnlLine."Unit Amount");
                    ItemJnlLine.Validate("Shortcut Dimension 1 Code");
                    ItemJnlLine.Validate("Shortcut Dimension 2 Code");
                    ItemJnlLine.Insert();

                    ReverseChargePatient(); //Modify bill

                    PharmLine.Remaining := PharmLine.Remaining + PharmLine."Returns Quantity";
                    PharmLine."Issued Quantity" := PharmLine."Issued Quantity" - PharmLine."Returns Quantity";
                    PharmLine.Quantity := PharmLine.Quantity - PharmLine."Returns Quantity";
                    PharmLine."Issued Units" := PharmLine."Issued Units" - PharmLine."Returns Quantity";
                    //PharmLine.
                    PharmLine.Modify;
                    LineNo := LineNo + 1;
                    /*Update the treatment lines*/
                    TreatmentLine.Reset;
                    TreatmentLine.SetRange(TreatmentLine."Treatment No.", PharmHeader."Link No.");
                    TreatmentLine.SetRange(TreatmentLine."Drug No.", PharmLine."No.");
                    if TreatmentLine.Find('-') then begin
                        TreatmentLine.Issued := true;
                        TreatmentLine.Modify;
                    end;

                end;
            until PharmLine.Next = 0;
            ItemJnlLine.Reset;
            ItemJnlLine.SetRange("Journal Template Name", HMSSetup."Pharmacy Item Journal Template");
            ItemJnlLine.SetRange("Journal Batch Name", HMSSetup."Pharmacy Item Journal Batch");
            if ItemJnlLine.Find('-') then
                Codeunit.Run(Codeunit::"Item Jnl.-Post Batch", ItemJnlLine);
            //ERROR('Mtg');
            PharmHeader.Status := PharmHeader.Status::Completed;
            PharmHeader.Modify;
        end;

    end;

    procedure PostTranferOrder(TransferNo: Text; DefaultNumber: Integer)
    var
        Selection: Option;
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
        TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
    begin

        TransferHeader.Reset;
        TransferHeader.SetRange("No.", TransferNo);
        if TransferHeader.Find('-') then begin
            //CODEUNIT.RUN(CODEUNIT::"TransferOrder-Post (Yes/No)",TransferHeader);

            with TransferHeader do begin
                TransferLine.SetRange("Document No.", TransferNo);
                if TransferLine.Find('-') then
                    /* REPEAT
                       IF (TransferLine."Quantity Shipped" < TransferLine.Quantity) AND
                          (DefaultNumber = 0)
                       THEN
                         DefaultNumber := 1;
                       IF (TransferLine."Quantity Received" < TransferLine.Quantity) AND
                          (DefaultNumber = 0)
                       THEN
                         DefaultNumber := 2;
                     UNTIL (TransferLine.NEXT = 0) OR (DefaultNumber > 0);
                     */
          if DefaultNumber = 0 then
                        DefaultNumber := 1;
                Selection := StrMenu('', DefaultNumber);
                case Selection of
                    0:
                        exit;
                    1:
                        TransferPostShipment.Run(TransferHeader);
                    2:
                        TransferPostReceipt.Run(TransferHeader);
                end;
            end;



        end;

    end;

    procedure CountAppointments() CountApprovals: Integer
    begin
        CountApprovals := 0;
        objAppointment.Reset;
        objAppointment.SetRange(objAppointment."Appointment Date", Today);

        if objAppointment.Find('-') then
            CountApprovals := objAppointment.Count;
    end;

    procedure CountNewPatients() CountApprovals: Integer
    begin
        CountApprovals := 0;
        ObjPatient.Reset;
        ObjPatient.SetRange(ObjPatient."Date Registered", Today);

        if ObjPatient.Find('-') then
            CountApprovals := ObjPatient.Count;
    end;

    procedure CountDoctorsVisits() CountApprovals: Integer
    begin
        CountApprovals := 0;
        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment Date", Today);
        if docHeader.Find('-') then
            CountApprovals := docHeader.Count;
    end;

    procedure CountLabVisits() CountApprovals: Integer
    begin
        CountApprovals := 0;
        LabHeader.Reset;
        LabHeader.SetRange(LabHeader."Laboratory Date", Today);

        if LabHeader.Find('-') then
            CountApprovals := LabHeader.Count;
    end;

    procedure CountRadiologyrequest() CountApprovals: Integer
    begin
        CountApprovals := 0;
        RadiologyHeader.Reset;
        RadiologyHeader.SetRange(RadiologyHeader."Radiology Date", Today);

        if RadiologyHeader.Find('-') then
            CountApprovals := RadiologyHeader.Count;
    end;

    procedure CountInpatients() CountApprovals: Integer
    begin
        CountApprovals := 0;
        ObjPatient.Reset;
        //ObjPatient.SETRANGE(ObjPatient."Date Registered", TODAY);
        ObjPatient.SetRange(ObjPatient.Inpatient, true);
        if ObjPatient.Find('-') then
            CountApprovals := ObjPatient.Count;
    end;

    procedure CountPharmacy() CountApprovals: Integer
    begin
        CountApprovals := 0;
        PharmHeader.Reset;
        PharmHeader.SetRange(PharmHeader."Pharmacy Date", Today);
        if PharmHeader.Find('-') then
            CountApprovals := PharmHeader.Count;
    end;

    procedure CountDoctors() CountApprovals: Integer
    begin
        CountApprovals := 0;
        //DoctorsRec.RESET;
        //DoctorsRec.SETRANGE();
        //IF DoctorsRec.FIND('-') THEN
        CountApprovals := DoctorsRec.Count;
    end;

    procedure PostTransferOrdPortal(DocNo: Text)
    var
        Item: Record Item;
        SourceCodeSetup: Record "Source Code Setup";
        InvtSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UpdateAnalysisView: Codeunit "Update Analysis View";
        UpdateItemAnalysisView: Codeunit "Update Item Analysis View";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        RecordLinkManagement: Codeunit "Record Link Management";
        Window: Dialog;
        LineCount: Integer;
        NextLineNo: Integer;
        Text001: label 'There is nothing to post.';
        Text002: label 'Warehouse handling is required for Transfer order = %1, %2 = %3.';
        Text003: label 'Posting transfer lines     #2######';
        Text004: label 'Transfer Order %1';
        Text005: label 'The combination of dimensions used in transfer order %1 is blocked. %2';
        Text006: label 'The combination of dimensions used in transfer order %1, line no. %2 is blocked. %3';
        Text007: label 'The dimensions that are used in transfer order %1, line no. %2 are not valid. %3.';
        Text008: label 'This order must be a complete shipment.';
        Text009: label 'Item %1 is not in inventory.';
    begin
        TransHeader.Get(DocNo);
        if TransHeader.Status = TransHeader.Status::Open then begin
            TransHeader."Posting Date" := Today;
            Codeunit.Run(Codeunit::"Release Transfer Document", TransHeader);
            TransHeader."Posting Date" := Today;
            TransHeader.Status := TransHeader.Status::Open;
            TransHeader.Modify;
            Commit;
            TransHeader.Status := TransHeader.Status::Released;
        end;
        //TransHeader := Rec;
        TransHeader.SetHideValidationDialog(HideValidationDialog);

        with TransHeader do begin
            CheckBeforePost;

            WhseReference := "Posting from Whse. Ref.";
            "Posting from Whse. Ref." := 0;

            if "Shipping Advice" = "shipping advice"::Complete then
                if not GetShippingAdvice then
                    Error(Text008);

            CheckDim;

            TransLine.Reset;
            TransLine.SetRange("Document No.", "No.");
            TransLine.SetRange("Derived From Line No.", 0);
            TransLine.SetFilter(Quantity, '<>0');
            TransLine.SetFilter("Qty. to Ship", '<>0');
            if TransLine.IsEmpty then
                Error(Text001);

            WhseShip := TempWhseShptHeader.FindFirst;
            InvtPickPutaway := WhseReference <> 0;
            CheckItemInInventoryAndWarehouse(TransLine, not (WhseShip or InvtPickPutaway));

            GetLocation("Transfer-from Code");
            if Location."Bin Mandatory" and not (WhseShip or InvtPickPutaway) then
                WhsePosting := true;

            Window.Open(
              '#1#################################\\' +
              Text003);

            Window.Update(1, StrSubstNo(Text004, "No."));

            SourceCodeSetup.Get;
            SourceCode := SourceCodeSetup.Transfer;
            InvtSetup.Get;
            InvtSetup.TestField("Posted Transfer Shpt. Nos.");

            CheckInvtPostingSetup;

            LockTables(InvtSetup."Automatic Cost Posting");

            // Insert shipment header
            PostedWhseShptHeader.LockTable;
            TransShptHeader.LockTable;
            TransShptHeader.Init;
            TransShptHeader.CopyFromTransferHeader(TransHeader);
            TransShptHeader."No. Series" := InvtSetup."Posted Transfer Shpt. Nos.";
            TransShptHeader."No." :=
              NoSeriesMgt.GetNextNo(
                InvtSetup."Posted Transfer Shpt. Nos.", "Posting Date", true);
            TransShptHeader.Insert;

            if InvtSetup."Copy Comments Order to Shpt." then begin
                CopyCommentLines(1, 2, "No.", TransShptHeader."No.");
                TransHeader.Get(DocNo);
                RecordLinkManagement.CopyLinks(TransHeader, TransShptHeader);
            end;

            if WhseShip then begin
                WhseShptHeader.Get(TempWhseShptHeader."No.");
                WhsePostShpt.CreatePostedShptHeader(PostedWhseShptHeader, WhseShptHeader, TransShptHeader."No.", "Posting Date");
            end;

            // Insert shipment lines
            LineCount := 0;
            if WhseShip then
                PostedWhseShptLine.LockTable;
            if InvtPickPutaway then
                WhseRqst.LockTable;
            TransShptLine.LockTable;
            TransLine.SetRange(Quantity);
            TransLine.SetRange("Qty. to Ship");
            if TransLine.Find('-') then
                repeat
                    LineCount := LineCount + 1;
                    Window.Update(2, LineCount);

                    if TransLine."Item No." <> '' then begin
                        Item.Get(TransLine."Item No.");
                        Item.TestField(Blocked, false);
                    end;

                    TransShptLine.Init;
                    TransShptLine."Document No." := TransShptHeader."No.";
                    TransShptLine.CopyFromTransferLine(TransLine);

                    if TransLine."Qty. to Ship" > 0 then begin
                        OriginalQuantity := TransLine."Qty. to Ship";
                        OriginalQuantityBase := TransLine."Qty. to Ship (Base)";
                        PostItemJnlLine(TransLine, TransShptHeader, TransShptLine);
                        TransShptLine."Item Shpt. Entry No." := InsertShptEntryRelation(TransShptLine);
                        if WhseShip then begin
                            WhseShptLine.SetCurrentkey(
                              "No.", "Source Type", "Source Subtype", "Source No.", "Source Line No.");
                            WhseShptLine.SetRange("No.", WhseShptHeader."No.");
                            WhseShptLine.SetRange("Source Type", Database::"Transfer Line");
                            WhseShptLine.SetRange("Source No.", TransLine."Document No.");
                            WhseShptLine.SetRange("Source Line No.", TransLine."Line No.");
                            WhseShptLine.FindFirst;
                            WhseShptLine.TestField("Qty. to Ship", TransShptLine.Quantity);
                            WhsePostShpt.CreatePostedShptLine(
                              WhseShptLine, PostedWhseShptHeader, PostedWhseShptLine, TempWhseSplitSpecification);
                        end;
                        if WhsePosting then
                            PostWhseJnlLine(ItemJnlLine, OriginalQuantity, OriginalQuantityBase);
                    end;
                    TransShptLine.Insert;
                until TransLine.Next = 0;

            InvtSetup.Get;
            if InvtSetup."Automatic Cost Adjustment" <> InvtSetup."automatic cost adjustment"::Never then begin
                InvtAdjmt.SetProperties(true, InvtSetup."Automatic Cost Posting");
                InvtAdjmt.MakeMultiLevelAdjmt;
            end;

            if WhseShip then
                WhseShptLine.LockTable;
            TransLine.LockTable;
            TransLine.SetFilter(Quantity, '<>0');
            TransLine.SetFilter("Qty. to Ship", '<>0');
            if TransLine.Find('-') then begin
                NextLineNo := AssignLineNo(TransLine."Document No.");
                repeat
                    TransLine2.Init;
                    TransLine2 := TransLine;
                    TransLine2."Transfer-from Code" := TransLine."In-Transit Code";
                    TransLine2."In-Transit Code" := '';
                    TransLine2."Derived From Line No." := TransLine."Line No.";
                    TransLine2."Line No." := NextLineNo;
                    NextLineNo := NextLineNo + 10000;
                    TransLine2.Quantity := TransLine."Qty. to Ship";
                    TransLine2."Quantity (Base)" := TransLine."Qty. to Ship (Base)";
                    TransLine2."Qty. to Ship" := TransLine2.Quantity;
                    TransLine2."Qty. to Ship (Base)" := TransLine2."Quantity (Base)";
                    TransLine2."Qty. to Receive" := TransLine2.Quantity;
                    TransLine2."Qty. to Receive (Base)" := TransLine2."Quantity (Base)";
                    TransLine2."Quantity Shipped" := 0;
                    TransLine2."Qty. Shipped (Base)" := 0;
                    TransLine2."Quantity Received" := 0;
                    TransLine2."Qty. Received (Base)" := 0;
                    TransLine2."Qty. in Transit" := 0;
                    TransLine2."Qty. in Transit (Base)" := 0;
                    TransLine2."Outstanding Quantity" := TransLine2.Quantity;
                    TransLine2."Outstanding Qty. (Base)" := TransLine2."Quantity (Base)";
                    TransLine2.Insert;

                    TransferTracking(TransLine, TransLine2, TransLine."Qty. to Ship (Base)");

                    TransLine.Validate("Quantity Shipped", TransLine."Quantity Shipped" + TransLine."Qty. to Ship");

                    TransLine.UpdateWithWarehouseShipReceive;

                    TransLine.Modify;
                until TransLine.Next = 0;
            end;

            if WhseShip then
                WhseShptLine.LockTable;
            LockTable;
            if WhseShip then begin
                WhsePostShpt.PostUpdateWhseDocuments(WhseShptHeader);
                TempWhseShptHeader.Delete;
            end;

            "Last Shipment No." := TransShptHeader."No.";
            Modify;

            TransLine.SetRange(Quantity);
            TransLine.SetRange("Qty. to Ship");
            //  HeaderDeleted := DeleteOneTransferOrder(TransHeader,TransLine);
            if not HeaderDeleted then begin
                WhseTransferRelease.Release(TransHeader);
                ReserveTransLine.UpdateItemTrackingAfterPosting(TransHeader, 0);
                // CreateReservEntry.UpdReservEntryAfterPostingPick(TransHeader);
            end;

            if not InvtPickPutaway then
                Commit;
            Clear(WhsePostShpt);
            Clear(InvtAdjmt);
            Window.Close;
        end;
        UpdateAnalysisView.UpdateAll(0, true);
        UpdateItemAnalysisView.UpdateAll(0, true);
        //Rec := TransHeader;
    end;

    procedure ReceiveTransferOrderPortal(DocNo: Text)
    var
        Item: Record Item;
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        NextLineNo: Integer;
        SourceCodeSetup: Record "Source Code Setup";
        InvtSetup: Record "Inventory Setup";
        ValueEntry: Record "Value Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemApplnEntry: Record "Item Application Entry";
        ItemReg: Record "Item Register";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UpdateAnalysisView: Codeunit "Update Analysis View";
        UpdateItemAnalysisView: Codeunit "Update Item Analysis View";
        ReservMgt: Codeunit "Reservation Management";
        RecordLinkManagement: Codeunit "Record Link Management";
        Window: Dialog;
        LineCount: Integer;
    begin

        TransHeader.Get(DocNo);
        if TransHeader.Status = TransHeader.Status::Open then begin
            Codeunit.Run(Codeunit::"Release Transfer Document", TransHeader);
            TransHeader.Status := TransHeader.Status::Open;
            TransHeader.Modify;
            Commit;
            TransHeader.Status := TransHeader.Status::Released;
        end;
        //TransHeader := Rec;
        TransHeader.SetHideValidationDialog(HideValidationDialog);

        with TransHeader do begin
            CheckBeforePost;

            WhseReference := "Posting from Whse. Ref.";
            "Posting from Whse. Ref." := 0;

            CheckDim;

            TransLine.Reset;
            TransLine.SetRange("Document No.", "No.");
            TransLine.SetRange("Derived From Line No.", 0);
            TransLine.SetFilter(Quantity, '<>0');
            TransLine.SetFilter("Qty. to Receive", '<>0');
            if not TransLine.Find('-') then
                Error(Text001);

            WhseReceive := TempWhseRcptHeader.FindFirst;
            InvtPickPutaway := WhseReference <> 0;
            if not (WhseReceive or InvtPickPutaway) then
                CheckWarehouse(TransLine);

            GetLocation("Transfer-to Code");
            if Location."Bin Mandatory" and not (WhseReceive or InvtPickPutaway) then
                WhsePosting := true;

            Window.Open(
              '#1#################################\\' +
              Text003);

            Window.Update(1, StrSubstNo(Text004, "No."));

            SourceCodeSetup.Get;
            SourceCode := SourceCodeSetup.Transfer;
            InvtSetup.Get;
            InvtSetup.TestField("Posted Transfer Rcpt. Nos.");

            CheckInvtPostingSetup;

            LockTables(InvtSetup."Automatic Cost Posting");

            // Insert receipt header
            if WhseReceive then
                PostedWhseRcptHeader.LockTable;
            TransRcptHeader2.LockTable;
            TransRcptHeader2.Init;
            TransRcptHeader2.CopyFromTransferHeader(TransHeader);
            TransRcptHeader2."No. Series" := InvtSetup."Posted Transfer Rcpt. Nos.";
            TransRcptHeader2."No." :=
              NoSeriesMgt.GetNextNo(
                InvtSetup."Posted Transfer Rcpt. Nos.", "Posting Date", true);
            TransRcptHeader2.Insert;

            if InvtSetup."Copy Comments Order to Rcpt." then begin
                CopyCommentLines(1, 3, "No.", TransRcptHeader2."No.");
                TransHeader.Get(DocNo);
                RecordLinkManagement.CopyLinks(TransHeader, TransRcptHeader2);
            end;

            if WhseReceive then begin
                WhseRcptHeader.Get(TempWhseRcptHeader."No.");
                WhsePostRcpt.CreatePostedRcptHeader(PostedWhseRcptHeader, WhseRcptHeader, TransRcptHeader2."No.", "Posting Date");
            end;

            // Insert receipt lines
            LineCount := 0;
            if WhseReceive then
                PostedWhseRcptLine.LockTable;
            if InvtPickPutaway then
                WhseRqst.LockTable;
            TransRcptLine2.LockTable;
            TransLine.SetRange(Quantity);
            TransLine.SetRange("Qty. to Receive");
            if TransLine.Find('-') then
                repeat
                    LineCount := LineCount + 1;
                    Window.Update(2, LineCount);

                    if TransLine."Item No." <> '' then begin
                        Item.Get(TransLine."Item No.");
                        Item.TestField(Blocked, false);
                    end;

                    TransRcptLine2.Init;
                    TransRcptLine2."Document No." := TransRcptHeader2."No.";
                    TransRcptLine2.CopyFromTransferLine(TransLine);
                    TransRcptLine2.Insert;

                    if TransLine."Qty. to Receive" > 0 then begin
                        OriginalQuantity := TransLine."Qty. to Receive";
                        OriginalQuantityBase := TransLine."Qty. to Receive (Base)";
                        PostItemJnlLine(TransLine, TransRcptHeader2, TransRcptLine2);
                        TransRcptLine."Item Rcpt. Entry No." := InsertRcptEntryRelation(TransRcptLine);
                        TransRcptLine.Modify;
                        SaveTempWhseSplitSpec(TransLine);
                        if WhseReceive then begin
                            WhseRcptLine.SetCurrentkey(
                              "No.", "Source Type", "Source Subtype", "Source No.", "Source Line No.");
                            WhseRcptLine.SetRange("No.", WhseRcptHeader."No.");
                            WhseRcptLine.SetRange("Source Type", Database::"Transfer Line");
                            WhseRcptLine.SetRange("Source No.", TransLine."Document No.");
                            WhseRcptLine.SetRange("Source Line No.", TransLine."Line No.");
                            WhseRcptLine.FindFirst;
                            WhseRcptLine.TestField("Qty. to Receive", TransRcptLine2.Quantity);
                            WhsePostRcpt.SetItemEntryRelation(PostedWhseRcptHeader, PostedWhseRcptLine, TempItemEntryRelation2);
                            WhsePostRcpt.CreatePostedRcptLine(
                              WhseRcptLine, PostedWhseRcptHeader, PostedWhseRcptLine, TempWhseSplitSpecification);
                        end;
                        if WhsePosting then
                            PostWhseJnlLine2(ItemJnlLine, OriginalQuantity, OriginalQuantityBase, TempWhseSplitSpecification);
                    end;
                until TransLine.Next = 0;

            if InvtSetup."Automatic Cost Adjustment" <> InvtSetup."automatic cost adjustment"::Never then begin
                InvtAdjmt.SetProperties(true, InvtSetup."Automatic Cost Posting");
                InvtAdjmt.MakeMultiLevelAdjmt;
            end;

            ValueEntry.LockTable;
            ItemLedgEntry.LockTable;
            ItemApplnEntry.LockTable;
            ItemReg.LockTable;
            TransLine.LockTable;
            if WhsePosting then
                WhseEntry.LockTable;

            TransLine.SetFilter(Quantity, '<>0');
            TransLine.SetFilter("Qty. to Receive", '<>0');
            if TransLine.Find('-') then
                repeat
                    TransLine.Validate("Quantity Received", TransLine."Quantity Received" + TransLine."Qty. to Receive");
                    TransLine.UpdateWithWarehouseShipReceive;
                    // ReservMgt.SetItemJnlLine(ItemJnlLine);
                    ReservMgt.SetItemTrackingHandling(1); // Allow deletion
                    ReservMgt.DeleteReservEntries(true, 0);
                    TransLine.Modify;
                until TransLine.Next = 0;

            if WhseReceive then
                WhseRcptLine.LockTable;
            LockTable;
            if WhseReceive then begin
                WhsePostRcpt.PostUpdateWhseDocuments(WhseRcptHeader);
                TempWhseRcptHeader.Delete;
            end;

            "Last Receipt No." := TransRcptHeader2."No.";
            Modify;

            TransLine.SetRange(Quantity);
            TransLine.SetRange("Qty. to Receive");
            //HeaderDeleted := DeleteOneTransferOrder(TransHeader,TransLine);
            if not HeaderDeleted then begin
                WhseTransferRelease.Release(TransHeader);
                ReserveTransLine.UpdateItemTrackingAfterPosting(TransHeader, 1);
            end;

            if not InvtPickPutaway then
                Commit;
            Clear(WhsePostRcpt);
            Clear(InvtAdjmt);
            Window.Close;
        end;
        UpdateAnalysisView.UpdateAll(0, true);
        UpdateItemAnalysisView.UpdateAll(0, true);
        //Rec := TransHeader;
    end;

    local procedure PostItemJnlLine(var TransLine3: Record "Transfer Line"; TransShptHeader2: Record "Transfer Shipment Header"; TransShptLine2: Record "Transfer Shipment Line")
    begin
        ItemJnlLine.Init;
        ItemJnlLine."Posting Date" := TransShptHeader2."Posting Date";
        ItemJnlLine."Document Date" := TransShptHeader2."Posting Date";
        ItemJnlLine."Document No." := TransShptHeader2."No.";
        ItemJnlLine."Document Type" := ItemJnlLine."document type"::"Transfer Shipment";
        ItemJnlLine."Document Line No." := TransShptLine2."Line No.";
        ItemJnlLine."Order Type" := ItemJnlLine."order type"::Transfer;
        ItemJnlLine."Order No." := TransShptHeader2."Transfer Order No.";
        ItemJnlLine."Order Line No." := TransLine3."Line No.";
        ItemJnlLine."External Document No." := TransShptHeader2."External Document No.";
        ItemJnlLine."Entry Type" := ItemJnlLine."entry type"::Transfer;
        ItemJnlLine."Item No." := TransShptLine2."Item No.";
        ItemJnlLine.Description := TransShptLine2.Description;
        ItemJnlLine."Shortcut Dimension 1 Code" := TransShptLine2."Shortcut Dimension 1 Code";
        ItemJnlLine."New Shortcut Dimension 1 Code" := TransShptLine2."Shortcut Dimension 1 Code";
        ItemJnlLine."Shortcut Dimension 2 Code" := TransShptLine2."Shortcut Dimension 2 Code";
        ItemJnlLine."New Shortcut Dimension 2 Code" := TransShptLine2."Shortcut Dimension 2 Code";
        ItemJnlLine."Dimension Set ID" := TransShptLine2."Dimension Set ID";
        ItemJnlLine."New Dimension Set ID" := TransShptLine2."Dimension Set ID";
        ItemJnlLine."Location Code" := TransShptHeader2."Transfer-from Code";
        ItemJnlLine."New Location Code" := TransHeader."In-Transit Code";
        ItemJnlLine.Quantity := TransShptLine2.Quantity;
        ItemJnlLine."Invoiced Quantity" := TransShptLine2.Quantity;
        ItemJnlLine."Quantity (Base)" := TransShptLine2."Quantity (Base)";
        ItemJnlLine."Invoiced Qty. (Base)" := TransShptLine2."Quantity (Base)";
        ItemJnlLine."Source Code" := SourceCode;
        ItemJnlLine."Gen. Prod. Posting Group" := TransShptLine2."Gen. Prod. Posting Group";
        ItemJnlLine."Inventory Posting Group" := TransShptLine2."Inventory Posting Group";
        ItemJnlLine."Unit of Measure Code" := TransShptLine2."Unit of Measure Code";
        ItemJnlLine."Qty. per Unit of Measure" := TransShptLine2."Qty. per Unit of Measure";
        ItemJnlLine."Variant Code" := TransShptLine2."Variant Code";
        ItemJnlLine."Bin Code" := TransLine."Transfer-from Bin Code";
        ItemJnlLine."Country/Region Code" := TransShptHeader2."Trsf.-from Country/Region Code";
        ItemJnlLine."Transaction Type" := TransShptHeader2."Transaction Type";
        ItemJnlLine."Transport Method" := TransShptHeader2."Transport Method";
        ItemJnlLine."Entry/Exit Point" := TransShptHeader2."Entry/Exit Point";
        ItemJnlLine.Area := TransShptHeader2.Area;
        ItemJnlLine."Transaction Specification" := TransShptHeader2."Transaction Specification";
        // ItemJnlLine."Product Group Code" := TransLine."Product Group Code";
        ItemJnlLine."Item Category Code" := TransLine."Item Category Code";
        ItemJnlLine."Applies-to Entry" := TransLine."Appl.-to Item Entry";

        ReserveTransLine.TransferTransferToItemJnlLine(TransLine3,
          ItemJnlLine, ItemJnlLine."Quantity (Base)", 0);

        ItemJnlPostLine.RunWithCheck(ItemJnlLine);
    end;

    local procedure CopyCommentLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        InvtCommentLine: Record "Inventory Comment Line";
        InvtCommentLine2: Record "Inventory Comment Line";
    begin
        InvtCommentLine.SetRange("Document Type", FromDocumentType);
        InvtCommentLine.SetRange("No.", FromNumber);
        if InvtCommentLine.Find('-') then
            repeat
                InvtCommentLine2 := InvtCommentLine;
                InvtCommentLine2."Document Type" := ToDocumentType;
                InvtCommentLine2."No." := ToNumber;
                InvtCommentLine2.Insert;
            until InvtCommentLine.Next = 0;
    end;

    local procedure CheckDim()
    begin
        TransLine."Line No." := 0;
        CheckDimComb(TransHeader, TransLine);
        CheckDimValuePosting(TransHeader, TransLine);

        TransLine.SetRange("Document No.", TransHeader."No.");
        if TransLine.FindFirst then begin
            CheckDimComb(TransHeader, TransLine);
            CheckDimValuePosting(TransHeader, TransLine);
        end;
    end;

    local procedure CheckDimComb(TransferHeader: Record "Transfer Header"; TransferLine: Record "Transfer Line")
    begin
        if TransferLine."Line No." = 0 then
            if not DimMgt.CheckDimIDComb(TransferHeader."Dimension Set ID") then
                Error(
                  Text005,
                  TransHeader."No.", DimMgt.GetDimCombErr);
        if TransferLine."Line No." <> 0 then
            if not DimMgt.CheckDimIDComb(TransferLine."Dimension Set ID") then
                Error(
                  Text006,
                  TransHeader."No.", TransferLine."Line No.", DimMgt.GetDimCombErr);
    end;

    local procedure CheckDimValuePosting(TransferHeader: Record "Transfer Header"; TransferLine: Record "Transfer Line")
    var
        TableIDArr: array[10] of Integer;
        NumberArr: array[10] of Code[20];
    begin
        TableIDArr[1] := Database::Item;
        NumberArr[1] := TransferLine."Item No.";
        if TransferLine."Line No." = 0 then
            if not DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, TransferHeader."Dimension Set ID") then
                Error(Text007, TransHeader."No.", TransferLine."Line No.", DimMgt.GetDimValuePostingErr);

        if TransferLine."Line No." <> 0 then
            if not DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, TransferLine."Dimension Set ID") then
                Error(Text007, TransHeader."No.", TransferLine."Line No.", DimMgt.GetDimValuePostingErr);
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    local procedure AssignLineNo(FromDocNo: Code[20]): Integer
    var
        TransLine3: Record "Transfer Line";
    begin
        TransLine3.SetRange("Document No.", FromDocNo);
        if TransLine3.FindLast then
            exit(TransLine3."Line No." + 10000);
    end;

    local procedure InsertShptEntryRelation(var TransShptLine: Record "Transfer Shipment Line"): Integer
    var
        TempHandlingSpecification2: Record "Tracking Specification" temporary;
        ItemEntryRelation: Record "Item Entry Relation";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        WhseSNRequired: Boolean;
        WhseLNRequired: Boolean;
    begin
        if WhsePosting then begin
            TempWhseSplitSpecification.Reset;
            TempWhseSplitSpecification.DeleteAll;
        end;

        TempHandlingSpecification2.Reset;
        if ItemJnlPostLine.CollectTrackingSpecification(TempHandlingSpecification2) then begin
            TempHandlingSpecification2.SetRange("Buffer Status", 0);
            if TempHandlingSpecification2.Find('-') then begin
                repeat
                    if WhsePosting or WhseShip or InvtPickPutaway then begin
                        // ItemTrackingMgt.CheckWhseItemTrkgSetup(
                        //   TransShptLine."Item No.", WhseSNRequired, WhseLNRequired, false);
                        if WhseSNRequired or WhseLNRequired then begin
                            TempWhseSplitSpecification := TempHandlingSpecification2;
                            TempWhseSplitSpecification."Source Type" := Database::"Transfer Line";
                            TempWhseSplitSpecification."Source ID" := TransLine."Document No.";
                            TempWhseSplitSpecification."Source Ref. No." := TransLine."Line No.";
                            TempWhseSplitSpecification.Insert;
                        end;
                    end;

                    ItemEntryRelation.Init;
                    ItemEntryRelation."Item Entry No." := TempHandlingSpecification2."Entry No.";
                    ItemEntryRelation."Serial No." := TempHandlingSpecification2."Serial No.";
                    ItemEntryRelation."Lot No." := TempHandlingSpecification2."Lot No.";
                    ItemEntryRelation.TransferFieldsTransShptLine(TransShptLine);
                    ItemEntryRelation.Insert;
                    TempHandlingSpecification := TempHandlingSpecification2;
                    TempHandlingSpecification."Source Prod. Order Line" := TransShptLine."Line No.";
                    TempHandlingSpecification."Buffer Status" := TempHandlingSpecification."buffer status"::Modify;
                    TempHandlingSpecification.Insert;
                until TempHandlingSpecification2.Next = 0;
                exit(0);
            end;
        end else
            exit(ItemJnlLine."Item Shpt. Entry No.");
    end;

    local procedure TransferTracking(var FromTransLine: Record "Transfer Line"; var ToTransLine: Record "Transfer Line"; TransferQty: Decimal)
    var
        DummySpecification: Record "Tracking Specification";
    begin
        TempHandlingSpecification.Reset;
        TempHandlingSpecification.SetRange("Source Prod. Order Line", ToTransLine."Derived From Line No.");
        if TempHandlingSpecification.Find('-') then begin
            repeat
                ReserveTransLine.TransferTransferToTransfer(
                  FromTransLine, ToTransLine, -TempHandlingSpecification."Quantity (Base)", 1, TempHandlingSpecification);
                TransferQty += TempHandlingSpecification."Quantity (Base)";
            until TempHandlingSpecification.Next = 0;
            TempHandlingSpecification.DeleteAll;
        end;

        if TransferQty > 0 then
            ReserveTransLine.TransferTransferToTransfer(
              FromTransLine, ToTransLine, TransferQty, 1, DummySpecification);
    end;

    local procedure CheckWarehouse(TransLine: Record "Transfer Line")
    var
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        ShowError: Boolean;
    begin
        GetLocation(TransLine."Transfer-from Code");
        if Location."Require Pick" or Location."Require Shipment" then begin
            if Location."Bin Mandatory" then
                ShowError := true
            else
                if WhseValidateSourceLine.WhseLinesExist(
                     Database::"Transfer Line",
                     0,// Out
                     TransLine."Document No.",
                     TransLine."Line No.",
                     0,
                     TransLine.Quantity)
                then
                    ShowError := true;

            if ShowError then
                Error(
                  Text002,
                  TransLine."Document No.",
                  TransLine.FieldCaption("Line No."),
                  TransLine."Line No.");
        end;
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.GetLocationSetup(LocationCode, Location)
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;

    local procedure PostWhseJnlLine(ItemJnlLine: Record "Item Journal Line"; OriginalQuantity: Decimal; OriginalQuantityBase: Decimal)
    var
        WhseJnlLine: Record "Warehouse Journal Line";
        TempWhseJnlLine2: Record "Warehouse Journal Line" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        WMSMgmt: Codeunit "WMS Management";
    begin
        with ItemJnlLine do begin
            Quantity := OriginalQuantity;
            "Quantity (Base)" := OriginalQuantityBase;
            GetLocation("Location Code");
            if Location."Bin Mandatory" then
                if WMSMgmt.CreateWhseJnlLine(ItemJnlLine, 1, WhseJnlLine, false) then begin
                    WMSMgmt.SetTransferLine(TransLine, WhseJnlLine, 0, TransShptHeader."No.");
                    ItemTrackingMgt.SplitWhseJnlLine(
                      WhseJnlLine, TempWhseJnlLine2, TempWhseSplitSpecification, true);
                    if TempWhseJnlLine2.Find('-') then
                        repeat
                            WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2, 1, 0, true);
                            Codeunit.Run(Codeunit::"Whse. Jnl.-Register Line", TempWhseJnlLine2);
                        until TempWhseJnlLine2.Next = 0;
                end;
        end;
    end;

    procedure SetWhseShptHeader(var WhseShptHeader2: Record "Warehouse Shipment Header")
    begin
        WhseShptHeader := WhseShptHeader2;
        TempWhseShptHeader := WhseShptHeader;
        TempWhseShptHeader.Insert;
    end;

    local procedure GetShippingAdvice(): Boolean
    var
        TransLine: Record "Transfer Line";
    begin
        TransLine.SetRange("Document No.", TransHeader."No.");
        if TransLine.Find('-') then
            repeat
                if TransLine."Quantity (Base)" <>
                   TransLine."Qty. to Ship (Base)" + TransLine."Qty. Shipped (Base)"
                then
                    exit(false);
            until TransLine.Next = 0;
        exit(true);
    end;

    local procedure CheckItemInInventory(TransLine: Record "Transfer Line")
    var
        Item: Record Item;
    begin
        with Item do begin
            Get(TransLine."Item No.");
            SetFilter("Variant Filter", TransLine."Variant Code");
            SetFilter("Location Filter", TransLine."Transfer-from Code");
            CalcFields(Inventory);
            if Inventory <= 0 then
                Error(Text009, TransLine."Item No.");
        end;
    end;

    local procedure CheckItemInInventoryAndWarehouse(var TransLine: Record "Transfer Line"; NeedCheckWarehouse: Boolean)
    var
        TransLine2: Record "Transfer Line";
    begin
        TransLine2.CopyFilters(TransLine);
        TransLine2.FindSet;
        repeat
            CheckItemInInventory(TransLine2);
            if NeedCheckWarehouse then
                CheckWarehouse(TransLine2);
        until TransLine2.Next = 0;
    end;

    local procedure LockTables(AutoCostPosting: Boolean)
    var
        GLEntry: Record "G/L Entry";
        NoSeriesLine: Record "No. Series Line";
    begin
        NoSeriesLine.LockTable;
        if NoSeriesLine.FindLast then;
        if AutoCostPosting then begin
            GLEntry.LockTable;
            if GLEntry.FindLast then;
        end;
    end;

    local procedure InsertRcptEntryRelation(var TransRcptLine: Record "Transfer Receipt Line"): Integer
    var
        ItemEntryRelation: Record "Item Entry Relation";
        TempItemEntryRelation: Record "Item Entry Relation" temporary;
    begin
        TempItemEntryRelation2.Reset;
        TempItemEntryRelation2.DeleteAll;

        if ItemJnlPostLine.CollectItemEntryRelation(TempItemEntryRelation) then begin
            if TempItemEntryRelation.Find('-') then begin
                repeat
                    ItemEntryRelation := TempItemEntryRelation;
                    ItemEntryRelation.TransferFieldsTransRcptLine(TransRcptLine);
                    ItemEntryRelation.Insert;
                    TempItemEntryRelation2 := TempItemEntryRelation;
                    TempItemEntryRelation2.Insert;
                until TempItemEntryRelation.Next = 0;
                exit(0);
            end;
        end else
            exit(ItemJnlLine."Item Shpt. Entry No.");
    end;

    local procedure SaveTempWhseSplitSpec(TransLine: Record "Transfer Line")
    var
        TempHandlingSpecification: Record "Tracking Specification" temporary;
    begin
        TempWhseSplitSpecification.Reset;
        TempWhseSplitSpecification.DeleteAll;
        if ItemJnlPostLine.CollectTrackingSpecification(TempHandlingSpecification) then
            if TempHandlingSpecification.Find('-') then
                repeat
                    TempWhseSplitSpecification := TempHandlingSpecification;
                    TempWhseSplitSpecification."Entry No." := TempHandlingSpecification."Transfer Item Entry No.";
                    TempWhseSplitSpecification."Source Type" := Database::"Transfer Line";
                    TempWhseSplitSpecification."Source Subtype" := 1;
                    TempWhseSplitSpecification."Source ID" := TransLine."Document No.";
                    TempWhseSplitSpecification."Source Ref. No." := TransLine."Line No.";
                    TempWhseSplitSpecification.Insert;
                until TempHandlingSpecification.Next = 0;
    end;

    procedure SetWhseRcptHeader(var WhseRcptHeader2: Record "Warehouse Receipt Header")
    begin
        WhseRcptHeader := WhseRcptHeader2;
        TempWhseRcptHeader := WhseRcptHeader;
        TempWhseRcptHeader.Insert;
    end;

    local procedure PostWhseJnlLine2(ItemJnlLine: Record "Item Journal Line"; OriginalQuantity: Decimal; OriginalQuantityBase: Decimal; var TempHandlingSpecification: Record "Tracking Specification" temporary)
    var
        WhseJnlLine: Record "Warehouse Journal Line";
        TempWhseJnlLine2: Record "Warehouse Journal Line" temporary;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        WMSMgmt: Codeunit "WMS Management";
    begin
        with ItemJnlLine do begin
            Quantity := OriginalQuantity;
            "Quantity (Base)" := OriginalQuantityBase;
            GetLocation("New Location Code");
            if Location."Bin Mandatory" then
                if WMSMgmt.CreateWhseJnlLine(ItemJnlLine, 1, WhseJnlLine, true) then begin
                    WMSMgmt.SetTransferLine(TransLine, WhseJnlLine, 1, TransRcptHeader."No.");
                    ItemTrackingMgt.SplitWhseJnlLine(WhseJnlLine, TempWhseJnlLine2, TempHandlingSpecification, true);
                    if TempWhseJnlLine2.Find('-') then
                        repeat
                            WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2, 1, 0, true);
                            Codeunit.Run(Codeunit::"Whse. Jnl.-Register Line", TempWhseJnlLine2);
                        until TempWhseJnlLine2.Next = 0;
                end;
        end;
    end;

    procedure MarkTheaterComplete(TreatmentNo: Text; TheatreNo: Text; ProcessName: Text)
    begin
        /*THeader2.SETRANGE("Link No.",TreatmentNo);
        THeader2.SETRANGE("No.",TheatreNo);
        IF THeader2.FIND('-') THEN
          THeader2.Status :=THeader2.Status::Closed;
          THeader2.Completed :=TRUE;
          THeader2.Closed :=TRUE;
          THeader2.MODIFY;
        
        THeader.SETRANGE("Treatment No.",TreatmentNo);
        THeader.SETRANGE("Process Name",ProcessName);
        IF THeader.FIND('-') THEN
          THeader.Status :=THeader.Status::Completed;
          THeader.MODIFY;*/

    end;

    procedure InsertPhysioSetUp(TreatmentNo: Text; ProcessNo: Text; Remarks: Text; Diagnosis: Text; Treatment: Text; Frequency: Decimal; Duration: Text)
    begin
        /*ObjPhysioTreat.INIT;
        ObjPhysioTreat."No." :=TreatmentNo;
        ObjPhysioTreat."Process No." :=ProcessNo;
        PhysioTypes.GET(ProcessNo);
        ObjPhysioTreat."Process Name" := PhysioTypes.Description;
        ObjPhysioTreat."Process Mandatory" :=TRUE;
        ObjPhysioTreat."Process Remarks" :=Remarks;
        ObjPhysioTreat.Diagnosis :=Diagnosis;
        ObjPhysioTreat.Treatment :=Treatment;
        ObjPhysioTreat."Frequency Per week" := Frequency;
        ObjPhysioTreat.Duration :=Duration;
        ObjPhysioTreat.INSERT;*/

    end;

    procedure SendToPhysio(TreatmentNo: Text)
    begin
        /*NewNo:=NoSeriesMgt.GetNextNo('HOSP-PHYSI',0D,TRUE);
        ObjPhysioTreat.SETRANGE("No." ,TreatmentNo);
        IF ObjPhysioTreat.FIND('-') THEN BEGIN
          docHeader.GET(TreatmentNo);
        PhysioHeader.INIT;
        PhysioHeader."No." :=NewNo;
        PhysioHeader.Type := PhysioHeader.Type::Visit;
        PhysioHeader."Physio Date" :=TODAY;
        PhysioHeader."Physio Time" := TIME;
        PhysioHeader."Physio User ID" :=docHeader."Doctor ID";
        PhysioHeader."Physio Remarks" :=ObjPhysioTreat."Process Remarks";
        PhysioHeader."Patient No." :=docHeader."Patient No.";
        PhysioHeader."Link Type" :='Doctor';
        PhysioHeader."Link No." :=TreatmentNo;
        PhysioHeader.Status:= PhysioHeader.Status::New;
        PhysioHeader.Duration :=ObjPhysioTreat.Duration;
        PhysioHeader."Frequency Per Week":=ObjPhysioTreat."Frequency Per week";
        PhysioHeader."Surname Name" :=docHeader.Surname;
        PhysioHeader."Last Name":=docHeader."Last Name";
        PhysioHeader."ADM No" :=docHeader."Adm No.";
        PhysioHeader.INSERT;
         END ELSE BEGIN
           docHeader.GET(TreatmentNo);
           PhysioHeader.INIT;
        PhysioHeader."No." :=NewNo;
        PhysioHeader.Type := PhysioHeader.Type::Visit;
        PhysioHeader."Physio Date" :=TODAY;
        PhysioHeader."Physio Time" := TIME;
        PhysioHeader."Physio User ID" :=docHeader."Doctor ID";
        //PhysioHeader."Physio Remarks" :=ObjPhysioTreat."Process Remarks";
        PhysioHeader."Patient No." :=docHeader."Patient No.";
        PhysioHeader."Link Type" :='Doctor';
        PhysioHeader."Link No." :=TreatmentNo;
        PhysioHeader.Status:= PhysioHeader.Status::New;
        //PhysioHeader.Duration :=ObjPhysioTreat.Duration;
        //PhysioHeader."Frequency Per Week":=ObjPhysioTreat."Frequency Per week";
        PhysioHeader."Surname Name" :=docHeader.Surname;
        PhysioHeader."Last Name":=docHeader."Last Name";
        PhysioHeader."ADM No" :=docHeader."Adm No.";
        PhysioHeader.INSERT;
        END;*/

    end;

    procedure InsertInpatientVitals(TreatmentNo: Text; ProcessNo: Text; ProcessRemarks: Text; ProcessResult: Text)

    begin
        /*
       TreatmentLine.Init;
       TreatmentLine."Treatment No." := TreatmentNo;
       TreatmentLine.Type := TreatmentLine.Type::"Admission Requests";
       TreatmentLine."No." := ProcessNo;
       TreatmentLine.Mandatory := true;
       TreatmentLine.Remarks := ProcessRemarks;
       TreatmentLine.Results := ProcessResult;
       TreatmentLine.Performed := true;
       TreatmentLine."Date Created" := CurrentDatetime;
       TreatmentLine.Insert;
   */
    end;

    procedure GenerateLabResults(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        LabHeader.Reset;
        LabHeader.SetRange("Link No.", TreatmentNo);
        if LabHeader.Find('-') then begin

            LabResults.Reset;
            LabResults.SetRange(LabResults."Laboratory No.", LabHeader."Laboratory No.");

            if LabResults.Find('-') then begin
                Report.SaveAsPdf(50047, filename, LabResults);
                // END
                // ELSE BEGIN
                // LabResults.RESET;
                // LabResults.SETRANGE(LabResults."Laboratory No.",TreatmentNo);
                // IF LabResults.FIND('-') THEN BEGIN
                // REPORT.SAVEASPDF(70135148,filename,LabResults);
                //END;
            end;
            exit(filename);
        end;
    end;

    procedure GenerateLabPrintOut(LabNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        LabResults.Reset;
        LabResults.SetRange(LabResults."Laboratory No.", LabNo);
        if LabResults.Find('-') then begin
            Report.SaveAsPdf(50047, filename, LabResults);

        end;
        exit(filename);
    end;

    procedure CheckLabResults(TreatmentNo: Text) Results: Boolean
    begin
        Results := false;
        LabHeader.Reset;
        LabHeader.SetRange("Link No.", TreatmentNo);

        if LabHeader.Find('-') then begin

            LabTestLines.Reset;
            LabTestLines.SetRange("Laboratory No.", LabHeader."Laboratory No.");
            LabTestLines.SetRange(Remarks, '>%1', '');
            if LabTestLines.Find('-') then begin
                Results := true;
            end;
            LabResults.Reset;
            LabResults.SetRange(LabResults."Laboratory No.", LabHeader."Laboratory No.");

            if LabResults.Find('-') then begin
                Results := true;
            end;
        end
        else begin
            LabTestLines.Reset;
            LabTestLines.SetRange("Laboratory No.", TreatmentNo);
            LabTestLines.SetRange(Remarks, '>%1', '');
            if LabTestLines.Find('-') then begin
                Results := true;
            end;
            LabResults.Reset;
            LabResults.SetRange(LabResults."Laboratory No.", TreatmentNo);

            if LabResults.Find('-') then begin
                Results := true;
            end;
        end;
    end;

    procedure InsertInpatientObservation(PatientNo: Text; AdmissionNo: Text; Category: Option; CategoryValue: Text; Timing: Option)
    begin
        /*InpatientObservation.INIT;
        InpatientObservation."Patient No" :=PatientNo;
        InpatientObservation."Admission No" :=AdmissionNo;
        InpatientObservation.Date :=TODAY;
        InpatientObservation.Category :=Category;
        InpatientObservation."Category Value":= CategoryValue;
        InpatientObservation.Timing :=Timing;
        InpatientObservation.INSERT;*/

    end;

    procedure GenerateObservationChart(AdmissionNo: Text; PatientNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        AdmissionHeader.Reset;
        AdmissionHeader.SetRange(AdmissionHeader."Admission No.", AdmissionNo);
        AdmissionHeader.SetRange(AdmissionHeader."Patient No.", PatientNo);


        if AdmissionHeader.Find('-') then begin
            Report.SaveAsPdf(70135142, filename, AdmissionHeader);
        end;
        exit(filename);
    end;

    procedure InsertICUObservation(PatientNo: Text; AdmissionNo: Text; Category: Option; CategoryValue: Text; Timing: Option; ICUObservationCateory: Text)
    begin
        /*InpatientObservation.INIT;
        InpatientObservation."Patient No" :=PatientNo;
        InpatientObservation."Admission No" :=AdmissionNo;
        InpatientObservation.Date :=TODAY;
        InpatientObservation."ICU Category" :=Category;
        InpatientObservation."Category Value":= CategoryValue;
        InpatientObservation."ICU Observation Cateory" :=ICUObservationCateory;
        InpatientObservation."ICU Timings" :=Timing;
        InpatientObservation.ICU:=TRUE;
        InpatientObservation.INSERT;*/

    end;

    procedure GenerateICUChart(AdmissionNo: Text; PatientNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        AdmissionHeader.Reset;
        AdmissionHeader.SetRange(AdmissionHeader."Admission No.", AdmissionNo);
        AdmissionHeader.SetRange(AdmissionHeader."Patient No.", PatientNo);

        if AdmissionHeader.Find('-') then begin
            Report.SaveAsPdf(70135151, filename, AdmissionHeader);
        end;
        exit(filename);
    end;

    procedure GenerateReferralPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(70135010, filename, docHeader);
        end;
        exit(filename);
    end;

    procedure GenerateTransferLetter(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(70135009, filename, docHeader);
        end;
        exit(filename);
    end;

    procedure GeneratePhysioPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(70135117, filename, docHeader);
        end;
        exit(filename);
    end;

    procedure InsertTSheet(TreatmentNo: Text; DrugNo: Text; Remarks: Text; IssuedBy: Text; AdmissionNo: Text)
    begin
        /*ObjPrescription .RESET;
        ObjPrescription.SETRANGE(ObjPrescription."Treatment No." ,TreatmentNo);
        ObjPrescription.SETRANGE(ObjPrescription."Drug No.", DrugNo);
        //ObjPrescription.SETRANGE(DrugPrescribe."Line No",Line_No);
        ObjPrescription.SETRANGE(ObjPrescription.Issued,FALSE);
        IF ObjPrescription.FIND('-') THEN BEGIN
          //REPEAT
          TSheet.INIT;
          TSheet."Admission No." :=AdmissionNo;
          TSheet."Drug No." := ObjPrescription."Drug No.";
          TSheet.Quantity  := ObjPrescription.Quantity  ;
          TSheet."Drug Name"  := ObjPrescription."Drug Name"  ;
          TSheet."Unit Of Measure"  := ObjPrescription."Unit Of Measure"  ;
          TSheet."Pharmacy Code"  := ObjPrescription."Pharmacy Code"  ;
          TSheet.Dosage  := ObjPrescription.Dosage  ;
          TSheet."Issued Date" :=TODAY;
          TSheet."Issued Time" :=TIME;
          TSheet."Issued By" :=IssuedBy;
          TSheet.Issued := TRUE;
          TSheet.Remarks :=Remarks;
          TSheet.INSERT;
         // ObjPrescription.Issued :=TRUE;
          //ObjPrescription.MODIFY;
          //UNTIL DrugPrescribe.NEXT=0;
          END;*/

    end;

    procedure InsertFluidBalanceIntake(PatientNo: Text; AdmissionNo: Text; Timings: Option; IntakeType: Text; IntakeAmount: Decimal; IVIntake: Boolean; Alimentary: Boolean; Infused: Decimal)
    begin
        /*FluidBalance.RESET;
        FluidBalance.SETRANGE(FluidBalance."Patient No",PatientNo);
        FluidBalance.SETRANGE(FluidBalance."Admission No",AdmissionNo);
        FluidBalance.SETRANGE(FluidBalance."Intake Date",TODAY);
        FluidBalance.SETRANGE(FluidBalance.Timings,Timings);
        FluidBalance.SETRANGE(FluidBalance."IV Intake Type",'');
        IF FluidBalance.FIND('-') THEN BEGIN
        FluidBalance."Patient No" :=PatientNo;
        FluidBalance."Admission No" :=AdmissionNo;
        FluidBalance."Fluid Balance" :=FluidBalance."Fluid Balance"::Intake;
        FluidBalance."Intake Date" :=TODAY;
        FluidBalance.Timings :=Timings;
        FluidBalance.VALIDATE(Timings);
        FluidBalance."IV Intake Type" :=IntakeType;
        FluidBalance."IV Intake Amount" :=IntakeAmount;
        FluidBalance."IV Intake":=IVIntake;
        FluidBalance.Alimentary :=Alimentary;
        FluidBalance.Infused :=Infused;
        FluidBalance.MODIFY;
        END ELSE BEGIN
        FluidBalance.INIT;
        FluidBalance."Patient No" :=PatientNo;
        FluidBalance."Admission No" :=AdmissionNo;
        FluidBalance."Fluid Balance" :=FluidBalance."Fluid Balance"::Intake;
        FluidBalance."Intake Date" :=TODAY;
        FluidBalance.Timings :=Timings;
        FluidBalance.VALIDATE(Timings);
        FluidBalance."IV Intake Type" :=IntakeType;
        FluidBalance."IV Intake Amount" :=IntakeAmount;
        FluidBalance."IV Intake":=IVIntake;
        FluidBalance.Alimentary :=Alimentary;
        FluidBalance.Infused :=Infused;
        FluidBalance.INSERT;
        END;*/

    end;

    procedure InsertFluidBalanceAlimentary(PatientNo: Text; AdmissionNo: Text; Timings: Option; IntakeType: Text; IntakeAmount: Decimal; IVIntake: Boolean; Alimentary: Boolean; Infused: Decimal)
    begin
        /*FluidBalance.RESET;
        FluidBalance.SETRANGE(FluidBalance."Patient No",PatientNo);
        FluidBalance.SETRANGE(FluidBalance."Admission No",AdmissionNo);
        FluidBalance.SETRANGE(FluidBalance."Intake Date",TODAY);
        FluidBalance.SETRANGE(FluidBalance.Timings,Timings);
        FluidBalance.SETRANGE(FluidBalance."Alimentary Intake Type",'');
        IF FluidBalance.FIND('-') THEN BEGIN
          FluidBalance."Patient No" :=PatientNo;
          FluidBalance."Admission No" :=AdmissionNo;
          FluidBalance."Fluid Balance" :=FluidBalance."Fluid Balance"::Intake;
          FluidBalance."Intake Date" :=TODAY;
          FluidBalance.Timings :=Timings;
          FluidBalance.VALIDATE(Timings);
          FluidBalance."Alimentary Intake Type":=IntakeType;
          FluidBalance."Alimentary Intake Amount" :=IntakeAmount;
          FluidBalance."IV Intake":=FALSE;
          FluidBalance.Alimentary :=TRUE;
          FluidBalance.Infused :=Infused;
          FluidBalance.MODIFY;
        END
        ELSE
        BEGIN
        FluidBalance.INIT;
        FluidBalance."Patient No" :=PatientNo;
        FluidBalance."Admission No" :=AdmissionNo;
        FluidBalance."Fluid Balance" :=FluidBalance."Fluid Balance"::Intake;
        FluidBalance."Intake Date" :=TODAY;
        FluidBalance.Timings :=Timings;
        FluidBalance.VALIDATE(Timings);
        FluidBalance."Alimentary Intake Type":=IntakeType;
        FluidBalance."Alimentary Intake Amount" :=IntakeAmount;
        FluidBalance."IV Intake":=FALSE;
        FluidBalance.Alimentary :=TRUE;
        FluidBalance.Infused :=Infused;
        FluidBalance.INSERT;
        END;*/

    end;

    procedure InsertFluidBalanceOutput(PatientNo: Text; AdmissionNo: Text; Timings: Option; VomitAmount: Decimal; StoolAmount: Text; NGastAmount: Decimal; UrineAmount: Text; OthersAmount: Decimal; Weight: Decimal)
    begin
        /*FluidBalance.RESET;
        FluidBalance.SETRANGE(FluidBalance."Patient No",PatientNo);
        FluidBalance.SETRANGE(FluidBalance."Admission No",AdmissionNo);
        FluidBalance.SETRANGE(FluidBalance."Intake Date",TODAY);
        FluidBalance.SETRANGE(FluidBalance.Timings,Timings);
        FluidBalance.SETRANGE(FluidBalance."Alimentary Intake Type",'');
        FluidBalance.SETRANGE(FluidBalance.Output,FluidBalance.Output::No);
        IF FluidBalance.FIND('-') THEN BEGIN
          FluidBalance."Patient No" :=PatientNo;
          FluidBalance."Admission No" :=AdmissionNo;
          FluidBalance."Fluid Balance" :=FluidBalance."Fluid Balance"::Output;
          FluidBalance."Intake Date" :=TODAY;
          FluidBalance.Timings :=Timings;
          FluidBalance.VALIDATE(Timings);
          FluidBalance.Output := FluidBalance.Output::Yes;
          IF VomitAmount<>0 THEN FluidBalance."Vomit Amount" :=VomitAmount;
          IF StoolAmount<>'' THEN FluidBalance."Stool Amount":=StoolAmount;
          IF NGastAmount<>0 THEN FluidBalance."N\Gast Amount" :=NGastAmount;
          IF UrineAmount<>'' THEN FluidBalance."Urine Amount" :=UrineAmount;
          IF OthersAmount<>0 THEN FluidBalance."Others Amount" :=OthersAmount;
          IF Weight<>0 THEN FluidBalance.Weight :=Weight;
          FluidBalance.MODIFY;
        END ELSE BEGIN
          FluidBalance.INIT;
          FluidBalance."Patient No" :=PatientNo;
          FluidBalance."Admission No" :=AdmissionNo;
          FluidBalance."Fluid Balance" :=FluidBalance."Fluid Balance"::Output;
          FluidBalance."Intake Date" :=TODAY;
          FluidBalance.Timings :=Timings;
          FluidBalance.VALIDATE(Timings);
          FluidBalance.Output := FluidBalance.Output::Yes;
          FluidBalance."Vomit Amount" :=VomitAmount;
          FluidBalance."Stool Amount":=StoolAmount;
          FluidBalance."N\Gast Amount" :=NGastAmount;
          FluidBalance."Urine Amount" :=UrineAmount;
          FluidBalance."Others Amount" :=OthersAmount;
          FluidBalance.Weight :=Weight;
          FluidBalance.INSERT;
        END;
        */

    end;

    procedure GenerateFluidChart(AdmissionNo: Text; PatientNo: Text; filenameFromApp: Text) filename: Text
    begin
        /*filename :=FILESPATH+filenameFromApp;
         IF EXISTS(filename) THEN
          ERASE(filename);
        
        MESSAGE(filename);
        FluidBalance.RESET;
        FluidBalance.SETRANGE(FluidBalance."Admission No",AdmissionNo);
        FluidBalance.SETRANGE(FluidBalance."Patient No",PatientNo);
        MESSAGE(filename);
        IF FluidBalance.FIND('-') THEN BEGIN
        REPORT.SAVEASPDF(70135030,filename,FluidBalance);
          MESSAGE(filename);
         END;
        EXIT(filename);*/

    end;

    procedure GenerateNurseCardex(AdmissionNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        Message(filename);
        objNurseNote.Reset;
        objNurseNote.SetRange(objNurseNote."Admission No.", AdmissionNo);

        if objNurseNote.Find('-') then begin
            Report.SaveAsPdf(70135520, filename, objNurseNote);
            Message(filename);
        end;
        exit(filename);
    end;

    procedure AdmitPatient(PatientNo: Text; AdmissionNo: Text; Ward: Text; Bed: Text; nhif: Boolean)
    var
        PatientName: Text[100];
        Patient: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        WardRec: Record "HMS Ward Setup";
        BedRec: Record "HMS Beds";
        PatRec: Record "HMS Patient";
    begin
        AdmissionHeader.Reset;
        AdmissionHeader.SetRange(AdmissionHeader."Admission No.", AdmissionNo);
        AdmissionHeader.SetRange(AdmissionHeader."Patient No.", PatientNo);
        if AdmissionHeader.Find('-') then begin

            /*
            //--------Admission--------------
            HMSPatientCharges.INIT;
            //HMSPatientCharges."Line No":=11;
            HMSPatientCharges."Transaction Type":='ADMISSION';
            HMSPatientCharges.VALIDATE("Transaction Type");
            HMSPatientCharges."Patient No.":=PatientNo;
            HMSPatientCharges."Link No":=AdmissionNo;
            HMSPatientCharges."Treatment No.":=AdmissionHeader."Link No.";
            HMSPatientCharges.Code:='ADMISSION FEE';
            HMSPatientCharges.VALIDATE(Code);
            HMSPatientCharges.Description:='ADMISSION FEE';
            //WardRec.GET(Ward);
            HMSPatientCharges.Amount:=1000;
            HMSPatientCharges.VALIDATE(Amount);
            HMSPatientCharges.Date:=TODAY;
            HMSPatientCharges."Bill Section":=HMSPatientCharges."Bill Section"::Admissions;
            HMSPatientCharges."Billing Type":=HMSPatientCharges."Billing Type"::Once;
            HMSPatientCharges."Reccuring Type":=HMSPatientCharges."Reccuring Type"::" ";
            HMSPatientCharges."Billing Start Date":=TODAY;
            IF PatRec.GET(PatientNo) THEN BEGIN
                HMSPatientCharges."Admission No" := PatRec."Adm No.";
                HMSPatientCharges."Visit No" := PatRec."Active Visit No";
                PatRec."Current Adm No":=AdmissionNo;
                PatRec.MODIFY;
            END;
            HMSPatientCharges.INSERT;


            //-------------------------------



            HMSPatientCharges.INIT;
            //HMSPatientCharges."Line No":=11;
            HMSPatientCharges."Transaction Type":='BED CHARGES';
            HMSPatientCharges.VALIDATE("Transaction Type");
            HMSPatientCharges."Patient No.":=PatientNo;
            HMSPatientCharges."Link No":=AdmissionNo;
            HMSPatientCharges."Treatment No.":=AdmissionHeader."Link No.";
            HMSPatientCharges.Code:=Ward;
            HMSPatientCharges.VALIDATE(Code);
            HMSPatientCharges.Description:=Ward+' '+Bed;
            WardRec.GET(Ward);
            HMSPatientCharges.Amount:=WardRec."Room Charges";
            HMSPatientCharges.VALIDATE(Amount);
            HMSPatientCharges.Date:=TODAY;
            HMSPatientCharges."Bill Section":=HMSPatientCharges."Bill Section"::Admissions;
            HMSPatientCharges."Billing Type":=HMSPatientCharges."Billing Type"::Reccuring;
            HMSPatientCharges."Reccuring Type":=HMSPatientCharges."Reccuring Type"::Daily;
            HMSPatientCharges."Billing Start Date":=TODAY;
            IF PatRec.GET(PatientNo) THEN BEGIN
                HMSPatientCharges."Admission No" := PatRec."Adm No.";
                HMSPatientCharges."Visit No" := PatRec."Active Visit No";
                END;
            HMSPatientCharges.INSERT;
            */
            /*
            BedRec.RESET;
            BedRec.SETRANGE(BedRec."Bed No",Bed);
            IF BedRec.FIND('-') THEN  BEGIN
             BedRec.Occupied := TRUE;
             BedRec.MODIFY;
            END;
            Patient.SETRANGE("Patient No.",PatientNo);

            IF Patient.FIND('-') THEN
            Patient.Inpatient:=TRUE;
            Patient."Admissions Date":=TODAY;
            Patient."Adm No.":=AdmissionNo;
            Patient."Current Adm No":=AdmissionNo;
            Patient.MODIFY;
            AdmissionHeader.Ward :=Ward;
            AdmissionHeader.Bed :=Bed;
            AdmissionHeader.Status:=AdmissionHeader.Status::Admitted;
            AdmissionHeader.NHIF :=nhif;
            AdmissionHeader.MODIFY;
            MESSAGE('Patient Admitted');


            IF (AdmissionHeader.NHIF=TRUE) THEN
             AdmissionHeader.Remarks := 'NHIF will pay some bed charges';
             AdmissionHeader.NHIF := TRUE;
             PatientInsurance.SETRANGE("Patient No",PatientNo);
             PatientInsurance.SETRANGE("Insurance No", 'CO-00099');
             IF PatientInsurance.FIND('-') THEN BEGIN

             END  ELSE BEGIN
             PatientInsurance.INIT;
             PatientInsurance."Patient No" :=PatientNo;
             //PatientInsurance."Insurance No" :='CO-00099';
            // PatientInsurance.VALIDATE("Insurance No");
             PatientInsurance.INSERT;
             END;*/
        end else
            nhif := false;

    end;

    procedure ReturnChartValues(AdmissionNo: Text; ICUTimings: Option; ICUCategory: Option) ChartValue: Text
    begin
        /*InpatientObservation.RESET;
        //InpatientObservation.SETRANGE("Patient No",PatientNo);
        InpatientObservation.SETRANGE("Admission No",AdmissionNo);
        InpatientObservation.SETRANGE(Date,TODAY);
        InpatientObservation.SETRANGE(ICU,TRUE);
        InpatientObservation.SETRANGE("ICU Timings",ICUTimings);
        InpatientObservation.SETRANGE("ICU Category",ICUCategory);
        //InpatientObservation.SETCURRENTKEY("ICU Timings");
        IF InpatientObservation.FIND('-') THEN BEGIN
          // REPEAT
        
          ChartValue  := InpatientObservation."Category Value"  +',';
          //UNTIL InpatientObservation.NEXT=0; ChartValue +
          END ELSE BEGIN
          ChartValue :='0,';
          END;*/

    end;

    procedure TransferBed(AdmissionNo: Text; PatientNo: Text; Ward: Text; Bed: Text)
    var
        HMSPatientCharges: Record "HMS Patient Charges";
        WardRec: Record "HMS Ward Setup";
        BedRec: Record "HMS Beds";
        PatRec: Record "HMS Patient";
    begin
        AdmissionHeader.Reset;
        AdmissionHeader.SetRange(AdmissionHeader."Admission No.", AdmissionNo);
        AdmissionHeader.SetRange(AdmissionHeader."Patient No.", PatientNo);
        if AdmissionHeader.Find('-') then begin

            HMSPatientCharges.Reset;
            HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", PatientNo);
            HMSPatientCharges.SetRange(HMSPatientCharges."Transaction Type", 'BED CHARGES');
            HMSPatientCharges.SetRange(HMSPatientCharges.Date, Today);
            if HMSPatientCharges.Find('-') then begin
                HMSPatientCharges.Code := Bed;
                WardRec.Get(Ward);
                HMSPatientCharges.Amount := WardRec."Room Charges";
                HMSPatientCharges.Validate(Amount);
                HMSPatientCharges.Modify;
            end
            else begin
                HMSPatientCharges.Init;
                //HMSPatientCharges."Line No":=11;
                HMSPatientCharges."Transaction Type" := 'BED CHARGES';
                HMSPatientCharges.Validate("Transaction Type");
                HMSPatientCharges."Patient No." := PatientNo;
                ObjPatient.SetRange("Patient No.", PatientNo);
                if ObjPatient.Find('-') then
                    HMSPatientCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                HMSPatientCharges."Link No" := AdmissionNo;
                HMSPatientCharges."Treatment No." := AdmissionHeader."Link No.";
                HMSPatientCharges.Code := Ward;
                HMSPatientCharges.Validate(Code);
                HMSPatientCharges.Description := Ward + ' ' + Bed;
                WardRec.Get(Ward);
                HMSPatientCharges.Amount := WardRec."Room Charges";
                HMSPatientCharges.Validate(Amount);
                HMSPatientCharges.Date := Today;
                HMSPatientCharges."Bill Section" := HMSPatientCharges."bill section"::Admissions;
                HMSPatientCharges."Billing Type" := HMSPatientCharges."billing type"::Reccuring;
                HMSPatientCharges."Reccuring Type" := HMSPatientCharges."reccuring type"::Daily;
                HMSPatientCharges."Billing Start Date" := Today;
                if PatRec.Get(PatientNo) then begin
                    HMSPatientCharges."Admission No" := PatRec."Adm No.";
                    HMSPatientCharges."Visit No" := PatRec."Active Visit No";
                end;
                HMSPatientCharges.Insert;
            end;
            BedRec.Reset;
            BedRec.SetRange(BedRec."Bed No", AdmissionHeader.Bed);
            if BedRec.Find('-') then begin
                BedRec.Occupied := false;
                BedRec.Modify;
            end;

            BedRec.Reset;
            BedRec.SetRange(BedRec."Bed No", Bed);
            if BedRec.Find('-') then begin
                BedRec.Occupied := true;
                BedRec.Modify;
            end;

            AdmissionHeader.Ward := Ward;
            AdmissionHeader.Bed := Bed;
            AdmissionHeader.Status := AdmissionHeader.Status::Admitted;
            AdmissionHeader.Modify;
        end;
    end;

    procedure StopTreatment(TreatmentNo: Text; DrugNo: Text; Remarks: Text)
    begin
        ObjPrescription.Reset;
        ObjPrescription.SetRange(ObjPrescription."Treatment No.", TreatmentNo);
        ObjPrescription.SetRange(ObjPrescription."Drug No.", DrugNo);
        //ObjPrescription.SETRANGE(DrugPrescribe."Line No",Line_No);
        ObjPrescription.SetRange(ObjPrescription.Issued, false);
        if ObjPrescription.Find('-') then begin
            //REPEAT

            ObjPrescription.Issued := true;
            ObjPrescription.Modify;
            //UNTIL DrugPrescribe.NEXT=0;
        end;
    end;

    procedure InsertIPPrescription(TreatmentNo: Text; DrugNo: Text; Remarks: Text; Location: Text; Frequency: Integer; Take: Decimal; Dosage: Text; Route: Integer)
    var
        objItem: Record Item;
    begin
        ObjPrescription.Init;
        ObjPrescription."Treatment No." := TreatmentNo;
        //ObjPrescription."Product Group" :=ProductGroup;
        ObjPrescription."Drug No." := DrugNo;
        ObjPrescription.Validate("Drug No.");
        ObjPrescription.Frequency := Frequency;
        ObjPrescription.Take := Take;
        ObjPrescription.Dosage := Dosage;

        //IF objItem.GET(DrugNo) THEN ObjPrescription.Route := objItem.Route;
        ObjPrescription.Route := Route;
        //ObjPrescription."Number of Days" :=NoofDays;
        ObjPrescription.Validate(Frequency);
        ObjPrescription.Validate(Take);
        //ObjPrescription.VALIDATE("Number of Days");
        ObjPrescription.Remarks := Remarks;
        ObjPrescription."Pharmacy Code" := Location;
        ObjPrescription.Inpatient := true;
        ObjPrescription."IP Status" := ObjPrescription."ip status"::Ongoing;
        ObjPrescription.Insert;
    end;

    procedure InsertPreOpList(Preopcode: Text; PatientNo: Text; AdmissionNo: Text; TreatmentNo: Text; Operation: Text; staffid: Text; Present: Boolean; Value: Text)
    begin
        /*PreOpSetup.GET(Preopcode);
        Patient.SETRANGE("Patient No.",PatientNo);
        IF Patient.FIND('-') THEN
        PreOpList.INIT;
        PreOpList.Code := Preopcode;
        PreOpList.Description :=PreOpSetup.Description;
        PreOpList."Patient No." :=PatientNo;
        PreOpList."Patient Name" :=Patient."Search Name";
        PreOpList."Admission No." :=AdmissionNo;
        PreOpList."Treatment No." :=TreatmentNo;
        PreOpList.Operation := Operation;
        PreOpList."User ID" :=staffid;
        PreOpList.Present :=Present;
        PreOpList.Value :=Value;
        PreOpList.INSERT;*/

    end;

    procedure UpdateTheatre(TheatreNo: Text; Surgeon: Text; Anaesthetist: Text; Assistant: Text; ScrubNurse: Text; CirculatingNurse: Text)
    begin
        /*TheaterForm.RESET;
        TheaterForm.SETRANGE("No.",TheatreNo);
        IF TheaterForm.FIND('-') THEN
          TheaterForm."Doctor ID" := Surgeon;
          TheaterForm."Anaesthetist ID" := Anaesthetist;
          TheaterForm."Theatre Assistant" :=Assistant;
          TheaterForm."Scrub Nurse" :=ScrubNurse;
          TheaterForm."Circulating Nurse ID" :=CirculatingNurse;
          TheaterForm.MODIFY;*/

    end;

    procedure GenerateTsheetPrintout(AdmissionNo: Text; filenameFromApp: Text) filename: Text
    begin
        /*filename :=FILESPATH+filenameFromApp;
         IF EXISTS(filename) THEN
          ERASE(filename);
        
        
        TSheet.RESET;
        TSheet.SETRANGE(TSheet."Admission No.",AdmissionNo);
        
        
        IF TSheet.FIND('-') THEN BEGIN
        REPORT.SAVEASPDF(70135078,filename,TSheet);
         END;
        EXIT(filename);
        */

    end;

    procedure InsertLabResults(LabNo: Text; LabTestCode: Text; SpecimenCode: Text; Results: Decimal; Remarks: Text; Labuser: Text)
    begin
        LabResults.SetRange(LabResults."Laboratory No.", LabNo);
        LabResults.SetRange(LabResults."Laboratory Test Code", LabTestCode);
        LabResults.SetRange(LabResults."Specimen Code", SpecimenCode);
        if LabResults.Find('-') then begin

            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            LabResults."Assigned User ID" := Labuser;
            LabResults."Collection Date" := Today;
            LabResults."Collection Time" := Time;
            LabResults.Results := Results;
            LabResults.Remarks := Remarks;
            LabResults.Validate(Results);
            LabResults.Validate("Laboratory Test Code");
            LabResults.Validate(Remarks);
            LabResults.Modify;
        end else begin
            LabResults.Init;
            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            LabResults."Assigned User ID" := Labuser;
            LabResults."Collection Date" := Today;
            LabResults."Collection Time" := Time;
            LabResults.Results := Results;
            LabResults.Remarks := Remarks;
            LabResults.Validate(Results);
            LabResults.Validate("Laboratory Test Code");
            LabResults.Validate(Remarks);
            LabResults.Insert;
        end;
        LabHeader.SetRange("Laboratory No.", LabNo);
        if LabHeader.Find('-') then
            docHeader.SetRange(docHeader."Treatment No.", LabHeader."Link No.");
        if docHeader.Find('-') then
            objAppointment.SetRange(objAppointment."Appointment No.", docHeader."Link No.");
        if objAppointment.Find('-') then begin
            objAppointment."Lab Time Out" := CurrentDatetime;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment.Modify;
        end;
    end;

    procedure InsertLabRemarks(LabNo: Text; LabTestCode: Text; SpecimenCode: Text; Remarks: Text; Labuser: Text)
    var
        Result2: Record "Patients Doctor's Advice";
    begin
        LabResults.SetRange(LabResults."Laboratory No.", LabNo);
        LabResults.SetRange(LabResults."Laboratory Test Code", LabTestCode);
        LabResults.SetRange(LabResults."Specimen Code", SpecimenCode);
        if LabResults.Find('-') then begin
            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            LabResults."Assigned User ID" := Labuser;
            LabResults."Collection Date" := Today;
            LabResults."Collection Time" := Time;
            LabResults.Remarks := Remarks;
            LabResults.Modify;
        end else begin
            LabResults.Init;
            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            LabResults."Assigned User ID" := Labuser;
            LabResults."Collection Date" := Today;
            LabResults."Collection Time" := Time;
            LabResults.Remarks := Remarks;
            LabResults.Insert;
        end;
        LabHeader.SetRange("Laboratory No.", LabNo);
        if LabHeader.Find('-') then
            docHeader.SetRange(docHeader."Treatment No.", LabHeader."Link No.");
        if docHeader.Find('-') then
            objAppointment.SetRange(objAppointment."Appointment No.", docHeader."Link No.");
        if objAppointment.Find('-') then begin
            objAppointment."Lab Time Out" := CurrentDatetime;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment.Modify;
        end;
    end;

    procedure ModifyLabResults(LabNo: Text; LabTestCode: Text; SpecimenCode: Text; Results: Decimal; Remarks: Text; Labuser: Text)
    begin
        LabResults.SetRange(LabResults."Laboratory No.", LabNo);
        LabResults.SetRange(LabResults."Laboratory Test Code", LabTestCode);
        LabResults.SetRange(LabResults."Specimen Code", SpecimenCode);
        if LabResults.Find('-') then begin

            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            LabResults."Assigned User ID" := Labuser;
            LabResults."Collection Date" := Today;
            LabResults."Collection Time" := Time;
            LabResults."Sort Test" := Random(50);
            LabResults.Results := Results;
            LabResults.Remarks := Remarks;
            LabResults.Validate(Results);
            LabResults.Validate("Laboratory Test Code");
            LabResults.Validate(Remarks);
            LabResults.Modify;
        end else begin
            LabResults.Init;
            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            LabResults."Assigned User ID" := Labuser;
            LabResults."Collection Date" := Today;
            LabResults."Collection Time" := Time;
            LabResults."Sort Test" := Random(50);
            LabResults.Results := Results;
            LabResults.Remarks := Remarks;
            LabResults.Validate(Results);
            LabResults.Validate("Laboratory Test Code");
            LabResults.Validate(Remarks);
            LabResults.Insert;
        end;
        LabHeader.SetRange("Laboratory No.", LabNo);
        if LabHeader.Find('-') then
            docHeader.SetRange(docHeader."Treatment No.", LabHeader."Link No.");
        if docHeader.Find('-') then
            objAppointment.SetRange(objAppointment."Appointment No.", docHeader."Link No.");
        if objAppointment.Find('-') then begin
            objAppointment."Lab Time Out" := CurrentDatetime;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment.Modify;
        end;
    end;

    procedure ModifyLabRemarks(LabNo: Text; LabTestCode: Text; SpecimenCode: Text; Remarks: Text; Labuser: Text)
    begin
        LabResults.SetRange(LabResults."Laboratory No.", LabNo);
        LabResults.SetRange(LabResults."Laboratory Test Code", LabTestCode);
        LabResults.SetRange(LabResults."Specimen Code", SpecimenCode);
        if LabResults.Find('-') then begin
            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            LabResults."Assigned User ID" := Labuser;
            LabResults."Sort Test" := Random(50);
            LabResults."Collection Date" := Today;
            LabResults."Collection Time" := Time;
            LabResults.Remarks := Remarks;
            LabResults.Modify;
        end else begin
            LabResults.Init;
            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            LabResults."Assigned User ID" := Labuser;
            LabResults."Sort Test" := Random(50);
            LabResults."Collection Date" := Today;
            LabResults."Collection Time" := Time;
            LabResults.Remarks := Remarks;
            LabResults.Insert;
        end;
        LabHeader.SetRange("Laboratory No.", LabNo);
        if LabHeader.Find('-') then
            docHeader.SetRange(docHeader."Treatment No.", LabHeader."Link No.");
        if docHeader.Find('-') then
            objAppointment.SetRange(objAppointment."Appointment No.", docHeader."Link No.");
        if objAppointment.Find('-') then begin
            objAppointment."Lab Time Out" := CurrentDatetime;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment.Modify;
        end;
    end;

    procedure StartNutrition(AdmissionNo: Text)
    begin
        AdmissionHeader.Reset;
        AdmissionHeader.SetRange("Admission No.", AdmissionNo);
        if AdmissionHeader.Find('-') then
            AdmissionHeader.Nutrition := true;
        AdmissionHeader."Nutrition Status" := AdmissionHeader."nutrition status"::Sent;
        AdmissionHeader.Modify;
    end;

    procedure StopNutrion(AdmissionNo: Text)
    begin
        AdmissionHeader.Reset;
        AdmissionHeader.SetRange("Admission No.", AdmissionNo);
        if AdmissionHeader.Find('-') then
            AdmissionHeader.Nutrition := false;
        AdmissionHeader."Nutrition Status" := AdmissionHeader."nutrition status"::Stopped;
        AdmissionHeader.Modify;
    end;

    procedure StartCounselling(AdmissionNo: Text)
    begin
        AdmissionHeader.Reset;
        AdmissionHeader.SetRange("Admission No.", AdmissionNo);
        if AdmissionHeader.Find('-') then
            AdmissionHeader.Counselling := true;
        AdmissionHeader."Counselling Status" := AdmissionHeader."counselling status"::Sent;
        AdmissionHeader.Modify;
    end;

    procedure StopCounselling(AdmissionNo: Text)
    begin
        AdmissionHeader.Reset;
        AdmissionHeader.SetRange("Admission No.", AdmissionNo);
        if AdmissionHeader.Find('-') then
            AdmissionHeader.Counselling := false;
        AdmissionHeader."Counselling Status" := AdmissionHeader."counselling status"::Stopped;
        AdmissionHeader.Modify;
    end;

    procedure InsertPharmacyLines(PharmacyNo: Text; DrugNo: Text; Quantity: Decimal; Take: Decimal; NoofDays: Decimal; Frequency: Integer; Route: Option; Dosage: Text; Remarks: Text)
    begin
        PharmacyLine.Init;
        PharmacyLine."Pharmacy No." := PharmacyNo;
        PharmacyLine."No." := DrugNo;
        PharmacyLine.Validate("No.");
        PharmacyLine.Quantity := Quantity;
        PharmacyLine.VALIDATE(Quantity);
        PharmacyLine."Issued Quantity" := Quantity;
        PharmacyLine.Dosage := Dosage;
        PharmacyLine.Remarks := Remarks;
        PharmacyLine.Take := Take;
        PharmacyLine.Route := Route;
        PharmacyLine."Number of Days" := NoofDays;
        PharmacyLine.Frequency := Frequency;
        PharmacyLine.Insert;
    end;

    procedure DeletePharmacyLine(PharmacyNo: Text; DrugNo: Text)
    begin
        PharmacyLine.Reset;
        PharmacyLine.SetRange("Pharmacy No.", PharmacyNo);
        PharmacyLine.SetRange("No.", DrugNo);
        if PharmacyLine.Find('-') then begin
            PharmacyLine.Delete;
        end;
    end;

    procedure CreateNewPharmacy() PharmacyNo: Text
    begin
        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", 0D, true);


        PharmHeader.Reset;
        PharmHeader.Init;
        PharmHeader."Pharmacy No." := NewNo;
        PharmHeader."Pharmacy Date" := Today;
        PharmHeader."Pharmacy Time" := Time;
        PharmHeader."Request Area" := PharmHeader."request area"::Walkin;
        PharmHeader."Patient No." := 'WALKIN';
        /*PharmHeader."Student No.":=AdmissionHeader."Student No.";
        PharmHeader."Employee No.":=AdmissionHeader."Employee No.";
        PharmHeader."Relative No.":=AdmissionHeader."Relative No.";*/
        // PharmHeader."Issuing Location" :=AdmissionLine."Location Code";
        //  PharmHeader."Transaction Type" :=AdmissionLine."Transaction Type";
        PharmHeader."Link Type" := 'WALKIN';
        //  PharmHeader."Link No.":=ObservationNo;
        PharmHeader.Status := PharmHeader.Status::New;

        PharmHeader.Insert();
        PharmacyNo := NewNo;

    end;

    procedure InsertPhysioEvalution(PhysioNo: Text; PatientNo: Text; Type: Option; SubType: Option; Description: Text)
    begin
        /*PhysioEvalution.INIT;
        PhysioEvalution."Physio No" :=PhysioNo;
        PhysioEvalution.Type :=Type;
        PhysioEvalution.SubType :=SubType;
        PhysioEvalution."Patient No" := PatientNo;
        PhysioEvalution.Description :=Description;
        PhysioEvalution.INSERT;*/

    end;

    procedure GeneratePhysioEvalution(PhysioNo: Text; filenameFromApp: Text) filename: Text
    begin
        /*filename :=FILESPATH+filenameFromApp;
         IF EXISTS(filename) THEN
          ERASE(filename);
        
        
        PhysioHeader.RESET;
        PhysioHeader.SETRANGE(PhysioHeader."No.",PhysioNo);
        
        
        IF PhysioHeader.FIND('-') THEN BEGIN
        REPORT.SAVEASPDF(70135289,filename,PhysioHeader);
         END;
        EXIT(filename);*/

    end;

    procedure InsertAdmissionFormNotes(TreatmentNo: Text; NotesType: Option; Notes: Text)
    begin
        /*AdmissionFormNotes.INIT;
        AdmissionFormNotes."Treatment No" :=TreatmentNo;
        AdmissionFormNotes.Notes :=Notes;
        AdmissionFormNotes."Notes Type" :=NotesType;
        AdmissionFormNotes.INSERT;
        */

    end;

    procedure GenerateP9Report(EmployeeNo: Text; Year: Integer; filenameFromApp: Text): Text[100]
    var
        hmsSetup: Record "HMS Setup";
    begin
        hmsSetup.get;
        FILESPATH := hmsSetup."Portal Reports Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        HREmp.Reset;
        HREmp.SetRange(HREmp."No.", EmployeeNo);
        //HrEmp.SETRANGE(HrEmp."Period Filter",Period);

        if HREmp.Find('-') then begin
            HREmp.count := Year;
            HREmp.Modify;
            Message(filename);
            Report.SaveAsPdf(52017737, filename, HREmp);
            Message(filename);
        end;
        exit(filename);
    end;

    procedure InsertPartographValues(PNo: Code[10]; GType: Integer; Xvalues: Time; YValues: Code[10])
    begin
        /*Partograph.RESET;
        Partograph."Patient No" := PNo;
        Partograph.Graph := GType;
        Partograph.XValues := Xvalues;
        Partograph.YValues := YValues;
        //Partograph.Contractions := Contraction;
        Partograph.INSERT;*/

    end;

    procedure InsertChildInformation(EmployeeNo: Text; Sname: Text; Fname: Text; Mname: Text; gender: Option; Dob: Date; Marital: Option; Id: Text; Address: Text; PostalCode: Text; City: Text; Phone: Text; Email: Text; Nationality: Text; Bloodgrp: Text; NextkinName: Text; NextkinRelationship: Text; NextkinContact: Text; InsuranceNo: Text; InsuranceName: Text; InsuranceMemberNo: Text; PatientType: Option)
    begin
        /*ChildInformation.INIT();
        ChildInformation."Patient No." :=NoSeriesMgt.GetNextNo('PAT',0D,TRUE);
        ChildInformation.VALIDATE("Patient No.");
        ChildInformation."Date Registered" :=TODAY;
        //ChildInformation."Patient Type" := PatientType;
        //ChildInformation.VALIDATE("Patient Type");
        ChildInformation."Employee No." :=EmployeeNo;
        ChildInformation.Surname :=Sname;
        ChildInformation."First Name" :=Fname;
        ChildInformation."Middle Name" :=Mname;
        ChildInformation.Gender :=gender;
        ChildInformation."Date Of Birth" :=Dob;
        ChildInformation."Marital Status" :=Marital;
        ChildInformation."Spouse Fax" := '';
        //ChildInformation.VALIDATE("Spouse Fax");
        ChildInformation."Place of Birth Village" := '';
        //ChildInformation."Correspondence Address 2" :=PostalCode;
        //ChildInformation."Correspondence Address 3" :=City;
        ChildInformation."Place of Birth Location" := '';
        ChildInformation."Place of Birth District" :='';
        ChildInformation.Nationality :=Nationality;
        //ChildInformation."Blood Group" :=Bloodgrp;
        ChildInformation."Next Of kin Full Name" :=NextkinName;
        ChildInformation."Next of kin Relationship" :=NextkinRelationship;
        ChildInformation."Next Of kin Address 1" :=Address;
        ChildInformation."Next Of kin Address 2" :=NextkinContact;
        //ChildInformation."Insurance No." :=InsuranceNo;
        //ChildInformation."Insurance Name" := InsuranceName;
        ChildInformation."Membership No" :=InsuranceMemberNo;
        //ChildInformation.VALIDATE("Patient Ref. No.");
        ChildInformation.VALIDATE("Spouse Telephone No. 1");
        ChildInformation.VALIDATE("Spouse Telephone No. 2");
        ChildInformation.VALIDATE("Spouse Email");
        ChildInformation.INSERT;
        */

    end;

    procedure InsertChildGrowth(PNo: Code[20]; Weight: Decimal; Height: Decimal)
    begin
        /*ChildGrowth.RESET;
        ChildGrowth."Patient No" := PNo;
        ChildInformation.RESET;
        ChildInformation.SETRANGE(ChildInformation."Patient No.",PNo);
        IF ChildInformation.FIND('-') THEN
          ChildGrowth.Gender := ChildInformation.Gender;
        ChildGrowth.Weight := Weight;
        ChildGrowth.Height := Height;
        ChildGrowth."Date Taken" := TODAY;
        ChildGrowth."User ID" := USERID;
        ChildGrowth.INSERT;*/

    end;

    procedure InsertMother(EmployeeNo: Text; Sname: Text; Fname: Text; Mname: Text; gender: Option; Dob: Date; Marital: Option; Id: Text; Address: Text; PostalCode: Text; City: Text; Phone: Text; Email: Text; Nationality: Text; Bloodgrp: Text; NextkinName: Text; NextkinRelationship: Text; NextkinContact: Text; InsuranceNo: Text; InsuranceName: Text; InsuranceMemberNo: Text; PatientType: Option)
    begin
        /*MothersList.INIT();
            MothersList."Patient No." :=NoSeriesMgt.GetNextNo('PAT',0D,TRUE);
            MothersList.VALIDATE("Patient No.");
            MothersList."Date Registered" :=TODAY;
            MothersList."Patient Type" := PatientType;
            MothersList.VALIDATE("Patient Type");
            MothersList."Employee No." :=EmployeeNo;
            MothersList.Surname :=Sname;
            MothersList."Middle Name" :=Fname;
            MothersList."Last Name" :=Mname;
            MothersList.Gender :=gender;
            MothersList."Date Of Birth" :=Dob;
            MothersList."Marital Status" :=Marital;
            MothersList."ID Number" :=Id;
            MothersList.VALIDATE("ID Number");
            MothersList."Correspondence Address 1" :=Address;
            MothersList."Correspondence Address 2" :=PostalCode;
            MothersList."Correspondence Address 3" :=City;
            MothersList."Telephone No. 1" :=Phone;
            MothersList.Email :=Email;
            MothersList.Nationality :=Nationality;
            MothersList."Blood Group" :=Bloodgrp;
            MothersList."Next Of kin Full Name" :=NextkinName;
            MothersList."Next of kin Relationship" :=NextkinRelationship;
            MothersList."Next Of kin Address 1" :=Address;
            MothersList."Next Of kin Address 2" :=NextkinContact;
            MothersList."Insurance No." :=InsuranceNo;
            MothersList."Insurance Name" := InsuranceName;
            MothersList."Membership No" :=InsuranceMemberNo;
            MothersList.VALIDATE("Patient Ref. No.");
            MothersList.VALIDATE(Surname);
            MothersList.VALIDATE("Middle Name");
            MothersList.VALIDATE("Last Name");
            MothersList.INSERT;
            */

    end;

    procedure InsertPatientHistoryNotes(PatientNo: Text; TreatmentNo: Text; NotesType: Option; Notes: Text)
    begin
        /*PatientHistory.INIT;
        PatientHistory."Patient No" :=PatientNo;
        PatientHistory."Treatment No" :=TreatmentNo;
        PatientHistory."Notes Type" :=NotesType;
        PatientHistory.Notes :=Notes;
        PatientHistory.INSERT;
        */

    end;

    procedure GeneratePhysioNotes(AdmissionNo: Text; filenameFromApp: Text) filename: Text
    begin
        /*filename :=FILESPATH+filenameFromApp;
         IF EXISTS(filename) THEN
          ERASE(filename);
        
        MESSAGE(filename);
        objNurseNote.RESET;
        objNurseNote.SETRANGE(objNurseNote."Admission No.",AdmissionNo);
        objNurseNote.SETRANGE(objNurseNote."Nurse Type",objNurseNote."Nurse Type"::Physiotherapist);
        
        IF objNurseNote.FIND('-') THEN BEGIN
        REPORT.SAVEASPDF(39005887,filename,objNurseNote);
          MESSAGE(filename);
         END;
        EXIT(filename);
        */

    end;

    procedure CheckStock(ItemNo: Text; Location: Text) stock: Decimal
    begin
        stock := 0.0;
        ObjItem.Reset;
        ObjItem.SetRange(ObjItem."No.", ItemNo);
        ObjItem.SetFilter(ObjItem."Location Filter", Location);
        if ObjItem.Find('-') then
            ObjItem.CalcFields(Inventory);
        stock := ObjItem.Inventory;
    end;

    procedure PopulatePatientSummary(TreatmentNo: Text)
    var
        intCount: array[13] of Integer;
        dtTreatDate: Date;
        tmTreatTime: Time;
        CompanyInfo: Record "Company Information";
        TreatmentProcess: Record "HMS Observation Form Header";
        ObservationSymptoms: Record "HMS Beds";
        TreatmentLaboratory: Record "HMS Observation Form Injection";
        TreatmentRadiology: Record "HMS Treatment Form Header";
        TreatmentDiagnosis: Record "HMS Treatment Form Process";
        TreatmentInjection: Record "HMS Observation Form Line Proc";
        TreatmentDrug: Record "HMS Treatment Form Injection";
        TreatmentAdmission: Record "HMS Treatment Form Laboratory";
        TreatmentReferral: Record "HMS Treatment Form Radiology";
        hmsNotes: Record "hms Notes";
        Ln: Integer;
        UserRec: Record "User Setup";
    begin
        /*intCount[1] := 1;
        
        
        Buffer.RESET;
        Buffer.SETRANGE(Buffer."Treatment No",TreatmentNo);
        IF Buffer.FIND('-') THEN Buffer.DELETEALL;
        
        //Process
        TreatmentProcess.RESET;
        TreatmentProcess.SETRANGE(TreatmentProcess."Treatment No.",TreatmentNo);
        IF TreatmentProcess.FIND('-') THEN BEGIN
          REPEAT
          Ln:=Ln+1;
          Buffer.INIT;
          Buffer."Treatment No":=TreatmentNo;
          Buffer."Line No":=Ln;
          Buffer.Category:='Vitals';
          Buffer.Code  :=TreatmentProcess."No.";
          Buffer.Description:=TreatmentProcess.Remarks;
          Buffer.Remarks:=TreatmentProcess.Results;
          Buffer."Sort Order":=1;
          Buffer.INSERT;
          UNTIL TreatmentProcess.NEXT=0;
        END;
        // Symtomps
        ObservationSymptoms.RESET;
        ObservationSymptoms.SETRANGE(ObservationSymptoms."Treatment No.",TreatmentNo);
        IF ObservationSymptoms.FIND('-') THEN BEGIN
          REPEAT
          Ln:=Ln+1;
          Buffer.INIT;
          Buffer."Treatment No":=TreatmentNo;
          Buffer."Line No":=Ln;
          Buffer.Category:='02.Symptoms';
          Buffer.Code  :=ObservationSymptoms."Symptom Code";
          Buffer.Description:=ObservationSymptoms.Description;
          Buffer.Remarks:=ObservationSymptoms.Characteristics;
          Buffer."Sort Order":=2;
          Buffer.INSERT;
          UNTIL ObservationSymptoms.NEXT=0;
        END;
        
        // Laboratory
        TreatmentLaboratory.RESET;
        TreatmentLaboratory.SETRANGE(TreatmentLaboratory."Treatment No.",TreatmentNo);
        IF TreatmentLaboratory.FIND('-') THEN BEGIN
          REPEAT
          Ln:=Ln+1;
          Buffer.INIT;
          Buffer."Treatment No":=TreatmentNo;
          Buffer."Line No":=Ln;
          Buffer.Category:='04.Laboratory';
          Buffer.Code  :=TreatmentLaboratory."Laboratory Test Package Code";
          Buffer.Description:=TreatmentLaboratory.Specimen;
          Buffer.Remarks:=TreatmentLaboratory.Results;
          Buffer."Sort Order":=3;
          Buffer.INSERT;
          UNTIL ObservationSymptoms.NEXT=0;
        END;
        
        // Radiology
        TreatmentRadiology.RESET;
        TreatmentRadiology.SETRANGE(TreatmentRadiology."Treatment No.",TreatmentNo);
        IF TreatmentRadiology.FIND('-') THEN BEGIN
          REPEAT
          Ln:=Ln+1;
          Buffer.INIT;
          Buffer."Treatment No":=TreatmentNo;
          Buffer."Line No":=Ln;
          Buffer.Category:='05.Radiology';
          Buffer.Code  :=TreatmentRadiology."Radiology Type Code";
          Buffer.Description:=TreatmentRadiology."Required Investigation";
          Buffer.Remarks:=TreatmentRadiology."Clinical Summary &  Diagnosis";
          Buffer."Sort Order":=4;
          Buffer.INSERT;
          UNTIL TreatmentRadiology.NEXT=0;
        END;
        
        // Theatre
        TheatreProcess.RESET;
        TheatreProcess.SETRANGE(TheatreProcess."No.",TreatmentNo);
        IF TheatreProcess.FIND('-') THEN BEGIN
          REPEAT
          Ln:=Ln+1;
          Buffer.INIT;
          Buffer."Treatment No":=TreatmentNo;
          Buffer."Line No":=Ln;
          Buffer.Category:='06.Theatre';
          Buffer.Code  :=TheatreProcess."Process No.";
          Buffer.Description:=TheatreProcess."Process Remarks";
          Buffer.Remarks:=TheatreProcess."Process Result";
          Buffer."Sort Order":=5;
          Buffer.INSERT;
          UNTIL TheatreProcess.NEXT=0;
        END;
        
        // ICU
        ICUProcess.RESET;
        ICUProcess.SETRANGE(ICUProcess."No.",TreatmentNo);
        IF ICUProcess.FIND('-') THEN BEGIN
          REPEAT
          Ln:=Ln+1;
          Buffer.INIT;
          Buffer."Treatment No":=TreatmentNo;
          Buffer."Line No":=Ln;
          Buffer.Category:='07.ICU';
          Buffer.Code  :=ICUProcess."Process No.";
          Buffer.Description:=ICUProcess."Process Remarks";
          Buffer.Remarks:=ICUProcess."Process Result";
          Buffer."Sort Order":=6;
          Buffer.INSERT;
          UNTIL ICUProcess.NEXT=0;
        END;
        
        // Diagnosis
        TreatmentDiagnosis.RESET;
        TreatmentDiagnosis.SETRANGE(TreatmentDiagnosis."Treatment No.",TreatmentNo);
        IF TreatmentDiagnosis.FIND('-') THEN BEGIN
          REPEAT
          TreatmentDiagnosis.CALCFIELDS("Diagnosis Name");
          Ln:=Ln+1;
          Buffer.INIT;
          Buffer."Treatment No":=TreatmentNo;
          Buffer."Line No":=Ln;
          Buffer.Category:='01.Diagnosis';
          Buffer.Code  :=TreatmentDiagnosis."Diagnosis Code";
          Buffer.Description:=TreatmentDiagnosis."Diagnosis Name";
          Buffer.Remarks:=TreatmentDiagnosis.Remarks;
          Buffer."Sort Order":=7;
          Buffer.INSERT;
          UNTIL TreatmentDiagnosis.NEXT=0;
        END;
        
        // Drug
        TreatmentDrug.RESET;
        TreatmentDrug.SETRANGE(TreatmentDrug."Treatment No.",TreatmentNo);
        IF TreatmentDrug.FIND('-') THEN BEGIN
          REPEAT
          Ln:=Ln+1;
          Buffer.INIT;
          Buffer."Treatment No":=TreatmentNo;
          Buffer."Line No":=Ln;
          Buffer.Category:='04.Prescription';
          Buffer.Code  :=TreatmentDrug."Drug No.";
          Buffer.Description:=TreatmentDrug."Drug Name";
          Buffer.Remarks:=TreatmentDrug.Dosage+' - '+FORMAT(TreatmentDrug.Frequency)+' - '+FORMAT(TreatmentDrug.Route);
          Buffer."Sort Order":=8;
          Buffer.INSERT;
          UNTIL TreatmentDrug.NEXT=0;
        END;
        // Admissions
        TreatmentAdmission.RESET;
        TreatmentAdmission.SETRANGE(TreatmentAdmission."Treatment No.",TreatmentNo);
        IF TreatmentAdmission.FIND('-') THEN BEGIN
          REPEAT
          Ln:=Ln+1;
          Buffer.INIT;
          Buffer."Treatment No":=TreatmentNo;
          Buffer."Line No":=Ln;
          Buffer.Category:='09.Admission';
          Buffer.Code  :=TreatmentAdmission."Bed No.";
          Buffer.Description:=TreatmentAdmission."Admission Remarks";
          Buffer.Remarks:=TreatmentAdmission."Admission Reason";
          Buffer."Sort Order":=9;
          Buffer.INSERT;
          UNTIL TreatmentAdmission.NEXT=0;
        END;
        // Referral
        TreatmentReferral.RESET;
        TreatmentReferral.SETRANGE(TreatmentReferral."Treatment No.",TreatmentNo);
        IF TreatmentReferral.FIND('-') THEN BEGIN
          REPEAT
          Ln:=Ln+1;
          Buffer.INIT;
          Buffer."Treatment No":=TreatmentNo;
          Buffer."Line No":=Ln;
          Buffer.Category:='10.Referral';
          Buffer.Code  :=TreatmentReferral."Hospital No.";
          Buffer.Description:=TreatmentReferral."Referral Remarks";
          Buffer.Remarks:=TreatmentReferral."Referral Reason";
          Buffer."Sort Order":=10;
          Buffer.INSERT;
          UNTIL TreatmentReferral.NEXT=0;
        END;
        // Notes
        hmsNotes.RESET;
        hmsNotes.SETRANGE(hmsNotes.TreatmentNo,TreatmentNo);
        IF hmsNotes.FIND('-') THEN BEGIN
          REPEAT
          Ln:=Ln+1;
          Buffer.INIT;
          Buffer."Treatment No":=TreatmentNo;
          Buffer."Line No":=Ln;
          Buffer.Category:='02.Notes';
          Buffer.Code  :=FORMAT(hmsNotes."Notes Type");
          IF UserRec.GET(hmsNotes."User ID") THEN
          Buffer.Description:=UserRec.UserName
          ELSE
          Buffer.Description:=hmsNotes."User ID";
          Buffer.Remarks:=hmsNotes.Notes;
          Buffer."Sort Order":=2;
          Buffer.INSERT;
          UNTIL hmsNotes.NEXT=0;
        END;
        */

    end;

    procedure InsertChiefComplaints(TreatmentNo: Code[30]; PatientNo: Code[30]; Notes: Text; TreatmentDate: Date; "docUSER ID": Code[30])
    begin
        objNotes.SetRange(objNotes."Patient No", PatientNo);
        objNotes.SetRange(objNotes.TreatmentNo, TreatmentNo);
        objNotes.SetRange(objNotes."Treatment Date", TreatmentDate);
        objNotes.SetRange(objNotes."User ID", "docUSER ID");
        // objNotes.SetRange( objNotes.Notes, Notes);
        // objNotes.SetRange(objNotes."Notes Type", objNotes."notes type"::"Chief Complaints");
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := Time;
            // objNotes.Notes := Notes;
            // objNotes."Notes Type" := objNotes."notes type"::"Chief Complaints";
            objNotes."User ID" := "docUSER ID";
            objNotes."Created Date" := Today;
            objNotes.Insert;
        end;

        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);
        if docHeader.Find('-') then begin
            if docHeader."Doctor's Name" = '' then begin

                DoctorsRec.Get(docHeader."Doctor ID");
                docHeader."Doctor's Name" := DoctorsRec."Doctors Name";
                docHeader.Modify;
            end;
        end;
    end;

    procedure ForwardLabResults(TreatmentNo: Text; LabNo: Text)
    begin
        ObjLab.Reset;
        ObjLab.SetRange(ObjLab."Treatment No.", TreatmentNo);
        // ObjLab.SETRANGE(ObjLab."Date Due", TODAY);
        if ObjLab.Find('-') then begin
            repeat
                ObjLab.Status := ObjLab.Status::Completed;
                ObjLab.Modify;
            until ObjLab.Next = 0;
        end;
        docHeader.Get(TreatmentNo);
        LaboratoryLines.SetRange("Laboratory No.", LabNo);
        if LaboratoryLines.Find('-') then begin
            repeat
                LaboratoryLines.Completed := true;
                LaboratoryLines.Modify;
            until LaboratoryLines.Next = 0;
        end;
        if LabHeader.Get(LabNo) then
            LabHeader.Status := LabHeader.Status::Completed;
        LabHeader.Modify;


        /* Patient.SETRANGE(Patient."Patient No." ,docHeader."Patient No.");
         IF Patient.FIND('-') THEN
         HMSQue.INIT;
         HMSQue."Patient No":=Patient."Patient No.";
         HMSQue."Visit No":=Patient."Active Visit No";
         HMSQue."Document No":=LabNo;
         HMSQue.Type:='LABORATORY';
         HMSQue."Queue Type":='RESULTS';
         HMSQue."Doctor ID":=docHeader."Doctor ID";
         HMSQue.Date:=TODAY;
         HMSQue.Time:=TIME;
         HMSQue.INSERT;*/

    end;

    procedure AssignDoctor(PatientNo: Text; TreatmentNo: Text; DocId: Text) Assigned: Boolean
    begin
        Assigned := false;

        UserSetUpPortal.Reset;
        UserSetUpPortal.SetRange(UserSetUpPortal."User ID", DocId);
        if UserSetUpPortal.Find('-') then begin
            if UserSetUpPortal."Selling Point" <> '' then begin
                ObjPatient.Reset;
                ObjPatient.SetRange(ObjPatient."Patient No.", PatientNo);
                if ObjPatient.Find('-') then begin
                    HMSPatientsCharges.Reset;
                    HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
                    HMSPatientsCharges.SetRange(HMSPatientsCharges."Visit No", ObjPatient."Active Visit No");
                    if HMSPatientsCharges.Find('-') then begin
                        repeat
                            HMSPatientsCharges.Validate(HMSPatientsCharges."Transaction Type");
                            HMSPatientsCharges."Doctor ID" := UserSetUpPortal."Selling Point";
                            HMSPatientsCharges.Validate("Doctor ID");
                            HMSPatientsCharges.Date := Today;
                            HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Appointment;
                            HMSPatientsCharges.Modify;

                        until HMSPatientsCharges.Next = 0;
                    end;
                end;


                if docHeader.Get(TreatmentNo) then
                    docHeader."Doctor ID" := UserSetUpPortal."Selling Point";
                docHeader.Validate("Doctor ID");
                docHeader.Modify;

                Assigned := true;
            end;
        end;
    end;

    procedure CalculateAge(PatientNo: Text)
    begin
        ObjPatient.Reset;
        ObjPatient.SetRange(ObjPatient."Patient No.", PatientNo);
        if ObjPatient.Find('-') then
            ObjPatient."Age in Years" := Date2dmy(Today, 3) - Date2dmy(ObjPatient."Date Of Birth", 3);
        ObjPatient.Modify;
        Message(Format(ObjPatient."Age in Years"));
    end;

    procedure BookTCA(PatientNo: Text; TCADate: Date; Doctor: Text)
    begin
        ObjPatient.Reset;
        ObjPatient.SetRange(ObjPatient."Patient No.", PatientNo);
        if ObjPatient.Find('-') then begin
            objAppointment.Reset;
            objAppointment.SetRange(objAppointment."Appointment No.", ObjPatient."Active Visit No");
            if objAppointment.Find('-') then
                objAppointment."ReAppointment Date" := TCADate;
            UserSetUpPortal.Reset;
            UserSetUpPortal.SetRange(UserSetUpPortal."User ID", Doctor);
            if UserSetUpPortal.Find('-') then begin objAppointment."ReAppointment Doctor ID" := UserSetUpPortal."Selling Point"; end;
            objAppointment."ReAppointment Type Code" := 'REVIEW';
            objAppointment.Modify;
        end;
    end;

    procedure VoidLabTest(LabNo: Text; LabTest: Text; Reason: Text)
    begin
        LabTestLines.Reset;
        LabTestLines.SetRange(LabTestLines."Laboratory No.", LabNo);
        LabTestLines.SetRange(LabTestLines."Laboratory Test Code", LabTest);
        if LabTestLines.Find('-') then
            LabTestLines.Delete;

        LabHeader.Get(LabNo);
        ObjPatient.SetRange("Patient No.", LabHeader."Patient No.");
        if ObjPatient.Find('-') then
            HMSPatientsCharges.Reset;
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", LabHeader."Patient No.");
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Visit No", ObjPatient."Active Visit No");
        HMSPatientsCharges.SetRange(HMSPatientsCharges.Code, LabTest);
        if HMSPatientsCharges.Find('-') then
            HMSPatientsCharges.Delete;

        ObjLab.Reset;
        ObjLab.SetRange(ObjLab."Laboratory Test Package Code", LabTest);
        ObjLab.SetRange(ObjLab."Treatment No.", LabHeader."Link No.");
        if ObjLab.Find('-') then
            ObjLab.Delete;
        LabHeader.Reset;
        LabHeader.SetRange("Laboratory No.", LabNo);
        if LabHeader.Find('-') then
            LabHeader."Test Voided" := LabHeader."Test Voided" + '1. ' + LabTest + ' ,';
        LabHeader."Reason For Voiding" := LabHeader."Reason For Voiding" + '1. ' + Reason + ' ,';
        LabHeader.Modify;
    end;

    procedure InsertOutpatientPro(TreatmentNo: Text; PatientNo: Text; OpProcedure: Code[20]; Description: Text; Department: Text; EmployeeNo: Text; Doctor: Text)
    begin
        /*OutpatientPro.INIT;
        OutpatientPro."Treatment No" := TreatmentNo;
        OutpatientPro."Patient No" := PatientNo;
        OutpatientPro."Procedure" := OpProcedure;
        OutpatientPro.Description := Description;
        OutpatientPro.Department := Department;
        OutpatientPro.Employee := EmployeeNo;
        OutpatientPro."Procedure Date" := CURRENTDATETIME;
        OutpatientPro.Doctor := Doctor;
        OutpatientPro.INSERT;*/

    end;

    procedure CheckDrugIssued(TreatmentNo: Text; Drugno: Text) issued: Boolean
    begin
        issued := false;
        ObjPrescription.Reset;
        ObjPrescription.SetRange("Treatment No.", TreatmentNo);
        ObjPrescription.SetRange("Drug No.", Drugno);
        ObjPrescription.SetRange(ObjPrescription.Status, ObjPrescription.Status::Completed);
        if ObjPrescription.Find('-') then begin
            issued := true;
        end;
    end;

    procedure PatientBillBalance(PatientNo: Text) balance: Decimal
    begin
        balance := 0;
        ObjPatient.SetRange(ObjPatient."Patient No.", PatientNo);
        //ObjPatient.SETRANGE(ObjPatient."Patient Type", ObjPatient."Patient Type"::Cash);
        if ObjPatient.Find('-') then begin
            objPatCharges.SetRange(objPatCharges."Patient No.", PatientNo);
            objPatCharges.SetRange(objPatCharges."Visit No", ObjPatient."Active Visit No");
            if objPatCharges.Find('-') then begin
                repeat
                    if objPatCharges."Total Amount" > 0 then
                        balance := balance + objPatCharges."Total Amount"
                    else
                        balance := balance + objPatCharges.Amount;

                until objPatCharges.Next = 0;
            end;
        end;
    end;

    procedure CalculateDrugTotal(TreatmentNo: Text) total: Decimal
    begin
        total := 0;
        ObjPrescription.Reset;
        ObjPrescription.SetRange(ObjPrescription."Treatment No.", TreatmentNo);
        if ObjPrescription.Find('-') then begin
            repeat
                total := total + ObjPrescription."Total Price";
            until ObjPrescription.Next = 0;
        end;
    end;

    procedure DeletePatientCharges(PatientNo: Text; VisitNo: Text; Charge: Text; Reason: Text; Employee: Text)
    var
        hmsPat: Record "HMS Patient";
    begin
        hmsPat.Reset;
        hmsPat.SetRange(hmsPat."Patient No.", PatientNo);
        if hmsPat.Find('-') then begin
            HMSPatientsCharges.Reset;
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Visit No", hmsPat."Active Visit No");
            HMSPatientsCharges.SetRange(HMSPatientsCharges.Code, Charge);
            HMSPatientsCharges.SetRange(HMSPatientsCharges.Date, Today);
            if HMSPatientsCharges.Find('-') then
                HMSPatientsCharges.Delete;

        end;
    end;

    procedure ReveiveLabTest(LabNo: Text; Samples: Text; EmployeeNo: Text)
    begin
        LabHeader.Reset;
        LabHeader.SetRange(LabHeader."Laboratory No.", LabNo);
        if LabHeader.Find('-') then begin
            LabHeader."Sampled Received" := Samples;
            LabHeader."Received by" := EmployeeNo;
            LabHeader.Modify;
        end;
    end;

    PROCEDURE UpdatePatient(PatientNo: Text; Sname: Text; Fname: Text; Mname: Text; gender: Option; Dob: Date; Marital: Option; Id: Text; Address: Text; PostalCode: Text; City: Text; Phone: Text; Email: Text; Nationality: Text; Bloodgrp: Text; NextkinName: Text; NextkinRelationship: Text; NextkinContact: Text; InsuranceNo: Text; InsuranceName: Text; InsuranceMemberNo: Text; PatientType: Option);
    BEGIN
        ObjPatient.RESET;
        ObjPatient.SETRANGE("Patient No.", PatientNo);
        IF ObjPatient.FIND('-') THEN BEGIN
            ObjPatient."Patient Type" := PatientType;
            ObjPatient.VALIDATE("Patient Type");
            //ObjPatient."Employee No." :=EmployeeNo;
            ObjPatient.Surname := Sname;
            ObjPatient.VALIDATE(Surname);
            ObjPatient."Middle Name" := Fname;
            ObjPatient.VALIDATE("Middle Name");
            ObjPatient."Last Name" := Mname;
            ObjPatient.VALIDATE("Last Name");
            ObjPatient.Gender := gender;
            ObjPatient."Date Of Birth" := Dob;
            ObjPatient."Marital Status" := Marital;
            ObjPatient."ID Number" := Id;
            ObjPatient.VALIDATE("ID Number");
            ObjPatient."Correspondence Address 1" := Address;
            ObjPatient."Correspondence Address 2" := PostalCode;
            ObjPatient."Correspondence Address 3" := City;
            ObjPatient."Telephone No. 1" := Phone;
            ObjPatient.VALIDATE("Telephone No. 1");
            ObjPatient.Email := Email;
            ObjPatient.Nationality := Nationality;
            ObjPatient."Blood Group" := Bloodgrp;
            //ObjPatient."Next Of kin Full Name" :=NextkinName;
            //ObjPatient."Next of kin Relationship" :=NextkinRelationship;
            //ObjPatient."Next Of kin Address 1" :=Address;
            //ObjPatient."Next Of kin Address 2" :=NextkinContact;
            ObjPatient."Insurance No." := InsuranceNo;
            ObjPatient."Insurance Name" := InsuranceName;
            ObjPatient."Membership No" := InsuranceMemberNo;
            ObjPatient.VALIDATE("Patient Ref. No.");
            ObjPatient.VALIDATE(Surname);
            ObjPatient.VALIDATE("Middle Name");
            ObjPatient.VALIDATE("Last Name");
            ObjPatient.MODIFY;
        END;
    END;

    PROCEDURE InsertStudentPatient(StudentNo: Text) NewNo: Text;
    BEGIN
        Customer.SETRANGE("No.", StudentNo);
        IF Customer.FIND('-') THEN BEGIN

            NewNo := NoSeriesMgt.GetNextNo('PAT', 0D, TRUE);
            ObjPatient.INIT();
            ObjPatient."Patient No." := NewNo;
            ObjPatient.VALIDATE("Patient No.");
            // ObjPatient."Student No." := StudentNo;
            ObjPatient."Date Registered" := TODAY;
            ObjPatient."Patient Type" := ObjPatient."Patient Type2"::Student;
            ObjPatient.VALIDATE("Patient Type");
            ObjPatient.Surname := Customer.Name;
            ObjPatient.VALIDATE(Surname);
            /*ObjPatient."Middle Name" :=Fname;
            ObjPatient.VALIDATE("Middle Name");
            ObjPatient."Last Name" :=Mname;
            ObjPatient.VALIDATE("Last Name");
            */
            ObjPatient.Gender := Customer.Gender;
            ObjPatient."Date Of Birth" := Customer."Date Of Birth";
            ObjPatient."Marital Status" := Customer."Marital Status";
            ObjPatient."ID Number" := Customer."ID No";
            //ObjPatient.VALIDATE("ID Number");

            ObjPatient."Telephone No. 1" := Customer."Phone No.";
            ObjPatient.VALIDATE("Telephone No. 1");
            ObjPatient.Email := Customer."E-Mail";
            ObjPatient.Nationality := Customer.Nationality;
            ObjPatient."Blood Group" := Customer."Blood Group";
            //ObjPatient."Next Of kin Full Name" :=NextkinName;
            //ObjPatient."Next of kin Relationship" :=NextkinRelationship;
            //ObjPatient."Next Of kin Address 1" :=Address;
            //ObjPatient."Next Of kin Address 2" :=NextkinContact;
            ObjPatient."Global Dimension 1 Code" := Customer."Global Dimension 1 Code";
            ObjPatient."Global Dimension 2 Code" := Customer."Global Dimension 2 Code";
            ObjPatient.VALIDATE(Surname);

            ObjPatient.INSERT;
        END;
    END;

    PROCEDURE InsertStaffPatient(StaffNo: Text) NewNo: Text;
    BEGIN
        HREmp.RESET;
        HREmp.SETRANGE("No.", StaffNo);
        IF HREmp.FIND('-') THEN BEGIN

            NewNo := NoSeriesMgt.GetNextNo('PAT', 0D, TRUE);
            ObjPatient.INIT();
            ObjPatient."Patient No." := NewNo;
            ObjPatient.VALIDATE("Patient No.");
            ObjPatient."Employee No." := HREmp."No.";
            ObjPatient."Date Registered" := TODAY;
            ObjPatient."Patient Type" := ObjPatient."Patient Type2"::Employee;
            //ObjPatient.VALIDATE("Patient Type");
            ObjPatient.Surname := HREmp."First Name";//+' '+HREmp."Middle Name"+' '+HREmp."Last Name";

            ObjPatient."Middle Name" := HREmp."Middle Name";

            ObjPatient."Last Name" := HREmp."Last Name";
            ObjPatient.VALIDATE("Last Name");
            ObjPatient.Gender := HREmp.Gender;
            ObjPatient."Date Of Birth" := HREmp."Date Of Birth";
            ObjPatient."Marital Status" := HREmp."Marital Status";
            ObjPatient."ID Number" := HREmp."ID Number";
            //ObjPatient.VALIDATE("ID Number");
            ObjPatient.Status := ObjPatient.Status::Registered;
            ObjPatient."Telephone No. 1" := HREmp."Home Phone Number";
            //ObjPatient.VALIDATE("Telephone No. 1");
            ObjPatient.Email := HREmp."Company E-Mail";
            //ObjPatient.Nationality :=HREmp."Country Code";
            //ObjPatient."Blood Group" :=HREmp."Blood Group";
            //ObjPatient."Next Of kin Full Name" :=NextkinName;
            //ObjPatient."Next of kin Relationship" :=NextkinRelationship;
            //ObjPatient."Next Of kin Address 1" :=Address;
            //ObjPatient."Next Of kin Address 2" :=NextkinContact;
            //ObjPatient."Global Dimension 1 Code" :=HREmp.;
            ObjPatient."Global Dimension 2 Code" := HREmp."Shortcut Dimension 2 Code";


            ObjPatient.INSERT;
        END;
    END;

    procedure ModifyPharmacyHeader(PharmNo: Text; PharmStore: Text; TransType: Text; EmpNo: Text)
    begin
        PharmHeader.RESET;
        PharmHeader.SETRANGE("Pharmacy No.", PharmNo);
        IF PharmHeader.FIND('-') THEN BEGIN
            PharmHeader."Issuing Location" := PharmStore;
            PharmHeader.VALIDATE("Issuing Location");
            PharmHeader."Transaction Type" := TransType;
            PharmHeader."Issued By" := EmpNo;
            PharmHeader.MODIFY;
        END;
    end;

    procedure ModifyPharmacyLine(PharmNo: Text; DrugNo: Text; Qnty: Integer)
    begin
        PharmLine.RESET;
        PharmLine.SETRANGE("Pharmacy No.", PharmNo);
        PharmLine.SETRANGE("No.", DrugNo);
        IF PharmLine.FIND('-') THEN BEGIN
            PharmLine.Quantity := Qnty;
            PharmLine.VALIDATE(Quantity);
            PharmLine.MODIFY;
        END;
    end;



}

