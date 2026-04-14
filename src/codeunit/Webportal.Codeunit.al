Codeunit 85034 Webportal
{
    Permissions = TableData "Approval Entry" = imd,
                  TableData "Approval Comment Line" = imd,
                  TableData "Posted Approval Entry" = imd,
                  TableData "Posted Approval Comment Line" = imd,
                  TableData "Overdue Approval Entry" = imd;

    trigger OnRun()
    begin
        //InsertPatientWalkin('DSL\ALFONCE','Wambua','KISOVI','th',1,TODAY,1,'222','','','','254725125002','','Kenyan','Musyoka','Business Partner','254712200210','','','','','KISUMU');



        //HRLeaveApplication('E-0002','ANNUAL',2.0,TODAY,TODAY,TODAY,'Test','','','Main');
        //GeneratePaySlipReport('FCH326',20180111D,'Test3.pdf');
        //InsertObservation(1,'SL-000021',f'AP-00011','125');
        //PrescribeDrugs('TR-00034');
        //DocumentApprovals('P_QUO00107'f,'REALE1\SL167');
        //GenerateInvoice('53820','Invoice.pdf');
        //HRCancelLeaveApplication('LV-0023');
        //DipatchtoDoctor(2,'DR064','PT001330','AP-00247','OB-00207','TR-00216');
        //MESSAGE('Current local time: %1\Current UTC time: %2','SystemDateTime.Now',SystemDateTime.UtcNow);
        //SendToTheatre('TR-02800');
        //MESSAGE(FORMAT(CountDoctorQue('HMSSERVER\NAV')));
        //RequestAdmission('TR-03246');
        //GenerateObservationChart('ADM-00262','19188','Test-191.pdf');
        //GenerateTreatmentHistoPrintout('TR-01420', 'Treatment.pdf');
        //GenerateFluidChart('ADM-01216','P62241','Fluid.pdf');
        //PrescribeDrugsInpatient('OB-31201','CL-000120');
        //AdmitPatient('P00002','ADM-00000','','',TRUE)
        //docHeader.VALIDATE("Doctor ID");
        //AssignDoctor('P50652','TR-00853','REALE1\PORTAL');
        //CalculateAge('P131697');
        //PrescribeDrugsTriage('OB-34642','ITM6585');
        //GenerateLabResults('TR-00106','LAB-0039PT018632.pdf');
        //InsertPrescription('TR-11931','ITM7737','','',3,5,10,'ML',0,'OD',1);
        //MESSAGE(FORMAT(CheckUserSetup('DSL0\aowuor')));

        //MESSAGE(FORMAT(PatientBillBalance('PT000003')));
        //RequestLab('TR-00558','Inpatient');

        //CheckLabResults('');

        //InsertTreatLab('TR-34606','LAB006','ACTH(ADRENOCORTICOTROPIC HORMONE)','ds');

        //MarkTreatmentComplete('OB-34653','PT000032');
        //InsertLabResults('LB-00003','LAB009','Yes',2.5,'','KSH1');
        //ForwardLabResults('AP-00066','LB-00015','REVIEW');
        //ReceiveTransferOrderPortal('TRO00020');

        //MESSAGE(FORMAT(GetStock('ITM-02360','MATERNITY')));

        //GenerateLabResultsIndividual('TR-00291','LabResultsTR-00291_LAB-0091PT018697.pdf','LAB-0091','LB-00339');
        //InsertTSheet('TR-00360','ITM-00578','','KSH\PORTAL','ADM-00037');
        //validate();

        //RequestRadiologyIP('ADM-00011');
    end;

    var
        "Approvals management": Codeunit "Approvals Mgmt.";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
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
        BaseCalendarChange: Record "Base Calendar Change2";
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
        BaseCalendar: Record "Base Calendar Change2";
        test: Boolean;
        testDate: Date;
        GeneralOptions: Record "HR Setup";
        ltype: Record "Leave Types";
        dates: Record Date;
        LeaveTypes: Record "Leave Types";
        ApprovalMgt1: Codeunit "Approvals Mgmt.";
        LeaveEntry: Record "Leave Types";
        StoreRequisition: Record "Store Requistion Header";
        StoreRequestedLines: Record "Store Requistion Lines";

        TransportRequisition: Record "FLT-Transport Requisition";
        HRTravellingStaff: Record "FLT-Travel Requisition Staff";
        TransportRequisition_2: Record "FLT-Transport Requisition";
        //DimProgramme: Record "Employee Responsibility";
        ImprestRequisition: Record "Imprest Header";
        ImprestRequisitionLines: Record "Imprest Lines";
        CashOfficeSetup: Record "Cash Office Setup";
        "HR Staff Requisition": Record "HR Staff Requisition";
        objPurchaseHeader: Record "Purchase Header";
        objPurchaseLine: Record "Purchase Line";
        objPayableSetup: Record "Purchases & Payables Setup";
        objApprovalCommentLine: Record "Approval Comment Line";
        objHRJobApplicants: Record "HR Job Applicants";
        objHRJobApplication: Record "HR Job Applications";
        //objProgramme: Record "Employee Responsibility";
        objDimValues: Record "Dimension Value";
        objAcademicYear: Record "prPension Details";
        objReceipt: Record "Receipt";
        objImprestSurrender: Record "Imprest Surrender Header";
        objCashOfficeSetup: Record "Cash Office Setup";
        objQualifications: Record "HR Applicant Qualifications";
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        FILESPATH: label 'C:\Portal\RFH LIVE\Downloads\';
        FILESPATHTEST: label 'C:\Portal\RFH LIVE\Downloads\';
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
        PhysioHeader: Record "HMS Physiotheraphy Form Header";
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
        HMSTreatH: Record "HMS Treatment Form Header";
        Labec: Record "HMS Setup Lab Test";
        ObjTheatre: Record "HMS Treatment Form Theater";
        DaysBtwnTodayAndLastVisit: Integer;
        ObjObservInjection: Record "HMS Observation Form Injection";
        ObservProcess: Record "HMS Observation Form Line Proc";
        ObjICULines: Record "HMS ICU Line Process";
        ObjDiagnosis: Record "HMS Treatment Form Diagnosis";
        ObjInjection: Record "HMS Treatment Form Injection";
        ObjPrescription: Record "HMS Treatment Form Drug";
        ObjAdmission: Record "HMS Treatment Admission";
        ObjReferral: Record "HMS Treatment Referral";
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
        OperationalNotes: Record "HMS Operational Notes";
        TheaterForm: Record "HMS Theatre Form Header";
        THeader: Record "HMS Treatment Form Theater";
        TLine: Record "HMS Treatment Form Theater";
        THeader2: Record "HMS Theatre Form Header";
        TTestLines: Record "HMS Theatre Line Process";
        DischargeSummary: Record "HMS Discharge Summary";
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
        PhysioTypes: Record "HMS Physiotheraphy TYpes";
        LabResults: Record "HMS Laboratory Results Entry";
        LabResults2: Record "HMS Laboratory Results Entry";
        InpatientObservation: Record "HMS General Observation";
        TSheet: Record "HMS Admission Drug Nurse";
        FluidBalance: Record "HMS Fluid Balance Chart";
        PreOpSetup: Record "HMS PreOp Checklist Setup";
        PreOpList: Record "HMS PreOperative Checklist";
        LabResultsEntry: Record "HMS Laboratory Results Entry";
        PharmacyLine: Record "HMS Pharmacy Line";
        PhysioEvalution: Record "HMS Physio Evalution Form";
        PatientHistory: Record "HMS Patient History Notes";
        AdmissionFormNotes: Record "HMS Treatment Admission Notes";
        Partograph: Record Partograph;
        ChildInformation: Record "Child Registration List";
        ChildGrowth: Record "Child Growth Monitoring";
        MothersList: Record "HMS Mothers List";
        OutpatientPro: Record "HMS Outpatient Procedures";
        ObjUser: Record User;
        LabParameters: Record "HMS Lab Parameters setup";
        EdmontonScale: Record "Edmonton Scale";
        HMSPatientFlags: Record "HMS Patient Flags";
        HMSDialysisFormHeader: Record "HMS Therapy Form Header";
        DialysisPatientInfo: Record "Dialysis Patient Info";
        HMSSample: Record "HMS Sample";
        LabNotes: Record "Lab Notes";
        HMSLaboratoryTestLine: Record "HMS Laboratory Test Line";
        TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
        Item: Record Item;
        HMSAdmissionDrugNurse: Record "HMS Admission Drug Nurse";
        InvtSetup: Record "Inventory Setup";
        PurchSetup: Record "Cash Office Setup";
        Cashsetup: Record "Cash Office Setup";
        DialysisVitals: Record "HMS Dialysis Vitals";

    procedure SendLeaveApprovalRequest(ApplicationCode: Code[20])
    var
        USERID_APPR: Text;
    begin
        "HR Leave Application".SetRange("HR Leave Application"."No.", ApplicationCode);
        if "HR Leave Application".Find('-')
        then begin
            //  "Approvals management".SendLeaveAppApprovalReq("HR Leave Application");
            Message('Test');
        end
    end;

    procedure HRLeaveApplication(EmployeeNo: Text; LeaveType: Text; AppliedDays: Decimal; StartDate: Date; EndDate: Date; ReturnDate: Date; SenderComments: Text; Reliever: Code[20]; RelieverName: Text[50]; RespCent: Text[50]) successMessage: Text
    var
        UserIdApprovals: Text;
        ApproverId: Text;
    begin
        LeaveT.Init;
        HRSetup.Get;
        NextLeaveApplicationNo := NoSeriesMgt.GetNextNo(HRSetup."Leave Application Nos.", 0D, true);
        //Employee details
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."No.", EmployeeNo);

        if "Employee Card".Find('-')
        then begin
            LeaveT."User ID" := "Employee Card"."User ID";
            UserIdApprovals := "Employee Card"."User ID";
            LeaveT."Employee No" := EmployeeNo;
            LeaveT."Employee Name" := "Employee Card"."First Name" + '  ' + "Employee Card"."Middle Name";
            LeaveT."Shortcut Dimension 2 Code" := "Employee Card"."Shortcut Dimension 2 Code";

            "User Setup".Reset;
            "User Setup".SetRange("User Setup"."User ID", "Employee Card"."User ID");
            if "User Setup".Find('-') then begin
                ApproverId := "User Setup"."Approver ID";
            end;


        end;

        LeaveT."No." := NextLeaveApplicationNo;
        LeaveT."Leave Type" := LeaveType;
        LeaveT."Applied Days" := AppliedDays;
        LeaveT."Application Date" := Today;
        LeaveT."No. Series" := 'LEAVE';
        LeaveT."Starting Date" := StartDate;
        LeaveT."Return Date" := ReturnDate;
        LeaveT."End Date" := EndDate;
        LeaveT."Return Date" := ReturnDate;
        LeaveT.Purpose := SenderComments;
        LeaveT."Reliever No." := Reliever;
        LeaveT."Reliever Name" := RelieverName;
        LeaveT."Responsibility Center" := RespCent;
        LeaveT.Insert;


        // successMessage:='Your Leave Application was successfully submitted for approval.';
    end;

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

    procedure DetermineIfIsNonWorking(var bcDate: Date) ItsNonWorking: Boolean
    begin

        //HRSetup.FIND('-');
        //HRSetup.TESTFIELD(HRSetup."Base Calendar");
        /*  BaseCalendarChange.SetFilter(BaseCalendarChange."Base Calendar Code", HRSetup."Base Calendar");
         BaseCalendarChange.SetRange(BaseCalendarChange.Date, bcDate);

         if BaseCalendarChange.Find('-') then begin
             if BaseCalendarChange.Nonworking = false then
                 Error('Start date can only be a Working Day Date');
             exit(true);
         end; */


        Clear(ItsNonWorking);
        GeneralOptions.Find('-');
        //One off Hollidays like Good Friday
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar.Date, bcDate);
        if BaseCalendar.Find('-') then begin
            if BaseCalendar.Nonworking = true then
                ItsNonWorking := true;
        end;

        // For Annual Holidays
        BaseCalendar.Reset;
        BaseCalendar.SetFilter(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar");
        BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."recurring system"::"Annual Recurring");
        if BaseCalendar.Find('-') then begin
            repeat
                if ((Date2dmy(bcDate, 1) = BaseCalendar."Date Day") and (Date2dmy(bcDate, 2) = BaseCalendar."Date Month")) then begin
                    if BaseCalendar.Nonworking = true then
                        ItsNonWorking := true;
                end;
            until BaseCalendar.Next = 0;
        end;

        if ItsNonWorking = false then begin
            // Check if its a weekend
            dates.Reset;
            dates.SetRange(dates."Period Type", dates."period type"::Date);
            dates.SetRange(dates."Period Start", bcDate);
            if dates.Find('-') then begin
                //if date is a sunday
                if dates."Period Name" = 'Sunday' then begin
                    //check if Leave includes sunday
                    if ltype."Inclusive of Sunday" = false then ItsNonWorking := true;
                end else
                    if dates."Period Name" = 'Saturday' then begin
                        //check if Leave includes sato
                        if ltype."Inclusive of Saturday" = false then ItsNonWorking := true;
                    end;
            end;
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

    procedure HRUpdateLeaveApplication("Document No": Text; "Reliever No": Text; ApprovedDays: Integer; "Supervisor ID param": Text) SuccessMessage: Text
    begin

        LeaveT.Reset;
        LeaveT.SetRange(LeaveT."No.", "Document No");

        if LeaveT.Find('-')
          then begin
            LeaveT."Reliever No." := "Reliever No";
            "Employee Card".Reset;
            "Employee Card".SetRange("Employee Card"."No.", "Reliever No");

            if "Employee Card".Find('-')
            then begin
                LeaveT."Reliever Name" := "Employee Card"."First Name" + ' ' + "Employee Card"."Middle Name" + ' ' + "Employee Card"."Last Name";
            end;

            // LeaveT."Applied Days"LeaveT."Approved days":=ApprovedDays;
            LeaveT.Modify;
            "Supervisor ID" := "Supervisor ID param";

            ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Document No");
            ApprovalEntry.SetRange(ApprovalEntry."Approver ID", "Supervisor ID param");
            ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
            if ApprovalEntry.Find('-') then begin
                //Modify status to approved if there are no other approvers
                ApprovalEntry.Status := ApprovalEntry.Status::Approved;
                ApprovalEntry.Modify;

                //Change next doc to open
                ApprovalEntry_2.Reset;
                ApprovalEntry_2.SetRange(ApprovalEntry_2."Document No.", "Document No");
                ApprovalEntry_2.SetRange(ApprovalEntry_2.Status, ApprovalEntry_2.Status::Created);
                if ApprovalEntry_2.Find('-') then begin
                    ApprovalEntry_2.Status := ApprovalEntry_2.Status::Open;
                    ApprovalEntry_2."Last Date-Time Modified" := CreateDatetime(Today, Time);
                    ApprovalEntry_2."Last Modified By User ID" := "Supervisor ID param";
                    ApprovalEntry_2.Modify;
                    SuccessMessage := 'Approval successful.';
                end;

            end;
            ApprovalEntry_2.Reset;
            ApprovalEntry_2.SetRange(ApprovalEntry_2."Document No.", "Document No");
            if ApprovalEntry_2.FindLast then begin
                if ApprovalEntry_2.Status = ApprovalEntry_2.Status::Approved then begin
                    HRLeave.Reset;
                    HRLeave.SetRange(HRLeave."No.", "Document No");
                    //IF HRLeave.FIND('-')THEN
                    //  BEGIN
                    // HRLeave.CreateLeaveLedgerEntries;
                    //   IF ApprovalSetup.Approvals THEN
                    //  ApprovalMgtNotification.SendLeaveApprovedMail(HRLeave,ApprovalEntry);

                    //  END;
                end;
            end;

        end;
    end;

    procedure HRRejectLeave("Document No": Text; "Supervisor ID": Text)
    begin
        ApprovalEntry.SetRange("Document No.", "Document No");
        if ApprovalEntry.Find('-') then
            repeat
                ApprovalEntry.Status := ApprovalEntry.Status::Rejected;
                ApprovalEntry."Last Date-Time Modified" := CreateDatetime(Today, Time);
                ApprovalEntry."Last Modified By User ID" := "Supervisor ID";
                ApprovalEntry.Modify;
            // ApprovalMgtNotification.SendLeaveRejectionsMail(HRLeaveApp,ApprovalEntry);
            until ApprovalEntry.Next = 0;

        HRLeaveApp.SetRange(HRLeaveApp."No.", "Document No");
        if HRLeaveApp.Find('-') then begin
            HRLeaveApp.Status := HRLeaveApp.Status::Cancelled;
            HRLeaveApp.Modify;
            Message('You rejected Leave No, %1', "Document No");
        end;
        // Message('You rejected Leave No '+"Document No" );
    end;

    procedure HRDetermineIfALeaveExistsForSameDate(EmployeeNo: Text; "Start Date": Date)
    begin
        HRLeaveApp.Reset;
        HRLeaveApp.SetRange(HRLeaveApp."Employee No", EmployeeNo);
        HRLeaveApp.SetRange(HRLeaveApp."Starting Date", "Start Date");
        if HRLeaveApp.Find('-') then begin
            Error('The Staff has an existing leave application starting on the same date, %1', HRLeaveApp."No.");
        end;
    end;

    procedure GeneratePaySlipReport(EmployeeNo: Text; Period: Date; filenameFromApp: Text): Text[100]

    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        "Salary Card".Reset;
        "Salary Card".SetRange("Salary Card"."Employee Code", EmployeeNo);
        "Salary Card".SetRange("Salary Card"."Period Filter", Period);

        if "Salary Card".Find('-') then begin
            Report.SaveAsPdf(Report::"Individual Payslips mst", filename, "Salary Card");

        end;
        exit(filename);
    end;

    procedure GeneratePaySlipReportKabu(EmployeeNo: Text; Period: Date; filenameFromApp: Text) filename: Text[100]
    var
        "prSalary Card": Record "prSalary Card";
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        "Salary Card".Reset;
        "Salary Card".SetRange("Salary Card"."Employee Code", EmployeeNo);
        "Salary Card".SetRange("Salary Card"."Period Filter", Period);
        //"Salary Card".SETRANGE("Salary Card"."Current Month",1);

        if "Salary Card".Find('-') then begin
            Report.SaveAsPdf(Report::"Individual Payslips mst", filename, "Salary Card");
        end;
        exit(filename);
    end;

    procedure GenerateReceipt("Receipt No": Code[50]; filenameFromApp: Text)
    var
        filename: Text;
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        Message(Format(filename));
        if Exists(filename) then
            Erase(filename);
        objReceipt.Reset;
        objReceipt.SetRange(objReceipt."Receipt No.", "Receipt No");

        if objReceipt.Find('-') then begin
            Report.SaveAsPdf(Report::"Receipts Report A4", filename, objReceipt);
        end;
    end;

    procedure HRLeaveApplicationUpdate(ReqNo: Text; LeaveType: Text; AppliedDays: Decimal; StartDate: Date; EndDate: Date; ReturnDate: Date; SenderComments: Text; "Reliever No": Text; ResponsibilityCenter: Code[20]) successMessage: Text
    var
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        tableNo: Integer;
    begin
        LeaveT.Reset;
        LeaveT.SetRange(LeaveT."No.", ReqNo);
        if LeaveT.Find('-') then begin
            NextLeaveApplicationNo := ReqNo;
            LeaveT."No." := NextLeaveApplicationNo;
            LeaveT."Leave Type" := LeaveType;
            LeaveT."Applied Days" := AppliedDays;
            LeaveT."Application Date" := Today;
            LeaveT."Starting Date" := StartDate;
            LeaveT."End Date" := EndDate;
            LeaveT."Return Date" := ReturnDate;
            LeaveT.Purpose := SenderComments;
            LeaveT."No. Series" := 'LEAVE';
            LeaveT."Reliever No." := "Reliever No";
            LeaveT.Validate(LeaveT."Reliever No.");
            LeaveT.Status := HRLeave.Status::Open;
            LeaveT."Responsibility Center" := ResponsibilityCenter;
            LeaveT.Validate(LeaveT."Employee No");
            LeaveT.Modify;
        end;
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
                if ((Date2dmy("Starting Date", 1) = BaseCalendar."Date Day")) then begin
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

    procedure HRCancelLeaveApplication(LeaveApplicationNo: Code[20])
    var
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition"," Staff Update ",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary;
        WebUser: Code[30];
        tableNo: Integer;
        showmessage: Boolean;
        ManualCancel: Boolean;
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange("Document No.", LeaveApplicationNo);
        if ApprovalEntry.Find('-') then begin

            ApprovalEntry.DeleteAll;

        end;
        "HR Leave Application".Reset;
        "HR Leave Application".SetRange("HR Leave Application"."No.", LeaveApplicationNo);

        if "HR Leave Application".Find('-') then begin
            WebUser := "HR Leave Application"."User ID";
        end;

        /*DocType:=DocType::"Leave Application";
        CLEAR(tableNo);
        tableNo:=39005550;
        ApprovalMgt1.CancelApproval(tableNo,DocType,LeaveApplicationNo,WebUser);
        */

        DocType := Doctype::"Leave Application";
        showmessage := true;
        ManualCancel := true;
        Clear(tableNo);
        tableNo := 39005550;
        // ApprovalMgt.CancelApproval(tableNo,DocType,LeaveApplicationNo,showmessage,ManualCancel);

    end;

    procedure StoreRequisitionCreate("Employee No": Text; RequestType: Option; "Date Required": Date; "IssuingLocation": Text; "Dept Code": Text; Description: Text; ResponsiblityCenter: Code[20]; Branch: Text): Code[20]
    var
        NextApplicationNo: Text;
        status: Option;
    begin
        StoreRequisition.Init;
        PurchSetup.Get;
        NextApplicationNo := NoSeriesMgt.GetNextNo(PurchSetup."Stores Requisition No", 0D, true);

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
        StoreRequisition."Global Dimension 1 Code" := Branch;
        StoreRequisition.Validate(StoreRequisition."Global Dimension 1 Code");
        StoreRequisition."Shortcut Dimension 2 Code" := "Dept Code";
        StoreRequisition.Validate(StoreRequisition."Shortcut Dimension 2 Code");
        StoreRequisition.Status := StoreRequisition.Status::Open;
        StoreRequisition."Responsibility Center" := ResponsiblityCenter;
        StoreRequisition."No. Series" := 'STORE';
        StoreRequisition."Issuing Store" := IssuingLocation;
        StoreRequisition."Employee No" := "Employee No";
        status := StoreRequisition.Status;

        StoreRequisition.Insert;
        exit(NextApplicationNo);
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
        TransportRequisition."Time Requested" := DT2TIME(System.CurrentDateTime);
        TransportRequisition."Date of Trip" := "Date of Trip";
        TransportRequisition."Purpose of Trip" := Purpose;
        TransportRequisition."No. Series" := 'TR';
        TransportRequisition."Responsibility Center" := ResponsibilityCenter;

        TransportRequisition."No of Days Requested" := "No of Days";
        TransportRequisition."No Of Passangers" := "No of Passengers";
        TransportRequisition.Insert;
    end;

    procedure HRTravelRequisitionCreate("Requisition No": Text; "Employee Number": Text)
    begin
        TransportRequisition.Reset;
        TransportRequisition.SetRange(TransportRequisition."Transport Requisition No", "Requisition No");
        TransportRequisition.SetRange(TransportRequisition.Status, TransportRequisition_2.Status::Open);

        if TransportRequisition.Find('-') then begin


            HRTravellingStaff.Reset;

            HRTravellingStaff.SetRange(HRTravellingStaff."Employee No", "Employee Number");
            HRTravellingStaff.SetRange(HRTravellingStaff."Req No", "Requisition No");

            if HRTravellingStaff.FindSet then
                Error('This staff member already exists for this ticket');

            HRTravellingStaff.Reset;
            HRTravellingStaff.Init;
            /*  "Employee Card".SETRANGE("Employee Card"."No.","Employee Number");

                 IF "Employee Card".FIND('-')
                 THEN
                   BEGIN
                      HRTravellingStaff."Employee Name":="Employee Card"."Names";
                      HRTravellingStaff.Position:="Employee Card"."Job Title";
                 END;
           */
            HRTravellingStaff."Req No" := "Requisition No";
            HRTravellingStaff."Employee No" := "Employee Number";
            HRTravellingStaff.Validate(HRTravellingStaff."Employee No");

            HRTravellingStaff.Insert(true);
        end
        else begin
            Error('You can only add staff to an open ticket');
        end;

    end;

    procedure HRTravellingStaffRemove("Entry Number": Integer)
    begin
        HRTravellingStaff.Reset;
        HRTravellingStaff.SetRange(HRTravellingStaff.EntryNo, "Entry Number");
        if HRTravellingStaff.FindSet then
            HRTravellingStaff.Delete;
    end;

    procedure TravelRequisitionApprovalRequest(ReqNo: Text)
    var
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        tableNo: Integer;
    begin
        TransportRequisition.Reset;
        TransportRequisition.SetRange(TransportRequisition."Transport Requisition No", ReqNo);
        if TransportRequisition.Find('-')
        then begin
            State := State::Open;
            if TransportRequisition.Status <> TransportRequisition.Status::Open then State := State::"Pending Approval";
            DocType := Doctype::TransportRequest;
            Clear(tableNo);
            tableNo := 52018055;
            // ApprovalMgt.SendApproval(tableNo,TransportRequisition."Transport Requisition No",DocType,State,TransportRequisition."Requested By",TransportRequisition."Responsibility Center");
        end;
    end;

    procedure ImprestRequisitionCreate("Employee No": Text; SchoolCode: Text; "Date Required": Date; "Campus Code": Text; "Dept Code": Text; Description: Text; ResponsibilityCenter: Code[20])
    var
        NextApplicationNo: Text;
        status: Option;
    begin
        Cashsetup.Get;
        ImprestRequisition.Init;
        NextApplicationNo := NoSeriesMgt.GetNextNo(Cashsetup."Imprest Req No", 0D, true);
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
        ImprestRequisition."Global Dimension 1 Code" := "Campus Code";

        ImprestRequisition."Shortcut Dimension 2 Code" := "Dept Code";
        ImprestRequisition.Validate(ImprestRequisition."Shortcut Dimension 2 Code");
        ImprestRequisition.Validate(ImprestRequisition."Global Dimension 1 Code");
        //ImprestRequisition."Shortcut Dimension 3 Code":=SchoolCode;
        ///ImprestRequisition.VALIDATE(ImprestRequisition."Shortcut Dimension 4 Code");
        ImprestRequisition."Account Type" := ImprestRequisition."account type"::Customer;
        ImprestRequisition."Employee No." := "Employee No";

        ImprestRequisition.Validate(ImprestRequisition."Account No.");
        ImprestRequisition."Responsibility Center" := ResponsibilityCenter;
        ImprestRequisition.Status := ImprestRequisition.Status::Pending;
        ImprestRequisition."No. Series" := Cashsetup."Imprest Req No";
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
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "Document No");
        ApprovalEntry.SetRange(ApprovalEntry."Approver ID", "Supervisor ID param");
        //mESSAGE("Supervisor ID param");
        if ApprovalEntry.Find('-') then
            ApprovalMgt.ApproveRecordApprovalRequest(ApprovalEntry.RecordId);
        //"Approvals management".ApproveApprovalRequests(ApprovalEntry);
    end;

    procedure HRStaffRequisitionCreate(EmployeeNo: Text; "Requisition Type": Option; CampusCode: Code[20]; DeptCode: Code[20]; SchoolCode: Code[20]; "Applied Days": Decimal; "Leave Type": Option; "Starting Date": Date; "End Date": Date; Purpose: Text; "Responsibility Center": Text; "Name of Beneficiary": Code[50]; "Beneficiary Reg. No": Code[50]; "Beneficiary Relationship": Code[50]; "Beneficiary Date of Birth": Date; "Beneficiary Age": Decimal; "Name of Programme": Text[30]; "School Code": Code[30]; "Duration of Study": Text; "Current Year/Semester of Study": Text; "Campus offering Programme": Text; "Total Tuition Kshs": Decimal; "Amount of waiver applied Kshs": Decimal; "First Name": Text; "Middle Name": Text; "Last Name": Text; "Postal Address": Text; "Residential Address": Text; City: Text; "Post Code": Text; County: Code[30]; "Home Phone Number": Text; "Cellular Phone Number": Text; "Work Phone Number": Text; "E-Mail": Text; Title: Text; "Marital Status": Option; Tribe: Code[50]; Religion: Text; "Satisfaction Level": Option; Motivation: Option; "Reason Motivated/Unmotivated": Text; "Reasons For Leaving": Code[10]; "Suggest Enhancement Motivation": Text; "Recommend Somebody?": Option)
    var
        NextApplicationNo: Code[20];
    begin
        HRSetup.Get;
        "HR Staff Requisition".Init;
        NextApplicationNo := NoSeriesMgt.GetNextNo(HRSetup."Staff Application Nos.", 0D, true);
        "HR Staff Requisition"."No." := NextApplicationNo;
        "HR Staff Requisition".Date := Today;
        "HR Staff Requisition"."Employee No" := EmployeeNo;
        "HR Staff Requisition"."Campus Code" := CampusCode;
        "HR Staff Requisition"."Department Code" := DeptCode;
        "HR Staff Requisition"."Applied Days" := "Applied Days";
        "HR Staff Requisition"."Starting Date" := "Starting Date";
        "HR Staff Requisition"."End Date" := "End Date";
        "HR Staff Requisition".Purpose := Purpose;
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
            // if ApprovalsMgmt.CheckItemApprovalsWorkflowEnabled(objPurchaseHeader) then
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
    begin
        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", DocumentNo);
        if ApprovalEntry.Find('-') then
            ApprovalMgt1.ApproveRecordApprovalRequest(ApprovalEntry.RecordId);
    end;

    procedure DocumentRejections("Document No": Text; "Supervisor ID param": Text)
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

    procedure HRLeaveApprovalRequest(ReqNo: Text)
    var
        State: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application",PCA,StaffMovement,"Medical Claims/General Claims","Tuition waiver","Leave Extension Requisition"," Staff Update ",Graduation,"Campus Transfer","Programme Transfer","Additional Units",Defferal,StudyMode,ExamRemark,SpecialExam,Supplimentary;
        tableNo: Integer;
    begin

        LeaveT.Reset;
        Message(ReqNo);
        LeaveT.SetRange(LeaveT."No.", ReqNo);
        if LeaveT.Find('-')
        then begin
            VarVariant := LeaveT;
            if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                CustomApprovals.OnSendDocForApproval(VarVariant);
        end;
    end;

    procedure HRJobApplicantCreate("User Name": Text)
    begin
        objHRJobApplicants.Init;
        objHRJobApplicants."User Name" := "User Name";
        objHRJobApplicants.Insert;
    end;

    procedure HRJobApplicantUpdate(UserName: Text; FirstName: Text; MiddleName: Text; LastName: Text; Initials: Text; IdNumber: Text; Gender: Integer; MaritalStatus: Integer; Age: Text; EthinicGroup: Integer)
    begin
        objHRJobApplicants.Reset;
        objHRJobApplicants.SetRange(objHRJobApplicants."User Name", UserName);

        if objHRJobApplicants.Find('-') then begin
            objHRJobApplicants."First Name" := FirstName;
            objHRJobApplicants."Middle Name" := MiddleName;
            objHRJobApplicants."Last Name" := LastName;
            objHRJobApplicants.Initials := Initials;
            objHRJobApplicants."ID Number" := IdNumber;
            objHRJobApplicants.Gender := Gender;
            objHRJobApplicants."Marital Status" := MaritalStatus;
            objHRJobApplicants."Ethnic Origin" := EthinicGroup;
            objHRJobApplicants.Age := Age;

            objHRJobApplicants.Modify;
        end;
    end;

    procedure HRJobApplicantUpdateContact("User Name": Text; "Postal Address": Text; "Residential Address": Text; City: Text; County: Text; "Home Phone Number": Text; "Cell Phone Number": Text; "Work Phone Number": Text; "E-Mail": Text; "Country Code": Text; "Fax Number": Text)
    begin
        objHRJobApplicants.Reset;
        objHRJobApplicants.SetRange(objHRJobApplicants."User Name", "User Name");

        if objHRJobApplicants.Find('-') then begin
            objHRJobApplicants."Postal Address" := "Postal Address";
            objHRJobApplicants."Residential Address" := "Residential Address";
            objHRJobApplicants.City := City;
            objHRJobApplicants.County := County;
            objHRJobApplicants."Home Phone Number" := "Home Phone Number";
            objHRJobApplicants."Cell Phone Number" := "Cell Phone Number";
            objHRJobApplicants."Work Phone Number" := "Work Phone Number";
            objHRJobApplicants."E-Mail" := "E-Mail";
            objHRJobApplicants."Country Code" := "Country Code";
            objHRJobApplicants."Fax Number" := "Fax Number";

            objHRJobApplicants.Modify;
        end;
    end;

    procedure HRJobApplication("User Name": Text; "Job Id": Text; "Requistion No": Code[50]; JobDescription: Text)
    var
        NextApplicationNo: Code[20];
    begin
        objHRJobApplication.Reset;

        objHRJobApplication.SetRange(objHRJobApplication."User Name", "User Name");
        objHRJobApplication.SetRange(objHRJobApplication."Requisition No", "Requistion No");
        if objHRJobApplication.Find('-') then begin
            Error('Sorry. You have already applied for this job');
        end;

        objHRJobApplication.Init;
        objHRJobApplication."Job Applied For" := "Job Id";
        objHRJobApplication."User Name" := "User Name";
        HRSetup.Get;
        NextApplicationNo := NoSeriesMgt.GetNextNo(HRSetup."Applicants Nos.", 0D, true);
        objHRJobApplication."Application No" := NextApplicationNo;
        objHRJobApplication."Date Applied" := Today;
        objHRJobApplicants.Reset;
        objHRJobApplicants.SetRange(objHRJobApplicants."User Name", "User Name");
        if objHRJobApplicants.Find('-') then begin
            objHRJobApplication."First Name" := objHRJobApplicants."First Name";
            objHRJobApplication."Middle Name" := objHRJobApplicants."Middle Name";
            objHRJobApplication."Last Name" := objHRJobApplicants."Last Name";
            objHRJobApplication.Initials := objHRJobApplicants.Initials;
            objHRJobApplication."ID Number" := objHRJobApplicants."ID Number";
            objHRJobApplication.Gender := objHRJobApplicants.Gender;
            objHRJobApplication."Marital Status" := objHRJobApplicants."Marital Status";
            objHRJobApplication."Ethnic Origin" := objHRJobApplicants."Ethnic Origin";
            objHRJobApplication.Age := objHRJobApplicants.Age;
            objHRJobApplication."Requisition No" := "Requistion No";
            objHRJobApplication."Job Applied for Description" := JobDescription;
            objHRJobApplication."Postal Address" := objHRJobApplicants."Postal Address";
            objHRJobApplication."Residential Address" := objHRJobApplicants."Residential Address";
            objHRJobApplication.City := objHRJobApplicants.City;
            objHRJobApplication.County := objHRJobApplicants.County;
            objHRJobApplication."Home Phone Number" := objHRJobApplicants."Home Phone Number";
            objHRJobApplication."Cell Phone Number" := objHRJobApplicants."Cell Phone Number";
            objHRJobApplication."Work Phone Number" := objHRJobApplicants."Work Phone Number";
            objHRJobApplication."E-Mail" := objHRJobApplicants."E-Mail";
            objHRJobApplication."Country Code" := objHRJobApplicants."Country Code";
            objHRJobApplication."Fax Number" := objHRJobApplicants."Fax Number";
            objHRJobApplication.Insert;
        end;
    end;

    procedure HRJobApplicantUpdateCom("User Name": Text; FirstLanguage: Code[20]; FirstLangRead: Boolean; FirstLangWrite: Boolean; FirstLangSpeak: Boolean; SecondLang: Code[20]; SecondLangRead: Boolean; SecondLangWrite: Boolean; SecondLangSpeak: Boolean)
    begin
        objHRJobApplicants.Reset;
        objHRJobApplicants.SetRange(objHRJobApplicants."User Name", "User Name");

        if objHRJobApplicants.Find('-') then begin
            objHRJobApplicants."First Language (R/W/S)" := FirstLanguage;
            objHRJobApplicants."First Language Read" := FirstLangRead;
            objHRJobApplicants."First Language Write" := FirstLangWrite;
            objHRJobApplicants."First Language Speak" := FirstLangSpeak;
            objHRJobApplicants."Second Language (R/W/S)" := SecondLang;
            objHRJobApplicants."Second Language Read" := SecondLangRead;
            objHRJobApplicants."Second Language Write" := SecondLangWrite;
            objHRJobApplicants."Second Language Speak" := SecondLangSpeak;
            objHRJobApplicants.Modify;
        end;
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

    procedure fnGetStaffNo(staff_userid: Code[50]) StaffNo: Code[100]
    begin
        "Employee Card".Reset;
        "Employee Card".SetRange("Employee Card"."User ID", staff_userid);
        if "Employee Card".Find('-')
        then begin
            StaffNo := "Employee Card"."No.";
        end;
        exit(StaffNo)
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

    procedure fnSaveHRApplicantQualificiation(ApplicationNo: Code[50]; QualificationType: Code[100]; QualificationDescription: Code[100]; Institution: Text; FromDate: Date; ToDate: Date)
    begin
        objQualifications.Init;
        objQualifications."Application No" := ApplicationNo;
        // objQualifications."Qualification Type":=QualificationType;
        objQualifications."Qualification Code" := QualificationDescription;
        objQualifications."Institution/Company" := Institution;
        objQualifications."From Date" := FromDate;
        objQualifications."To Date" := ToDate;
        objQualifications.Validate(objQualifications."Qualification Code");
        objQualifications.Insert;
    end;

    procedure fnDeleteQualification(LineNo: Code[60]; ApplicationNo: Code[50])
    begin
        objQualifications.Reset;
        objQualifications.SetRange(objQualifications."Application No", ApplicationNo);
        objQualifications.SetRange(objQualifications."Qualification Code", LineNo);

        if objQualifications.Find('-') then begin
            objQualifications.DeleteAll;
        end
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

    procedure UpdateLeaveAppStatus(DocNo: Code[20])
    begin
        LeaveT.Reset;
        LeaveT.SetRange(LeaveT."No.", DocNo);
        if LeaveT.Find('-') then
            LeaveT.Status := LeaveT.Status::Posted;
        LeaveT.Modify;
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
                //  Customer.Picture.CreateInstream(IStream);
                MemoryStream := MemoryStream.MemoryStream();
                CopyStream(MemoryStream, IStream);
                Bytes := MemoryStream.GetBuffer();
                BaseImage := Convert.ToBase64String(Bytes);
            end;
        end;
    end;

    procedure GenerateStudentReportCardTesting("Student No": Text; filenameFromApp: Text)
    var
        filename: Text;
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        Message(Format(filename));
        if Exists(filename) then
            Erase(filename);
        Customer.Reset;
        Customer.SetRange(Customer."No.", "Student No");

        if Customer.Find('-') then begin
            //REPORT.SAVEASPDF(39005900,filename,Customer);
            Report.SaveAsPdf(39005835, filename, Customer);
        end;
    end;

    procedure InsertPatient(EmployeeNo: Text; Sname: Text; Fname: Text; Mname: Text; gender: Option; Dob: Date; Marital: Option; Id: Text; Address: Text; PostalCode: Text; City: Text; Phone: Text; Email: Text; Nationality: Text; Bloodgrp: Text; NextkinName: Text; NextkinRelationship: Text; NextkinContact: Text; InsuranceNo: Text; InsuranceName: Text; InsuranceMemberNo: Text; PatientType: Option " ",Corporate,Cash; branch: Text) NewNo: Text
    begin
        HMSSetup.Get;
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", 0D, true);
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
        ObjPatient."Next Of kin Full Name" := NextkinName;
        ObjPatient."Next of kin Relationship" := NextkinRelationship;
        ObjPatient."Next Of kin Address 1" := Address;
        ObjPatient."Next Of kin Address 2" := NextkinContact;
        ObjPatient."Insurance No." := InsuranceNo;
        ObjPatient."Insurance Name" := InsuranceName;
        ObjPatient."Membership No" := InsuranceMemberNo;
        ObjPatient.Validate("Patient Ref. No.");
        ObjPatient.Validate(Surname);
        ObjPatient.Validate("Middle Name");
        ObjPatient.Validate("Last Name");
        ObjPatient."Global Dimension 1 Code" := branch;
        ObjPatient.Insert;
    end;

    procedure InsertAppointment(PatientType: Option; PatientNo: Text; EmployeeNo: Text; doctor: Text; Remark: Text; Settlement: Option; InsuranceNo: Text; InsuranceName: Text; InsMemberNo: Text) AppointmentNo: Text
    begin
        DaysBtwnTodayAndLastVisit := isLastVisitDayWithin7days(PatientNo);
        objAppointment.Init();
        HMSSetup.Get;
        AppointmentNo := NoSeriesMgt.GetNextNo(HMSSetup."Appointment Nos", 0D, true);
        objAppointment."Appointment No." := AppointmentNo;
        objAppointment."Appointment Date" := Today;
        objAppointment."Appointment Time" := DT2TIME(System.CurrentDateTime);
        if DaysBtwnTodayAndLastVisit <= 7 then
            objAppointment."Appointment Type" := 'REVIEW' else
            objAppointment."Appointment Type" := 'NORMAL';
        //objAppointment."Appointment Type" :=AppType;
        objAppointment."Patient Type" := PatientType;
        objAppointment."Patient No." := PatientNo;
        objAppointment."Employee No." := EmployeeNo;
        objAppointment.Doctor := doctor;
        objAppointment."MVC No." := Remark;
        objAppointment."No. Series" := HMSSetup."Appointment Nos";
        //IF PatientType=objAppointment."Patient Type"::Corporate THEN objAppointment."Settlement Type":=objAppointment."Settlement Type"::Credit;
        objAppointment."Settlement Type" := Settlement;
        objAppointment."Insurance No" := InsuranceNo;
        objAppointment."Insurance Name" := InsuranceName;
        objAppointment."Insurance Member No" := InsMemberNo;
        objAppointment.Insert;

        ObjPatient.Reset;
        ObjPatient.SetRange("Patient No.", PatientNo);
        if ObjPatient.Find('-') then
            ObjPatient."Active Visit No" := AppointmentNo;
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
        objNurseNote."Nurse Type" := NurseType;
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
            objPatCharges."Shortcut Dimension 1 Code" := ObjPatient."Global Dimension 1 Code";

        objPatCharges.Validate("Shortcut Dimension 1 Code");
        HMSCharges.SetRange(HMSCharges.Code, Transctioncode);
        if HMSCharges.Find('-') then begin
            objPatCharges."Transaction Type" := HMSCharges."Transaction Type";
            objPatCharges.Validate("Transaction Type");
            objPatCharges.Amount := HMSCharges.Amount;
            objPatCharges."Reccuring Type" := HMSCharges."Reccuring Type";

            objPatCharges.Date := Today;
            objPatCharges.Description := Description;
            objPatCharges.Code := Transctioncode;
            hmsPat.Reset;
            hmsPat.SetRange(hmsPat."Patient No.", PatientNo);
            if hmsPat.Find('-') then begin
                objPatCharges."Visit No" := hmsPat."Active Visit No";
                objPatCharges."Appointment No" := hmsPat."Active Visit No";
            end;


            //Amount;
            objPatCharges."Invoice ID" := TreatmentNo;

            objPatCharges."Shortcut Dimension 2 Code" := RevenueCenter;

            objPatCharges.Validate(Code);
            objPatCharges.Quantity := Quantity;
            objPatCharges.Validate(Amount);
            objPatCharges.Validate(Quantity);
            objPatCharges.Remarks := Remarks;
            objPatCharges."Doctor ID" := Doctor;
            objPatCharges.Validate("Doctor ID");
            objPatCharges.Validate("Apply to");
            objPatCharges.Validate("Invoice ID");
            objPatCharges."User ID" := staffno;

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
            objPatCharges.SetRange(objPatCharges."Visit No", hmsPat."Active Visit No");
            objPatCharges.SetRange(objPatCharges."Patient No.", PatientNo);
            objPatCharges.SetRange(objPatCharges.Code, ChargeCode);
            if objPatCharges.Find('-') then begin
                objPatCharges.Amount := Amount;
                objPatCharges.Quantity := Quantity;
                objPatCharges."Total Amount" := Amount * Quantity;
                objPatCharges.Modify;
            end;
        end;
    end;

    procedure InsertObservation(SettlementType: Option; PatientNo: Text; AppointmentNo: Text; Doctor: Text)
    var
        AppointmentType: Text;
    begin
        ObjPatient.Reset;
        ObjPatient.SetRange(ObjPatient."Patient No.", PatientNo);
        if ObjPatient.Find('-') then begin
            ObjPatient.Activated := true;
            ObjPatient.Modify;
        end;

        objAppointment.SetRange(objAppointment."Appointment No.", AppointmentNo);
        if objAppointment.Find('-')
          then
            AppointmentType := objAppointment."Appointment Type";

        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);
        if SettlementType = 2 then
            testfields(objAppointment."Insurance Member No");

        //LabHeader.RESET;
        ObservHeader.Init;
        ObservHeader."Observation No." := NewNo;
        ObservHeader."Patient No." := PatientNo;
        ObservHeader."Observation Date" := Today;
        ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
        //ObservHeader."Request Area"::Doctor;
        ObservHeader.Doctor := Doctor;
        ObservHeader."Link Type" := 'Observation';
        ObservHeader."Link No." := AppointmentNo;
        ObservHeader.Insert;


        /* IF AppType.GET(AppointmentType) THEN BEGIN
          DoctorsRec.RESET;
          DoctorsRec.SETRANGE(DoctorsRec."Doctor ID",Doctor);
          IF DoctorsRec.FIND('-') THEN
          DoctorsRec.TESTFIELD("Consultation Code");
          HMSPatientsCharges.INIT;
          HMSPatientsCharges."Line No":=1;
          HMSPatientsCharges."Patient No."   :=PatientNo;
          HMSPatientsCharges."Link No":=NewNo;
          HMSPatientsCharges."Treatment No.":=NewNo;
          HMSPatientCharges."Transaction Type" :='DOCTORS FEES';
          HMSPatientCharges.VALIDATE("Transaction Type");
          HMSPatientsCharges."Appointment No.":=AppointmentNo;
          HMSPatientsCharges.Code:=DoctorsRec."Consultation Code";
          HMSPatientsCharges.Description:=DoctorsRec."Consultation Code"+' - '+DoctorsRec."Doctor ID";
          HMSCharges.GET(DoctorsRec."Consultation Code");
          HMSPatientsCharges.Amount:=HMSCharges.Amount;
          HMSPatientCharges.VALIDATE(Amount);
          HMSPatientsCharges.Date:=TODAY;
          HMSPatientsCharges."Shortcut Dimension 1 Code":= HMSCharges."Shortcut Dimension 1 Code";
          HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
          HMSPatientsCharges."Bill Section":=HMSPatientsCharges."Bill Section"::Appointment;
          HMSPatientsCharges."Doctor ID" := DoctorsRec."Doctor ID";
          HMSPatientsCharges.INSERT;
         END;*/
        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Link No" := NewNo;
            objAppointment.Modify;
        end;

    end;

    procedure InsertObservationSigns(Treatmentno: Text; SignCode: Text; System: Text; Description: Text)
    begin
        ObjSigns.Reset;
        ObjSigns.SetRange("Treatment No.", Treatmentno);
        ObjSigns.SetRange(System, System);
        if ObjSigns.Find('-') then
            ObjSigns.Delete;
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
        ObjLab."Brief History" := BriefHistory;
        ObjLab.Insert;
    end;

    procedure InsertTreatTheatre(TreatmetNo: Text; ProcessNo: Text; ProcessName: Text; Remarks: Text; Doctor: Text; Anaesthesist: Text; TheatreTime: Time; TheatreProcedure: Option)
    begin
        ObjTheatre.Init;
        ObjTheatre."Treatment No." := TreatmetNo;
        ObjTheatre."Process No." := ProcessNo;
        ObjTheatre."Process Name" := ProcessName;
        ObjTheatre."Process Mandatory" := true;
        ObjTheatre."Process Remarks" := Remarks;
        ObjTheatre."Procedure" := TheatreProcedure;
        ObjTheatre.Doctor := Doctor;
        ObjTheatre."Theatre Date" := Today;
        ObjTheatre."Theatre Time" := TheatreTime;
        ObjTheatre.Anaesthesist := Anaesthesist;
        ObjTheatre.Status := ObjTheatre.Status::New;
        ObjTheatre.Insert;
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
        docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
        docHeader."Doctor ID" := Doctor;
        docHeader."Patient No." := PatientNo;

        //docHeader."Student No.":="Student No.";
        //docHeader."Employee No.":="Employee No.";
        //docHeader."Relative No.":="Relative No.";
        docHeader.Direct := true;
        docHeader."Link No." := AppointmentNo;
        docHeader."Triage Notes" := TriageNotes;
        docHeader.Clinic := docHeader.Clinic;
        ObjPatient.Reset;
        ObjPatient.SetRange("Patient No.", PatientNo);
        if ObjPatient.Find('-') then
            docHeader.Branch := ObjPatient."Global Dimension 1 Code";
        //:=LabHeader."Request Area"::Doctor;
        docHeader."Link Type" := 'Outpatient';
        // docHeader."Link No.":=TreatmentHeader."Appointment No.";
        docHeader.Insert;
        //END;
        ObsLine.Reset;
        ObsLine.SetRange(ObsLine."Observation No.", ObservationNo);
        ObsLine.SetRange(ObsLine.Type, ObsLine.Type::Triage);
        if ObsLine.Find('-') then begin
            repeat
                TreatmentLine.Init;
                TreatmentLine."Treatment No." := NewNo;
                TreatmentLine.Type := TreatmentLine.Type::Triage;
                TreatmentLine."Patient No." := ObsLine."Patient No.";
                TreatmentLine.Validate("Patient No.");
                TreatmentLine.Pain := ObsLine.Pain;
                TreatmentLine."Pulse Rate" := ObsLine."Pulse Rate";
                TreatmentLine."Blood Pressure" := ObsLine."Blood Pressure";
                TreatmentLine.Temperature := ObsLine.Temperature;
                TreatmentLine.Height := ObsLine.Height;
                TreatmentLine.Weight := ObsLine.Weight;
                TreatmentLine.BMI := ObsLine.BMI;
                TreatmentLine.SP02 := ObsLine.SP02;
                TreatmentLine."Respiration Rate" := ObsLine."Respiration Rate";
                TreatmentLine."Date Created" := ObsLine."Date Created";
                TreatmentLine."Date Taken" := ObsLine."Date Taken";
                TreatmentLine.Time := ObsLine.Time;
                TreatmentLine.Insert;
            until ObsLine.Next = 0;
        end;
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
        HMSQue.Time := DT2TIME(System.CurrentDateTime);
        HMSQue.Insert;

        if AppType.Get(AppointmentType) then begin
            DoctorsRec.Reset;
            DoctorsRec.SetRange(DoctorsRec."Doctor ID", Doctor);
            if DoctorsRec.Find('-') then
                DoctorsRec.TestField("Consultation Code");
            HMSPatientsCharges.Reset;
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Appointment No.", AppointmentNo);
            if HMSPatientsCharges.Find('-') then begin
                repeat
                    HMSPatientsCharges.Validate(HMSPatientsCharges."Transaction Type");
                    HMSPatientsCharges."Doctor ID" := Doctor;
                    HMSPatientsCharges.Date := Today;
                    HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Appointment;
                    HMSPatientsCharges.Modify;

                until HMSPatientsCharges.Next = 0;
            end;
        end;
        ObservHeader.SetRange(ObservHeader."Link No.", AppointmentNo);
        if ObservHeader.Find('-') then begin
            //ObservHeader.Status:= ObservHeader.Status::Closed;
            //ObservHeader."Treatment No":=NewNo;
            ObservHeader.Closed := true;
            ObservHeader.Modify;
        end;

        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
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
        docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
        docHeader."Doctor ID" := Doctor;
        docHeader."Patient No." := PatientNo;
        //docHeader."Student No.":="Student No.";
        //docHeader."Employee No.":="Employee No.";
        //docHeader."Relative No.":="Relative No.";
        docHeader.Direct := true;
        docHeader."Link No." := AppointmentNo;
        docHeader."Triage Notes" := TriageNotes;
        docHeader.Clinic := docHeader.Clinic;
        ObjPatient.Reset;
        ObjPatient.SetRange("Patient No.", PatientNo);
        if ObjPatient.Find('-') then
            docHeader.Branch := ObjPatient."Global Dimension 1 Code";
        //:=LabHeader."Request Area"::Doctor;
        docHeader."Link Type" := 'Outpatient';
        // docHeader."Link No.":=TreatmentHeader."Appointment No.";
        docHeader.Insert;
        //END;
        ObsLine.Reset;
        ObsLine.SetRange(ObsLine."Observation No.", ObservationNo);
        ObsLine.SetRange(ObsLine.Type, ObsLine.Type::Triage);
        if ObsLine.Find('-') then begin
            repeat
                TreatmentLine.Init;
                TreatmentLine."Treatment No." := NewNo;
                TreatmentLine.Type := TreatmentLine.Type::Triage;
                TreatmentLine."Patient No." := ObsLine."Patient No.";
                TreatmentLine.Validate("Patient No.");
                TreatmentLine.Pain := ObsLine.Pain;
                TreatmentLine."Pulse Rate" := ObsLine."Pulse Rate";
                TreatmentLine."Blood Pressure" := ObsLine."Blood Pressure";
                TreatmentLine.Temperature := ObsLine.Temperature;
                TreatmentLine.Height := ObsLine.Height;
                TreatmentLine.Weight := ObsLine.Weight;
                TreatmentLine.BMI := ObsLine.BMI;
                TreatmentLine.SP02 := ObsLine.SP02;
                TreatmentLine."Respiration Rate" := ObsLine."Respiration Rate";
                TreatmentLine."Date Created" := ObsLine."Date Created";
                TreatmentLine."Date Taken" := ObsLine."Date Taken";
                TreatmentLine.Time := ObsLine.Time;
                TreatmentLine.Insert;
            until ObsLine.Next = 0;
        end;
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
        HMSQue.Time := DT2TIME(System.CurrentDateTime);
        HMSQue.Insert;

        if AppType.Get(AppointmentType) then begin
            DoctorsRec.Reset;
            DoctorsRec.SetRange(DoctorsRec."Doctor ID", Doctor);
            if DoctorsRec.Find('-') then
                DoctorsRec.TestField("Consultation Code");
            HMSPatientsCharges.Reset;
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Appointment No.", AppointmentNo);
            if HMSPatientsCharges.Find('-') then begin
                repeat
                    HMSPatientsCharges.Validate(HMSPatientsCharges."Transaction Type");
                    HMSPatientsCharges."Doctor ID" := Doctor;
                    HMSPatientsCharges.Date := Today;
                    HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Appointment;
                    HMSPatientsCharges.Modify;

                until HMSPatientsCharges.Next = 0;
            end;
        end;
        ObservHeader.SetRange(ObservHeader."Link No.", AppointmentNo);
        if ObservHeader.Find('-') then begin
            //ObservHeader.Status:= ObservHeader.Status::Closed;
            //ObservHeader.Closed :=TRUE;
            ObservHeader."Treatment No" := NewNo;
            ObservHeader.Modify;
        end;

        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
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
        docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
        docHeader."Doctor ID" := Doctor;
        docHeader."Patient No." := PatientNo;
        //docHeader."Student No.":="Student No.";
        //docHeader."Employee No.":="Employee No.";
        //docHeader."Relative No.":="Relative No.";
        docHeader.Direct := true;
        docHeader."Link No." := AppointmentNo;
        docHeader."Triage Notes" := TriageNotes;
        docHeader.Clinic := docHeader.Clinic;
        ObjPatient.Reset;
        ObjPatient.SetRange("Patient No.", PatientNo);
        if ObjPatient.Find('-') then
            docHeader.Branch := ObjPatient."Global Dimension 1 Code";
        //:=LabHeader."Request Area"::Doctor;
        docHeader."Link Type" := 'Outpatient';
        // docHeader."Link No.":=TreatmentHeader."Appointment No.";
        docHeader.Insert;
        //END;
        ObsLine.Reset;
        ObsLine.SetRange(ObsLine."Observation No.", ObservationNo);
        ObsLine.SetRange(ObsLine.Type, ObsLine.Type::Triage);
        if ObsLine.Find('-') then begin
            repeat
                TreatmentLine.Init;
                TreatmentLine."Treatment No." := NewNo;
                TreatmentLine.Type := TreatmentLine.Type::Triage;
                TreatmentLine."Patient No." := ObsLine."Patient No.";
                TreatmentLine.Validate("Patient No.");
                TreatmentLine.Pain := ObsLine.Pain;
                TreatmentLine."Pulse Rate" := ObsLine."Pulse Rate";
                TreatmentLine."Blood Pressure" := ObsLine."Blood Pressure";
                TreatmentLine.Temperature := ObsLine.Temperature;
                TreatmentLine.Height := ObsLine.Height;
                TreatmentLine.Weight := ObsLine.Weight;
                TreatmentLine.BMI := ObsLine.BMI;
                TreatmentLine.SP02 := ObsLine.SP02;
                TreatmentLine."Respiration Rate" := ObsLine."Respiration Rate";
                TreatmentLine."Date Created" := ObsLine."Date Created";
                TreatmentLine."Date Taken" := ObsLine."Date Taken";
                TreatmentLine.Time := ObsLine.Time;
                TreatmentLine.Insert;
            until ObsLine.Next = 0;
        end;
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
        HMSQue.Time := DT2TIME(System.CurrentDateTime);
        HMSQue.Insert;

        if AppType.Get(AppointmentType) then begin
            DoctorsRec.Reset;
            DoctorsRec.SetRange(DoctorsRec."Doctor ID", Doctor);
            if DoctorsRec.Find('-') then
                DoctorsRec.TestField("Consultation Code");
            HMSPatientsCharges.Reset;
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
            HMSPatientsCharges.SetRange(HMSPatientsCharges."Appointment No.", AppointmentNo);
            if HMSPatientsCharges.Find('-') then begin
                repeat
                    HMSPatientsCharges.Validate(HMSPatientsCharges."Transaction Type");
                    HMSPatientsCharges."Doctor ID" := Doctor;
                    HMSPatientsCharges.Date := Today;
                    HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Appointment;
                    HMSPatientsCharges.Modify;

                until HMSPatientsCharges.Next = 0;
            end;
        end;
        ObservHeader.SetRange(ObservHeader."Link No.", AppointmentNo);
        if ObservHeader.Find('-') then begin
            //ObservHeader.Status:= ObservHeader.Status::Closed;
            //ObservHeader.Closed :=TRUE;
            ObservHeader."Treatment No" := NewNo;
            ObservHeader.Modify;
        end;

        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
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
        docHeader.SetRange("Link No.", AppointmentNo);
        if docHeader.Find('-') then
            LabHeader.Reset;
        LabHeader.Init;
        LabHeader."Laboratory No." := NewNo;
        LabHeader."Laboratory Date" := Today;
        LabHeader."Laboratory Time" := DT2TIME(System.CurrentDateTime);
        LabHeader."Patient No." := TreatmentHeader."Patient No.";
        LabHeader."Link No." := docHeader."Treatment No.";
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
            objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
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
        RadiologyHeader."Radiology Time" := DT2TIME(System.CurrentDateTime);
        RadiologyHeader."Radiology Area" := RadiologyHeader."radiology area"::Doctor;
        RadiologyHeader."Patient No." := PatientNo;
        ObjPatient.SetRange(ObjPatient."Patient No.", PatientNo);
        if ObjPatient.Find('-') then
            RadiologyHeader."Link No." := AppointmentNo;
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
            objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
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
            PharmHeader."Pharmacy Time" := DT2TIME(System.CurrentDateTime);
            PharmHeader."Request Area" := PharmHeader."request area"::Doctor;
            PharmHeader."Patient No." := TreatmentHeader."Patient No.";
            PharmHeader."Student No." := TreatmentHeader."Student No.";
            PharmHeader."Employee No." := TreatmentHeader."Employee No.";
            PharmHeader."Relative No." := TreatmentHeader."Relative No.";
            PharmHeader."Pharmacy Type" := PharmHeader."Pharmacy Type"::Outpatient;
            PharmHeader."Link Type" := 'Appointment';
            PharmHeader."Link No." := TreatmentHeader."Appointment No.";
            PharmHeader.Insert();

            objAppointment.SetRange("Appointment No.", AppointmentNo);
            if objAppointment.Find('-') then begin
                objAppointment."Dispatch To" := objAppointment."dispatch to";
                objAppointment."Dispatch Date" := Today;
                objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
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
        objAppointment.Reset;
        objAppointment.SetRange(objAppointment."Appointment No.", AppointmentNo);
        if objAppointment.Find('-')
          then
            AppointmentType := objAppointment."Appointment Type";

        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);
        TreatmentHeader.Reset;
        TreatmentHeader.Get(AppointmentNo);
        LabHeader.Reset;
        LabHeader.Init;
        PhysioHeader."No." := NewNo;
        PhysioHeader."Physio Date" := Today;
        PhysioHeader."Physio Time" := DT2TIME(System.CurrentDateTime);
        PhysioHeader."Patient No." := TreatmentHeader."Patient No.";
        PhysioHeader."Link Type" := 'Observation';
        PhysioHeader."Link No." := TreatmentHeader."Appointment No.";
        PhysioHeader.Insert;


        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
            objAppointment.Status := objAppointment.Status::Dispatched;

            objAppointment.Modify;
        end;
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
            docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
            docHeader."Doctor ID" := Doctor;
            docHeader."Treatment Type" := docHeader."treatment type"::Inpatient;
            docHeader."Patient No." := PatientNo;
            docHeader.Direct := true;
            docHeader."Link No." := AppointmentNo;
            ObjPatient.Reset;
            ObjPatient.SetRange("Patient No.", PatientNo);
            if ObjPatient.Find('-') then
                docHeader.Branch := ObjPatient."Global Dimension 1 Code";
            //:=LabHeader."Request Area"::Doctor;
            docHeader."Link Type" := 'InPatient';
            //      docHeader."Link No.":=TreatmentHeader."Appointment No.";
            docHeader.Insert;
        end;
        if AppType.Get(AppointmentType) then begin
            DoctorsRec.Reset;
            DoctorsRec.SetRange(DoctorsRec."Doctor ID", Doctor);
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
            objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
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
            AdmissionHeader."Admission Time" := DT2TIME(System.CurrentDateTime);
            AdmissionHeader."Admission Area" := AdmissionHeader."admission area"::Referral;
            AdmissionHeader."Patient No." := PatientNo;
            AdmissionHeader.Doctor := Doctor;
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
        ObjObservInjection."Injection Time" := DT2TIME(System.CurrentDateTime);
        //ObjObservInjection."Injection Remarks" :=Remarks;
        //ObjObservInjection."Item No.":=ItemNo;
        ObjObservInjection.Quantity := Quantity;
        ObjObservInjection."Injection Name" := InjectionName;
        ObjObservInjection.Insert;
    end;

    procedure InsertObservationProcess(ObservationNo: Text; PatientNo: Text; Pain: Decimal; PulseRate: Text; BloodPressure: Text; Temperature: Decimal; Height: Decimal; Weight: Decimal; SP02: Text; RespirationRate: Text)
    begin

        ObservProcess.Init;
        ObservProcess."Observation No." := ObservationNo;
        ObservProcess.Type := TreatmentLine.Type::Triage;
        ObservProcess."Patient No." := PatientNo;
        ObservProcess.Validate("Patient No.");
        ObservProcess.Pain := Pain;
        ObservProcess."Pulse Rate" := PulseRate;
        ObservProcess."Blood Pressure" := BloodPressure;
        ObservProcess.Temperature := Temperature;
        ObservProcess.Height := Height;
        ObservProcess.Weight := Weight;
        ObservProcess.Validate(Height);
        ObservProcess.Validate(Weight);
        ObservProcess.SP02 := SP02;
        ObservProcess."Respiration Rate" := RespirationRate;
        ObservProcess."Date Created" := CurrentDatetime;
        ObservProcess."Date Taken" := Today;
        ObservProcess.Time := DT2TIME(System.CurrentDateTime);
        ObservProcess.Insert;

        IF ObjPatient.GET(PatientNo) THEN
            objAppointment.RESET;
        objAppointment.SETRANGE("Appointment No.", ObjPatient."Active Visit No");
        IF objAppointment.FIND('-') THEN BEGIN
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Triage Time out" := CURRENTDATETIME;
            objAppointment."Doctor Time In" := CURRENTDATETIME;
            objAppointment.MODIFY;
        END;
    end;

    procedure ModifyObservationProcess(ObservationNo: Text; PatientNo: Text; Pain: Decimal; PulseRate: Text; BloodPressure: Text; Temperature: Decimal; Height: Decimal; Weight: Decimal; SP02: Text; RespirationRate: Text)
    begin
        ObservProcess.Reset;
        ObservProcess.SetRange("Observation No.", ObservationNo);
        ObservProcess.SetRange("Line No", LineNo);
        if ObservProcess.Find('-') then begin

            ObservProcess.Init;
            ObservProcess."Observation No." := ObservationNo;
            ObservProcess.Type := TreatmentLine.Type::Triage;
            ObservProcess."Patient No." := PatientNo;
            ObservProcess.Validate("Patient No.");
            ObservProcess.Pain := Pain;
            ObservProcess."Pulse Rate" := PulseRate;
            ObservProcess."Blood Pressure" := BloodPressure;
            ObservProcess.Temperature := Temperature;
            ObservProcess.Height := Height;
            ObservProcess.Weight := Weight;
            ObservProcess.Validate(Height);
            ObservProcess.Validate(Weight);
            ObservProcess.SP02 := SP02;
            ObservProcess."Respiration Rate" := RespirationRate;
            ObservProcess."Date Created" := CurrentDatetime;
            ObservProcess."Date Taken" := Today;
            ObservProcess.Time := DT2TIME(System.CurrentDateTime);
            ObservProcess.Modify;
        end;
    end;

    procedure InsertObservationProcessDoc(TreatmentNo: Text; PatientNo: Text; Pain: Decimal; PulseRate: Text; BloodPressure: Text; Temperature: Decimal; Height: Decimal; Weight: Decimal; SP02: Text; RespirationRate: Text)
    begin


        TreatmentLine.Init;
        TreatmentLine."Treatment No." := TreatmentNo;
        TreatmentLine.Type := TreatmentLine.Type::Doctor;
        TreatmentLine."Patient No." := PatientNo;
        TreatmentLine.Validate("Patient No.");
        TreatmentLine.Pain := Pain;
        TreatmentLine."Pulse Rate" := PulseRate;
        TreatmentLine."Blood Pressure" := BloodPressure;
        TreatmentLine.Temperature := Temperature;
        TreatmentLine.Height := Height;
        TreatmentLine.Weight := Weight;
        TreatmentLine.Validate(Height);
        TreatmentLine.Validate(Weight);
        TreatmentLine.SP02 := SP02;
        TreatmentLine."Respiration Rate" := RespirationRate;
        TreatmentLine."Date Created" := CurrentDatetime;
        TreatmentLine."Date Taken" := Today;
        TreatmentLine.Time := DT2TIME(System.CurrentDateTime);
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
        if docHeader.Find('-') then begin
            docHeader."Triage Notes" := Notes + Remarks;
            docHeader.Modify;
        end;
    end;

    procedure InsertICULines(TreatmentNo: Text; ProcessNo: Text; ProcessName: Text; Mandatory: Boolean; Remarks: Text)
    begin
        ObjICULines.Init;
        ObjICULines."No." := TreatmentNo;
        ObjICULines."Process No." := ProcessNo;
        ObjICULines."Process Name" := ProcessName;
        ObjICULines."Process Mandatory" := Mandatory;
        ObjICULines."Process Remarks" := Remarks;
        ObjICULines.Insert;
    end;

    procedure InsertDiagnosis(TreamentNo: Text; DiagnosisNo: Text; Confirmed: Boolean; PatientNo: Text; Doctor: Text; Remarks: Text; DiagnosisType: Option; DifferentialDiagnosis: Text)
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
        ObjDiagnosis.Remarks := DifferentialDiagnosis;
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
        ObjPrescription."Pharmacy Type" := ObjPrescription."pharmacy type"::Outpatient;
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
        ObjReferral.Init;
        ObjReferral."Treatment No." := TreatmentNo;
        ObjReferral."Hospital No." := HospitalNo;
        ObjReferral."Hospital Name" := HospitalName;
        ObjReferral."Date Referred" := Today;
        ObjReferral."Referral Reason" := Reason;
        ObjReferral."Referral Remarks" := Remarks;
        ObjReferral.Status := ObjReferral.Status::Referred;
        ObjReferral."Clinical History & Treatment" := ClinicalHistory;
        ObjReferral."Findings on Exam & Investigtn" := FindingsonExam;
        ObjReferral.Insert;
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
            docHeader."Color Code" := 2;
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
                    objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
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
                ObservHeader."Treatment No" := TreatmentNo;
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
        TreatmentLine.Reset;
        TreatmentLine.SetRange(TreatmentLine."Treatment No.", TreatmentNo);
        if TreatmentLine.Find('-') then
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
                PharmHeader."Pharmacy Time" := DT2TIME(System.CurrentDateTime);
                PharmHeader."Request Area" := PharmHeader."request area"::Doctor;
                PharmHeader."Patient No." := TreatmentHeader."Patient No.";
                PharmHeader."Student No." := TreatmentHeader."Student No.";
                PharmHeader."Employee No." := TreatmentHeader."Employee No.";
                PharmHeader."Relative No." := TreatmentHeader."Relative No.";
                PharmHeader."ADM No" := TreatmentHeader."Adm No.";
                PharmHeader."Pharmacy Type" := PharmHeader."Pharmacy Type"::Outpatient;
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
                objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                objAppointment.Status := objAppointment.Status::Dispatched;
                objAppointment."Waiting At" := objAppointment."waiting at";
                objAppointment."Doctor Time Out" := CurrentDatetime;
                objAppointment."Pharmacy Time In" := CurrentDatetime;

                objAppointment.Modify;
            end;
        end;

    end;

    procedure PrescribeDrugsDocInpatient(TreatmentNo: Code[20])
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Drug";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
    begin
        TreatmentLine.Reset;
        TreatmentLine.SetRange(TreatmentLine."Treatment No.", TreatmentNo);
        TreatmentLine.SetRange(TreatmentLine."IP Status", TreatmentLine."ip status"::Ongoing);
        if TreatmentLine.Find('-') then begin
            HMSSetup.Reset;
            HMSSetup.Get();
            AdmissionHeader.Reset;
            AdmissionHeader.SetRange("Link No.", TreatmentNo);
            if AdmissionHeader.Find('-') then
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
                    PharmHeader."Pharmacy Time" := DT2TIME(System.CurrentDateTime);
                    PharmHeader."Request Area" := PharmHeader."request area"::Doctor;
                    PharmHeader."Patient No." := TreatmentHeader."Patient No.";
                    PharmHeader."Student No." := TreatmentHeader."Student No.";
                    PharmHeader."Employee No." := TreatmentHeader."Employee No.";
                    PharmHeader."Relative No." := TreatmentHeader."Relative No.";
                    PharmHeader."ADM No" := AdmissionHeader."Admission No.";
                    PharmHeader."Link Type" := 'Doctor';
                    PharmHeader."Link No." := TreatmentHeader."Link No.";
                    PharmHeader."Treatment No." := TreatmentNo;
                    PharmHeader.Insert();
                end;
                TreatmentLine.Reset;
                TreatmentLine.SetRange(TreatmentLine."Treatment No.", TreatmentNo);
                TreatmentLine.SetRange(TreatmentLine."IP Status", TreatmentLine."ip status"::Ongoing);
                TreatmentLine.SetFilter(TreatmentLine."Sent Date", '<>%1', Today);
                if TreatmentLine.Find('-') then begin
                    repeat

                        PharmacyLine.Reset;
                        PharmacyLine.SetRange(PharmacyLine."No.", TreatmentLine."Drug No.");
                        PharmacyLine.SetRange(PharmacyLine."Pharmacy No.", NewNo);
                        if PharmacyLine.Find('-') then begin

                        end else begin
                            if TreatmentLine."Remaining Days" <> 0 then begin
                                PharmLine.Init;
                                PharmLine."Pharmacy No." := NewNo;
                                PharmLine."No." := TreatmentLine."Drug No.";
                                PharmLine.Validate("No.");
                                PharmLine.Quantity := TreatmentLine.Frequency;
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
                                TreatmentLine."Remaining Days" := TreatmentLine."Remaining Days" - 1;
                                TreatmentLine."Sent Date" := Today;
                                TreatmentLine.Modify;

                            end;
                        end;
                    until TreatmentLine.Next = 0;
                end;

            end;
        end;

    end;

    procedure PrescribeDrugsDocInpatientSelected(TreatmentNo: Code[20]; DrugNo: Code[20])
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Drug";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
    begin
        TreatmentLine.Reset;
        TreatmentLine.SetRange(TreatmentLine."Treatment No.", TreatmentNo);
        TreatmentLine.SetRange(TreatmentLine."IP Status", TreatmentLine."ip status"::Ongoing);
        TreatmentLine.SetRange(TreatmentLine."Drug No.", DrugNo);
        if TreatmentLine.Find('-') then begin
            HMSSetup.Reset;
            HMSSetup.Get();
            AdmissionHeader.Reset;
            AdmissionHeader.SetRange("Link No.", TreatmentNo);
            if AdmissionHeader.Find('-') then
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
                    PharmHeader."Pharmacy Time" := DT2TIME(System.CurrentDateTime);
                    PharmHeader."Request Area" := PharmHeader."request area"::Doctor;
                    PharmHeader."Patient No." := TreatmentHeader."Patient No.";
                    PharmHeader."Student No." := TreatmentHeader."Student No.";
                    PharmHeader."Employee No." := TreatmentHeader."Employee No.";
                    PharmHeader."Relative No." := TreatmentHeader."Relative No.";
                    PharmHeader."ADM No" := AdmissionHeader."Admission No.";
                    PharmHeader."Link Type" := 'Doctor';
                    PharmHeader."Link No." := TreatmentHeader."Link No.";
                    PharmHeader."Treatment No." := TreatmentNo;
                    PharmHeader.Insert();
                end;
                TreatmentLine.Reset;
                TreatmentLine.SetRange(TreatmentLine."Treatment No.", TreatmentNo);
                TreatmentLine.SetRange(TreatmentLine."IP Status", TreatmentLine."ip status"::Ongoing);
                TreatmentLine.SetRange(TreatmentLine."Drug No.", DrugNo);
                if TreatmentLine.Find('-') then begin
                    repeat

                        PharmacyLine.Reset;
                        PharmacyLine.SetRange(PharmacyLine."No.", TreatmentLine."Drug No.");
                        PharmacyLine.SetRange(PharmacyLine."Pharmacy No.", NewNo);
                        if PharmacyLine.Find('-') then begin

                        end else begin
                            if TreatmentLine."Remaining Days" <> 0 then begin
                                PharmLine.Init;
                                PharmLine."Pharmacy No." := NewNo;
                                PharmLine."No." := TreatmentLine."Drug No.";
                                PharmLine.Validate("No.");
                                PharmLine.Quantity := TreatmentLine.Frequency;
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
                                TreatmentLine."Remaining Days" := TreatmentLine."Remaining Days" - 1;
                                TreatmentLine."Sent Date" := Today;
                                TreatmentLine.Modify;

                            end;
                        end;
                    until TreatmentLine.Next = 0;
                end;

            end;
        end;

    end;

    procedure PrescribeDrugsDischarge(TreatmentNo: Code[20])
    var
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NewNo: Code[20];
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Drug";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
    begin
        TreatmentLine.Reset;
        TreatmentLine.SetRange(TreatmentLine."Treatment No.", TreatmentNo);
        TreatmentLine.SetRange(TreatmentLine."Pharmacy Type", TreatmentLine."pharmacy type"::Discharge);
        if TreatmentLine.Find('-') then
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
                PharmHeader."Pharmacy Time" := DT2TIME(System.CurrentDateTime);
                PharmHeader."Request Area" := PharmHeader."request area"::Doctor;
                PharmHeader."Patient No." := TreatmentHeader."Patient No.";
                PharmHeader."Student No." := TreatmentHeader."Student No.";
                PharmHeader."Employee No." := TreatmentHeader."Employee No.";
                PharmHeader."Relative No." := TreatmentHeader."Relative No.";
                PharmHeader."ADM No" := TreatmentHeader."Adm No.";
                PharmHeader."Link Type" := 'Doctor';
                PharmHeader."Link No." := TreatmentHeader."Link No.";
                PharmHeader."Pharmacy Type" := PharmHeader."pharmacy type"::Discharge;
                PharmHeader."Treatment No." := TreatmentNo;
                PharmHeader.Insert();
            end;
            TreatmentLine.Reset;
            TreatmentLine.SetRange(TreatmentLine."Treatment No.", TreatmentNo);
            TreatmentLine.SetRange(TreatmentLine.Status, TreatmentLine.Status::New);
            TreatmentLine.SetRange(TreatmentLine."Pharmacy Type", TreatmentLine."pharmacy type"::Discharge);
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

        if TreatmentHeader.get(TreatmentNo) then
            Patient.get(TreatmentHeader."Patient No.");

        AdmissionHeader.Reset;
        AdmissionHeader.SetRange("Link No.", Patient."Active Visit No");
        if AdmissionHeader.Find('-') then begin

        end else begin
            HMSSetup.Reset;
            HMSSetup.Get();
            NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Admission Request Nos", 0D, true);

            TreatmentHeader.Reset;
            if TreatmentHeader.Get(TreatmentNo) then begin
                Patient.Reset;
                Patient.SetRange(Patient."Patient No.", TreatmentHeader."Patient No.");
                Patient.SetRange(Patient.Inpatient, true);
                if Patient.Find('-') then Error('The patient is in the wards currently no need to re-admit');


                AdmissionHeader.Init;
                AdmissionHeader."Admission No." := NewNo;
                AdmissionHeader."Admission Date" := Today;
                AdmissionHeader."Admission Time" := DT2TIME(System.CurrentDateTime);
                AdmissionHeader."Admission Area" := AdmissionHeader."admission area"::Doctor;
                AdmissionHeader."Patient No." := TreatmentHeader."Patient No.";
                AdmissionHeader.validate("Patient No.");
                AdmissionHeader."Employee No." := TreatmentHeader."Treatment No.";
                AdmissionHeader."Relative No." := TreatmentHeader."Relative No.";
                // AdmissionHeader.Ward:="Ward No.";
                //  AdmissionHeader.Bed:="Bed No.";
                AdmissionHeader.Doctor := TreatmentHeader."Doctor ID";
                //  AdmissionHeader.Remarks:="Admission Remarks";
                //  AdmissionHeader."Admission Reason":="Admission Reason";
                AdmissionHeader."Student No." := TreatmentHeader."Student No.";
                AdmissionHeader."Link Type" := 'Doctor';
                AdmissionHeader."Link No." := TreatmentHeader."Treatment No.";
                AdmissionHeader."Appointment No." := Patient."Active Visit No";

                AdmissionHeader.Insert();
                Message('The Admission Request has been sent');
            end;
        end;
    end;

    PROCEDURE RequestLab(TreatmentNo: Code[20]; Dept: Text[20]; Inpatient: Boolean);
    VAR
        LabHeader: Record "HMS Laboratory Form Header";
        LabLine: Record "HMS Laboratory Test Line";
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Laboratory";
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
        PatRec: Record "HMS Patient";
    BEGIN
        HMSSetup.RESET;
        HMSSetup.GET();

        TreatmentHeader.RESET;
        TreatmentHeader.GET(TreatmentNo);
        PatRec.get(TreatmentHeader."Patient No.");
        LabHeader.RESET;
        LabHeader.SETRANGE(LabHeader."Patient No.", TreatmentHeader."Patient No.");
        LabHeader.SETRANGE(LabHeader."Laboratory Date", TODAY);
        LabHeader.SETRANGE(LabHeader.Status, LabHeader.Status::New);
        LabHeader.SETRANGE(LabHeader.Inpatient, false);
        IF LabHeader.FIND('-') THEN BEGIN
            NewNo := LabHeader."Laboratory No.";
        END ELSE BEGIN
            NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Lab Test Request Nos", 0D, TRUE);
            LabHeader.INIT;
            LabHeader."Laboratory No." := NewNo;
            LabHeader."Laboratory Date" := TODAY;
            LabHeader."Laboratory Time" := TIME;
            LabHeader."Patient No." := TreatmentHeader."Patient No.";
            LabHeader."Request Area" := LabHeader."Request Area"::Doctor;
            LabHeader.Type := Dept;
            LabHeader."Link Type" := 'Treatment';
            LabHeader."Link No." := PatRec."Active Visit No";
            LabHeader."Doctor ID" := TreatmentHeader."Doctor ID";
            LabHeader."Treatment No" := TreatmentNo;
            LabHeader.Inpatient := Inpatient;
            LabHeader.INSERT;

            Patient.GET(LabHeader."Patient No.");
            HMSQue.INIT;
            HMSQue."Patient No" := LabHeader."Patient No.";
            HMSQue."Visit No" := Patient."Active Visit No";
            HMSQue."Document No" := LabHeader."Laboratory No.";
            HMSQue.Type := 'LABORATORY';
            HMSQue."Queue Type" := 'DISPATCH';
            HMSQue."Doctor ID" := LabHeader."Doctor ID";
            HMSQue.Date := TODAY;
            HMSQue.Time := TIME;
            HMSQue.INSERT;
        END;

        DocLabRequestLines.RESET;
        DocLabRequestLines.SETRANGE(DocLabRequestLines."Treatment No.", TreatmentNo);
        DocLabRequestLines.SETRANGE(DocLabRequestLines.Status, DocLabRequestLines.Status::New);
        IF DocLabRequestLines.FIND('-') THEN BEGIN
            REPEAT
                DocLabRequestLines."Lab No" := NewNo;
                DocLabRequestLines.Time := TIME;
                DocLabRequestLines.Status := DocLabRequestLines.Status::Forwarded;
                DocLabRequestLines.MODIFY;

                LabTestLines.INIT;
                LabTestLines."Laboratory No." := NewNo;
                LabTestLines."Duplicate test" := 0;
                LabTestLines."Unique No" := DocLabRequestLines."Line No";
                LabTestLines."Treat No" := TreatmentNo;
                //LabTestLines."Laboratory Test Code":=LabSpecimenSetup.Test;
                LabTestLines."Laboratory Test Code" := DocLabRequestLines."Laboratory Test Package Code";
                LabTestLines.validate("Laboratory Test Code");
                LabTestLines."Specimen Code" := LabSpecimenSetup.Specimen;
                LabTestLines."Measuring Unit Code" := LabSpecimenSetup."Measuring Unit";
                //LabTestLines."Laboratory Test Name":=LabSpecimenSetup."Test Name";
                LabTestLines."Laboratory Test Name" := DocLabRequestLines."Laboratory Test Package Name";
                LabTestLines.Dept := Dept;
                LabTestLines."Lab Request Date" := TODAY;
                LabTestLines."Lab Request Time" := TIME;
                LabTestLines.INSERT;
            UNTIL DocLabRequestLines.NEXT = 0;
        END ELSE BEGIN
            ERROR('Already forwarded');
        END;

        objAppointment.SETRANGE("Appointment No.", TreatmentHeader."Link No.");
        IF objAppointment.FIND('-') THEN BEGIN
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := TODAY;
            objAppointment."Dispatch Time" := TIME;
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Doctor Time Out" := CURRENTDATETIME;
            objAppointment."Lab Time In" := CURRENTDATETIME;
            objAppointment.MODIFY;
        END;
    END;

    PROCEDURE InsertTreatLabReturn(TreatmentNo: Text; LabNo_: Text; LabtestCode: Text; LabtestName: Text; BriefHistory: Text) Line: Integer;
    VAR
        uuID_: Text[250];
    BEGIN

        uuID_ := CREATEGUID;

        ObjLab.INIT;
        ObjLab."Treatment No." := TreatmentNo;
        ObjLab.UUID := uuID_;
        ObjLab."Lab No" := LabNo_;
        ObjLab."Laboratory Test Package Code" := LabtestCode;
        ObjLab.VALIDATE("Laboratory Test Package Code");
        ObjLab."Laboratory Test Package Name" := LabtestName;
        ObjLab."Date Due" := TODAY;
        ObjLab.Status := ObjLab.Status::Forwarded;
        ObjLab."Brief History" := BriefHistory;
        ObjLab.INSERT;

        ObjLab.RESET;
        ObjLab.SETRANGE(UUID, uuID_);
        IF ObjLab.FIND('-') THEN BEGIN
            Line := ObjLab."Line No";
        END;
    END;

    procedure RequestRadiologyIP(TreatmentNo: Code[20])
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
        TreatmentHeader.SetRange("Adm No.", TreatmentNo);
        if TreatmentHeader.Find('-') then begin


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
                RadiologyHeader."Radiology Time" := DT2TIME(System.CurrentDateTime);
                RadiologyHeader."Radiology Area" := RadiologyHeader."radiology area"::Admission;
                RadiologyHeader."Patient No." := TreatmentHeader."Patient No.";
                RadiologyHeader."Link No." := TreatmentHeader."Link No.";
                RadiologyHeader."Doctor ID" := TreatmentHeader."Doctor ID";
                RadiologyHeader."Doctor Name" := TreatmentHeader."Doctor's Name";
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
                HMSQue.Time := DT2TIME(System.CurrentDateTime);
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
                    RadiologyLine.validate("Radiology Type Code");
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
                objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
                objAppointment.Status := objAppointment.Status::Dispatched;
                objAppointment."Waiting At" := objAppointment."waiting at";
                objAppointment."Doctor Time Out" := CurrentDatetime;
                objAppointment."Imaging Time In" := CurrentDatetime;

                objAppointment.Modify;
            end;
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
                RadiologyHeader."Radiology Time" := DT2TIME(System.CurrentDateTime);
                if TreatmentHeader."Treatment Type" = TreatmentHeader."treatment type"::Inpatient then
                    RadiologyHeader."Radiology Area" := RadiologyHeader."radiology area"::Admission
                else
                    RadiologyHeader."Radiology Area" := RadiologyHeader."radiology area"::Doctor;
                RadiologyHeader."Patient No." := TreatmentHeader."Patient No.";
                RadiologyHeader."Link No." := TreatmentHeader."Link No.";
                RadiologyHeader."Doctor ID" := TreatmentHeader."Doctor ID";
                RadiologyHeader."Doctor Name" := TreatmentHeader."Doctor's Name";
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
                HMSQue.Time := DT2TIME(System.CurrentDateTime);
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
                    RadiologyLine.validate("Radiology Type Code");
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
                objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
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
        // objNotes.SETRANGE(objNotes."Patient No", PatientNo);
        // objNotes.SETRANGE(objNotes.TreatmentNo, TreatmentNo);
        // objNotes.SETRANGE(objNotes."Treatment Date", TreatmentDate);
        // objNotes.SETRANGE(objNotes."User ID", "docUSER ID");
        // objNotes.SETRANGE(// objNotes.Notes, Notes);
        // objNotes.SETRANGE(objNotes."Notes Type",objNotes."Notes Type"::DoctorsNotes);
        // IF objNotes.FIND('-') THEN BEGIN
        //  MESSAGE('Notes already recorded');
        //  END ELSE BEGIN
        objNotes.Init;
        objNotes.TreatmentNo := TreatmentNo;
        objNotes."Patient No" := PatientNo;
        objNotes."Treatment Date" := TreatmentDate;
        objNotes."Treatment Time" := DT2TIME(System.CurrentDateTime);
        // objNotes.Notes := Notes;
        objNotes."Notes Type" := objNotes."notes type"::DoctorsNotes;
        objNotes."Creation DateTime" := CurrentDatetime;
        objNotes."User ID" := "docUSER ID";
        objNotes."Created Date" := Today;
        objNotes.Insert;
        //END;
    end;

    procedure InsertMedicalReport(TreatmentNo: Code[30]; PatientNo: Code[30]; Notes: Text; TreatmentDate: Date; "docUSER ID": Code[30])
    begin
        objNotes.SetRange(objNotes."Patient No", PatientNo);
        objNotes.SetRange(objNotes.TreatmentNo, TreatmentNo);
        objNotes.SetRange(objNotes."Treatment Date", TreatmentDate);
        objNotes.SetRange(objNotes."User ID", "docUSER ID");
        // objNotes.SetRange(objNotes.Notes, Notes); TODO : Notes is a blob field. Need to refactor to use RichTextContent
        objNotes.SetRange(objNotes."Notes Type", objNotes."notes type"::MedicalReport);
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := DT2TIME(System.CurrentDateTime);
            // objNotes.Notes := Notes;
            objNotes."Notes Type" := objNotes."notes type"::MedicalReport;
            objNotes."Creation DateTime" := CurrentDatetime;
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
        // objNotes.SetRange(objNotes.Notes, Notes); TODO : Notes is a blob field. Need to refactor to use RichTextContent
        objNotes.SetRange(objNotes."Notes Type", objNotes."notes type"::"Patient History");
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := DT2TIME(System.CurrentDateTime);
            // objNotes.Notes := Notes;
            objNotes."Notes Type" := objNotes."notes type"::"Patient History";
            objNotes."Creation DateTime" := CurrentDatetime;
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
        // objNotes.SetRange(objNotes.Notes, Notes); TODO : Notes is a blob field. Need to refactor to use RichTextContent
        objNotes.SetRange(objNotes."Notes Type", objNotes."notes type"::"Treatment Plan");
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := DT2TIME(System.CurrentDateTime);
            // objNotes.Notes := Notes;
            objNotes."Notes Type" := objNotes."notes type"::"Treatment Plan";
            objNotes."Creation DateTime" := CurrentDatetime;
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

    procedure DeleteAllergies(PatientNo: Text[20]; AllergyChronic: Text[200]; Typ: Option)

    begin
        HMSPatientFlags.RESET;
        HMSPatientFlags.SETRANGE("Patient No.", PatientNo);
        HMSPatientFlags.SETRANGE(Type, Typ);
        HMSPatientFlags.SETRANGE(Description, AllergyChronic);
        IF HMSPatientFlags.FIND('-') THEN
            HMSPatientFlags.DELETE;
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

    procedure InsertPatientNotes(TreatmentNo: Code[30]; PatientNo: Code[30]; Notes: Text; TreatmentDate: Date; "docUSER ID": Code[30]; NotesTyp: Option; Clinic: Code[30])
    begin
        objNotes.SetRange(objNotes."Patient No", PatientNo);
        objNotes.SetRange(objNotes.TreatmentNo, TreatmentNo);
        objNotes.SetRange(objNotes."Treatment Date", TreatmentDate);
        objNotes.SetRange(objNotes."User ID", "docUSER ID");
        // objNotes.SetRange(objNotes.Notes, Notes); TODO : Notes is a blob field. Need to refactor to use RichTextContent
        objNotes.SetRange(objNotes."Notes Type", NotesTyp);
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := DT2TIME(System.CurrentDateTime);
            // objNotes.Notes := Notes;
            objNotes."Notes Type" := NotesTyp;
            objNotes."User ID" := "docUSER ID";
            objNotes."Created Date" := Today;
            objNotes.Clinic := Clinic;
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

        if AdmissionHeader.Get(ObservationNo) then begin
            PrescribeDrugsPrescrip(AdmissionHeader."Patient No.", ObservationNo);
            PostConsumablesItems(ObservationNo, DrugNo, AdmissionHeader."Patient No.");
        end;
        if PhysioHeader.Get(ObservationNo) then begin
            PrescribeDrugsPrescrip(PhysioHeader."Patient No.", ObservationNo);
            PostConsumablesItems(ObservationNo, DrugNo, PhysioHeader."Patient No.");
        end;
        if ObservationH.Get(ObservationNo) then begin
            PrescribeDrugsPrescrip(ObservationH."Patient No.", ObservationNo);
            PostConsumablesItems(ObservationNo, DrugNo, ObservationH."Patient No.");
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

        AdmissionHeader.Reset;
        AdmissionHeader.SetRange(AdmissionHeader."Admission No.", ObservationNo);
        //IF AdmissionHeader.GET(ObservationNo) THEN BEGIN
        if AdmissionHeader.Find('-') then begin
            PrescribeDrugsPrescrip(AdmissionHeader."Patient No.", ObservationNo);
            PostConsumablesItems(ObservationNo, DrugNo, AdmissionHeader."Patient No.");
        end else
            if ObservationH.Get(ObservationNo) then begin
                PrescribeDrugsPrescrip(ObservationH."Patient No.", ObservationNo);
                PostConsumablesItems(ObservationNo, DrugNo, ObservationH."Patient No.");
            end else
                if PhysioHeader.Get(ObservationNo) then begin
                    PrescribeDrugsPrescrip(PhysioHeader."Patient No.", ObservationNo);
                    PostConsumablesItems(ObservationNo, DrugNo, PhysioHeader."Patient No.");
                end else
                    if TheaterForm.Get(ObservationNo) then begin
                        PrescribeDrugsPrescrip(TheaterForm."Patient No.", ObservationNo);
                        PostConsumablesItems(ObservationNo, DrugNo, TheaterForm."Patient No.");
                    end else
                        if
               objAppointment.Get(ObservationNo) then begin
                            PrescribeDrugsPrescrip(objAppointment."Patient No.", ObservationNo);
                            PostConsumablesItems(ObservationNo, DrugNo, objAppointment."Patient No.");
                        end;
    end;

    procedure GenerateInvoice(PatientNo: Text; filenameFromApp: Text) filename: Text
    var
        hmsPat: Record "HMS Patient";
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
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
            Report.SaveAsPdf(Report::"HMS Patient Invoice", filename, HMSPatientsCharges);
        end;
        exit(filename);
    end;

    procedure GenerateInvoicebyVisit(PatientNo: Text; filenameFromApp: Text; VisitNo: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        HMSPatientsCharges.Reset;
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
        HMSPatientsCharges.SetRange(HMSPatientsCharges."Visit No", VisitNo);

        if HMSPatientsCharges.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Patient Invoice", filename, HMSPatientsCharges);
        end;
        exit(filename);
    end;

    procedure InsertPatientWalkin(EmployeeNo: Text; Sname: Text; Fname: Text; Mname: Text; gender: Option; Dob: Date; Marital: Option; Id: Text; Address: Text; PostalCode: Text; City: Text; Phone: Text; Email: Text; Nationality: Text; Bloodgrp: Text; NextkinName: Text; NextkinRelationship: Text; NextkinContact: Text; InsuranceNo: Text; InsuranceName: Text; InsuranceMemberNo: Text; Branch: Text) patientid: Text
    begin
        ObjPatient.Init();
        HMSSetup.Get;
        ObjPatient."Patient No." := NoSeriesMgt.GetNextNo(HMSSetup."Walkin Nos", 0D, true);
        patientid := ObjPatient."Patient No.";
        ObjPatient.Validate("Patient No.");
        ObjPatient."Date Registered" := Today;
        ObjPatient."Patient Type" := 2;
        ObjPatient.Activated := true;
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

    procedure PostConsumablesItems(ObservationNo: Text; DrugNo: Text; PatientNo: code[20])
    var
        ItemJnlLine: Record "Item Journal Line";
        PatRec: Record "HMS Patient";
    begin

        HMSSetup.Reset;
        HMSSetup.Get();
        PatRec.get(PatientNo);
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
                if AdmissionLine."Inventory Group" <> 'DRUGSS' then begin
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
                    ItemJnlLine."Shortcut Dimension 1 Code" := PatRec."Global Dimension 1 Code";
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
                    if AdmissionLine."Inventory Group" <> 'DRUGSS' then begin
                        if ObservationH.Get(ObservationNo) then begin
                            ChargePatient(AdmissionLine."Admission No.", AdmissionLine."Drug No.", AdmissionLine."Line No", AdmissionLine."Transaction Type", ObservationH."Patient No.", ObservationH."Link No.");
                        end else
                            if AdmissionHeader.Get(ObservationNo) then begin
                                ChargePatient(AdmissionLine."Admission No.", AdmissionLine."Drug No.", AdmissionLine."Line No", AdmissionLine."Transaction Type", AdmissionHeader."Patient No.", AdmissionHeader."Link No.");
                            end else
                                if TheaterForm.Get(ObservationNo) then begin
                                    ChargePatient(AdmissionLine."Admission No.", AdmissionLine."Drug No.", AdmissionLine."Line No", AdmissionLine."Transaction Type", TheaterForm."Patient No.", TheaterForm."No.");
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
            HMSPatientsCharges."Charge Type" := HMSPatientsCharges."Charge Type"::Item;
            HMSPatientsCharges.validate(Code);
            HMSPatientsCharges.Description := AdmissionLine."Drug Name";
            HMSPatientsCharges.Amount := AdmissionLine."Unit Price";
            HMSPatientsCharges.Quantity := AdmissionLine.Quantity;
            HMSPatientsCharges.Validate(Amount);
            HMSPatientsCharges.Validate(Quantity);

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
        AdmissionLine.SetFilter(AdmissionLine."Inventory Group", 'DRUGSS');
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
            PharmHeader."Pharmacy Time" := DT2TIME(System.CurrentDateTime);
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

    procedure InsertTransferHeader(From: Text; TransferTo: Text; Department: Text; Revenuecode: Text; employeeno: Text; Branch: Text) TrNo: Text
    begin
        InvtSetup.Get;
        TransferHeader.Init;
        TrNo := NoSeriesMgt.GetNextNo(InvtSetup."Transfer Order Nos.", 0D, true);
        TransferHeader."No." := TrNo;

        TransferHeader."Transfer-from Code" := From;

        TransferHeader."Transfer-to Code" := TransferTo;

        TransferHeader.Status := TransferHeader.Status::Open;
        TransferHeader."Shipment Date" := Today;
        TransferHeader."Receipt Date" := Today;
        TransferHeader."Shortcut Dimension 1 Code" := Branch;
        TransferHeader."Shortcut Dimension 2 Code" := Department;
        TransferHeader."In-Transit Code" := 'IN-Transit';
        TransferHeader."Assigned User ID" := employeeno;
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
        RadiologyLines."Performed Time" := DT2TIME(System.CurrentDateTime);
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

    procedure DeletePrescriptiontreatLine(TreatmentNo: Text; Drugno: Text; LineNo: Integer)
    begin

        ObjPrescription.Reset;
        ObjPrescription.SetRange("Treatment No.", TreatmentNo);
        ObjPrescription.SetRange("Drug No.", Drugno);
        ObjPrescription.SetRange(ObjPrescription."Lline No", LineNo);
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

    procedure InsertLabLines(LabNo: Text; LabTestCode: Text; SpecimenCode: Text; UnitCode: Text; employee: Text; Remarks: Text[200]; Ln: Integer)
    BEGIN
        LaboratoryLines.INIT;
        LaboratoryLines."Laboratory No." := LabNo;
        LaboratoryLines."Unique No" := Ln;
        LaboratoryLines."Laboratory Test Code" := LabTestCode;
        Labec.GET(LabTestCode);
        LaboratoryLines.VALIDATE("Laboratory Test Code");
        LaboratoryLines."Collection Date" := TODAY;
        LaboratoryLines."Collection Time" := TIME;
        LaboratoryLines."Lab Request Date" := TODAY;
        LaboratoryLines."Lab Request Time" := TIME;
        //LaboratoryLines."Specimen Code" :=SpecimenCode;
        //ObjSpecimen.GET(SpecimenCode);
        //LaboratoryLines."Measuring Unit Code" :=UnitCode;
        //ObjMeasuring.GET(UnitCode);
        LaboratoryLines."Assigned User ID" := employee;
        LaboratoryLines.Remarks := Remarks;
        LaboratoryLines."Laboratory Test Name" := Labec.Description;
        //LaboratoryLines."Specimen Name" :=ObjSpecimen.Description;
        //LaboratoryLines."Measuring Unit Name" :=ObjMeasuring.Description;
        LaboratoryLines.INSERT;
    END;

    procedure MarkLaboratoryComplete(LabNo: Text)
    begin
        LabHeader.Reset;
        LabHeader.SetRange("Laboratory No.", LabNo);
        if LabHeader.Find('-') then begin
            LabHeader.Status := LabHeader.Status::Completed;
            LabHeader."Completion Date" := Today;
            LabHeader."Completion Time" := DT2TIME(System.CurrentDateTime);
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
            HMSQue.Time := DT2TIME(System.CurrentDateTime);
            HMSQue.Insert;
        end;
        LabTestLines.Reset;
        LabTestLines.SetRange("Laboratory No.", LabNo);
        if LabTestLines.Find('-') then begin
            repeat
                LabTestLines.Completed := true;
                //LabTestLines."Collection Date" := TODAY;
                //LabTestLines."Collection Time" := DT2TIME(System.CurrentDateTime);
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
            HMSQue.Time := DT2TIME(System.CurrentDateTime);
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
        Cashsetup.Get;
        StaffClaims."No." := NoSeriesMgt.GetNextNo(Cashsetup."Staff Claim No", 0D, true);
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
        StaffClaims."No. Series" := Cashsetup."Staff Claim No";
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
        OperationalNotes.Init;
        OperationalNotes."Theatre No." := TheatreNo;
        OperationalNotes."Nurse ID" := EmployeeId;
        OperationalNotes."Notes Date" := Today;
        OperationalNotes."Notes Time" := DT2TIME(System.CurrentDateTime);
        OperationalNotes.Notes := Notes;
        OperationalNotes.notesType := NotesType;
        OperationalNotes.Insert;
    end;

    procedure InsertTheatreForm(TheatreNo: Text; Surgery: Text; PatientNo: Text; Doctor: Text; Incision: Text; EstimtdBloodLoss: Text; "Count": Option; Anaesthesia: Text)
    begin
        TheaterForm.SetRange("No.", TheatreNo);
        if TheaterForm.Find('-') then begin
            TheaterForm."No. Series" := 'HOSP-THEAT';
            TheaterForm.Incision := Incision;
            TheaterForm."Estimated Blood Loss" := EstimtdBloodLoss;
            TheaterForm.Count := Count;
            TheaterForm.Anaesthesia := Anaesthesia;
            TheaterForm.Modify;
        end
        else begin
            HMSSetup.Get;
            TheaterForm.Init;
            TheaterForm."No." := NoSeriesMgt.GetNextNo(HMSSetup."Theatre Nos", 0D, true);
            ;
            TheaterForm.Type := TheaterForm.Type::Admission;
            TheaterForm."Theatre Date" := Today;
            TheaterForm."Theatre Time" := DT2TIME(System.CurrentDateTime);
            TheaterForm."Surgery Code" := Surgery;
            TheaterForm.Validate("Surgery Code");
            TheaterForm."Patient No." := PatientNo;
            TheaterForm."Link Type" := 'TREATMENT';
            TheaterForm."Link No." := '';
            TheaterForm."No. Series" := HMSSetup."Theatre Nos";
            TheaterForm.Status := TheaterForm.Status::New;
            TheaterForm."Doctor ID" := Doctor;
            TheaterForm."Theatre Procedure" := TheaterForm."theatre procedure"::" ";
            TheaterForm.Incision := Incision;
            TheaterForm."Estimated Blood Loss" := EstimtdBloodLoss;
            TheaterForm.Count := Count;
            ObjPatient.SetRange("Patient No.", PatientNo);
            if ObjPatient.Find('-') then
                TheaterForm."Surname Name" := ObjPatient.Surname;
            TheaterForm."Last Name" := ObjPatient."Last Name";
            TheaterForm."ADM No" := '';
            TheaterForm.Anaesthesia := Anaesthesia;
            TheaterForm.Insert;
        end;
    end;

    procedure GenerateTheatreNotes(TheatreNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        TheaterForm.Reset;
        TheaterForm.SetRange(TheaterForm."No.", TheatreNo);


        if TheaterForm.Find('-') then begin
            Report.SaveAsPdf(Report::"Treatment Sheets", filename, TheaterForm);
        end;
        exit(filename);
    end;

    procedure GenerateRadiologyPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        ObjRadiology.Reset;
        ObjRadiology.SetRange(ObjRadiology."Treatment No.", TreatmentNo);


        if ObjRadiology.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Radiology", filename, ObjRadiology);
        end;
        exit(filename);
    end;

    procedure GeneratePrescriptionPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        ObjPrescription.Reset;
        ObjPrescription.SetRange(ObjPrescription."Treatment No.", TreatmentNo);


        if ObjPrescription.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Prescription", filename, ObjPrescription);
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
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Sickoff OP", filename, docHeader);
        end;
        exit(filename);
    end;

    procedure SendToTheatre(TreatmentNo: Text)
    begin
        HMSSetup.Reset;
        HMSSetup.Get();

        docHeader.Reset;
        docHeader.Get(TreatmentNo);
        THeader.Reset;
        THeader.SetRange(THeader."Treatment No.", TreatmentNo);
        THeader.SetRange(THeader.Status, THeader.Status::New);
        if THeader.Find('-') then begin
            repeat
                THeader2.Reset;
                THeader2.Init;
                HMSSetup.Get;
                NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Theatre Nos", 0D, true);
                THeader2."No." := NewNo;
                THeader2."Theatre Date" := Today;
                THeader2."Theatre Time" := DT2TIME(System.CurrentDateTime);
                THeader2."Patient No." := docHeader."Patient No.";
                THeader2."Surgery Code" := THeader."Process No.";
                THeader2.Surgery := THeader."Process Name";
                THeader2."Relative No." := docHeader."Relative No.";
                THeader2."Link Type" := 'Treatment';
                THeader2."Link No." := docHeader."Treatment No.";
                THeader2."No. Series" := 'HOSP-THEAT';
                THeader2."Doctor ID" := THeader.Doctor;
                THeader2."Anaesthetist ID" := THeader.Anaesthesist;
                THeader2.Instructions := THeader.Instructions;
                THeader2.Insert;

                THeader.Status := THeader.Status::Forwarded;
                THeader.Modify;
            until THeader.Next = 0;
        end;

        TLine.Reset;
        TLine.SetRange(TLine."Treatment No.", TreatmentNo);
        TLine.SetRange(TLine.Status, TLine.Status::New);
        if TLine.Find('-') then begin
            repeat
                TLine.Status := TLine.Status::Forwarded;
                TLine.Modify;

                TTestLines.Init;
                TTestLines."Line No" := 0;
                TTestLines."No." := THeader2."No.";
                TTestLines."Process No." := TLine."Process No.";
                TTestLines."Process Name" := TLine."Process Name";

                TTestLines.Insert;

            until TLine.Next = 0;
        end;
    end;

    procedure InsertDischargeSummary(DischargeCode: Text; Type: Option; Description: Text; TreatmentNo: Text; PatientNo: Text; ReviewDate: Date; FinalDiagnosis: Text[250]
    ; "Duration": Text; "Membrane Size": text; BloodFlow: Text; Bp: Text; DialysisFlowRate: Text; HeartRate: Text; HeparinUsed: text; MaintenanceDone: Text; PatientCondition: Text; PostDialysisWeight: Decimal; PreDialysisWeight: Decimal; SPO2: Text; UFAchieved: text)
    begin
        DischargeSummary.Init;
        DischargeSummary."Discharge Code" := DischargeCode;
        DischargeSummary.Type := Type;
        DischargeSummary.Description := Description;
        DischargeSummary."Diagnosis" := FinalDiagnosis;
        DischargeSummary."Admission No" := TreatmentNo;
        DischargeSummary.PatientNo := PatientNo;
        DischargeSummary."Review Date" := ReviewDate;
        DischargeSummary."Duration" := "Duration";
        DischargeSummary."Membrane Size" := "Membrane Size";
        DischargeSummary."Blood Flow Rate" := BloodFlow;
        DischargeSummary.Bp := Bp;
        DischargeSummary."Dialysis Flow Rate" := DialysisFlowRate;
        DischargeSummary."Heart Rate" := HeartRate;
        DischargeSummary."Heparin Used" := HeparinUsed;
        DischargeSummary."Maintenance Done" := MaintenanceDone;
        DischargeSummary."Patient Condition" := PatientCondition;
        DischargeSummary."Post Dialysis Weight" := PostDialysisWeight;
        DischargeSummary."Pre Dialysis Weight" := PreDialysisWeight;
        DischargeSummary."Review Date" := ReviewDate;
        DischargeSummary.SPO2 := SPO2;
        DischargeSummary."UF Achieved" := UFAchieved;
        DischargeSummary.Insert;
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
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        AdmissionDischargeHeader.Reset;
        AdmissionDischargeHeader.SetRange(AdmissionDischargeHeader."Admission No.", AdmissionNo);


        if AdmissionDischargeHeader.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Discharge Summary", filename, AdmissionDischargeHeader);
        end;
        exit(filename);
    end;

    procedure GenerateAdmissionPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        ObjAdmission.Reset;
        ObjAdmission.SetRange(ObjAdmission."Treatment No.", TreatmentNo);


        if ObjAdmission.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Adm History and phys", filename, ObjAdmission);
        end;
        exit(filename);
    end;

    procedure GenerateTreatmentHistoPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Treatment Notes", filename, docHeader);
        end;
        exit(filename);
    end;

    procedure GenerateMedicalReport(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Medical Report", filename, docHeader);
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

    procedure SendtoDischarge(TreatmentNo: Text; AdmissionNo: Text; Doctor: Text)
    begin
        DischargeSummary.Reset;
        DischargeSummary.SetRange("Discharge Code", AdmissionNo);
        if DischargeSummary.Find('-') then
            docHeader.Get(TreatmentNo);
        AdmissionHeader.Get(AdmissionNo);
        AdmissionDischargeHeader.Init;
        AdmissionDischargeHeader."Admission No." := AdmissionNo;
        AdmissionDischargeHeader."Patient No." := AdmissionHeader."Patient No.";
        AdmissionDischargeHeader."Discharge Date" := Today;
        AdmissionDischargeHeader."Discharge Time" := DT2TIME(System.CurrentDateTime);
        AdmissionDischargeHeader."Date of Admission" := AdmissionHeader."Admission Date";
        AdmissionDischargeHeader."Time Of Admission" := AdmissionHeader."Admission Time";
        AdmissionDischargeHeader."Ward No." := AdmissionHeader.Ward;
        AdmissionDischargeHeader."Bed No." := AdmissionHeader.Bed;
        //AdmissionDischargeHeader."Discharge Type" :=AdmissionDischargeHeader."Discharge Type"::
        AdmissionDischargeHeader."Patient Type" := docHeader."Patient Type";
        UserSetUpPortal.Reset;
        UserSetUpPortal.SetRange(UserSetUpPortal."User ID", Doctor);
        if UserSetUpPortal.Find('-') then
            AdmissionDischargeHeader."Doctor ID" := UserSetUpPortal."Doctor ID" else
            AdmissionDischargeHeader."Doctor ID" := Doctor;

        AdmissionDischargeHeader.Remarks := 'Discharged by doctor ' + docHeader."Doctor ID";
        AdmissionDischargeHeader.Status := AdmissionDischargeHeader.Status::New;
        AdmissionDischargeHeader.Insert;


        AdmissionHeader.Status := AdmissionHeader.Status::Discharged;
        AdmissionHeader.MODIFY;
    end;

    procedure CountDoctorQue(DocID: Text) DocQue: Integer
    begin
        DocQue := 0;
        UserSetUpPortal.SetRange("User ID", DocID);
        UserSetUpPortal.SetFilter("Doctor ID", '<>%1', '');
        if UserSetUpPortal.Find('-')
          then begin
            HMSQue.Reset;
            HMSQue.SetRange("Doctor ID", UserSetUpPortal."Doctor ID");
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

                    objItem.Dosage := TreatmentLine.Dosage;
                    objItem.Take := TreatmentLine.Take;
                    objItem."Number of Days" := TreatmentLine."Number of Days";
                    objItem.Frequency := TreatmentLine.Frequency;
                    objItem.Modify;
                    objItem.Modify;
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
        PostOrder: Codeunit "TransferOrder-Post Shipment";
    begin
        if TransferHeader.get(DocNo) then
            PostOrder.Run(TransferHeader);
    end;


    procedure ReceiveTransferOrderPortal(DocNo: Text)
    var
        Item: Record Item;

    begin
        TransHeader.Reset;
        TransHeader.SetRange("No.", DocNo);
        if TransHeader.Find('-') then
            TransferPostReceipt.Run(TransHeader);
        // IF TransHeader.Status = TransHeader.Status::Open THEN BEGIN
        //  CODEUNIT.RUN(CODEUNIT::"Release Transfer Document",TransHeader);
        //  TransHeader.Status := TransHeader.Status::Open;
        //  TransHeader.MODIFY;
        //  COMMIT;
        //  TransHeader.Status := TransHeader.Status::Released;
        // END;
        // //TransHeader := Rec;
        // TransHeader.SetHideValidationDialog(HideValidationDialog);
        //
        // WITH TransHeader DO BEGIN
        //  CheckBeforePost;
        //
        //  WhseReference := "Posting from Whse. Ref.";
        //  "Posting from Whse. Ref." := 0;
        //
        //  CheckDim;
        //
        //  TransLine.RESET;
        //  TransLine.SETRANGE("Document No.","No.");
        //  TransLine.SETRANGE("Derived From Line No.",0);
        //  TransLine.SETFILTER(Quantity,'<>0');
        //  TransLine.SETFILTER("Qty. to Receive",'<>0');
        //  IF NOT TransLine.FIND('-') THEN
        //    ERROR(Text001);
        //
        //  WhseReceive := TempWhseRcptHeader.FINDFIRST;
        //  InvtPickPutaway := WhseReference <> 0;
        //  IF NOT (WhseReceive OR InvtPickPutaway) THEN
        //    CheckWarehouse(TransLine);
        //
        //  GetLocation("Transfer-to Code");
        //  IF Location."Bin Mandatory" AND NOT (WhseReceive OR InvtPickPutaway) THEN
        //    WhsePosting := TRUE;
        //
        //  Window.OPEN(
        //    '#1#################################\\' +
        //    Text003);
        //
        //  Window.UPDATE(1,STRSUBSTNO(Text004,"No."));
        //
        //  SourceCodeSetup.GET;
        //  SourceCode := SourceCodeSetup.Transfer;
        //  InvtSetup.GET;
        //  InvtSetup.TESTFIELD("Posted Transfer Rcpt. Nos.");
        //
        //  CheckInvtPostingSetup;
        //
        //  LockTables(InvtSetup."Automatic Cost Posting");
        //
        //  // Insert receipt header
        //  IF WhseReceive THEN
        //    PostedWhseRcptHeader.LOCKTABLE;
        //  TransRcptHeader2.LOCKTABLE;
        //  TransRcptHeader2.INIT;
        //  TransRcptHeader2.CopyFromTransferHeader(TransHeader);
        //  TransRcptHeader2."No. Series" := InvtSetup."Posted Transfer Rcpt. Nos.";
        //
        //  TransRcptHeader2."No." :=
        //    NoSeriesMgt.GetNextNo(
        //      InvtSetup."Posted Transfer Rcpt. Nos.","Posting Date",TRUE);
        //  TransRcptHeader2.INSERT;
        //   TransRcptHeader2.GET(DocNo);
        //  IF InvtSetup."Copy Comments Order to Rcpt." THEN BEGIN
        //    CopyCommentLines(1,3,"No.",TransRcptHeader2."No.");
        //    TransHeader.GET(DocNo);
        //    RecordLinkManagement.CopyLinks(TransHeader,TransRcptHeader2);
        //  END;
        //
        //  IF WhseReceive THEN BEGIN
        //    WhseRcptHeader.GET(TempWhseRcptHeader."No.");
        //    WhsePostRcpt.CreatePostedRcptHeader(PostedWhseRcptHeader,WhseRcptHeader,TransRcptHeader2."No.","Posting Date");
        //  END;
        //
        //  // Insert receipt lines
        //  LineCount := 0;
        //  IF WhseReceive THEN
        //    PostedWhseRcptLine.LOCKTABLE;
        //  IF InvtPickPutaway THEN
        //    WhseRqst.LOCKTABLE;
        //  TransRcptLine2.LOCKTABLE;
        //  TransLine.SETRANGE(Quantity);
        //  TransLine.SETRANGE("Qty. to Receive");
        //  IF TransLine.FIND('-') THEN
        //    REPEAT
        //      LineCount := LineCount + 1;
        //      Window.UPDATE(2,LineCount);
        //
        //      IF TransLine."Item No." <> '' THEN BEGIN
        //        Item.GET(TransLine."Item No.");
        //        Item.TESTFIELD(Blocked,FALSE);
        //      END;
        //
        //      TransRcptLine2.INIT;
        //      TransRcptLine2."Document No." := TransRcptHeader2."No.";
        //      TransRcptLine2.CopyFromTransferLine(TransLine);
        //      TransRcptLine2.INSERT;
        //
        //      IF TransLine."Qty. to Receive" > 0 THEN BEGIN
        //        OriginalQuantity := TransLine."Qty. to Receive";
        //        OriginalQuantityBase := TransLine."Qty. to Receive (Base)";
        //        TransRcptHeader2.GET(DocNo);
        //        TransRcptLine2.RESET;
        //        TransRcptLine2.SETRANGE("Document No.", DocNo);
        //        IF TransRcptLine2.FIND('-') THEN
        //        PostItemJnlLine(TransLine,TransRcptHeader2,TransRcptLine2);
        //        TransRcptLine."Item Rcpt. Entry No." := InsertRcptEntryRelation(TransRcptLine);
        //        TransRcptLine.MODIFY;
        //        SaveTempWhseSplitSpec(TransLine);
        //        IF WhseReceive THEN BEGIN
        //          WhseRcptLine.SETCURRENTKEY(
        //            "No.","Source Type","Source Subtype","Source No.","Source Line No.");
        //          WhseRcptLine.SETRANGE("No.",WhseRcptHeader."No.");
        //          WhseRcptLine.SETRANGE("Source Type",DATABASE::"Transfer Line");
        //          WhseRcptLine.SETRANGE("Source No.",TransLine."Document No.");
        //          WhseRcptLine.SETRANGE("Source Line No.",TransLine."Line No.");
        //          WhseRcptLine.FINDFIRST;
        //          WhseRcptLine.TESTFIELD("Qty. to Receive",TransRcptLine2.Quantity);
        //          WhsePostRcpt.SetItemEntryRelation(PostedWhseRcptHeader,PostedWhseRcptLine,TempItemEntryRelation2);
        //          WhsePostRcpt.CreatePostedRcptLine(
        //            WhseRcptLine,PostedWhseRcptHeader,PostedWhseRcptLine,TempWhseSplitSpecification);
        //        END;
        //        IF WhsePosting THEN
        //          PostWhseJnlLine2(ItemJnlLine,OriginalQuantity,OriginalQuantityBase,TempWhseSplitSpecification);
        //      END;
        //    UNTIL TransLine.NEXT = 0;
        //
        //  IF InvtSetup."Automatic Cost Adjustment" <> InvtSetup."Automatic Cost Adjustment"::Never THEN BEGIN
        //    InvtAdjmt.SetProperties(TRUE,InvtSetup."Automatic Cost Posting");
        //    InvtAdjmt.MakeMultiLevelAdjmt;
        //  END;
        //
        //  ValueEntry.LOCKTABLE;
        //  ItemLedgEntry.LOCKTABLE;
        //  ItemApplnEntry.LOCKTABLE;
        //  ItemReg.LOCKTABLE;
        //  TransLine.LOCKTABLE;
        //  IF WhsePosting THEN
        //    WhseEntry.LOCKTABLE;
        //
        //  TransLine.SETFILTER(Quantity,'<>0');
        //  TransLine.SETFILTER("Qty. to Receive",'<>0');
        //  IF TransLine.FIND('-') THEN
        //    REPEAT
        //      TransLine.VALIDATE("Quantity Received",TransLine."Quantity Received" + TransLine."Qty. to Receive");
        //      TransLine.UpdateWithWarehouseShipReceive;
        //      ReservMgt.SetItemJnlLine(ItemJnlLine);
        //      ReservMgt.SetItemTrackingHandling(1); // Allow deletion
        //      ReservMgt.DeleteReservEntries(TRUE,0);
        //      TransLine.MODIFY;
        //    UNTIL TransLine.NEXT = 0;
        //
        //  IF WhseReceive THEN
        //    WhseRcptLine.LOCKTABLE;
        //  LOCKTABLE;
        //  IF WhseReceive THEN BEGIN
        //    WhsePostRcpt.PostUpdateWhseDocuments(WhseRcptHeader);
        //    TempWhseRcptHeader.DELETE;
        //  END;
        //
        //  "Last Receipt No." := TransRcptHeader2."No.";
        //  MODIFY;
        //
        //  TransLine.SETRANGE(Quantity);
        //  TransLine.SETRANGE("Qty. to Receive");
        //  HeaderDeleted := DeleteOneTransferOrder(TransHeader,TransLine);
        //  IF NOT HeaderDeleted THEN BEGIN
        //    WhseTransferRelease.Release(TransHeader);
        //    ReserveTransLine.UpdateItemTrackingAfterPosting(TransHeader,1);
        //  END;
        //
        //  IF NOT InvtPickPutaway THEN
        //    COMMIT;
        //  CLEAR(WhsePostRcpt);
        //  CLEAR(InvtAdjmt);
        //  Window.CLOSE;
        // END;
        // UpdateAnalysisView.UpdateAll(0,TRUE);
        // UpdateItemAnalysisView.UpdateAll(0,TRUE);
        // //Rec := TransHeader;
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
        ItemJnlLine.Quantity := TransLine3."Qty. to Receive";
        ItemJnlLine."Invoiced Quantity" := TransLine3."Qty. to Receive";
        ItemJnlLine."Quantity (Base)" := TransLine3."Qty. Shipped (Base)";
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
        //ItemJnlLine."Product Group Code" := TransLine."Product Group Code";
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
        //  ItemTrackingMgt: Codeunit "Item Tracking Management";
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
                        //  ItemTrackingMgt.CheckWhseItemTrkgSetup(
                        //  TransShptLine."Item No.",WhseSNRequired,WhseLNRequired,false);
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
        // WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        ShowError: Boolean;
    begin
        /*  GetLocation(TransLine."Transfer-from Code");
         if Location."Require Pick" or Location."Require Shipment" then begin
           if Location."Bin Mandatory" then
             ShowError := true
           else
            // if WhseValidateSourceLine.WhseLinesExist(
                  Database::"Transfer Line",
                  0,// Out
                  TransLine."Document No.",
                  TransLine."Line No.",
                  0,
                  TransLine.Quantity)
             then
           //    ShowError := true;

           if ShowError then
             Error(
               Text002,
               TransLine."Document No.",
               TransLine.FieldCaption("Line No."),
               TransLine."Line No.");
         end; */
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
    //  ItemTrackingMgt: Codeunit "Item Tracking Management";
    //  WMSMgmt: Codeunit "WMS Management";
    begin
        /*  with ItemJnlLine do begin
           Quantity := OriginalQuantity;
           "Quantity (Base)" := OriginalQuantityBase;
           GetLocation("Location Code");
           if Location."Bin Mandatory" then
             if WMSMgmt.CreateWhseJnlLine(ItemJnlLine,1,WhseJnlLine,false) then begin
               WMSMgmt.SetTransferLine(TransLine,WhseJnlLine,0,TransShptHeader."No.");
               ItemTrackingMgt.SplitWhseJnlLine(
                 WhseJnlLine,TempWhseJnlLine2,TempWhseSplitSpecification,true);
               if TempWhseJnlLine2.Find('-') then
                 repeat
                   WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2,1,0,true);
                 //  Codeunit.Run(Codeunit::"Whse. Jnl.-Register Line",TempWhseJnlLine2);
                 until TempWhseJnlLine2.Next = 0;
             end;
         end; */
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
    //  ItemTrackingMgt: Codeunit "Item Tracking Management";
    //    WMSMgmt: Codeunit "WMS Management";
    begin
        /*  with ItemJnlLine do begin
           Quantity := OriginalQuantity;
           "Quantity (Base)" := OriginalQuantityBase;
           GetLocation("New Location Code");
           if Location."Bin Mandatory" then
             if WMSMgmt.CreateWhseJnlLine(ItemJnlLine,1,WhseJnlLine,true) then begin
               WMSMgmt.SetTransferLine(TransLine,WhseJnlLine,1,TransRcptHeader."No.");
               ItemTrackingMgt.SplitWhseJnlLine(WhseJnlLine,TempWhseJnlLine2,TempHandlingSpecification,true);
               if TempWhseJnlLine2.Find('-') then
                 repeat
                   WMSMgmt.CheckWhseJnlLine(TempWhseJnlLine2,1,0,true);
                 //  Codeunit.Run(Codeunit::"Whse. Jnl.-Register Line",TempWhseJnlLine2);
                 until TempWhseJnlLine2.Next = 0;
             end;
         end; */
    end;

    procedure MarkTheaterComplete(TreatmentNo: Text; TheatreNo: Text; ProcessName: Text)
    begin
        THeader2.SetRange("Link No.", TreatmentNo);
        THeader2.SetRange("No.", TheatreNo);
        if THeader2.Find('-') then
            THeader2.Status := THeader2.Status::Closed;
        THeader2.Completed := true;
        THeader2.Closed := true;
        THeader2.Modify;

        THeader.SetRange("Treatment No.", TreatmentNo);
        THeader.SetRange("Process Name", ProcessName);
        if THeader.Find('-') then
            THeader.Status := THeader.Status::Completed;
        THeader.Modify;
    end;

    procedure InsertPhysioSetUp(TreatmentNo: Text; ProcessNo: Text; Remarks: Text; Diagnosis: Text; Treatment: Text; Frequency: Decimal; Duration: Text)
    begin
        ObjPhysioTreat.Init;
        ObjPhysioTreat."No." := TreatmentNo;
        ObjPhysioTreat."Process No." := ProcessNo;
        PhysioTypes.Get(ProcessNo);
        ObjPhysioTreat."Process Name" := PhysioTypes.Description;
        ObjPhysioTreat."Process Mandatory" := true;
        ObjPhysioTreat."Process Remarks" := Remarks;
        ObjPhysioTreat.Diagnosis := Diagnosis;
        ObjPhysioTreat.Treatment := Treatment;
        ObjPhysioTreat."Frequency Per week" := Frequency;
        ObjPhysioTreat.Duration := Duration;
        ObjPhysioTreat.Insert;
    end;

    procedure SendToPhysio(TreatmentNo: Text)
    begin
        HMSSetup.Get;
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Physio Nos", 0D, true);
        ObjPhysioTreat.SetRange("No.", TreatmentNo);
        if ObjPhysioTreat.Find('-') then begin
            docHeader.Get(TreatmentNo);
            PhysioHeader.Init;
            PhysioHeader."No." := NewNo;
            PhysioHeader.Type := PhysioHeader.Type::Visit;
            PhysioHeader."Physio Date" := Today;
            PhysioHeader."Physio Time" := DT2TIME(System.CurrentDateTime);
            PhysioHeader."Physio User ID" := docHeader."Doctor ID";
            PhysioHeader."Physio Remarks" := ObjPhysioTreat."Process Remarks";
            PhysioHeader."Patient No." := docHeader."Patient No.";
            PhysioHeader."Link Type" := 'Doctor';
            PhysioHeader."Link No." := TreatmentNo;
            PhysioHeader.Status := PhysioHeader.Status::New;
            PhysioHeader.Duration := ObjPhysioTreat.Duration;
            PhysioHeader."Frequency Per Week" := ObjPhysioTreat."Frequency Per week";
            PhysioHeader."Surname Name" := docHeader.Surname;
            PhysioHeader."Last Name" := docHeader."Last Name";
            PhysioHeader."ADM No" := docHeader."Adm No.";
            PhysioHeader.Insert;
        end else begin
            docHeader.Get(TreatmentNo);
            PhysioHeader.Init;
            PhysioHeader."No." := NewNo;
            PhysioHeader.Type := PhysioHeader.Type::Visit;
            PhysioHeader."Physio Date" := Today;
            PhysioHeader."Physio Time" := DT2TIME(System.CurrentDateTime);
            PhysioHeader."Physio User ID" := docHeader."Doctor ID";
            //PhysioHeader."Physio Remarks" :=ObjPhysioTreat."Process Remarks";
            PhysioHeader."Patient No." := docHeader."Patient No.";
            PhysioHeader."Link Type" := 'Doctor';
            PhysioHeader."Link No." := TreatmentNo;
            PhysioHeader.Status := PhysioHeader.Status::New;
            //PhysioHeader.Duration :=ObjPhysioTreat.Duration;
            //PhysioHeader."Frequency Per Week":=ObjPhysioTreat."Frequency Per week";
            PhysioHeader."Surname Name" := docHeader.Surname;
            PhysioHeader."Last Name" := docHeader."Last Name";
            PhysioHeader."ADM No" := docHeader."Adm No.";
            PhysioHeader.Insert;
        end;
    end;

    procedure InsertInpatientVitals(TreatmentNo: Text; PatientNo: Text; Pain: Decimal; PulseRate: Text; BloodPressure: Text; Temperature: Decimal; Height: Decimal; Weight: Decimal; SP02: Text; RespirationRate: Text)
    begin
        TreatmentLine.Init;
        TreatmentLine."Treatment No." := TreatmentNo;
        TreatmentLine.Type := TreatmentLine.Type::Inpatient;
        TreatmentLine."Patient No." := PatientNo;
        TreatmentLine.Validate("Patient No.");
        TreatmentLine.Pain := Pain;
        TreatmentLine."Pulse Rate" := PulseRate;
        TreatmentLine."Blood Pressure" := BloodPressure;
        TreatmentLine.Temperature := Temperature;
        TreatmentLine.Height := Height;
        TreatmentLine.Weight := Weight;
        TreatmentLine.Validate(Height);
        TreatmentLine.Validate(Weight);
        TreatmentLine.SP02 := SP02;
        TreatmentLine."Date Created" := CurrentDatetime;
        TreatmentLine."Date Taken" := Today;
        TreatmentLine."Respiration Rate" := RespirationRate;
        TreatmentLine.Time := DT2TIME(System.CurrentDateTime);


        TreatmentLine.Insert;
    end;

    procedure GenerateLabResults(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        LabHeader.Reset;
        LabHeader.SetRange("Link No.", TreatmentNo);
        if LabHeader.Find('-') then begin

            if LabHeader.Status = LabHeader.Status::Recalled then begin
            end else begin
                LabResults.Reset;
                LabResults.SetRange(LabResults."Laboratory No.", LabHeader."Laboratory No.");
                if LabResults.Find('-') then begin
                    Report.SaveAsPdf(Report::"HMS Lab Results2", filename, LabResults);
                end;
            end;
            exit(filename);
        end;
    end;

    procedure GenerateLabPrintOut(LabNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        LabResults.Reset;
        LabResults.SetRange(LabResults."Laboratory No.", LabNo);
        if LabResults.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Lab Results2", filename, LabResults);

        end;
        exit(filename);

    end;

    procedure CheckLabResults(TreatmentNo: Text) Results: Boolean
    begin
        Results := false;
        LabHeader.Reset;
        LabHeader.SetRange("Laboratory No.", TreatmentNo);

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
        InpatientObservation.Init;
        InpatientObservation."Patient No" := PatientNo;
        InpatientObservation."Admission No" := AdmissionNo;
        InpatientObservation.Date := Today;
        InpatientObservation.Category := Category;
        InpatientObservation."Category Value" := CategoryValue;
        InpatientObservation.Timing := Timing;
        InpatientObservation.Insert;
    end;

    procedure GenerateObservationChart(AdmissionNo: Text; PatientNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        AdmissionHeader.Reset;
        AdmissionHeader.SetRange(AdmissionHeader."Admission No.", AdmissionNo);
        AdmissionHeader.SetRange(AdmissionHeader."Patient No.", PatientNo);


        if AdmissionHeader.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS General Observation", filename, AdmissionHeader);
        end;
        exit(filename);
    end;

    procedure InsertICUObservation(PatientNo: Text; AdmissionNo: Text; Category: Option; CategoryValue: Text; Timing: Option; ICUObservationCateory: Text)
    begin
        InpatientObservation.Init;
        InpatientObservation."Patient No" := PatientNo;
        InpatientObservation."Admission No" := AdmissionNo;
        InpatientObservation.Date := Today;
        InpatientObservation."ICU Category" := Category;
        InpatientObservation."Category Value" := CategoryValue;
        InpatientObservation."ICU Observation Cateory" := ICUObservationCateory;
        InpatientObservation."ICU Timings" := Timing;
        InpatientObservation.ICU := true;
        InpatientObservation.Insert;
    end;

    procedure GenerateICUChart(AdmissionNo: Text; PatientNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        AdmissionHeader.Reset;
        AdmissionHeader.SetRange(AdmissionHeader."Admission No.", AdmissionNo);
        AdmissionHeader.SetRange(AdmissionHeader."Patient No.", PatientNo);

        if AdmissionHeader.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS General Observation", filename, AdmissionHeader);
        end;
        exit(filename);
    end;

    procedure GenerateReferralPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Refferal Form", filename, docHeader);
        end;
        exit(filename);
    end;

    procedure GenerateTransferLetter(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(Report::"Refferal Form", filename, docHeader);
        end;
        exit(filename);
    end;

    procedure GeneratePhysioPrintout(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        docHeader.Reset;
        docHeader.SetRange(docHeader."Treatment No.", TreatmentNo);


        if docHeader.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Physio Printout", filename, docHeader);
        end;
        exit(filename);
    end;

    procedure InsertTSheet(TreatmentNo: Text; DrugNo: Text; Remarks: Text; IssuedBy: Text; AdmissionNo: Text)
    begin
        ObjPrescription.Reset;
        ObjPrescription.SetRange(ObjPrescription."Treatment No.", TreatmentNo);
        ObjPrescription.SetRange(ObjPrescription."Drug No.", DrugNo);
        //ObjPrescription.SETRANGE(DrugPrescribe."Line No",Line_No);
        //ObjPrescription.SETRANGE(ObjPrescription.Issued,FALSE);
        if ObjPrescription.Find('-') then begin
            //REPEAT
            TSheet.Init;
            TSheet."Admission No." := AdmissionNo;
            TSheet."Drug No." := ObjPrescription."Drug No.";
            TSheet.Quantity := ObjPrescription.Quantity;
            TSheet."Drug Name" := ObjPrescription."Drug Name";
            TSheet."Unit Of Measure" := ObjPrescription."Unit Of Measure";
            TSheet."Pharmacy Code" := ObjPrescription."Pharmacy Code";
            TSheet.Dosage := ObjPrescription.Dosage;
            TSheet."Issued Date" := Today;
            TSheet."Issued Time" := DT2TIME(System.CurrentDateTime);
            TSheet."Issued By" := IssuedBy;
            TSheet.Issued := true;
            TSheet.Remarks := Remarks;
            TSheet.Insert;
            // ObjPrescription.Issued :=TRUE;
            //ObjPrescription.MODIFY;
            //UNTIL DrugPrescribe.NEXT=0;
        end;
    end;

    procedure InsertFluidBalanceIntake(PatientNo: Text; AdmissionNo: Text; Timings: Option; IntakeType: Text; IntakeAmount: Decimal; IVIntake: Boolean; Alimentary: Boolean; Infused: Decimal)
    begin
        FluidBalance.Reset;
        FluidBalance.SetRange(FluidBalance."Patient No", PatientNo);
        FluidBalance.SetRange(FluidBalance."Admission No", AdmissionNo);
        FluidBalance.SetRange(FluidBalance."Intake Date", Today);
        FluidBalance.SetRange(FluidBalance.Timings, Timings);
        FluidBalance.SetRange(FluidBalance."IV Intake Type", '');
        if FluidBalance.Find('-') then begin
            FluidBalance."Patient No" := PatientNo;
            FluidBalance."Admission No" := AdmissionNo;
            FluidBalance."Fluid Balance" := FluidBalance."fluid balance"::Intake;
            FluidBalance."Intake Date" := Today;
            FluidBalance.Timings := Timings;
            FluidBalance.Validate(Timings);
            FluidBalance."IV Intake Type" := IntakeType;
            FluidBalance."IV Intake Amount" := IntakeAmount;
            FluidBalance."IV Intake" := IVIntake;
            FluidBalance.Alimentary := Alimentary;
            FluidBalance.Infused := Infused;
            FluidBalance.Modify;
        end else begin
            FluidBalance.Init;
            FluidBalance."Patient No" := PatientNo;
            FluidBalance."Admission No" := AdmissionNo;
            FluidBalance."Fluid Balance" := FluidBalance."fluid balance"::Intake;
            FluidBalance."Intake Date" := Today;
            FluidBalance.Timings := Timings;
            FluidBalance.Validate(Timings);
            FluidBalance."IV Intake Type" := IntakeType;
            FluidBalance."IV Intake Amount" := IntakeAmount;
            FluidBalance."IV Intake" := IVIntake;
            FluidBalance.Alimentary := Alimentary;
            FluidBalance.Infused := Infused;
            FluidBalance.Insert;
        end;
    end;

    procedure InsertFluidBalanceAlimentary(PatientNo: Text; AdmissionNo: Text; Timings: Option; IntakeType: Text; IntakeAmount: Decimal; IVIntake: Boolean; Alimentary: Boolean; Infused: Decimal)
    begin
        FluidBalance.Reset;
        FluidBalance.SetRange(FluidBalance."Patient No", PatientNo);
        FluidBalance.SetRange(FluidBalance."Admission No", AdmissionNo);
        FluidBalance.SetRange(FluidBalance."Intake Date", Today);
        FluidBalance.SetRange(FluidBalance.Timings, Timings);
        FluidBalance.SetRange(FluidBalance."Alimentary Intake Type", '');
        if FluidBalance.Find('-') then begin
            FluidBalance."Patient No" := PatientNo;
            FluidBalance."Admission No" := AdmissionNo;
            FluidBalance."Fluid Balance" := FluidBalance."fluid balance"::Intake;
            FluidBalance."Intake Date" := Today;
            FluidBalance.Timings := Timings;
            FluidBalance.Validate(Timings);
            FluidBalance."Alimentary Intake Type" := IntakeType;
            FluidBalance."Alimentary Intake Amount" := IntakeAmount;
            FluidBalance."IV Intake" := false;
            FluidBalance.Alimentary := true;
            FluidBalance.Infused := Infused;
            FluidBalance.Modify;
        end
        else begin
            FluidBalance.Init;
            FluidBalance."Patient No" := PatientNo;
            FluidBalance."Admission No" := AdmissionNo;
            FluidBalance."Fluid Balance" := FluidBalance."fluid balance"::Intake;
            FluidBalance."Intake Date" := Today;
            FluidBalance.Timings := Timings;
            FluidBalance.Validate(Timings);
            FluidBalance."Alimentary Intake Type" := IntakeType;
            FluidBalance."Alimentary Intake Amount" := IntakeAmount;
            FluidBalance."IV Intake" := false;
            FluidBalance.Alimentary := true;
            FluidBalance.Infused := Infused;
            FluidBalance.Insert;
        end;
    end;

    procedure InsertFluidBalanceOutput(PatientNo: Text; AdmissionNo: Text; Timings: Option; VomitAmount: Decimal; StoolAmount: Text; NGastAmount: Decimal; UrineAmount: Text; OthersAmount: Decimal; Weight: Decimal)
    begin
        FluidBalance.Reset;
        FluidBalance.SetRange(FluidBalance."Patient No", PatientNo);
        FluidBalance.SetRange(FluidBalance."Admission No", AdmissionNo);
        FluidBalance.SetRange(FluidBalance."Intake Date", Today);
        FluidBalance.SetRange(FluidBalance.Timings, Timings);
        FluidBalance.SetRange(FluidBalance."Alimentary Intake Type", '');
        FluidBalance.SetRange(FluidBalance.Output, FluidBalance.Output::No);
        if FluidBalance.Find('-') then begin
            FluidBalance."Patient No" := PatientNo;
            FluidBalance."Admission No" := AdmissionNo;
            FluidBalance."Fluid Balance" := FluidBalance."fluid balance"::Output;
            FluidBalance."Intake Date" := Today;
            FluidBalance.Timings := Timings;
            FluidBalance.Validate(Timings);
            FluidBalance.Output := FluidBalance.Output::Yes;
            if VomitAmount <> 0 then FluidBalance."Vomit Amount" := VomitAmount;
            if StoolAmount <> '' then FluidBalance."Stool Amount" := StoolAmount;
            if NGastAmount <> 0 then FluidBalance."N\Gast Amount" := NGastAmount;
            if UrineAmount <> '' then FluidBalance."Urine Amount" := UrineAmount;
            if OthersAmount <> 0 then FluidBalance."Others Amount" := OthersAmount;
            if Weight <> 0 then FluidBalance.Weight := Weight;
            FluidBalance.Modify;
        end else begin
            FluidBalance.Init;
            FluidBalance."Patient No" := PatientNo;
            FluidBalance."Admission No" := AdmissionNo;
            FluidBalance."Fluid Balance" := FluidBalance."fluid balance"::Output;
            FluidBalance."Intake Date" := Today;
            FluidBalance.Timings := Timings;
            FluidBalance.Validate(Timings);
            FluidBalance.Output := FluidBalance.Output::Yes;
            FluidBalance."Vomit Amount" := VomitAmount;
            FluidBalance."Stool Amount" := StoolAmount;
            FluidBalance."N\Gast Amount" := NGastAmount;
            FluidBalance."Urine Amount" := UrineAmount;
            FluidBalance."Others Amount" := OthersAmount;
            FluidBalance.Weight := Weight;
            FluidBalance.Insert;
        end;
    end;

    procedure GenerateFluidChart(AdmissionNo: Text; PatientNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        Message(filename);
        FluidBalance.Reset;
        FluidBalance.SetRange(FluidBalance."Admission No", AdmissionNo);
        FluidBalance.SetRange(FluidBalance."Patient No", PatientNo);
        Message(filename);
        if FluidBalance.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Fluid Balance Fluid Chart", filename, FluidBalance);
            Message(filename);
        end;
        exit(filename);
    end;

    procedure GenerateNurseCardex(AdmissionNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        Message(filename);
        objNurseNote.Reset;
        objNurseNote.SetRange(objNurseNote."Admission No.", AdmissionNo);
        if objNurseNote.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Nurse Notes", filename, objNurseNote);
            Message(filename);
        end else begin
            objNurseNote.Reset;
            objNurseNote.SetRange(objNurseNote."Admission No.", AdmissionNo);
            if objNurseNote.Find('-') then begin
                Report.SaveAsPdf(Report::"HMS Nurse Notes", filename, objNurseNote);
                Message(filename);
            end;
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
        PatientInsurance: Record "HMS Patient Insuarance";
        Charges: Record "HMS Charges";
    begin
        AdmissionHeader.Reset;
        AdmissionHeader.SetRange(AdmissionHeader."Admission No.", AdmissionNo);
        AdmissionHeader.SetRange(AdmissionHeader."Patient No.", PatientNo);
        if AdmissionHeader.Find('-') then begin
            HMSSetup.Get();
            HMSSetup.TestField("Admission Fee");
            Patient.get(PatientNo);
            Charges.get(HMSSetup."Admission Fee");
            HMSPatientCharges.Init;
            //HMSPatientCharges."Line No":=1;
            HMSPatientCharges."Transaction Type" := Charges."Transaction Type";
            HMSPatientCharges.Validate("Transaction Type");
            HMSPatientCharges."Patient No." := AdmissionHeader."Patient No.";
            HMSPatientCharges."Link No" := AdmissionHeader."Admission No.";
            HMSPatientCharges."Treatment No." := AdmissionHeader."Admission No.";
            HMSPatientCharges."Appointment No." := AdmissionHeader."Appointment No.";
            HMSPatientCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
            HMSPatientCharges.Code := HMSSetup."Admission Fee";
            HMSPatientCharges.validate(Code);
            // HMSPatientCharges.Amount := HMSCharges.Amount;
            HMSPatientCharges.Validate(Amount);
            HMSPatientCharges.Date := Today;

            ///HMSPatientCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
            HMSPatientCharges."Bill Section" := HMSPatientCharges."Bill Section"::Admissions;
            HMSPatientCharges."User ID" := UserId;
            HMSPatientCharges."Creation Date" := Today;
            HMSPatientCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
            HMSPatientCharges."Admission No" := AdmissionHeader."Admission No.";
            HMSPatientCharges."Visit No" := Patient."Active Visit No";
            HMSPatientCharges.Insert;

            Charges.get(WardRec."Charges Code");
            HMSPatientCharges.INIT;
            HMSPatientCharges."Patient No." := AdmissionHeader."Patient No.";
            HMSPatientCharges."Link No" := AdmissionHeader."Admission No.";
            HMSPatientCharges."Treatment No." := AdmissionHeader."Link No.";
            WardRec.GET(Ward);
            Charges.GET(WardRec."Charges Code");
            HMSPatientCharges."Transaction Type" := Charges."Transaction Type";
            HMSPatientCharges.VALIDATE("Transaction Type");
            HMSPatientCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
            HMSPatientCharges.Code := WardRec."Charges Code";
            HMSPatientCharges.VALIDATE(Code);
            HMSPatientCharges.Description := Ward + ' ' + Bed;
            HMSPatientCharges.VALIDATE(Amount);
            HMSPatientCharges.Date := TODAY;
            HMSPatientCharges."Bill Section" := HMSPatientCharges."Bill Section"::Admissions;
            HMSPatientCharges."Billing Type" := HMSPatientCharges."Billing Type"::Reccuring;
            HMSPatientCharges."Reccuring Type" := HMSPatientCharges."Reccuring Type"::Daily;
            HMSPatientCharges."Billing Start Date" := TODAY;
            HMSPatientCharges."Admission No" := AdmissionHeader."Admission No.";
            HMSPatientCharges."Visit No" := Patient."Active Visit No";
            HMSPatientCharges.INSERT;

            BedRec.Reset;
            BedRec.SetRange(BedRec."Bed No", Bed);
            BedRec.SetRange("Ward No", Ward);
            if BedRec.Find('-') then begin
                BedRec.Occupied := true;
                BedRec.Modify;
            end;
            Patient.SetRange("Patient No.", PatientNo);

            if Patient.Find('-') then
                Patient.Inpatient := true;
            Patient."Admissions Date" := Today;
            Patient."Adm No." := AdmissionNo;
            Patient."Current Adm No" := AdmissionNo;
            Patient.Modify;
            AdmissionHeader.Ward := Ward;
            AdmissionHeader.Bed := Bed;
            AdmissionHeader.Status := AdmissionHeader.Status::Admitted;
            AdmissionHeader.NHIF := nhif;
            AdmissionHeader.Validate("Patient No.");
            AdmissionHeader.Modify;
            Message('Patient Admitted');


            if (AdmissionHeader.NHIF = true) then
                AdmissionHeader.Remarks := 'NHIF will pay some bed charges';
            AdmissionHeader.NHIF := true;
            PatientInsurance.SetRange("Patient No", PatientNo);
            PatientInsurance.SetRange("Insurance No", 'CO-00099');
            if PatientInsurance.Find('-') then begin

            end else begin
                PatientInsurance.Init;
                PatientInsurance."Patient No" := PatientNo;
                //PatientInsurance."Insurance No" :='CO-00099';
                // PatientInsurance.VALIDATE("Insurance No");
                PatientInsurance.Insert;
            end;
        end else
            nhif := false;

    end;

    procedure ReturnChartValues(AdmissionNo: Text; ICUTimings: Option; ICUCategory: Option) ChartValue: Text
    begin
        InpatientObservation.Reset;
        //InpatientObservation.SETRANGE("Patient No",PatientNo);
        InpatientObservation.SetRange("Admission No", AdmissionNo);
        InpatientObservation.SetRange(Date, Today);
        InpatientObservation.SetRange(ICU, true);
        InpatientObservation.SetRange("ICU Timings", ICUTimings);
        InpatientObservation.SetRange("ICU Category", ICUCategory);
        //InpatientObservation.SETCURRENTKEY("ICU Timings");
        if InpatientObservation.Find('-') then begin
            // REPEAT

            ChartValue := InpatientObservation."Category Value" + ',';
            //UNTIL InpatientObservation.NEXT=0; ChartValue +
        end else begin
            ChartValue := '0,';
        end;
    end;

    procedure TransferBed(AdmissionNo: Text; PatientNo: Text; Ward: Text; Bed: Text)
    var
        HMSPatientCharges: Record "HMS Patient Charges";
        WardRec: Record "HMS Ward Setup";
        BedRec: Record "HMS Beds";
        PatRec: Record "HMS Patient";
    begin
        PatRec.get(PatientNo);
        AdmissionHeader.Reset;
        AdmissionHeader.SetRange(AdmissionHeader."Admission No.", AdmissionNo);
        AdmissionHeader.SetRange(AdmissionHeader."Patient No.", PatientNo);
        if AdmissionHeader.Find('-') then begin
            // Stop auto billing of old bed
            HMSPatientCharges.Reset;
            HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", PatientNo);
            HMSPatientCharges.SetRange(HMSPatientCharges."Visit No", PatRec."Active Visit No");
            HMSPatientCharges.SetRange(HMSPatientCharges."Transaction Type", 'BED CHARGES');
            HMSPatientCharges.SetRange(HMSPatientCharges."System Created", false);
            if HMSPatientCharges.Find('-') then begin
                repeat
                    HMSPatientCharges."System Created" := true;
                    HMSPatientCharges.Remarks := 'Bed Transfer';
                    HMSPatientCharges.modify;
                until HMSPatientCharges.next = 0;
            end;
            // Update today's rate
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
            BedRec.SetRange(BedRec."Ward No", AdmissionHeader.Ward);
            if BedRec.Find('-') then begin
                BedRec.Occupied := false;
                BedRec.Modify;
            end;

            BedRec.Reset;
            BedRec.SetRange(BedRec."Bed No", Bed);
            BedRec.SetRange(BedRec."Ward No", Ward);
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

    procedure StopTreatment(TreatmentNo: Text; DrugNo: Text; Remarks: Text; LineNo: Integer)
    begin
        ObjPrescription.RESET;
        ObjPrescription.SETRANGE(ObjPrescription."Treatment No.", TreatmentNo);
        ObjPrescription.SETRANGE(ObjPrescription."Drug No.", DrugNo);
        ObjPrescription.SETRANGE(ObjPrescription."Lline No", LineNo);
        //ObjPrescription.SETRANGE(ObjPrescription.Issued,FALSE);
        IF ObjPrescription.FIND('-') THEN BEGIN
            //REPEAT
            ObjPrescription."IP Status" := ObjPrescription."IP Status"::Stopped;
            ObjPrescription."Stopped Date" := TODAY;
            ObjPrescription."Stopped by" := Remarks;
            ObjPrescription.Issued := TRUE;
            ObjPrescription.MODIFY;
            //UNTIL DrugPrescribe.NEXT=0;
        END;
    end;

    procedure InsertIPPrescription(TreatmentNo: Text; DrugNo: Text; Remarks: Text; Location: Text; Frequency: Integer; Take: Decimal; Dosage: Text; Route: Integer; Quantity: Integer; NoofDays: Integer; PatientNo: Text; DocID: Text; PrescriptionDose: Text)
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
        ObjPrescription.Quantity := Quantity;
        ObjPrescription."Number of Days" := NoofDays;
        ObjPrescription."Remaining Days" := NoofDays;
        ObjPrescription."Patient No" := PatientNo;
        ObjPatient.Reset;
        ObjPatient.SetRange("Patient No.", PatientNo);
        if ObjPatient.Find('-') then
            ObjPrescription."Patient Names" := ObjPatient."Search Name";
        //ObjPrescription.VALIDATE(Frequency);
        //ObjPrescription.VALIDATE(Take);
        //ObjPrescription.VALIDATE("Number of Days");
        ObjPrescription."Prescribed By" := DocID;
        Evaluate(ObjPrescription."Prescription Dose", PrescriptionDose);
        ObjPrescription.Remarks := Remarks;
        ObjPrescription."Pharmacy Code" := Location;
        ObjPrescription.Inpatient := true;
        ObjPrescription."Date Prescribed" := Today;
        ObjPrescription."IP Status" := ObjPrescription."ip status"::Ongoing;
        ObjPrescription."Pharmacy Type" := ObjPrescription."pharmacy type"::Inpatient;
        ObjPrescription.Insert;
    end;

    procedure InsertPreOpList(Preopcode: Text; PatientNo: Text; AdmissionNo: Text; TreatmentNo: Text; Operation: Text; staffid: Text; Present: Boolean; Value: Text)
    begin
        PreOpSetup.Get(Preopcode);
        Patient.SetRange("Patient No.", PatientNo);
        if Patient.Find('-') then
            PreOpList.Init;
        PreOpList.Code := Preopcode;
        PreOpList.Description := PreOpSetup.Description;
        PreOpList."Patient No." := PatientNo;
        PreOpList."Patient Name" := Patient."Search Name";
        PreOpList."Admission No." := AdmissionNo;
        PreOpList."Treatment No." := TreatmentNo;
        PreOpList.Date := CurrentDatetime;
        PreOpList.Operation := Operation;
        PreOpList."User ID" := staffid;
        PreOpList.Present := Present;
        PreOpList.Value := Value;
        PreOpList.Insert;
    end;

    procedure UpdateTheatre(TheatreNo: Text; Surgeon: Text; Anaesthetist: Text; Assistant: Text; ScrubNurse: Text; CirculatingNurse: Text)
    begin
        TheaterForm.Reset;
        TheaterForm.SetRange("No.", TheatreNo);
        if TheaterForm.Find('-') then
            TheaterForm."Doctor ID" := Surgeon;
        TheaterForm."Anaesthetist ID" := Anaesthetist;
        TheaterForm."Theatre Assistant" := Assistant;
        TheaterForm."Scrub Nurse" := ScrubNurse;
        TheaterForm."Circulating Nurse ID" := CirculatingNurse;
        TheaterForm.Modify;
    end;

    procedure GenerateTsheetPrintout(AdmissionNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        TSheet.Reset;
        TSheet.SetRange(TSheet."Admission No.", AdmissionNo);
        if TSheet.Find('-') then begin
            Report.SaveAsPdf(Report::"Treatment Sheets", filename, TSheet);
        end;
        exit(filename);
    end;

    PROCEDURE InsertLabResults(LabNo: Text; LabTestCode: Text; SpecimenCode: Text; Results: Decimal; Remarks: Text; Labuser: Text; Type: Text; UID: Integer);
    BEGIN
        LabResults.RESET;
        LabResults.SETRANGE(LabResults."Lab Unique No", UID);
        LabResults.SETRANGE(LabResults."Laboratory No.", LabNo);
        LabResults.SETRANGE(LabResults."Laboratory Test Code", LabTestCode);
        LabResults.SETRANGE(LabResults."Specimen Code", SpecimenCode);
        IF LabResults.FIND('-') THEN BEGIN

            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            IF Type = 'REVIEW' THEN BEGIN
                LabResults."Reveiw Date" := TODAY;
                LabResults."Reviewed By" := Labuser;
                LabResults."Review Time" := TIME;
            END ELSE BEGIN
                LabResults."Assigned User ID" := Labuser;
            END;
            LabResults."Collection Date" := TODAY;
            LabResults."Collection Time" := TIME;
            LabResults.Results := Results;
            LabResults.Remarks := Remarks;
            LabResults.VALIDATE(Results);
            LabResults.VALIDATE("Laboratory Test Code");
            LabResults.VALIDATE(Remarks);
            LabResults.MODIFY;
        END ELSE BEGIN
            LabResults.INIT;
            LabResults."Lab Unique No" := UID;
            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            IF Type = 'REVIEW' THEN BEGIN
                LabResults."Reveiw Date" := TODAY;
                LabResults."Reviewed By" := Labuser;
                LabResults."Review Time" := TIME;
            END ELSE BEGIN
                LabResults."Assigned User ID" := Labuser;
            END;
            LabResults."Collection Date" := TODAY;
            LabResults."Collection Time" := TIME;
            LabResults.Results := Results;
            LabResults.Remarks := Remarks;
            LabResults.VALIDATE(Results);
            LabResults.VALIDATE("Laboratory Test Code");
            LabResults.VALIDATE(Remarks);
            LabResults.INSERT;
        END;
        LabHeader.SETRANGE("Laboratory No.", LabNo);
        IF LabHeader.FIND('-') THEN BEGIN
            IF Type = 'REVIEW' THEN BEGIN
                LabHeader."Reveiw Date" := TODAY;
                LabHeader."Reviewed By" := Labuser;
                LabHeader."Review Time" := TIME;
            END ELSE BEGIN
                //docHeader."Assigned User ID" :=Labuser;
            END;
            LabHeader.MODIFY();

            docHeader.SETRANGE(docHeader."Treatment No.", LabHeader."Link No.");
            IF docHeader.FIND('-') THEN BEGIN
                objAppointment.SETRANGE(objAppointment."Appointment No.", docHeader."Link No.");
                IF objAppointment.FIND('-') THEN BEGIN
                    objAppointment."Lab Time Out" := CURRENTDATETIME;
                    objAppointment."Waiting At" := objAppointment."waiting at";
                    objAppointment.MODIFY;
                END;
            END;
        END;
    END;

    PROCEDURE InsertLabRemarks(LabNo: Text; LabTestCode: Text; SpecimenCode: Text; Remarks: Text; Labuser: Text);
    VAR
        Result2: Record "HMS Laboratory Results Entry";
    BEGIN
        LabResults.SETRANGE(LabResults."Laboratory No.", LabNo);
        LabResults.SETRANGE(LabResults."Laboratory Test Code", LabTestCode);
        LabResults.SETRANGE(LabResults."Specimen Code", SpecimenCode);
        IF LabResults.FIND('-') THEN BEGIN
            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            LabResults."Assigned User ID" := Labuser;
            LabResults."Collection Date" := TODAY;
            LabResults."Collection Time" := TIME;
            LabResults.Remarks := Remarks;
            LabResults.MODIFY;
        END ELSE BEGIN
            LabResults.INIT;
            LabResults."Laboratory No." := LabNo;
            LabResults."Laboratory Test Code" := LabTestCode;
            LabResults."Specimen Code" := SpecimenCode;
            LabResults."Assigned User ID" := Labuser;
            LabResults."Collection Date" := TODAY;
            LabResults."Collection Time" := TIME;
            LabResults.Remarks := Remarks;
            LabResults.INSERT;
        END;
        LabHeader.SETRANGE("Laboratory No.", LabNo);
        IF LabHeader.FIND('-') THEN
            docHeader.SETRANGE(docHeader."Treatment No.", LabHeader."Link No.");
        IF docHeader.FIND('-') THEN
            objAppointment.SETRANGE(objAppointment."Appointment No.", docHeader."Link No.");
        IF objAppointment.FIND('-') THEN
            objAppointment."Lab Time Out" := CURRENTDATETIME;
        objAppointment."Waiting At" := objAppointment."waiting at";
        objAppointment.MODIFY;
    END;

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
            LabResults."Collection Time" := DT2TIME(System.CurrentDateTime);
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
            LabResults."Collection Time" := DT2TIME(System.CurrentDateTime);
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
        if objAppointment.Find('-') then
            objAppointment."Lab Time Out" := CurrentDatetime;
        objAppointment."Waiting At" := objAppointment."waiting at";
        objAppointment.Modify;
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
            LabResults."Collection Time" := DT2TIME(System.CurrentDateTime);
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
            LabResults."Collection Time" := DT2TIME(System.CurrentDateTime);
            LabResults.Remarks := Remarks;
            LabResults.Insert;
        end;
        LabHeader.SetRange("Laboratory No.", LabNo);
        if LabHeader.Find('-') then
            docHeader.SetRange(docHeader."Treatment No.", LabHeader."Link No.");
        if docHeader.Find('-') then
            objAppointment.SetRange(objAppointment."Appointment No.", docHeader."Link No.");
        if objAppointment.Find('-') then
            objAppointment."Lab Time Out" := CurrentDatetime;
        objAppointment."Waiting At" := objAppointment."waiting at";
        objAppointment.Modify;
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
        PharmHeader."Pharmacy Time" := DT2TIME(System.CurrentDateTime);
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
        PhysioEvalution.Init;
        PhysioEvalution."Physio No" := PhysioNo;
        PhysioEvalution.Type := Type;
        PhysioEvalution.SubType := SubType;
        PhysioEvalution."Patient No" := PatientNo;
        PhysioEvalution.Description := Description;
        PhysioEvalution.Insert;
    end;

    procedure GeneratePhysioEvalution(PhysioNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);


        PhysioHeader.Reset;
        PhysioHeader.SetRange(PhysioHeader."No.", PhysioNo);


        if PhysioHeader.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Physio Evalution Form", filename, PhysioHeader);

        end;
        exit(filename);
    end;

    procedure InsertAdmissionFormNotes(TreatmentNo: Text; NotesType: Option; Notes: Text)
    begin
        AdmissionFormNotes.Init;
        AdmissionFormNotes."Treatment No" := TreatmentNo;
        AdmissionFormNotes.Notes := Notes;
        AdmissionFormNotes."Notes Type" := NotesType;
        AdmissionFormNotes.Insert;
    end;

    procedure GenerateP9Report(EmployeeNo: Text; Year: Integer; filenameFromApp: Text): Text[100]
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        HREmp.Reset;
        HREmp.SetRange(HREmp."No.", EmployeeNo);
        //HrEmp.SETRANGE(HrEmp."Period Filter",Period);

        if HREmp.Find('-') then begin
            HREmp.P9Year := Year;
            HREmp.Modify;
            Message(filename);
            Report.SaveAsPdf(50002, filename, HREmp);
            Message(filename);
        end;
        exit(filename);
    end;

    procedure InsertPartographValues(PNo: Code[10]; GType: Integer; Xvalues: Time; YValues: Code[10])
    begin
        Partograph.Reset;
        Partograph."Patient No" := PNo;
        Partograph.Graph := GType;
        Partograph.XValues := Xvalues;
        Partograph.YValues := YValues;
        //Partograph.Contractions := Contraction;
        Partograph.Insert;
    end;

    procedure InsertChildInformation(EmployeeNo: Text; Sname: Text; Fname: Text; Mname: Text; gender: Option; Dob: Date; Marital: Option; Id: Text; Address: Text; PostalCode: Text; City: Text; Phone: Text; Email: Text; Nationality: Text; Bloodgrp: Text; NextkinName: Text; NextkinRelationship: Text; NextkinContact: Text; InsuranceNo: Text; InsuranceName: Text; InsuranceMemberNo: Text; PatientType: Option)
    begin
        HMSSetup.Get;
        ChildInformation.Init();
        ChildInformation."Patient No." := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", 0D, true);
        ChildInformation.Validate("Patient No.");
        ChildInformation."Date Registered" := Today;
        //ChildInformation."Patient Type" := PatientType;
        //ChildInformation.VALIDATE("Patient Type");
        ChildInformation."Employee No." := EmployeeNo;
        ChildInformation.Surname := Sname;
        ChildInformation."First Name" := Fname;
        ChildInformation."Middle Name" := Mname;
        ChildInformation.Gender := gender;
        ChildInformation."Date Of Birth" := Dob;
        ChildInformation."Marital Status" := Marital;
        ChildInformation."Spouse Fax" := '';
        //ChildInformation.VALIDATE("Spouse Fax");
        ChildInformation."Place of Birth Village" := '';
        //ChildInformation."Correspondence Address 2" :=PostalCode;
        //ChildInformation."Correspondence Address 3" :=City;
        ChildInformation."Place of Birth Location" := '';
        ChildInformation."Place of Birth District" := '';
        ChildInformation.Nationality := Nationality;
        //ChildInformation."Blood Group" :=Bloodgrp;
        ChildInformation."Next Of kin Full Name" := NextkinName;
        ChildInformation."Next of kin Relationship" := NextkinRelationship;
        ChildInformation."Next Of kin Address 1" := Address;
        ChildInformation."Next Of kin Address 2" := NextkinContact;
        //ChildInformation."Insurance No." :=InsuranceNo;
        //ChildInformation."Insurance Name" := InsuranceName;
        ChildInformation."Membership No" := InsuranceMemberNo;
        //ChildInformation.VALIDATE("Patient Ref. No.");
        ChildInformation.Validate("Spouse Telephone No. 1");
        ChildInformation.Validate("Spouse Telephone No. 2");
        ChildInformation.Validate("Spouse Email");
        ChildInformation.Insert;
    end;

    procedure InsertChildGrowth(PNo: Code[20]; Weight: Decimal; Height: Decimal)
    begin
        ChildGrowth.Reset;
        ChildGrowth."Patient No" := PNo;
        ChildInformation.Reset;
        ChildInformation.SetRange(ChildInformation."Patient No.", PNo);
        if ChildInformation.Find('-') then
            ChildGrowth.Gender := ChildInformation.Gender;
        ChildGrowth.Weight := Weight;
        ChildGrowth.Height := Height;
        ChildGrowth."Date Taken" := Today;
        ChildGrowth."User ID" := UserId;
        ChildGrowth.Insert;
    end;

    procedure InsertMother(EmployeeNo: Text; Sname: Text; Fname: Text; Mname: Text; gender: Option; Dob: Date; Marital: Option; Id: Text; Address: Text; PostalCode: Text; City: Text; Phone: Text; Email: Text; Nationality: Text; Bloodgrp: Text; NextkinName: Text; NextkinRelationship: Text; NextkinContact: Text; InsuranceNo: Text; InsuranceName: Text; InsuranceMemberNo: Text; PatientType: Option)
    begin
        HMSSetup.Get;
        MothersList.Init();
        MothersList."Patient No." := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", 0D, true);
        MothersList.Validate("Patient No.");
        MothersList."Date Registered" := Today;
        MothersList."Patient Type" := PatientType;
        MothersList.Validate("Patient Type");
        MothersList."Employee No." := EmployeeNo;
        MothersList.Surname := Sname;
        MothersList."Middle Name" := Fname;
        MothersList."Last Name" := Mname;
        MothersList.Gender := gender;
        MothersList."Date Of Birth" := Dob;
        MothersList."Marital Status" := Marital;
        MothersList."ID Number" := Id;
        MothersList.Validate("ID Number");
        MothersList."Correspondence Address 1" := Address;
        MothersList."Correspondence Address 2" := PostalCode;
        MothersList."Correspondence Address 3" := City;
        MothersList."Telephone No. 1" := Phone;
        MothersList.Email := Email;
        MothersList.Nationality := Nationality;
        MothersList."Blood Group" := Bloodgrp;
        MothersList."Next Of kin Full Name" := NextkinName;
        MothersList."Next of kin Relationship" := NextkinRelationship;
        MothersList."Next Of kin Address 1" := Address;
        MothersList."Next Of kin Address 2" := NextkinContact;
        MothersList."Insurance No." := InsuranceNo;
        MothersList."Insurance Name" := InsuranceName;
        MothersList."Membership No" := InsuranceMemberNo;
        MothersList.Validate("Patient Ref. No.");
        MothersList.Validate(Surname);
        MothersList.Validate("Middle Name");
        MothersList.Validate("Last Name");
        MothersList.Insert;
    end;

    procedure InsertPatientHistoryNotes(PatientNo: Text; TreatmentNo: Text; NotesType: Option; Notes: Text)
    begin
        PatientHistory.Init;
        PatientHistory."Patient No" := PatientNo;
        PatientHistory."Treatment No" := TreatmentNo;
        PatientHistory."Notes Type" := NotesType;
        // PatientHistory.Notes := Notes;
        PatientHistory.Insert;
    end;

    procedure GeneratePhysioNotes(AdmissionNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        Message(filename);
        objNurseNote.Reset;
        objNurseNote.SetRange(objNurseNote."Admission No.", AdmissionNo);
        objNurseNote.SetRange(objNurseNote."Nurse Type", objNurseNote."nurse type"::Physiotherapist);

        if objNurseNote.Find('-') then begin
            // Report.SaveAsPdf(39005887,filename,objNurseNote);
            Message(filename);
        end;
        exit(filename);
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
        TreatmentProcess: Record "HMS Treatment Form Process";
        ObservationSymptoms: Record "HMS Observation Symptoms";
        TreatmentLaboratory: Record "HMS Treatment Form Laboratory";
        TreatmentRadiology: Record "HMS Treatment Form Radiology";
        TheatreProcess: Record "HMS Theatre Line Process";
        ICUProcess: Record "HMS ICU Line Process";
        TreatmentDiagnosis: Record "HMS Treatment Form Diagnosis";
        TreatmentInjection: Record "HMS Treatment Form Injection";
        TreatmentDrug: Record "HMS Treatment Form Drug";
        TreatmentAdmission: Record "HMS Treatment Admission";
        TreatmentReferral: Record "HMS Treatment Referral";
        hmsNotes: Record "hms Notes";
        Buffer: Record "Treatment Buffer";
        Ln: Integer;
        UserRec: Record "User Setup";
    begin
        intCount[1] := 1;


        Buffer.Reset;
        Buffer.SetRange(Buffer."Treatment No", TreatmentNo);
        if Buffer.Find('-') then Buffer.DeleteAll;

        //Process
        // TreatmentProcess.RESET;
        // TreatmentProcess.SETRANGE(TreatmentProcess."Treatment No.",TreatmentNo);
        // IF TreatmentProcess.FIND('-') THEN BEGIN
        //  REPEAT
        //  Ln:=Ln+1;
        //  Buffer.INIT;
        //  Buffer."Treatment No":=TreatmentNo;
        //  Buffer."Line No":=Ln;
        //  Buffer.Category:='Vitals';
        //  Buffer.Code  :=TreatmentProcess."Patient No.";
        //  Buffer.Description:=TreatmentProcess."Pulse Rate";
        //  Buffer.Remarks:=TreatmentProcess.Temperature;
        //  Buffer."Sort Order":=1;
        //  Buffer.INSERT;
        //  UNTIL TreatmentProcess.NEXT=0;
        // END;
        // Symtomps
        ObservationSymptoms.Reset;
        ObservationSymptoms.SetRange(ObservationSymptoms."Treatment No.", TreatmentNo);
        if ObservationSymptoms.Find('-') then begin
            repeat
                Ln := Ln + 1;
                Buffer.Init;
                Buffer."Treatment No" := TreatmentNo;
                Buffer."Line No" := Ln;
                Buffer.Category := '02.Symptoms';
                Buffer.Code := ObservationSymptoms."Symptom Code";
                Buffer.Description := ObservationSymptoms.Description;
                Buffer.Remarks := ObservationSymptoms.Characteristics;
                Buffer."Sort Order" := 2;
                Buffer.Insert;
            until ObservationSymptoms.Next = 0;
        end;

        // Laboratory
        TreatmentLaboratory.Reset;
        TreatmentLaboratory.SetRange(TreatmentLaboratory."Treatment No.", TreatmentNo);
        if TreatmentLaboratory.Find('-') then begin
            repeat
                Ln := Ln + 1;
                Buffer.Init;
                Buffer."Treatment No" := TreatmentNo;
                Buffer."Line No" := Ln;
                Buffer.Category := '04.Laboratory';
                Buffer.Code := TreatmentLaboratory."Laboratory Test Package Code";
                Buffer.Description := TreatmentLaboratory.Specimen;
                Buffer.Remarks := TreatmentLaboratory.Results;
                Buffer."Sort Order" := 3;
                Buffer.Insert;
            until ObservationSymptoms.Next = 0;
        end;

        // Radiology
        TreatmentRadiology.Reset;
        TreatmentRadiology.SetRange(TreatmentRadiology."Treatment No.", TreatmentNo);
        if TreatmentRadiology.Find('-') then begin
            repeat
                Ln := Ln + 1;
                Buffer.Init;
                Buffer."Treatment No" := TreatmentNo;
                Buffer."Line No" := Ln;
                Buffer.Category := '05.Radiology';
                Buffer.Code := TreatmentRadiology."Radiology Type Code";
                Buffer.Description := TreatmentRadiology."Required Investigation";
                Buffer.Remarks := TreatmentRadiology."Clinical Summary &  Diagnosis";
                Buffer."Sort Order" := 4;
                Buffer.Insert;
            until TreatmentRadiology.Next = 0;
        end;

        // Theatre
        TheatreProcess.Reset;
        TheatreProcess.SetRange(TheatreProcess."No.", TreatmentNo);
        if TheatreProcess.Find('-') then begin
            repeat
                Ln := Ln + 1;
                Buffer.Init;
                Buffer."Treatment No" := TreatmentNo;
                Buffer."Line No" := Ln;
                Buffer.Category := '06.Theatre';
                Buffer.Code := TheatreProcess."Process No.";
                Buffer.Description := TheatreProcess."Process Remarks";
                Buffer.Remarks := TheatreProcess."Process Result";
                Buffer."Sort Order" := 5;
                Buffer.Insert;
            until TheatreProcess.Next = 0;
        end;

        // ICU
        ICUProcess.Reset;
        ICUProcess.SetRange(ICUProcess."No.", TreatmentNo);
        if ICUProcess.Find('-') then begin
            repeat
                Ln := Ln + 1;
                Buffer.Init;
                Buffer."Treatment No" := TreatmentNo;
                Buffer."Line No" := Ln;
                Buffer.Category := '07.ICU';
                Buffer.Code := ICUProcess."Process No.";
                Buffer.Description := ICUProcess."Process Remarks";
                Buffer.Remarks := ICUProcess."Process Result";
                Buffer."Sort Order" := 6;
                Buffer.Insert;
            until ICUProcess.Next = 0;
        end;

        // Diagnosis
        TreatmentDiagnosis.Reset;
        TreatmentDiagnosis.SetRange(TreatmentDiagnosis."Treatment No.", TreatmentNo);
        if TreatmentDiagnosis.Find('-') then begin
            repeat
                TreatmentDiagnosis.CalcFields("Diagnosis Name");
                Ln := Ln + 1;
                Buffer.Init;
                Buffer."Treatment No" := TreatmentNo;
                Buffer."Line No" := Ln;
                Buffer.Category := '01.Diagnosis';
                Buffer.Code := TreatmentDiagnosis."Diagnosis Code";
                Buffer.Description := TreatmentDiagnosis."Diagnosis Name";
                Buffer.Remarks := TreatmentDiagnosis.Remarks;
                Buffer."Sort Order" := 7;
                Buffer.Insert;
            until TreatmentDiagnosis.Next = 0;
        end;

        // Drug
        TreatmentDrug.Reset;
        TreatmentDrug.SetRange(TreatmentDrug."Treatment No.", TreatmentNo);
        if TreatmentDrug.Find('-') then begin
            repeat
                Ln := Ln + 1;
                Buffer.Init;
                Buffer."Treatment No" := TreatmentNo;
                Buffer."Line No" := Ln;
                Buffer.Category := '04.Prescription';
                Buffer.Code := TreatmentDrug."Drug No.";
                Buffer.Description := TreatmentDrug."Drug Name";
                Buffer.Remarks := TreatmentDrug.Dosage + ' - ' + Format(TreatmentDrug.Frequency) + ' - ' + Format(TreatmentDrug.Route);
                Buffer."Sort Order" := 8;
                Buffer.Insert;
            until TreatmentDrug.Next = 0;
        end;
        // Admissions
        TreatmentAdmission.Reset;
        TreatmentAdmission.SetRange(TreatmentAdmission."Treatment No.", TreatmentNo);
        if TreatmentAdmission.Find('-') then begin
            repeat
                Ln := Ln + 1;
                Buffer.Init;
                Buffer."Treatment No" := TreatmentNo;
                Buffer."Line No" := Ln;
                Buffer.Category := '09.Admission';
                Buffer.Code := TreatmentAdmission."Bed No.";
                Buffer.Description := TreatmentAdmission."Admission Remarks";
                Buffer.Remarks := TreatmentAdmission."Admission Reason";
                Buffer."Sort Order" := 9;
                Buffer.Insert;
            until TreatmentAdmission.Next = 0;
        end;
        // Referral
        TreatmentReferral.Reset;
        TreatmentReferral.SetRange(TreatmentReferral."Treatment No.", TreatmentNo);
        if TreatmentReferral.Find('-') then begin
            repeat
                Ln := Ln + 1;
                Buffer.Init;
                Buffer."Treatment No" := TreatmentNo;
                Buffer."Line No" := Ln;
                Buffer.Category := '10.Referral';
                Buffer.Code := TreatmentReferral."Hospital No.";
                Buffer.Description := TreatmentReferral."Referral Remarks";
                Buffer.Remarks := TreatmentReferral."Referral Reason";
                Buffer."Sort Order" := 10;
                Buffer.Insert;
            until TreatmentReferral.Next = 0;
        end;
        // Notes
        hmsNotes.Reset;
        hmsNotes.SetRange(hmsNotes.TreatmentNo, TreatmentNo);
        if hmsNotes.Find('-') then begin
            repeat
                Ln := Ln + 1;
                Buffer.Init;
                Buffer."Treatment No" := TreatmentNo;
                Buffer."Line No" := Ln;
                Buffer.Category := '02.Notes';
                Buffer.Code := Format(hmsNotes."Notes Type");
                if UserRec.Get(hmsNotes."User ID") then
                    Buffer.Description := UserRec.UserName
                else
                    Buffer.Description := hmsNotes."User ID";
                // Buffer.Remarks := hmsNotes.Notes; TODO : Notes is a blob field. Need to refactor to use RichTextContent
                Buffer."Sort Order" := 2;
                Buffer.Insert;
            until hmsNotes.Next = 0;
        end;
    end;

    procedure InsertChiefComplaints(TreatmentNo: Code[30]; PatientNo: Code[30]; Notes: Text; TreatmentDate: Date; "docUSER ID": Code[30])
    begin
        objNotes.SetRange(objNotes."Patient No", PatientNo);
        objNotes.SetRange(objNotes.TreatmentNo, TreatmentNo);
        objNotes.SetRange(objNotes."Treatment Date", TreatmentDate);
        objNotes.SetRange(objNotes."User ID", "docUSER ID");
        // objNotes.SetRange(objNotes.Notes, Notes); TODO : Notes is a blob field. Need to refactor to use RichTextContent
        // objNotes.SetRange(objNotes."Notes Type", objNotes."notes type"::"Chief Complaints");
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := DT2TIME(System.CurrentDateTime);
            objNotes."Creation DateTime" := CurrentDatetime;
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

    PROCEDURE ForwardLabResults(TreatmentNo: Text; LabNo: Text; TestCode: Text; Type: Text; Reviewer: Code[30]; Uniq: Integer);
    BEGIN
        //Changed
        ObjLab.RESET;
        ObjLab.SETRANGE(ObjLab."Treatment No.", TreatmentNo);
        ObjLab.SETRANGE(ObjLab."Lab No", LabNo);
        ObjLab.SETRANGE(ObjLab."Laboratory Test Package Code", TestCode);
        ObjLab.SETRANGE(ObjLab."Line No", Uniq);
        // ObjLab.SETRANGE(ObjLab."Date Due", TODAY);
        IF ObjLab.FIND('-') THEN BEGIN
            REPEAT
                IF Type = 'INTERIM' THEN
                    ObjLab.Status := ObjLab.Status::Interim
                ELSE
                    IF Type = 'RECALLED' THEN
                        ObjLab.Status := ObjLab.Status::Recalled
                    ELSE
                        IF Type = 'REVIEW' THEN BEGIN
                            ObjLab.Status := ObjLab.Status::Review;
                        END ELSE
                            ObjLab.Status := ObjLab.Status::Completed;
                ObjLab.MODIFY;
            UNTIL ObjLab.NEXT = 0;
        END;
        //docHeader.GET(TreatmentNo);
        LaboratoryLines.SETRANGE("Laboratory No.", LabNo);
        LaboratoryLines.SETRANGE("Laboratory Test Code", TestCode);
        LaboratoryLines.SETRANGE("Unique No", Uniq);
        IF LaboratoryLines.FIND('-') THEN BEGIN
            REPEAT
                IF Type = '' THEN BEGIN
                    LaboratoryLines.Completed := TRUE;
                    LaboratoryLines."Completion Time" := TIME;
                    LaboratoryLines.Status := LaboratoryLines.Status::Completed;
                    LaboratoryLines."Completion Date" := TODAY;
                END;
                IF Type = 'REVIEW' THEN BEGIN
                    LaboratoryLines."Reviewed By" := Reviewer;
                    LaboratoryLines.Status := LaboratoryLines.Status::Review;
                    LaboratoryLines."Reveiw Date" := TODAY;
                    LaboratoryLines."Review Time" := TIME;
                END;
                LaboratoryLines.MODIFY;
            UNTIL LaboratoryLines.NEXT = 0;
        END;
        IF LabHeader.GET(LabNo) THEN BEGIN
            IF Type = 'INTERIM' THEN
                LabHeader.Status := LabHeader.Status::Interim
            ELSE
                IF Type = 'RECALLED' THEN
                    LabHeader.Status := LabHeader.Status::Recalled
                ELSE
                    IF Type = 'REVIEW' THEN
                        LabHeader.Status := LabHeader.Status::Review
                    ELSE
                        LabHeader.Status := LabHeader.Status::Completed;
            LabHeader."Completion Date" := TODAY;
            LabHeader."Completion Time" := TIME;
            LabHeader.MODIFY;
        END;

        Patient.SETRANGE(Patient."Patient No.", docHeader."Patient No.");
        IF Patient.FIND('-') THEN
            HMSQue.INIT;
        HMSQue."Patient No" := Patient."Patient No.";
        HMSQue."Visit No" := Patient."Active Visit No";
        HMSQue."Document No" := LabNo;
        HMSQue.Type := 'LABORATORY';
        HMSQue."Queue Type" := 'RESULTS';
        HMSQue."Doctor ID" := docHeader."Doctor ID";
        HMSQue.Date := TODAY;
        HMSQue.Time := TIME;
        HMSQue.INSERT;
    END;

    procedure AssignDoctor(PatientNo: Text; TreatmentNo: Text; DocId: Text) Assigned: Boolean
    begin
        Assigned := false;

        UserSetUpPortal.Reset;
        UserSetUpPortal.SetRange(UserSetUpPortal."User ID", DocId);
        if UserSetUpPortal.Find('-') then begin
            if UserSetUpPortal."Doctor ID" <> '' then begin
                ObjPatient.Reset;
                ObjPatient.SetRange(ObjPatient."Patient No.", PatientNo);
                if ObjPatient.Find('-') then begin
                    HMSPatientsCharges.Reset;
                    HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
                    HMSPatientsCharges.SetRange(HMSPatientsCharges."Visit No", ObjPatient."Active Visit No");
                    if HMSPatientsCharges.Find('-') then begin
                        repeat
                            HMSPatientsCharges.Validate(HMSPatientsCharges."Transaction Type");
                            HMSPatientsCharges."Doctor ID" := UserSetUpPortal."Doctor ID";
                            HMSPatientsCharges.Validate("Doctor ID");
                            HMSPatientsCharges.Date := Today;
                            HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Appointment;
                            HMSPatientsCharges.Modify;

                        until HMSPatientsCharges.Next = 0;
                    end;
                end;


                if docHeader.Get(TreatmentNo) then
                    docHeader."Doctor ID" := UserSetUpPortal."Doctor ID";
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

    procedure BookTCA(PatientNo: Text; TCADate: Date; Doctor: Text; BookedBy: Code[50])
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
            if UserSetUpPortal.Find('-')
              then begin
                if BookedBy = UserSetUpPortal."Doctor ID" then begin
                    objAppointment."ReAppointment Doctor ID" := BookedBy;
                    objAppointment."Booked By" := UserSetUpPortal."Doctor ID";
                end else
                    objAppointment."ReAppointment Doctor ID" := UserSetUpPortal."Doctor ID";

            end;
            objAppointment."ReAppointment Type Code" := 'REVIEW';
            objAppointment.Modify;
        end;
    end;

    PROCEDURE VoidLabTest(LabNo: Text; LabTest: Text; Reason: Text; LinNo: Integer);
    BEGIN
        LabTestLines.RESET;
        LabTestLines.SETRANGE(LabTestLines."Laboratory No.", LabNo);
        LabTestLines.SETRANGE(LabTestLines."Unique No", LinNo);
        LabTestLines.SETRANGE(LabTestLines."Laboratory Test Code", LabTest);
        IF LabTestLines.FIND('-') THEN
            LabTestLines.DELETE;

        LabHeader.GET(LabNo);
        ObjPatient.SETRANGE("Patient No.", LabHeader."Patient No.");
        IF ObjPatient.FIND('-') THEN
            HMSPatientsCharges.RESET;
        HMSPatientsCharges.SETRANGE(HMSPatientsCharges."Patient No.", LabHeader."Patient No.");
        HMSPatientsCharges.SETRANGE(HMSPatientsCharges."Visit No", ObjPatient."Active Visit No");
        HMSPatientsCharges.SETRANGE(HMSPatientsCharges.Code, LabTest);
        IF HMSPatientsCharges.FIND('-') THEN
            HMSPatientsCharges.DELETE;

        ObjLab.RESET;
        ObjLab.SETRANGE(ObjLab."Laboratory Test Package Code", LabTest);
        ObjLab.SETRANGE(ObjLab."Line No", LinNo);
        ObjLab.SETRANGE(ObjLab."Treatment No.", LabHeader."Link No.");
        IF ObjLab.FIND('-') THEN
            ObjLab.DELETE;
        LabHeader.RESET;
        LabHeader.SETRANGE("Laboratory No.", LabNo);
        IF LabHeader.FIND('-') THEN
            LabHeader."Test Voided" := LabHeader."Test Voided" + '1. ' + LabTest + ' ,';
        LabHeader."Reason For Voiding" := LabHeader."Reason For Voiding" + '1. ' + Reason + ' ,';
        LabHeader.MODIFY;
    END;

    procedure InsertOutpatientPro(TreatmentNo: Text; PatientNo: Text; OpProcedure: Code[20]; Description: Text; Department: Text; EmployeeNo: Text; Doctor: Text)
    begin
        OutpatientPro.Init;
        OutpatientPro."Treatment No" := TreatmentNo;
        OutpatientPro."Patient No" := PatientNo;
        OutpatientPro."Procedure" := OpProcedure;
        OutpatientPro.Description := Description;
        OutpatientPro.Department := Department;
        OutpatientPro.Employee := EmployeeNo;
        OutpatientPro."Procedure Date" := CurrentDatetime;
        OutpatientPro.Doctor := Doctor;
        OutpatientPro.Insert;
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

    procedure UpdateIntervals()
    var
        HMSOutpatientProcedures: Record "HMS Outpatient Procedures";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
        Duration: Duration;
    begin
        HMSOutpatientProcedures.Reset;
        HMSOutpatientProcedures.SetFilter("Procedure Date", '<>%1', 0DT);
        if HMSOutpatientProcedures.FindSet then begin
            repeat
                HMSTreatmentFormHeader.Reset;
                HMSTreatmentFormHeader.SetRange("Treatment No.", HMSOutpatientProcedures."Treatment No");
                HMSTreatmentFormHeader.SetRange(Status, HMSTreatmentFormHeader.Status::New);
                if HMSTreatmentFormHeader.Find('-') then begin
                    if HMSOutpatientProcedures."Procedure Date" <> 0DT then begin
                        Duration := CurrentDatetime - HMSOutpatientProcedures."Procedure Date";
                        HMSOutpatientProcedures."Time Interval" := Format(Duration);
                        HMSOutpatientProcedures.Modify();
                    end;
                end;
            until HMSOutpatientProcedures.Next = 0;
        end;
    end;

    procedure InsertEdmontonValue(TxtNo: Code[30]; PatientNo: Code[30]; Pain: Integer; Tiredness: Integer; Drowsiness: Integer; Nausea: Integer; Appetite: Integer; ShortnessOfBreath: Integer; Depression: Integer; Anxiety: Integer; WellBeing: Integer; Other: Integer)
    begin
        EdmontonScale.Init;
        EdmontonScale."Treatment No" := TxtNo;
        EdmontonScale."Patient No" := PatientNo;
        EdmontonScale.Pain := Pain;
        EdmontonScale.Tiredness := Tiredness;
        EdmontonScale.Drowsiness := Drowsiness;
        EdmontonScale.Nausea := Nausea;
        EdmontonScale.Appetite := Appetite;
        EdmontonScale."Shortness of Breath" := ShortnessOfBreath;
        EdmontonScale.Depression := Depression;
        EdmontonScale.Anxienty := Anxiety;
        EdmontonScale.Wellbeing := WellBeing;
        EdmontonScale.Other := Other;
        EdmontonScale.Insert;
    end;

    procedure UpdateEdmontonValue(TxtNo: Code[30]; PatientNo: Code[30]; Pain: Integer; Tiredness: Integer; Drowsiness: Integer; Nausea: Integer; Appetite: Integer; ShortnessOfBreath: Integer; Depression: Integer; Anxiety: Integer; WellBeing: Integer; Other: Integer)
    begin
        EdmontonScale.Reset;
        EdmontonScale.SetRange("Treatment No", TxtNo);
        if EdmontonScale.FindFirst() then begin

            EdmontonScale.Pain := Pain;
            EdmontonScale.Tiredness := Tiredness;
            EdmontonScale.Drowsiness := Drowsiness;
            EdmontonScale.Nausea := Nausea;
            EdmontonScale.Appetite := Appetite;
            EdmontonScale."Shortness of Breath" := ShortnessOfBreath;
            EdmontonScale.Depression := Depression;
            EdmontonScale.Anxienty := Anxiety;
            EdmontonScale.Wellbeing := WellBeing;
            EdmontonScale.Other := Other;
            EdmontonScale.Modify();

        end;
    end;

    procedure DipatchtoDoctor(SettlementType: Option; Doctor: Text; PatientNo: Text; AppointmentNo: Text; ObservationNo: Text; TreatmentNo: Text)
    var
        AppointmentType: Text;
        TriageNotes: Text;
        UiDD: Text;
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
        docHeader.Reset;
        docHeader.SetRange(docHeader."Patient No.", PatientNo);
        docHeader.SetRange(docHeader."Treatment Date", Today);
        docHeader.SetRange(docHeader."Link Type", 'Outpatient');
        if docHeader.Find('-') then begin
            // MESSAGE('Patient already sent to doctor');

            UiDD := CreateGuid;
            ObsLine.Reset;
            ObsLine.SetRange(ObsLine."Observation No.", ObservationNo);
            ObsLine.SetRange(ObsLine.Type, ObsLine.Type::Triage);
            if ObsLine.Find('-') then begin
                repeat
                    TreatmentLine.Init;
                    TreatmentLine."Treatment No." := NewNo;
                    TreatmentLine.Type := TreatmentLine.Type::Triage;
                    TreatmentLine."Patient No." := ObsLine."Patient No.";
                    TreatmentLine.Validate("Patient No.");
                    TreatmentLine.Pain := ObsLine.Pain;
                    TreatmentLine."Pulse Rate" := ObsLine."Pulse Rate";
                    TreatmentLine."Blood Pressure" := ObsLine."Blood Pressure";
                    TreatmentLine.Temperature := ObsLine.Temperature;
                    TreatmentLine.Height := ObsLine.Height;
                    TreatmentLine.Weight := ObsLine.Weight;
                    TreatmentLine.BMI := ObsLine.BMI;
                    TreatmentLine.SP02 := ObsLine.SP02;
                    TreatmentLine."Respiration Rate" := ObsLine."Respiration Rate";
                    TreatmentLine."Date Created" := ObsLine."Date Created";
                    TreatmentLine."Date Taken" := ObsLine."Date Taken";
                    TreatmentLine.Time := ObsLine.Time;
                    TreatmentLine.Insert;
                until ObsLine.Next = 0;
            end;
        end else begin
            NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);

            docHeader.Init;
            docHeader."Treatment No." := NewNo;
            docHeader."Treatment Date" := Today;
            docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
            docHeader."Doctor ID" := Doctor;
            docHeader."Patient No." := PatientNo;
            //docHeader."Student No.":="Student No.";
            //docHeader."Employee No.":="Employee No.";
            //docHeader."Relative No.":="Relative No.";
            docHeader.Clinic := docHeader.Clinic;
            docHeader.Direct := true;
            docHeader."Link No." := AppointmentNo;
            docHeader."Triage Notes" := TriageNotes;
            ObjPatient.Reset;
            ObjPatient.SetRange("Patient No.", PatientNo);
            if ObjPatient.Find('-') then
                docHeader.Branch := ObjPatient."Global Dimension 1 Code";
            //:=LabHeader."Request Area"::Doctor;
            docHeader."Link Type" := 'Outpatient';
            // docHeader."Link No.":=TreatmentHeader."Appointment No.";
            docHeader.Insert;

            if AppType.Get(AppointmentType) then begin
                DoctorsRec.Reset;
                DoctorsRec.SetRange(DoctorsRec."Doctor ID", Doctor);
                if DoctorsRec.Find('-') then
                    DoctorsRec.TestField("Consultation Code");
                HMSPatientsCharges.Reset;
                HMSPatientsCharges.SetRange(HMSPatientsCharges."Patient No.", PatientNo);
                HMSPatientsCharges.SetRange(HMSPatientsCharges."Appointment No.", AppointmentNo);
                if HMSPatientsCharges.Find('-') then begin
                    repeat
                        HMSPatientsCharges.Validate(HMSPatientsCharges."Transaction Type");
                        HMSPatientsCharges."Doctor ID" := Doctor;
                        HMSPatientsCharges.Date := Today;
                        HMSPatientsCharges."Bill Section" := HMSPatientsCharges."bill section"::Appointment;
                        HMSPatientsCharges.Modify;

                    until HMSPatientsCharges.Next = 0;
                end;
            end;




        end;
        UiDD := CreateGuid;
        ObsLine.Reset;
        ObsLine.SetRange(ObsLine."Observation No.", ObservationNo);
        if ObsLine.Find('-') then begin
            repeat
                TreatmentLine.Init;
                TreatmentLine."Treatment No." := NewNo;
                TreatmentLine.Type := TreatmentLine.Type::Triage;
                TreatmentLine."Patient No." := ObsLine."Patient No.";
                TreatmentLine.Validate("Patient No.");
                TreatmentLine.Pain := ObsLine.Pain;
                TreatmentLine."Pulse Rate" := ObsLine."Pulse Rate";
                TreatmentLine."Blood Pressure" := ObsLine."Blood Pressure";
                TreatmentLine.Temperature := ObsLine.Temperature;
                TreatmentLine.Height := ObsLine.Height;
                TreatmentLine.Weight := ObsLine.Weight;
                TreatmentLine.BMI := ObsLine.BMI;
                TreatmentLine.SP02 := ObsLine.SP02;
                TreatmentLine."Respiration Rate" := ObsLine."Respiration Rate";
                TreatmentLine."Date Created" := ObsLine."Date Created";
                TreatmentLine."Date Taken" := ObsLine."Date Taken";
                TreatmentLine.Time := ObsLine.Time;
                TreatmentLine.Insert;
            until ObsLine.Next = 0;
        end;

        // Update Queue
        docHeader.Get(NewNo);
        Patient.Get(PatientNo);
        HMSQue.Init;
        HMSQue."Patient No" := PatientNo;
        HMSQue."Visit No" := Patient."Active Visit No";
        HMSQue."Document No" := NewNo;
        TreatmentNo := NewNo;
        HMSQue.Type := 'CONSULTATION';
        HMSQue."Queue Type" := 'DISPATCH';
        HMSQue."Doctor ID" := docHeader."Doctor ID";
        HMSQue.Date := Today;
        HMSQue.Time := DT2TIME(System.CurrentDateTime);
        HMSQue.Insert;


        ObservHeader.SetRange(ObservHeader."Link No.", AppointmentNo);
        if ObservHeader.Find('-') then begin
            //ObservHeader.Status:= ObservHeader.Status::Closed;
            //ObservHeader.Closed :=TRUE;
            ObservHeader."Treatment No" := NewNo;
            ObservHeader.Modify;
        end;

        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Link No" := NewNo;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Triage Time out" := CurrentDatetime;
            objAppointment."Doctor Time In" := CurrentDatetime;
            objAppointment.Modify;
        end;

    end;

    procedure FnInsertAlergy(patientNo: Code[20]; descr: Text[250]; remarks: Text[250]; Type: Text[250])
    begin
        HMSPatientFlags.Init;
        HMSPatientFlags.Description := descr;
        HMSPatientFlags.Remarks := remarks;
        HMSPatientFlags."Patient No." := patientNo;
        if Type = 'Allergy' then
            HMSPatientFlags.Type := HMSPatientFlags.Type::Allergy
        else
            HMSPatientFlags.Type := HMSPatientFlags.Type::"Chronic Illness";
        HMSPatientFlags.Date := Today;
        HMSPatientFlags."Creation Date" := Today;
        HMSPatientFlags."Creation Time" := DT2TIME(System.CurrentDateTime);
        HMSPatientFlags.Insert;
    end;

    procedure FnMarkObservationAsComplete(ObsNo: Code[20]; PatientNo: Code[20])
    begin
        ObservHeader.Reset;
        ObservHeader.SetRange(ObservHeader."Observation No.", ObsNo);
        ObservHeader.SetRange(ObservHeader."Patient No.", PatientNo);
        if ObservHeader.Find('-') then begin
            //ObservHeader.Status:= ObservHeader.Status::Closed;
            ObservHeader.Closed := true;
            ObservHeader.Modify;
        end;
    end;

    procedure InsertDoctorsAdvice(TreatmentNo: Code[30]; PatientNo: Code[30]; Notes: Text; TreatmentDate: Date; "docUSER ID": Code[30])
    begin
        objNotes.SetRange(objNotes."Patient No", PatientNo);
        objNotes.SetRange(objNotes.TreatmentNo, TreatmentNo);
        objNotes.SetRange(objNotes."Treatment Date", TreatmentDate);
        objNotes.SetRange(objNotes."User ID", "docUSER ID");
        // objNotes.SetRange(objNotes.Notes, Notes); TODO : Notes is a blob field. Need to refactor to use RichTextContent
        // objNotes.SetRange(objNotes."Notes Type", objNotes."notes type"::"Doctors Advice");
        if objNotes.Find('-') then begin
            Message('Notes already recorded');
        end else begin
            objNotes.Init;
            objNotes.TreatmentNo := TreatmentNo;
            objNotes."Patient No" := PatientNo;
            objNotes."Treatment Date" := TreatmentDate;
            objNotes."Treatment Time" := DT2TIME(System.CurrentDateTime);
            // objNotes.Notes := Notes;
            // objNotes."Notes Type" := objNotes."notes type"::"Doctors Advice";
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

    procedure DispatchToDialysis(SettlementType: Option; Doctor: Text; PatientNo: Text; AppointmentNo: Text)
    var
        AppointmentType: Text;
        DocNo: text;
        ObsNo: Text;
        ADmNo: Text;
        InsurancePackage: Record "HMS Insuarance Packages";
        ObjCust: Record Customer;
        PatRec: Record "HMS Patient";
    begin
        objAppointment.SetRange(objAppointment."Appointment No.", AppointmentNo);
        if objAppointment.Find('-')
          then
            AppointmentType := objAppointment."Appointment Type";

        HMSSetup.Reset;
        HMSSetup.Get();
        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Therapy Nos", 0D, true);
        DocNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);
        ObsNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);
        ADmNo := NoSeriesMgt.GetNextNo(HMSSetup."Admission Request Nos", 0D, true);

        HMSDialysisFormHeader.Reset;
        HMSDialysisFormHeader.Init;
        HMSDialysisFormHeader."Treatment No." := NewNo;
        HMSDialysisFormHeader."Therapy Date" := Today;
        HMSDialysisFormHeader."Therapy Time" := DT2TIME(System.CurrentDateTime);
        HMSDialysisFormHeader."Patient No." := PatientNo;
        ObjPatient.SetRange(ObjPatient."Patient No.", PatientNo);
        if ObjPatient.Find('-') then
            HMSDialysisFormHeader."Link No." := NewNo;
        HMSDialysisFormHeader."Therapy User ID" := UserId;
        HMSDialysisFormHeader.Doctor := Doctor;
        HMSDialysisFormHeader.Status := HMSDialysisFormHeader.Status::New;
        HMSDialysisFormHeader."Link Type" := 'Doctor';
        HMSDialysisFormHeader."Treatment No." := DocNo;
        HMSDialysisFormHeader.Branch := ObjPatient."Global Dimension 1 Code";
        HMSDialysisFormHeader.Insert();

        //END;
        objAppointment.SetRange("Appointment No.", AppointmentNo);
        if objAppointment.Find('-') then begin
            objAppointment."Dispatch To" := objAppointment."dispatch to";
            objAppointment."Dispatch Date" := Today;
            objAppointment."Dispatch Time" := DT2TIME(System.CurrentDateTime);
            objAppointment.Status := objAppointment.Status::Dispatched;
            objAppointment."Link No" := NewNo;
            objAppointment."Waiting At" := objAppointment."waiting at";
            objAppointment."Triage Time out" := CurrentDatetime;
            objAppointment."Therapy Time In" := CurrentDatetime;
            objAppointment.Modify;
        end;
        //////Begin
        ///HMSSetup.Reset;
        HMSSetup.Get();
        HMSSetup.TestField("Therapy Nos");

        patient.get(PatientNo);
        if ObjCust.get(Patient."Insurance No.") then
            // if Cust."NHIF Package" = true then begin
            // if Confirm('Bill for NHIF Package charges/ Items') then begin
            InsurancePackage.Reset();
        InsurancePackage.SetRange(InsurancePackage."Insurance No", ObjCust."No.");
        if InsurancePackage.Find('-')
        then begin
            repeat
                HMSPatientsCharges.Init();
                HMSPatientsCharges."Patient No." := PatientNo;
                HMSPatientsCharges."Link No" := NewNo;
                HMSPatientsCharges."Treatment No." := NewNo;
                HMSPatientsCharges."Appointment No." := AppointmentNo;
                HMSPatientsCharges.Date := Today;
                HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Dialysis;
                HMSPatientsCharges."User ID" := UserId;
                HMSPatientsCharges."Creation Date" := Today;
                HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
                HMSPatientsCharges."Doctor ID" := Doctor;
                if PatRec.Get(PatientNo) then begin
                    HMSPatientsCharges."Admission No" := PatRec."Adm No.";
                    HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
                end;
                if InsurancePackage.Type = InsurancePackage.Type::Charge then begin
                    if HMSCharges.Get(InsurancePackage."Charge Item") then
                        HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                    HMSPatientsCharges.Validate("Transaction Type");
                    HMSPatientsCharges.Code := InsurancePackage."Charge Item";
                    HMSPatientsCharges.Validate(Code);
                end else begin
                    HMSPatientsCharges."Transaction Type" := InsurancePackage."Transaction Type";
                    HMSPatientsCharges.Code := InsurancePackage."Charge Item";
                    HMSPatientsCharges.Description := InsurancePackage.Description;
                end;
                HMSPatientsCharges.Amount := InsurancePackage.Amount;
                HMSPatientsCharges.Quantity := InsurancePackage.Quantity;
                HMSPatientsCharges.Validate(Quantity);
                HMSPatientsCharges.Insert();

            until InsurancePackage.Next() = 0;
        end;

        // TestField("NHIF LOU Amount");
        Patient."Current LOU Amount" := 37000;

        //end;
        Patient."Current Adm No" := ADmNo;
        Patient.modify;



        //  if "Settlement Type" = "Settlement Type"::Insurance then begin
        HMSSetup.TestField("Therapy Fee Code");
        HMSCharges.Get(HMSSetup."Therapy Fee Code");
        HMSPatientsCharges.Init;
        //HMSPatientsCharges."Line No":=1;
        HMSPatientsCharges."Patient No." := PatientNo;
        HMSPatientsCharges."Link No" := NewNo;
        HMSPatientsCharges."Treatment No." := NewNo;
        HMSPatientsCharges."Appointment No." := AppointmentNo;
        HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
        HMSPatientsCharges.Validate("Transaction Type");
        HMSPatientsCharges.Code := HMSSetup."Therapy Fee Code";
        HMSPatientsCharges.Validate(code);

        // HMSPatientsCharges."Shortcut Dimension 1 Code":= HMSCharges."Shortcut Dimension 1 Code";
        //  HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
        HMSPatientsCharges.Date := Today;
        HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Appointment;
        HMSPatientsCharges."User ID" := UserId;
        HMSPatientsCharges."Creation Date" := Today;
        HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
        HMSPatientsCharges."Doctor ID" := Doctor;
        if PatRec.Get(PatientNo) then begin
            HMSPatientsCharges."Admission No" := PatRec."Adm No.";
            HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
        end;
        HMSPatientsCharges.Insert;

        docHeader.Init;
        docHeader."Treatment No." := NewNo;
        docHeader."Treatment Date" := Today;
        docHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
        docHeader."Doctor ID" := Doctor;
        docHeader."Patient No." := PatientNo;
        docHeader.Direct := true;
        docHeader."Link No." := AppointmentNo;
        docHeader.Clinic := docHeader.Clinic;
        docHeader."Special Clinics" := docHeader."Special Clinics";
        docHeader."Link Type" := 'Outpatient';
        docHeader.Insert;

        ObservHeader.Init;
        ObservHeader."Observation No." := DocNo;
        ObservHeader."Patient No." := PatientNo;
        ObservHeader."Observation Date" := Today;
        ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
        //ObservHeader."Request Area"::Doctor;
        ObservHeader."Link Type" := 'Observation';
        ObservHeader."Link No." := AppointmentNo;
        ObservHeader.Doctor := Doctor;
        ObservHeader."Treatment No" := NewNo;
        ObservHeader."Special Clinics" := ObservHeader."Special Clinics";
        ObservHeader.Insert;

        AdmissionHeader.Reset;
        AdmissionHeader.Init;
        AdmissionHeader."Admission No." := ADmNo;
        AdmissionHeader."Admission Date" := Today;
        AdmissionHeader."Admission Time" := DT2TIME(System.CurrentDateTime);
        AdmissionHeader."Admission Area" := AdmissionHeader."Admission Area"::Referral;
        AdmissionHeader."Patient No." := PatientNo;
        AdmissionHeader.validate("Patient No.");
        AdmissionHeader.Doctor := Doctor;
        AdmissionHeader.Status := AdmissionHeader.Status::New;
        AdmissionHeader.Remarks := 'Direct Admission';
        AdmissionHeader."Admission Reason" := 'Direct Admission';
        AdmissionHeader."Link Type" := 'Direct Admission';
        AdmissionHeader."Link No." := docHeader."Treatment No.";
        AdmissionHeader."Appointment No." := AppointmentNo;
        AdmissionHeader.Insert();



    end;

    procedure InsertPatientFormDialysis(TreatmentNo: Text; PatientNo: Text; Remarks: Text; PreDialysisWeight: Decimal; UFSET: Text; BP: Text; HR: Text; DialysisHours: Decimal; Access: Option; Dialyzer: Text; Dialyste: Text; KBath: Text; HeparinLD: Text; HeparinMD: Text; DialysisStart: DateTime; DialysisEND: DateTime; NurseCom: Text; NurseEnd: Text; PDWeight: Decimal; PostBP: Text; PostHR: Text; Bicarbonate: Text; Calcium: Text; Conductivity: Text; Height: Decimal; Sodium: Text; Potassium: Text; WeightGain: Decimal
    ; AcidConc: Text; Bolus: Text; BolusRate: Text; Cannulla: Text; PreviousWeight: Decimal; "UF Goal": Text)
    begin
        DialysisPatientInfo.Reset();
        DialysisPatientInfo.Setrange(TreatmentNo, TreatmentNo);
        DialysisPatientInfo.Setrange(PatientNo, PatientNo);
        If DialysisPatientInfo.Find('-') then begin
            DialysisPatientInfo.TreatmentNo := TreatmentNo;
            DialysisPatientInfo.PatientNo := PatientNo;
            DialysisPatientInfo."Pre-Dialysis Weight" := PreDialysisWeight;
            DialysisPatientInfo."UF Set" := UFSET;
            DialysisPatientInfo.BP := BP;
            DialysisPatientInfo.HR := HR;
            DialysisPatientInfo."Dialysis Hours" := DialysisHours;
            DialysisPatientInfo.Access := Access;
            DialysisPatientInfo.Dialyzer := Dialyzer;
            DialysisPatientInfo.Dialysate := Dialyste;
            DialysisPatientInfo."K+V" := KBath;
            DialysisPatientInfo."Heparin LD" := HeparinLD;
            DialysisPatientInfo."Heparin MD" := HeparinMD;
            DialysisPatientInfo."Dialysis Start Time" := DialysisStart;
            DialysisPatientInfo."Dialysis End Time" := DialysisEND;
            DialysisPatientInfo."Nurse Commencing Dialysis" := NurseCom;
            DialysisPatientInfo."Nurse Disconnecting Dialysis" := NurseEnd;
            DialysisPatientInfo."Post Dialysis Bp" := PostBP;
            DialysisPatientInfo."Post Dialysis HR" := PostHR;
            DialysisPatientInfo."Post Dialysis Weight" := PDWeight;
            DialysisPatientInfo.Bicarbonate := Bicarbonate;
            DialysisPatientInfo.Calcium := Calcium;
            DialysisPatientInfo.Conductivity := Conductivity;
            DialysisPatientInfo.Height := Height;
            DialysisPatientInfo.Potassium := Potassium;
            DialysisPatientInfo.Sodium := Sodium;
            DialysisPatientInfo."Weight Gain" := WeightGain;
            DialysisPatientInfo."Acid Conc" := AcidConc;
            DialysisPatientInfo.Bolus := Bolus;
            DialysisPatientInfo."Bolus Rate" := BolusRate;
            DialysisPatientInfo.Cannulla := Cannulla;
            DialysisPatientInfo."Previous Weight" := PreviousWeight;
            DialysisPatientInfo."UF Goal" := "UF Goal";
            DialysisPatientInfo.Modify();
        end else begin
            DialysisPatientInfo.Init;
            DialysisPatientInfo.TreatmentNo := TreatmentNo;
            DialysisPatientInfo.PatientNo := PatientNo;
            DialysisPatientInfo."Pre-Dialysis Weight" := PreDialysisWeight;
            DialysisPatientInfo."UF Set" := UFSET;
            DialysisPatientInfo.BP := BP;
            DialysisPatientInfo.HR := HR;
            DialysisPatientInfo."Dialysis Hours" := DialysisHours;
            DialysisPatientInfo.Access := Access;
            DialysisPatientInfo.Dialyzer := Dialyzer;
            DialysisPatientInfo.Dialysate := Dialyste;
            DialysisPatientInfo."K+V" := KBath;
            DialysisPatientInfo."Heparin LD" := HeparinLD;
            DialysisPatientInfo."Heparin MD" := HeparinMD;
            DialysisPatientInfo."Dialysis Start Time" := DialysisStart;
            DialysisPatientInfo."Dialysis End Time" := DialysisEND;
            DialysisPatientInfo."Nurse Commencing Dialysis" := NurseCom;
            DialysisPatientInfo."Nurse Disconnecting Dialysis" := NurseEnd;
            DialysisPatientInfo."Post Dialysis Bp" := PostBP;
            DialysisPatientInfo."Post Dialysis HR" := PostHR;
            DialysisPatientInfo."Post Dialysis Weight" := PDWeight;
            DialysisPatientInfo.Bicarbonate := Bicarbonate;
            DialysisPatientInfo.Calcium := Calcium;
            DialysisPatientInfo.Conductivity := Conductivity;
            DialysisPatientInfo.Height := Height;
            DialysisPatientInfo.Potassium := Potassium;
            DialysisPatientInfo.Sodium := Sodium;
            DialysisPatientInfo."Weight Gain" := WeightGain;
            DialysisPatientInfo."Acid Conc" := AcidConc;
            DialysisPatientInfo.Bolus := Bolus;
            DialysisPatientInfo."Bolus Rate" := BolusRate;
            DialysisPatientInfo.Cannulla := Cannulla;
            DialysisPatientInfo."Previous Weight" := PreviousWeight;
            DialysisPatientInfo."UF Goal" := "UF Goal";
            DialysisPatientInfo.Insert();
        end;

        //  TreatmentLine.:=BMI;
        //  TreatmentLine.Results :=Result;
        //  TreatmentLine.Performed := TRUE;
        //  TreatmentLine."Date Created" :=CURRENTDATETIME;
        //  TreatmentLine.INSERT;
    end;

    PROCEDURE InsertSample(LabHeaderNo: Code[20]; LabLineNo: Code[20]; CollectionTime: Time; CollectedBy: Code[30]; "Type of Tube": Text[50]; Quantity: Text; Descr: Text[250]; LabUnique: Integer);
    BEGIN
        HMSSample.RESET;
        HMSSample.SETRANGE("Laboratory No", LabHeaderNo);
        HMSSample.SETRANGE("Lab Test Code", LabLineNo);
        HMSSample.SETRANGE("Collection Time", CollectionTime);
        IF HMSSample.FIND('-') THEN BEGIN
            HMSSample."Collection Time" := CollectionTime;
            HMSSample."Collected By" := CollectedBy;
            HMSSample."Type of Tube" := "Type of Tube";
            HMSSample.Remarks := Descr;
            HMSSample.Quantity := Quantity;
            HMSSample.MODIFY;
        END ELSE BEGIN

            HMSSample.INIT;
            // HMSSample.No := 0;
            // HMSSample."Lab No" := LabHeaderNo;
            // HMSSample."Lab No" := LabLineNo;
            HMSSample."Collection Date" := TODAY;
            HMSSample.Remarks := Descr;
            HMSSample."Collection Time" := CollectionTime;
            HMSSample."Collected By" := CollectedBy;
            HMSSample."Type of Tube" := "Type of Tube";
            HMSSample.No := LabUnique;
            HMSSample.Quantity := Quantity;
            HMSSample.INSERT;

            LaboratoryLines.RESET;
            LaboratoryLines.SETRANGE("Laboratory No.", LabHeaderNo);
            LaboratoryLines.SETRANGE("Laboratory Test Code", LabLineNo);
            IF LaboratoryLines.FIND('-') THEN BEGIN
                LaboratoryLines."Collection Time" := CollectionTime;
                LaboratoryLines.MODIFY();
            END;
        END;
    END;

    procedure DeleteSample(SampleNo: Integer) res: Text[10]
    begin
        HMSSample.Reset;
        HMSSample.SetRange(HMSSample.No, SampleNo);
        if HMSSample.Find('-') then begin
            if HMSSample.Received then begin
                res := 'RECEIVED';
            end else begin
                HMSSample.Delete;
                res := 'TRUE';
            end;
        end;
    end;

    procedure UpdateSample(SampleNo: Integer; type: Integer; UserId: Code[30]; txt: Text[250]) res: Text[10]
    begin
        HMSSample.Reset;
        HMSSample.SetRange(HMSSample.No, SampleNo);
        if HMSSample.Find('-') then begin
            if type = 2 then begin
                HMSSample.Status := HMSSample.Status::Rejected;
                HMSSample."Reason for Rejection" := txt;
            end else
                if type = 1 then begin
                    HMSSample.Status := HMSSample.Status::Received;
                end;
            HMSSample."Receipt Rejection Date" := Today;
            HMSSample."Receipt Rejection Time" := DT2TIME(System.CurrentDateTime);
            HMSSample."Received Rejected By" := UserId;
            HMSSample.Received := true;
            HMSSample.Modify();
        end;
    end;

    procedure UpdateColourCode(DocNo: Code[20]; "Code": Option "0","1","2"; Type: Code[20])
    begin
        case Type of
            'TREATMENT':
                begin
                    docHeader.Reset;
                    docHeader.SetRange("Treatment No.", DocNo);
                    if docHeader.Find('-') then begin
                        docHeader."Color Code" := docHeader."color code"::"1";
                        docHeader.Modify();
                    end;
                end;
            'LABORATORY':
                begin
                    LabHeader.Reset;
                    LabHeader.SetRange(LabHeader."Laboratory No.", DocNo);
                    if LabHeader.Find('-') then begin
                        LabHeader."Color Code" := LabHeader."color code"::"1";
                        LabHeader.Modify();
                    end;
                end;
        end;
    end;

    local procedure LimitforRecall() val: Integer
    begin
    end;

    PROCEDURE GenerateLabResultsIndividual(TreatmentNo: Text; filenameFromApp: Text; TestNo: Code[10]; LabNo: Code[10]; LinNo: Integer) filename: Text;
    var
        HMSSetup: Record "HMS Setup";
    BEGIN
        HMSSetup.get;
        HMSSetup.TestField("Portal Report Path");
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);

        LabHeader.RESET;
        LabHeader.SETRANGE("Link No.", TreatmentNo);
        LabHeader.SETRANGE("Laboratory No.", LabNo);
        IF LabHeader.FIND('-') THEN BEGIN

            //IF LabHeader.Status=LabHeader.Status::Recalled THEN BEGIN
            //END ELSE BEGIN
            LabResults.RESET;
            LabResults.SETRANGE(LabResults."Laboratory No.", LabHeader."Laboratory No.");
            //LabResults.SETRANGE(LabResults."Laboratory Test Code", TestNo);
            //LabResults.SETRANGE(LabResults."Lab Unique No",LinNo);
            IF LabResults.FIND('-') THEN BEGIN
                REPORT.SAVEASPDF(Report::"HMS Lab Results2", filename, LabResults);
            END;
            //END;
            EXIT(filename);
        END;
    END;

    procedure UpdateSampleReferral(SampleNo: Integer; UserId: Code[30]; txt: Text[250]; ReferalHos: Text[100]; Opt: Option Discard,Retained,Referred) res: Text[10]
    begin
        HMSSample.Reset;
        HMSSample.SetRange(HMSSample.No, SampleNo);
        if HMSSample.Find('-') then begin
            HMSSample."Sample Retention Status" := Opt;
            HMSSample."Refered By" := UserId;
            HMSSample."Date Referred" := Today;
            HMSSample."Time Referred" := DT2TIME(System.CurrentDateTime);
            HMSSample."Referal hospital" := ReferalHos;
            HMSSample."Remarks to Referal" := txt;
            HMSSample.Modify();
        end;
    end;

    PROCEDURE InsertLabNotes(LabNo: Text; LabTestCode: Text; Remarks: Text; Labuser: Text; TestMethodModified: Text; ModificationComments: Text; UID: Integer);
    BEGIN
        LabNotes.SETRANGE(LabNotes."Laboratory No.", LabNo);
        LabNotes.SETRANGE(LabNotes."Laboratory Test Code", LabTestCode);
        LabNotes.SETRANGE(LabNotes."Unique Lab ID", UID);

        IF LabNotes.FIND('-') THEN BEGIN
            LabNotes."Laboratory No." := LabNo;
            LabNotes."Laboratory Test Code" := LabTestCode;
            LabNotes.Remarks := Remarks;
            LabNotes."Modification Comments" := ModificationComments;
            LabNotes.MODIFY;
        END ELSE BEGIN
            LabNotes.INIT;
            LabNotes."Unique Lab ID" := UID;
            LabNotes."Laboratory No." := LabNo;
            LabNotes."Laboratory Test Code" := LabTestCode;
            LabNotes.Remarks := Remarks;
            LabNotes."Modification Comments" := ModificationComments;
            LabNotes.INSERT;
        END;

        HMSLaboratoryTestLine.RESET;
        HMSLaboratoryTestLine.SETRANGE("Laboratory No.", LabNo);
        HMSLaboratoryTestLine.SETRANGE("Unique No", UID);
        HMSLaboratoryTestLine.SETRANGE("Laboratory Test Code", LabTestCode);
        IF HMSLaboratoryTestLine.FIND('-') THEN BEGIN
            HMSLaboratoryTestLine."Test Method Modified" := TestMethodModified;
            HMSLaboratoryTestLine."Modification Comments" := ModificationComments;
            //IF HMSLaboratoryTestLine."Modification Comments"='' THEN
            HMSLaboratoryTestLine.MODIFY();
        END;
    END;

    procedure StartCCC(AdmissionNo: Text)
    begin
        AdmissionHeader.Reset;
        AdmissionHeader.SetRange("Admission No.", AdmissionNo);
        if AdmissionHeader.Find('-') then
            AdmissionHeader.CCC := true;
        AdmissionHeader."CCC Status" := AdmissionHeader."ccc status"::Start;
        AdmissionHeader.Modify;
    end;

    procedure DeleteTheatreLine(TreatmentNo: Text; RadiologyCode: Text)
    begin
        TLine.Reset;
        TLine.SetRange(TLine."Treatment No.", TreatmentNo);
        TLine.SetRange(TLine."Process No.", RadiologyCode);
        TLine.SetRange(TLine.Status, TLine.Status::New);
        if TLine.Find('-') then
            TLine.Delete;
    end;

    procedure UserStore(UIDD: Code[30]) store: Code[50]
    begin
        "User Setup".Reset;
        "User Setup".SetRange("User Setup"."User ID", UIDD);
        if "User Setup".Find('-') then begin
            store := "User Setup"."Location Code";
        end;
    end;

    procedure UserDefaultStore(UIDD: Code[30]) store: Code[50]
    begin
        "User Setup".Reset;
        "User Setup".SetRange("User Setup"."User ID", UIDD);
        if "User Setup".Find('-') then begin
            store := "User Setup"."Default Store Location";
        end;
    end;

    procedure UserTransactionCode(UIDD: Code[30]) TransactionCode: Code[50]
    begin
        "User Setup".Reset;
        "User Setup".SetRange("User Setup"."User ID", UIDD);
        if "User Setup".Find('-') then begin
            TransactionCode := "User Setup"."Default Transaction Type";
        end;
    end;

    procedure GetStock(ItemNo: Code[20]; loc: Code[30]) stocklevel: Integer
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        ItemLedgerEntry.Reset;
        ItemLedgerEntry.SetRange("Item No.", ItemNo);
        ItemLedgerEntry.SetRange("Location Code", loc);
        if ItemLedgerEntry.Find('-') then begin
            ItemLedgerEntry.CalcSums(Quantity);
            stocklevel := ItemLedgerEntry.Quantity;
        end;
    end;

    local procedure validate()
    var
        HMSTreatmentFormDrug: Record "HMS Treatment Form Drug";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
    begin
        HMSAdmissionDrugNurse.Reset;
        HMSAdmissionDrugNurse.SetFilter("Drug No.", '<>%1', '');
        if HMSAdmissionDrugNurse.Find('-') then begin
            repeat
                HMSAdmissionDrugNurse.Validate(Remarks);

                HMSTreatmentFormDrug.Reset;
                HMSTreatmentFormDrug.SetRange("Drug No.", HMSAdmissionDrugNurse."Drug No.");
                if HMSTreatmentFormDrug.Find('-') then begin

                    //  HMSTreatmentFormHeader.RESET;
                    //  HMSTreatmentFormHeader.SETRANGE("Treatment No.",hms)
                    HMSTreatmentFormDrug.CalcFields("Prescribed By name");
                    HMSAdmissionDrugNurse."Prescribed By2" := HMSTreatmentFormDrug."Prescribed By name";
                end;
            until
HMSAdmissionDrugNurse.Next = 0;
        end;
    end;

    procedure InsertDischargePrescription(TreatmentNo: Text; DrugNo: Text; Remarks: Text; Location: Text; Frequency: Integer; NoofDays: Integer; Take: Decimal; Dosage: Text; Route: Integer; PrescriptionDose: Text; Qty: Decimal)
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
        ObjPrescription."Pharmacy Type" := ObjPrescription."pharmacy type"::Discharge;
        Evaluate(ObjPrescription."Prescription Dose", PrescriptionDose);
        ObjPrescription."Pharmacy Code" := Location;
        ObjPrescription.Insert;
    end;

    procedure CheckIssuedDrugIP(TreatmentNo: Text; DrugNo: Text; PharmacyType: Option) Issued: Boolean
    begin
        Issued := FALSE;
        ObjPrescription.RESET;
        ObjPrescription.SETRANGE(ObjPrescription."Treatment No.", TreatmentNo);
        ObjPrescription.SETRANGE(ObjPrescription."Drug No.", DrugNo);
        ObjPrescription.SETRANGE(ObjPrescription."Pharmacy Type", PharmacyType);
        ObjPrescription.SETRANGE(ObjPrescription."IP Status", ObjPrescription."IP Status"::Ongoing);
        ObjPrescription.SETFILTER(ObjPrescription."Remaining Days", '>%1', 0);
        IF ObjPrescription.FIND('-') THEN
            Issued := TRUE;
    end;


    PROCEDURE CompleteLabTest(LabNo: Text);
    BEGIN
        //Changed
        /*     ObjLab.RESET;
            // ObjLab.SETRANGE(ObjLab."Treatment No.", TreatmentNo);
            ObjLab.SETRANGE(ObjLab."Lab No", LabNo);
            // ObjLab.SETRANGE(ObjLab."Date Due", TODAY);
            IF ObjLab.FIND('-') THEN BEGIN
                REPEAT

                    ObjLab.Status := ObjLab.Status::Completed;
                    ObjLab.MODIFY;
                UNTIL ObjLab.NEXT = 0;
            END; */

        IF LabHeader.GET(LabNo) THEN BEGIN

            LabHeader.Status := LabHeader.Status::Completed;
            LabHeader."Completion Date" := TODAY;
            LabHeader."Completion Time" := DT2Time(System.CurrentDateTime);
            LabHeader.MODIFY;
        END;


    END;

    procedure CountAppointmentsBranch(BranchF: Text) CountApprovals: Integer
    begin
        CountApprovals := 0;
        objAppointment.RESET;
        objAppointment.SETRANGE(objAppointment."Appointment Date", TODAY);
        objAppointment.SETRANGE(objAppointment.Branch, BranchF);
        IF objAppointment.FIND('-') THEN
            CountApprovals := objAppointment.COUNT;
    end;

    procedure CountNewPatientsBranch(Branch: Text) CountApprovals: Integer
    begin
        CountApprovals := 0;
        ObjPatient.RESET;
        ObjPatient.SETRANGE(ObjPatient."Date Registered", TODAY);
        ObjPatient.SETRANGE(ObjPatient."Global Dimension 1 Code", Branch);
        IF ObjPatient.FIND('-') THEN
            CountApprovals := ObjPatient.COUNT;
    end;

    procedure CountDoctorsVisitsBranch(Branch: Text) CountApprovals: Integer
    begin
        CountApprovals := 0;
        docHeader.RESET;
        docHeader.SETRANGE(docHeader."Treatment Date", TODAY);
        docHeader.SETRANGE(docHeader.Branch, Branch);
        IF docHeader.FIND('-') THEN
            CountApprovals := docHeader.COUNT;
    end;

    procedure CountLabVisitsBranch(Branch: Text) CountApprovals: Integer
    begin
        CountApprovals := 0;
        LabHeader.RESET;
        LabHeader.SETRANGE(LabHeader."Laboratory Date", TODAY);
        LabHeader.SETRANGE(LabHeader."Global Dimension 1", Branch);
        IF LabHeader.FIND('-') THEN
            CountApprovals := LabHeader.COUNT;
    end;

    procedure CountRadiologyrequestBranch(Branch: Text) CountApprovals: Integer
    begin
        CountApprovals := 0;
        RadiologyHeader.RESET;
        RadiologyHeader.SETRANGE(RadiologyHeader."Radiology Date", TODAY);
        RadiologyHeader.SETRANGE(RadiologyHeader.Branch, Branch);
        IF RadiologyHeader.FIND('-') THEN
            CountApprovals := RadiologyHeader.COUNT;
    end;

    procedure CountInpatientsBranch(Branch: Text) CountApprovals: Integer
    begin
        CountApprovals := 0;
        AdmissionHeader.RESET;
        AdmissionHeader.SETRANGE(AdmissionHeader.Branch, Branch);
        AdmissionHeader.SETRANGE(AdmissionHeader.Status, AdmissionHeader.Status::Admitted);
        IF AdmissionHeader.FIND('-') THEN
            CountApprovals := AdmissionHeader.COUNT;
    end;

    procedure CountPharmacyBranch(Branch: Text) CountApprovals: Integer
    begin
        CountApprovals := 0;
        PharmHeader.RESET;
        PharmHeader.SETRANGE(PharmHeader."Pharmacy Date", TODAY);
        PharmHeader.SETRANGE(PharmHeader."Global Dimension 1 Code", Branch);
        IF PharmHeader.FIND('-') THEN
            CountApprovals := PharmHeader.COUNT;
    end;

    procedure CountDischargeReuestBranch(Branch: Text) CountApprovals: Integer
    begin
        CountApprovals := 0;
        AdmissionDischargeHeader.RESET;
        //AdmissionDischargeHeader.SETRANGE(AdmissionDischargeHeader.Branch, Branch);
        AdmissionDischargeHeader.SETRANGE(AdmissionDischargeHeader.Status, AdmissionDischargeHeader.Status::New);
        IF AdmissionDischargeHeader.FIND('-') THEN
            CountApprovals := AdmissionDischargeHeader.COUNT;
    end;

    procedure BedCapacity(Branch: Text) S: ARRAY[3] OF Integer
    var
        Ward: Record "HMS Ward Setup";
        Beds: Record "HMS Beds";
    begin
        Ward.RESET;
        Beds.RESET;
        //Beds.SETRANGE(Beds.Branch, Branch);
        Beds.SETRANGE(Beds.Occupied, FALSE);
        IF Beds.FIND('-') THEN
            S[1] := Beds.COUNT;
        Beds.RESET;
        Beds.SETRANGE(Beds.Occupied, TRUE);
        IF Beds.FIND('-') THEN
            S[2] := Beds.COUNT;
        S[3] := S[1] + S[2];
    end;

    procedure CashPatientsPerMonth(Branch: Text; StartDate: date) P: ARRAY[12] OF Integer
    var
        EndDate: date;
    begin
        EndDate := StartDate + 365;
        objAppointment.RESET;
        //objAppointment.SETRANGE(objAppointment."Appointment Date", TODAY);
        objAppointment.SETRANGE(objAppointment.Branch, Branch);
        objAppointment.SETRANGE(objAppointment."Settlement Type", objAppointment."Settlement Type"::Cash);
        objAppointment.SetFilter(objAppointment."Appointment Date", '%1..%2', StartDate, EndDate);
        IF objAppointment.FIND('-') THEN BEGIN
            IF objAppointment."Appointment Date" <> 0D THEN BEGIN
                REPEAT
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 1 THEN
                        P[1] := P[1] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 2 THEN
                        P[2] := P[2] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 3 THEN
                        P[3] := P[3] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 4 THEN
                        P[4] := P[4] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 5 THEN
                        P[5] := P[5] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 6 THEN
                        P[6] := P[6] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 7 THEN
                        P[7] := P[7] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 8 THEN
                        P[8] := P[8] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 9 THEN
                        P[9] := P[9] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 10 THEN
                        P[10] := P[10] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 11 THEN
                        P[11] := P[11] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 12 THEN
                        P[12] := P[12] + 1;
                // END;
                UNTIL objAppointment.NEXT = 0;
            END;
        END;
    end;

    procedure CorporatePatientsPerMonth(Branch: Text; StartDate: Date) P: ARRAY[12] OF Integer
    var
        EndDate: date;
    begin
        Enddate := StartDate + 365;
        objAppointment.RESET;
        //objAppointment.SETRANGE(objAppointment."Appointment Date", TODAY);
        objAppointment.SETRANGE(objAppointment.Branch, Branch);
        objAppointment.SETRANGE(objAppointment."Settlement Type", objAppointment."Settlement Type"::Insurance);
        objAppointment.SETfilter(objAppointment."Appointment Date", '%1..%2', StartDate, EndDate);
        IF objAppointment.FIND('-') THEN BEGIN
            IF objAppointment."Appointment Date" <> 0D THEN BEGIN
                REPEAT
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 1 THEN
                        P[1] := P[1] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 2 THEN
                        P[2] := P[2] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 3 THEN
                        P[3] := P[3] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 4 THEN
                        P[4] := P[4] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 5 THEN
                        P[5] := P[5] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 6 THEN
                        P[6] := P[6] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 7 THEN
                        P[7] := P[7] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 8 THEN
                        P[8] := P[8] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 9 THEN
                        P[9] := P[9] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 10 THEN
                        P[10] := P[10] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 11 THEN
                        P[11] := P[11] + 1;
                    IF DATE2DMY(objAppointment."Appointment Date", 2) = 12 THEN
                        P[12] := P[12] + 1;

                UNTIL objAppointment.NEXT = 0;
            END;
        END;
    end;

    procedure AdmissionsCorporatePerMonth(Branch: Text; StartDate: date) P: ARRAY[12] OF Integer

    var
        EndDate: date;
    begin
        EndDate := StartDate + 365;
        AdmissionHeader.RESET;
        AdmissionHeader.SETFILTER(AdmissionHeader."Admission Date", '%1..%2', StartDate, EndDate);
        AdmissionHeader.SetFilter(AdmissionHeader."Global Dimension1", Branch);
        AdmissionHeader.SetFilter(AdmissionHeader."Settlement Type", '%1', AdmissionHeader."Settlement Type"::Insurance);

        IF AdmissionHeader.FIND('-') THEN BEGIN
            REPEAT
                // IF DATE2DMY(AdmissionHeader."Admission Date", 3) = 2020 THEN BEGIN
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 1 THEN
                    P[1] := P[1] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 2 THEN
                    P[2] := P[2] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 3 THEN
                    P[3] := P[3] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 4 THEN
                    P[4] := P[4] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 5 THEN
                    P[5] := P[5] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 6 THEN
                    P[6] := P[6] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 7 THEN
                    P[7] := P[7] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 8 THEN
                    P[8] := P[8] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 9 THEN
                    P[9] := P[9] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 10 THEN
                    P[10] := P[10] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 11 THEN
                    P[11] := P[11] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 12 THEN
                    P[12] := P[12] + 1;
            UNTIL AdmissionHeader.NEXT = 0;
        END;
    END;

    Procedure CheckCapitation(PatientNo: Text; ItemNo: Text) Capitation: Boolean
    var
        Customer: record customer;
    begin
        Capitation := FALSE;
        ObjPatient.Reset();
        ObjPatient.SETRANGE(ObjPatient."Patient No.", PatientNo);
        IF ObjPatient.FIND('-') THEN
            IF Customer.GET(ObjPatient."Insurance No.") THEN
                IF Customer."NHIF Capitation" = TRUE THEN BEGIN
                    ObjItem.RESET;
                    ObjItem.SETRANGE("No.", ItemNo);
                    ObjItem.SETRANGE("NHIF Covered", FALSE);
                    IF ObjItem.FIND('-') THEN
                        Capitation := TRUE;
                END;
    end;

    procedure AdmissionsCashPerMonth(Branch: Text; StartDate: date) P: ARRAY[12] OF Integer

    var
        EndDate: date;
    begin
        EndDate := StartDate + 365;
        AdmissionHeader.RESET;
        AdmissionHeader.SETFILTER(AdmissionHeader."Admission Date", '%1..%2', StartDate, EndDate);
        AdmissionHeader.SetFilter(AdmissionHeader."Global Dimension1", Branch);
        AdmissionHeader.SetFilter(AdmissionHeader."Settlement Type", '%1', AdmissionHeader."Settlement Type"::Cash);
        IF AdmissionHeader.FIND('-') THEN BEGIN
            REPEAT

                // IF DATE2DMY(AdmissionHeader."Admission Date", 3) = 2020 THEN BEGIN
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 1 THEN
                    P[1] := P[1] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 2 THEN
                    P[2] := P[2] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 3 THEN
                    P[3] := P[3] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 4 THEN
                    P[4] := P[4] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 5 THEN
                    P[5] := P[5] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 6 THEN
                    P[6] := P[6] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 7 THEN
                    P[7] := P[7] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 8 THEN
                    P[8] := P[8] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 9 THEN
                    P[9] := P[9] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 10 THEN
                    P[10] := P[10] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 11 THEN
                    P[11] := P[11] + 1;
                IF DATE2DMY(AdmissionHeader."Admission Date", 2) = 12 THEN
                    P[12] := P[12] + 1;
            UNTIL AdmissionHeader.NEXT = 0;
        END;
    END;

    procedure ReturnLeaveBalance(Empno: Text) Leavedays: Integer;
    begin
        Leavedays := 0;
        HREmp.Reset();
        HREmp.SetRange("No.", Empno);
        if HREmp.Find('-') then begin
            HREmp.CalcFields("Leave Balance");
            Leavedays := HREmp."Leave Balance";
        end;

    end;

    procedure UpdateHMSDialysisFormHeader(DialNo: Text; Branch: Text; Ward: Text; Bed: Text; DialMachine: Text; DialysisSesssion: Option) Modi: Boolean
    begin
        Modi := false;
        HMSDialysisFormHeader.Reset();
        HMSDialysisFormHeader.SetRange("Treatment No.", DialNo);
        if HMSDialysisFormHeader.Find('-') then begin
            HMSDialysisFormHeader.Branch := Branch;
            HMSDialysisFormHeader."Therapy Session" := DialysisSesssion;
            HMSDialysisFormHeader."Therapy Type" := DialMachine;
            HMSDialysisFormHeader.Validate("Therapy Type");
            HMSDialysisFormHeader.Modify();
            Modi := true;
        end;
    end;

    procedure InsertDialysisVitals(TreatmentNo: Text; DialysisNo: Text; Timetaken: Time; Bp: Text; Pulse: Text; PSpeed: Text; ArtP: Text; VenP: Text; Temp: Text; UFRate: Text; UFVol: Text; Heparin: Text; Cond: text; Remarks: Text)
    begin
        DialysisVitals.Init();
        DialysisVitals."Treatment No" := TreatmentNo;
        DialysisVitals."Dialysis No" := DialysisNo;
        DialysisVitals.Validate("Treatment No");
        DialysisVitals."Observation Date" := Today;
        DialysisVitals."Observation Time" := Timetaken;
        DialysisVitals."Blood Pressure" := Bp;
        DialysisVitals."Pulse Rate" := Pulse;
        DialysisVitals."P Speed" := PSpeed;
        DialysisVitals."Art P" := ArtP;
        DialysisVitals."Ven P" := VenP;
        DialysisVitals.Temp := Temp;
        DialysisVitals."UF Rate" := UFRate;
        DialysisVitals."UF Vol" := UFVol;
        DialysisVitals.Heparin := Heparin;
        DialysisVitals.Cond := Cond;
        DialysisVitals.Remarks := Remarks;
        DialysisVitals.Insert;
    end;

    procedure DeleteVitals(LineNo: Integer; TreatmentNo: Text)
    begin
        DialysisVitals.Reset();
        DialysisVitals.SetRange("Treatment No", TreatmentNo);
        DialysisVitals.SetRange("Line No", LineNo);
        if DialysisVitals.Find('-') then
            DialysisVitals.Delete();

    end;

    procedure GenerateDialysisChart(TreatmentNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.get;
        HMSSetup.TestField("Portal Report Path");
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
        DialysisPatientInfo.Reset();
        DialysisPatientInfo.SetRange(TreatmentNo, TreatmentNo);
        if DialysisPatientInfo.find('-') then begin
            REPORT.SAVEASPDF(Report::"HMS HaemoDialysis Chart", filename, DialysisPatientInfo);
        End;
    end;

    procedure GenerateDialysisDischargeSummary(DialysisNo: Text; filenameFromApp: Text) filename: Text
    begin
        HMSSetup.Get;
        filename := HMSSetup."Portal Report Path" + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        HMSDialysisFormHeader.Reset;
        HMSDialysisFormHeader.SetRange(HMSDialysisFormHeader."Treatment No.", DialysisNo);

        if HMSDialysisFormHeader.Find('-') then begin
            Report.SaveAsPdf(Report::"HMS Discharge Summary Dialysis", filename, HMSDialysisFormHeader);
        end;
        exit(filename);
    end;


}

