#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52202504 "Staff Portal Codeunit"
{
    trigger OnRun()
    begin
    end;

    var
        TbApprovalCommentLine: Record "Approval Comment Line";
        TbApprovalEntry: Record "Approval Entry";
        TbCashOfficeSetup: Record "Cash Office Setup";
        TbCustomer: Record Customer;
        TbDocumentAttachment: Record "Document Attachment";
        TbEmployeePnine: Record Employee;
        TbAdvFinSetup: Record "General Ledger Setup";
        TbGeneralSetup: Record "General Ledger Setup";
        TbEmployee: Record "HR-Employee";
        TbEmployeeMaster: Record "HR-Employee";
        TbPrSalaryCard: Record "HR-Employee";
        TbAppraisalHe: Record "HR Appraisal Card1";
        TbAppraisalScore: Record "HR Appraisal skills comp Score";
        TbHRJobs: Record "HR Jobs";
        HRLeaveApplication: Record "HR Leave Application";
        TbLeaveLedger: Record "HR Leave Ledger";
        TbLeaveLedger2: Record "HR Leave Ledger";
        // CuImprestMgt: Codeunit ;
        // TbClaimSetup: Record UnknownRecord52202487;
        HRSetup: Record "HR Setup";
        // TbTempBlob: Record tempbl;
        TbTrainingHe: Record "HR Training Applications";
        TbTrainingParticipant: Record "HR Training Participants";
        TbImprestRequisitionHeader: Record "Imprest Header";
        TbImprestRequisitionLines: Record "Imprest Lines";
        TbImprestSurrenderLines: Record "Imprest Surrender Details";
        TbImprestSurrenderHeader: Record "Imprest Surrender Header";
        TbImprestSurrenderHeader2: Record "Imprest Surrender Header";
        TbItem: Record Item;
        TbCommitments: Record "Payment Line";
        TbPVLine: Record "Payment Line";
        TbReceiptPaymentType: Record "Payment Line";
        TbPVHeader: Record "Payments Header";
        // TbLeavePeriod: Record Leavecalendar;
        TbEmp99Info: Record "prEmployee P9 Info";
        TbPaPerTrans: Record "prPeriod Transactions";
        PRSalaryCard: Record "prSalary Card";
        TbPurchaseHeader: Record "Purchase Header";
        TbPurchaseLine: Record "Purchase Line";
        TbProcurementSetup: Record "Purchases & Payables Setup";
        TbTransportRequisition: Record "Purchases & Payables Setup";
        TbStaffClaimLines: Record "Staff Claim Lines";
        TbStaffClaimHeader: Record "Staff Claims Header";
        TbStaffClaimsHeader: Record "Staff Claims Header";
        TbStoreRequisition: Record "Store Requistion Header";
        TbStoreRequisitionLine: Record "Store Requistion Lines";
        TbTenantMedia: Record "Tenant Media";
        TbUserSetup: Record "User Setup";
        IndividualPayslip: Report "Individual Payslips mst";
        RpPayslip: Report "Individual Payslips mst";
        RpLeaveStatement: Report "Leave statements";
        RpPnine: Report "P9 Report Portal (Final)";
        RpPV: Report "Payment Voucher Vend";
        RpMasterRoll: Report "Payroll Master Summary";
        CuApprovalsManagement: Codeunit "Approvals Mgmt.";
        CuBase64Convert: Codeunit "Base64 Convert";
        CuCustomApprovals: Codeunit "Custom Approvals Codeunit";
        CuBudgetaryControl: Codeunit "GLBudget-Open";
        CuNoSeriesMgt: Codeunit NoSeriesManagement;
        TbTempBlob: codeunit "Temp Blob";
        MyRecordRef: RecordRef;
        NextNo: Code[20];
        MyInStream: InStream;
        DocState: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        MyOutstream: OutStream;
        filename: Text[350];
        FILESPATH: Text[350];
        VarVariant: Variant;

    procedure GetStaffName(staffNo: Code[100]) name: Text[250]
    begin
        TbEmployee.Reset();
        TbEmployee.SetRange(TbEmployee."No.", staffNo);

        if TbEmployee.FindFirst() then begin
            name := TbEmployee."First Name" + ' ' + TbEmployee."Middle Name" + ' ' + TbEmployee."Last Name";
        end;
    end;

    procedure UpdatePasswordToken(password_token: Code[10]; staffNo: Code[50]) updated: Boolean
    begin
        updated := false;
        TbEmployee.RESET();
        TbEmployee.SETRANGE("No.", staffNo);
        IF TbEmployee.FINDFIRST() THEN begin
            TbEmployee."Portal Reset Token" := password_token;
            TbEmployee."Portal Reset Token Expired" := false;
            TbEmployee.MODIFY();
            updated := true;
        END;
    end;

    procedure UpdatePassword(staffNo: Code[50]; password: Text[180]) inserted: Boolean
    begin
        inserted := FALSE;
        TbEmployee.RESET();
        TbEmployee.SETRANGE(TbEmployee."No.", staffNo);
        IF TbEmployee.FINDFIRST() THEN BEGIN
            TbEmployee."Portal Password" := password;
            TbEmployee."Portal Reset Token Expired" := true;
            TbEmployee."Changed Password" := true;
            TbEmployee.Modify();
            inserted := true;
        END;
    end;

    procedure SendEmail(recipients: Text[250]; subject: Text[50]; message: Text[1000]; ccRecipients: Text[100]) returnValue: Boolean
    var
        CuEmail: Codeunit Email;
        CuEmailMessage: Codeunit "Email Message";
        BCcRecipients: List of [Text];
        CcRecipients2: List of [Text];
        EmailRecipients: List of [Text];
    begin
        returnValue := FALSE;
        EmailRecipients := recipients.Split(';');
        CcRecipients2 := ccRecipients.Split(';');
        CuEmailMessage.Create(EmailRecipients, subject, message, true, CcRecipients2, BCcRecipients);
        CuEmail.Send(CuEmailMessage, Enum::"Email Scenario"::Default);
        returnValue := true;
    end;

    procedure FnGetLeaveDetails(empNo: Code[30]; startDate: Date; endDate: Date; leaveType: Code[20]) returnValue: Text
    begin
        HRLeaveApplication.Reset();
        HRLeaveApplication.Init();
        HRLeaveApplication."Leave Type" := leaveType;
        HRLeaveApplication."Employee No" := empNo;
        HRLeaveApplication."Starting Date" := startDate;
        HRLeaveApplication."End Date" := endDate;
        HRLeaveApplication.Validate("End Date");
        returnValue := Format(HRLeaveApplication."Return Date") + '##' + Format(HRLeaveApplication."Applied Days");
    end;

    procedure DocumentApproval(entryNo: Integer; docNo: Code[100]; userID: Code[100]; isApprove: Boolean; comments: Text[250]) return_value: Boolean
    begin
        return_value := false;
        TbApprovalEntry.Reset();
        TbApprovalEntry.SetRange("Entry No.", entryNo);
        TbApprovalEntry.SetRange("Document No.", docNo);
        TbApprovalEntry.SetRange("Approver ID", userID);
        TbApprovalEntry.SetRange(Status, TbApprovalEntry.Status::Open);
        if TbApprovalEntry.FindFirst() then begin
            if isApprove = true then
                CuApprovalsManagement.ApproveApprovalRequests(TbApprovalEntry)
            else
                CuApprovalsManagement.RejectApprovalRequests(TbApprovalEntry);
            DocumentApprovalComments(docNo, comments, userID, TbApprovalEntry."Document Type", TbApprovalEntry."Record ID to Approve", TbApprovalEntry."Sequence No.", TbApprovalEntry."Table ID");
            return_value := true;
        end else begin
            Error('Record to approve not found.');
        end;
    end;

    procedure LeaveDocumentApproval(entryNo: Integer; docNo: Code[20]; userID: Code[50]; isApprove: Boolean; comments: Text[80]; leaveReliever: Code[30]) return_value: Boolean
    var
        TbLeaveApp: Record "HR Leave Application";
    begin
        return_value := false;
        TbApprovalEntry.Reset();
        TbApprovalEntry.SetRange("Entry No.", entryNo);
        TbApprovalEntry.SetRange("Document No.", docNo);
        TbApprovalEntry.SetRange("Approver ID", userID);
        TbApprovalEntry.SetRange(Status, TbApprovalEntry.Status::Open);
        if TbApprovalEntry.FindFirst() then begin
            if isApprove = true then begin
                CuApprovalsManagement.ApproveApprovalRequests(TbApprovalEntry);
                //first approver
                if TbApprovalEntry."Sequence No." = 1 then begin
                    TbLeaveApp.Reset();
                    TbLeaveApp.SetRange("No.", docNo);
                    TbLeaveApp.SetRange(Status, TbLeaveApp.Status::"Pending Approval");
                    if TbLeaveApp.FindFirst() then begin
                        TbLeaveApp."Reliever No." := leaveReliever;
                        TbLeaveApp.Validate("Reliever No.");
                        TbLeaveApp.Modify();
                    end;
                end;
            end
            else
                CuApprovalsManagement.RejectApprovalRequests(TbApprovalEntry);
            DocumentApprovalComments(docNo, comments, userID, TbApprovalEntry."Document Type", TbApprovalEntry."Record ID to Approve", TbApprovalEntry."Sequence No.", TbApprovalEntry."Table ID");
            return_value := true;
        end else begin
            Error('Record to approve not found.');
        end;
    end;

    procedure DocumentApprovalComments(docNo: Code[20]; comments: Text[80]; userID: Code[50]; docType: Integer; recordID: RecordID; sequenceNo: Integer; tableID: Integer) return_value: Boolean
    var
        NextEntryNo: Integer;
    begin
        return_value := false;
        TbApprovalCommentLine.Reset();
        if TbApprovalCommentLine.FindLast() then
            NextEntryNo := TbApprovalCommentLine."Entry No." + 1
        else
            NextEntryNo := 1;
        //
        TbApprovalCommentLine.Reset();
        TbApprovalCommentLine.Init();
        TbApprovalCommentLine."Entry No." := NextEntryNo;
        TbApprovalCommentLine."Table ID" := tableID;
        TbApprovalCommentLine."Document Type" := docType;
        TbApprovalCommentLine."Document No." := docNo;
        TbApprovalCommentLine."User ID" := userID;
        TbApprovalCommentLine.Comment := comments;
        TbApprovalCommentLine."Date and Time" := CurrentDatetime;
        //TbApprovalCommentLine."Seqeunce No.":=sequenceNo;
        TbApprovalCommentLine."Record ID to Approve" := recordID;
        TbApprovalCommentLine.Insert();
        return_value := true;
    end;

    procedure LeaveApplication(leaveNo: Code[100]; employeeNo: Code[30]; leaveType: Code[30]; reason: Text[250]; daysApplied: Integer; startDate: DateTime; reliever: Code[30]; isRequestLeaveAllowance: Boolean; "action": Text; myUserID: Code[30]; endDate: DateTime) return_value: Boolean
    begin
        return_value := false;
        HRLeaveApplication.Reset();
        if action = 'create' then begin
            if HRLeaveApplication.FindLast() then
                NextNo := IncStr(HRLeaveApplication."No.")
            else
                NextNo := 'LV-00001';
            //TbHRSetup.GET;
            //TbHRSetup.TESTFIELD("Leave Application Nos");
            //NextNo := CuNoSeriesMgt.GetNextNo(TbHRSetup."Leave Application Nos", 0D, TRUE);
            HRLeaveApplication.Init();
            HRLeaveApplication."No." := NextNo;
            HRLeaveApplication."Application Date" := Today;
            HRLeaveApplication."Employee No" := employeeNo;
            HRLeaveApplication.Validate("Employee No");
            HRLeaveApplication."User ID" := myUserID;
            HRLeaveApplication."Leave Type" := leaveType;
            HRLeaveApplication.Purpose := reason;
            HRLeaveApplication."Leave Period" := FnGetCurrentLeavePeriod();
            HRLeaveApplication."Starting Date" := Dt2Date(startDate);
            HRLeaveApplication.Validate("Starting Date");
            HRLeaveApplication."End Date" := Dt2Date(endDate);
            HRLeaveApplication.Validate("End Date");
            //TbHRLeaveRequisition."Days Applied" := daysApplied;
            HRLeaveApplication."Reliever No." := reliever;
            HRLeaveApplication.Validate("Reliever No.");
            // HRLeaveApplication."Request Leave Allowance" := isRequestLeaveAllowance;
            // HRLeaveApplication.Validate("Request Leave Allowance");
            if HRLeaveApplication.Insert(true) then begin
                Commit();
                HRLeaveApplication.Reset();
                HRLeaveApplication.SetRange("No.", NextNo);
                if HRLeaveApplication.FindFirst() then begin
                    HRLeaveApplication.Validate("Leave Type");
                    HRLeaveApplication.Validate("Applied Days");
                    HRLeaveApplication.Modify();
                end;
                return_value := true;
            end;
        end else begin
            HRLeaveApplication.SetRange("No.", leaveNo);
            HRLeaveApplication.SetRange("Employee No", employeeNo);
            HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::Open);
            if HRLeaveApplication.FindFirst() then begin
                HRLeaveApplication."Employee No" := employeeNo;
                HRLeaveApplication.Validate("Employee No");
                HRLeaveApplication."User ID" := myUserID;
                HRLeaveApplication."Leave Type" := leaveType;
                HRLeaveApplication.Validate("Leave Type");
                HRLeaveApplication.Purpose := reason;
                HRLeaveApplication."Leave Period" := FnGetCurrentLeavePeriod();
                HRLeaveApplication."Starting Date" := Dt2Date(startDate);
                HRLeaveApplication.Validate("Starting Date");
                HRLeaveApplication."End Date" := Dt2Date(endDate);
                HRLeaveApplication.Validate("End Date");
                //TbHRLeaveRequisition."Days Applied" := daysApplied;
                HRLeaveApplication.Validate("Applied Days");
                HRLeaveApplication."Reliever No." := reliever;
                HRLeaveApplication.Validate("Reliever No.");
                // HRLeaveApplication."Request Leave Allowance" := isRequestLeaveAllowance;
                HRLeaveApplication.Modify();
                return_value := true;
            end else begin
                Error('Leave application is not editable or was not found');
            end;
        end;
    end;

    procedure CancelLeaveApplication(employeeNo: Code[100]; requisitionNo: Code[100]) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        return_value := false;
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange(HRLeaveApplication."No.", requisitionNo);
        HRLeaveApplication.SetRange(HRLeaveApplication."Employee No", employeeNo);
        HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::"Pending Approval");
        if HRLeaveApplication.FindFirst() then begin
            VarVariant := HRLeaveApplication;
            CuCustomApprovals.OnCancelDocApprovalRequest(VarVariant);
            return_value := true;
        end else begin
            Error('Leave application cannot be cancelled or was not found');
        end;
    end;

    procedure RequestLeaveApproval(employeeNo: Code[100]; requisitionNo: Code[30]; tableID: Integer) return_value: Boolean
    begin
        return_value := false;
        HRLeaveApplication.Reset();
        HRLeaveApplication.SetRange(HRLeaveApplication."No.", requisitionNo);
        HRLeaveApplication.SetRange(HRLeaveApplication."Employee No", employeeNo);
        HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::Open);
        if HRLeaveApplication.FindFirst() then begin
            VarVariant := HRLeaveApplication;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;
            Commit();
            FnUpdateApprovalEntries(requisitionNo, HRLeaveApplication."User ID", HRLeaveApplication.RecordId);
        end else begin
            Error('Leave application cannot be sent for approval or was not found');
        end;
    end;

    procedure GeneratePayslip(employeeNo: Code[100]; year: Integer; month: Integer; filenameFromApp: Text[200]) return_value: Text
    var
        MyRecordRef: RecordRef;
        Period: Date;
        PeriodDate: Date;
        Convert: dotnet Convert;
        IOFile: dotnet File;
        MyOutstream: OutStream;
        base64txt: Text;
        // TbTempBlob: Record temp;
        FileName2: Text;
    begin
        return_value := '';
        HRSetup.Get();
        HRSetup.TestField("Portal Reports File Path");
        FILESPATH := HRSetup."Portal Reports File Path";
        filename := FILESPATH + filenameFromApp;
        FileName2 := FILESPATH + '-Encr-' + filenameFromApp;
        if Exists(filename) then
            Erase(filename);

        PRSalaryCard.Reset();
        PRSalaryCard.SetFilter("Employee Code", '=%1', employeeNo);
        PRSalaryCard.SetFilter("Period Filter", '=%1', Dmy2date(1, month, year));
        if PRSalaryCard.FindFirst() then begin
            IndividualPayslip.SetTableview(PRSalaryCard)
        end else begin
            Error('No data found in Employee D');
        end;

        MyRecordRef.GetTable(PRSalaryCard);
        TbTempBlob.CreateOutstream(MyOutstream);
        IndividualPayslip.SaveAs(filename, Reportformat::Pdf, MyOutstream, MyRecordRef);
        TbTempBlob.CreateInStream(MyInStream);
        return_value := CuBase64Convert.ToBase64(MyInStream, true);
        if Exists(filename) then
            Erase(filename);
    end;

    // procedure GeneratePNine(employeeNo: Code[100]; year: Integer; filenameFromApp: Text[200]) return_value: Text
    // var
    //     MyRecordRef: RecordRef;
    //     MyOutstream: OutStream;
    //     // TbTempBlob: Record UnknownRecord99008535;
    //     FileName2: Text;
    //     Convert: dotnet Convert;
    //     IOFile: dotnet File;
    //     base64txt: Text;
    // begin
    //     return_value := '';
    //     HRSetup.Get;
    //     FILESPATH := HRSetup."Portal Reports File Path";
    //     filename := FILESPATH + filenameFromApp;
    //     FileName2 := FILESPATH + '-Encr-' + filenameFromApp;
    //     if Exists(filename) then
    //         Erase(filename);
    //     RpPnine.FnInitiateYear(year);
    //     TbEmployee.Reset;
    //     TbEmployee.SetFilter(TbEmployee."No.", '=%1', employeeNo);
    //     TbEmployee.SetFilter(TbEmployee."Period Year Filter", '=%1', year);
    //     if TbEmployee.FindFirst() then begin
    //         RpPnine.SetTableview(TbEmployee);
    //     end else begin
    //         Error('No data found in Employee');
    //     end;
    //     TbEmp99Info.Reset;
    //     TbEmp99Info.SetFilter("Employee Code", '=%1', employeeNo);
    //     TbEmp99Info.SetFilter("Payroll Period", '%1..%2', Dmy2date(1, 1, year), Dmy2date(31, 12, year));
    //     if TbEmp99Info.FindSet then begin
    //         RpPnine.SetTableview(TbEmp99Info);
    //     end;

    //     MyRecordRef.GetTable(TbEmployee);
    //     TbTempBlob.Blob.CreateOutstream(MyOutstream);
    //     RpPnine.SaveAs(filename, Reportformat::Pdf, MyOutstream, MyRecordRef);
    //     return_value := TbTempBlob.ToBase64String();
    //     /*PDFEncriptor:= PDFEncriptorCode.PDFProtect();
    //     RpPnine.SAVEASPDF(filename);
    //     IF(PDFEncriptor.PdfProtect(filename,FileName2,TbEmployee."ID Number")='Success') THEN BEGIN
    //       base64txt := Convert.ToBase64String(IOFile.ReadAllBytes(FileName2));
    //       return_value := base64txt;
    //     END;
    //     */
    //     if Exists(filename) then
    //         Erase(filename);
    //     if Exists(FileName2) then
    //         Erase(FileName2);
    //     /*RpPnine.FnInitiateDates(startDate,endDate);
    //     MyRecordRef.GETTABLE(TbEmployee);
    //   TbTempBlob.Blob.CREATEOUTSTREAM(MyOutstream);
    //   RpPnine.SAVEAS(filename, REPORTFORMAT::Pdf, MyOutstream, MyRecordRef);
    //   return_value := TbTempBlob.ToBase64String();
    //     IF EXISTS(filename) THEN
    //       ERASE(filename);*/

    // end;

    procedure ImprestRequisitionHeader(myUserId: Code[100]; "action": Text; DocNo: Code[50]; purpose: Text; travelDestination: Text[250]; travelDate: Date; returnDate: Date; isStandingImprest: Boolean) return_value: Code[50]
    begin
        return_value := '';
        TbImprestRequisitionHeader.Reset();
        if action = 'create' then begin
            TbCashOfficeSetup.Get();
            TbCashOfficeSetup.TestField("Imprest Req No");
            NextNo := CuNoSeriesMgt.GetNextNo(TbCashOfficeSetup."Imprest Req No", 0D, true);
            //
            TbImprestRequisitionHeader.Init();
            TbImprestRequisitionHeader."No." := NextNo;
            TbImprestRequisitionHeader.Date := Today;
            TbImprestRequisitionHeader."Requested By" := myUserId;
            TbImprestRequisitionHeader.Cashier := myUserId;
            //TbImprestRequisitionHeader."Global Dimension 1 Code" := department;
            TbImprestRequisitionHeader.Purpose := purpose;
            // TbImprestRequisitionHeader.st := isStandingImprest;
            // TbImprestRequisitionHeader.Validate("Standing Imprest");
            //TbImprestRequisitionHeader."Responsibility Center" := responsibilityCenter;
            // TbImprestRequisitionHeader."Travel Destination" := travelDestination;
            // TbImprestRequisitionHeader."Travel Date" := travelDate;
            // TbImprestRequisitionHeader."Return Date" := returnDate;
            // TbImprestRequisitionHeader.Validate("Travel Date");
            TbImprestRequisitionHeader.Insert(true);
            return_value := NextNo;
        end else begin
            TbImprestRequisitionHeader.SetRange("No.", DocNo);
            TbImprestRequisitionHeader.SetRange(Status, TbImprestRequisitionHeader.Status::Pending);
            if TbImprestRequisitionHeader.FindFirst() then begin
                //TbImprestRequisitionHeader."Global Dimension 1 Code" := department;
                TbImprestRequisitionHeader.Purpose := purpose;
                // TbImprestRequisitionHeader."Standing Imprest" := isStandingImprest;
                // TbImprestRequisitionHeader.Validate("Standing Imprest");
                // //TbImprestRequisitionHeader."Responsibility Center" := responsibilityCenter;
                // TbImprestRequisitionHeader."Travel Destination" := travelDestination;
                // TbImprestRequisitionHeader."Travel Date" := travelDate;
                // TbImprestRequisitionHeader."Return Date" := returnDate;
                // TbImprestRequisitionHeader.Validate("Travel Date");
                TbImprestRequisitionHeader.Cashier := myUserId;
                TbImprestRequisitionHeader.Modify();
                return_value := DocNo;
            end else begin
                Error('Requisition is no longer editable or it does not exist.');
            end;
        end;
    end;

    procedure ImprestRequisitionLine("action": Text; lineNo: Integer; docNo: Code[50]; advanceType: Code[30]; accountNo: Code[30]; amount: Decimal) return_value: Boolean
    begin
        return_value := false;
        //
        TbImprestRequisitionHeader.SetRange("No.", docNo);
        if TbImprestRequisitionHeader.FindFirst() then;
        //
        TbImprestRequisitionLines.Reset();
        if action = 'create' then begin
            TbImprestRequisitionLines.Reset();
            if TbImprestRequisitionLines.FindLast() then
                lineNo := TbImprestRequisitionLines."Line No." + 1
            else
                lineNo := 1;
            //
            TbImprestRequisitionLines.Init();
            TbImprestRequisitionLines.No := docNo;
            TbImprestRequisitionLines."Line No." := lineNo;    //
            TbImprestRequisitionLines."Advance Type" := advanceType;    //
            TbImprestRequisitionLines.Validate("Advance Type");
            TbImprestRequisitionLines."Account No:" := accountNo;
            TbImprestRequisitionLines.Validate("Account No:");
            TbImprestRequisitionLines.Amount := amount;
            TbImprestRequisitionLines."Imprest Holder" := TbImprestRequisitionHeader."Account No.";
            TbImprestRequisitionLines.Insert(true);
            return_value := true;
        end else begin
            TbImprestRequisitionLines.SetRange(No, docNo);
            TbImprestRequisitionLines.SetRange("Line No.", lineNo);
            if TbImprestRequisitionLines.FindFirst() then begin
                TbImprestRequisitionLines."Advance Type" := advanceType;    //
                TbImprestRequisitionLines.Validate("Advance Type");
                TbImprestRequisitionLines."Account No:" := accountNo;
                TbImprestRequisitionLines.Validate("Account No:");
                TbImprestRequisitionLines.Amount := amount;
                TbImprestRequisitionLines."Imprest Holder" := TbImprestRequisitionHeader."Account No.";
                TbImprestRequisitionLines.Modify();
                return_value := true;
            end else begin
                Error('Requisition line is no longer editable or it does not exist.');
            end;
        end;
    end;

    procedure DeleteImprestLine(lineNo: Integer; requisitionNo: Code[100]) return_value: Boolean
    begin
        return_value := false;
        TbImprestRequisitionLines.Reset();
        TbImprestRequisitionLines.SetRange(No, requisitionNo);
        TbImprestRequisitionLines.SetRange("Line No.", lineNo);
        if TbImprestRequisitionLines.FindFirst() then begin
            TbImprestRequisitionLines.Delete();
            return_value := true;
        end else begin
            Error('Requisition line cannot be deleted or was not found');
        end;
    end;

    procedure CancelImprestRequisition(employeeNo: Code[100]; requisitionNo: Code[100]; tableID: Integer) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        return_value := false;
        TbImprestRequisitionHeader.Reset();
        TbImprestRequisitionHeader.SetRange("No.", requisitionNo);
        TbImprestRequisitionHeader.SetRange("Employee No.", employeeNo);
        if TbImprestRequisitionHeader.FindFirst() then begin
            VarVariant := TbImprestRequisitionHeader;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition cannot be cancelled or was not found');
        end;
    end;

    procedure RequestImprestApproval(employeeNo: Code[100]; reqNo: Code[50]; tableID: Integer) return_value: Boolean
    begin
        return_value := false;
        if not IsImprestLinesExists(reqNo) then
            Error('You must add imprest lines before sENDing an imprest for approval.');
        TbImprestRequisitionHeader.Reset();
        TbImprestRequisitionHeader.SetRange("No.", reqNo);
        TbImprestRequisitionHeader.SetRange("Employee No.", employeeNo);
        if TbImprestRequisitionHeader.FindFirst() then begin
            //First Check whether other lines are already committed.
            // TbCommitments.Reset;
            // TbCommitments.SetRange(TbCommitments."Document Type", TbCommitments."document type"::Imprest);
            // TbCommitments.SetRange(TbCommitments."Document No.", reqNo);
            // TbCommitments.DeleteAll;
            VarVariant := TbImprestRequisitionHeader;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition is no longer editable or it does not exist.');
        end;
    end;

    procedure IsImprestLinesExists(reqNo: Code[100]) hasLines: Boolean
    begin
        hasLines := false;
        TbImprestRequisitionLines.Reset();
        TbImprestRequisitionLines.SetRange(TbImprestRequisitionLines.No, reqNo);
        if TbImprestRequisitionLines.FindFirst() then begin
            hasLines := true;
        end;
    end;

    procedure ImprestSurrenderHeader(myUserID: Code[30]; myAction: Text[100]; docNo: Code[30]; imprestIssueDocNo: Code[30]; receivedFrom: Code[50]; PVNo: Code[30]) return_value: Code[50]
    begin
        return_value := '';
        if myAction = 'create' then begin
            TbCashOfficeSetup.Get();
            TbCashOfficeSetup.TestField("Imprest Surrender No");
            NextNo := CuNoSeriesMgt.GetNextNo(TbCashOfficeSetup."Imprest Surrender No", 0D, true);
            TbImprestSurrenderHeader.No := NextNo;
            TbImprestSurrenderHeader."Surrender Date" := Today;
            TbImprestSurrenderHeader."User ID" := myUserID;
            TbImprestSurrenderHeader."Account No." := GetUserCustomerNo(myUserID, '');
            TbImprestSurrenderHeader."Imprest Issue Doc. No" := imprestIssueDocNo;
            TbImprestSurrenderHeader."Received From" := receivedFrom;
            TbImprestSurrenderHeader."PV No" := PVNo;
            //TbImprestSurrenderHeader."Financial Period":=financialPeriod;
            if TbImprestSurrenderHeader.Insert() then begin
                Commit();
                TbImprestSurrenderHeader.Reset();
                TbImprestSurrenderHeader.SetRange(No, NextNo);
                if TbImprestSurrenderHeader.FindFirst() then begin
                    TbImprestSurrenderHeader.Validate("Imprest Issue Doc. No");
                    TbImprestSurrenderHeader.Validate("PV No");
                    TbImprestSurrenderHeader.Modify();
                end;
            end;
            return_value := NextNo;
        end else begin
            TbImprestSurrenderHeader.Reset();
            TbImprestSurrenderHeader.SetRange(No, docNo);
            if TbImprestSurrenderHeader.FindFirst() then begin
                TbImprestSurrenderHeader."Imprest Issue Doc. No" := imprestIssueDocNo;
                TbImprestSurrenderHeader.Validate("Imprest Issue Doc. No");
                TbImprestSurrenderHeader."Received From" := receivedFrom;
                TbImprestSurrenderHeader."PV No" := PVNo;
                TbImprestSurrenderHeader.Validate("PV No");
                //TbImprestSurrenderHeader."Financial Period":=financialPeriod;
                TbImprestSurrenderHeader.Validate("Financial Period");
                TbImprestSurrenderHeader.Modify(true);
                return_value := docNo;
            end;
        end;
    end;

    procedure ImprestSurrenderLine(docNo: Code[50]; lineNo: Integer; actualSpent: Decimal; cashReceiptNo: Code[20]; cashReceiptAmount: Decimal) return_value: Boolean
    begin
        return_value := false;
        TbImprestSurrenderLines.Reset();
        TbImprestSurrenderLines.SetRange("Surrender Doc No.", docNo);
        if TbImprestSurrenderLines.FindFirst() then begin
            TbImprestSurrenderLines."Actual Spent" := actualSpent;
            TbImprestSurrenderLines."Cash Receipt No" := cashReceiptNo;
            TbImprestSurrenderLines."Cash Receipt Amount" := cashReceiptAmount;
            TbImprestSurrenderLines.Validate("Actual Spent");
            TbImprestSurrenderLines.Modify();
            return_value := true;
        end else begin
            Error('Imprest surrender line is no longer editable or it does not exist.');
        end;
    end;

    procedure DeletImprestSurrenderLine(accountNo: Code[50]; requisitionNo: Code[100]; LineNo: Integer) return_value: Boolean
    begin
        return_value := false;
        TbImprestSurrenderLines.Reset();
        TbImprestSurrenderLines.SetRange("Surrender Doc No.", requisitionNo);
        // TbImprestSurrenderLines.SetRange("Line No", LineNo);
        TbImprestSurrenderLines.SetRange("Account No:", accountNo);
        if TbImprestSurrenderLines.FindFirst() then begin
            TbImprestSurrenderLines.Delete();
            return_value := true;
        end else begin
            Error('Imprest surrender details cannot be deleted or was not found');
        end;
    end;

    procedure RequestImprestSurrenderApproval(docNo: Code[100]) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        return_value := false;
        TbImprestSurrenderHeader.Reset();
        TbImprestSurrenderHeader.SetRange(No, docNo);
        if TbImprestSurrenderHeader.FindFirst() then begin
            VarVariant := TbImprestSurrenderHeader;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;
        end else begin
            Error('Imprest Surrender cannot be sent for approval or was not found');
        end;
    end;

    procedure CancelImprestSurrender(employeeNo: Code[100]; requisitionNo: Code[100]; tableID: Integer) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        return_value := false;
        TbImprestSurrenderHeader.Reset();
        TbImprestSurrenderHeader.SetRange(No, requisitionNo);
        if TbImprestSurrenderHeader.FindFirst() then begin
            VarVariant := TbImprestSurrenderHeader;
            CuCustomApprovals.OnCancelDocApprovalRequest(VarVariant);
        end else begin
            Error('Imprest Surrender cannot be cancelled or was not found');
        end;
    end;

    procedure StoreRequisitionHeader(myUserID: Code[100]; myAction: Text; docNo: Code[30]; requestDate: Date; requestDescription: Text) return_value: Code[50]
    begin
        return_value := '';
        TbStoreRequisition.Reset();
        if myAction = 'create' then begin
            TbCashOfficeSetup.Get();
            TbCashOfficeSetup.TestField("Stores Requisition No");
            NextNo := CuNoSeriesMgt.GetNextNo(TbCashOfficeSetup."Stores Requisition No", 0D, true);
            TbStoreRequisition.Init();
            TbStoreRequisition."No." := NextNo;
            TbStoreRequisition."User ID" := myUserID;
            TbStoreRequisition."Request date" := Today;
            TbStoreRequisition."Required Date" := requestDate;
            TbStoreRequisition."Request Description" := requestDescription;
            //
            TbUserSetup.Get(myUserID);
            TbUserSetup.TestField("Employee No.");
            TbEmployee.Reset();
            TbEmployee.SetRange("No.", TbUserSetup."Employee No.");
            if TbEmployee.FindFirst() then begin
                TbEmployee.TestField("Shortcut Dimension 1 Code");
                TbEmployee.TestField("Shortcut Dimension 2 Code");
                TbEmployee.TestField("Responsibility Center");
                TbStoreRequisition."Global Dimension 1 Code" := TbEmployee."Shortcut Dimension 1 Code";
                TbStoreRequisition."Shortcut Dimension 2 Code" := TbEmployee."Shortcut Dimension 2 Code";
                TbStoreRequisition."Responsibility Center" := TbEmployee."Responsibility Center";
            end;
            TbStoreRequisition.Insert(true);
            return_value := NextNo;
        end else begin
            TbStoreRequisition.SetRange("No.", docNo);
            if TbStoreRequisition.FindFirst() then begin
                TbStoreRequisition."Request date" := Today;
                TbStoreRequisition."Required Date" := requestDate;
                TbStoreRequisition."Request Description" := requestDescription;
                //
                TbUserSetup.Get(myUserID);
                TbUserSetup.TestField("Employee No.");
                TbEmployee.Reset();
                TbEmployee.SetRange("No.", TbUserSetup."Employee No.");
                if TbEmployee.FindFirst() then begin
                    TbEmployee.TestField("Shortcut Dimension 1 Code");
                    TbEmployee.TestField("Shortcut Dimension 2 Code");
                    TbEmployee.TestField("Responsibility Center");
                    TbStoreRequisition."Global Dimension 1 Code" := TbEmployee."Shortcut Dimension 1 Code";
                    TbStoreRequisition."Shortcut Dimension 2 Code" := TbEmployee."Shortcut Dimension 2 Code";
                    TbStoreRequisition."Responsibility Center" := TbEmployee."Responsibility Center";
                end;
                TbStoreRequisition.Modify();
                return_value := docNo;
            end else begin
                Error('Requisition is no longer editable or it does not exist.');
            end;
        end;
    end;

    procedure StoreRequisitionLine("action": Text; lineNo: Integer; type: Integer; reqNo: Code[50]; itemNo: Code[100]; location: Code[30]; quantity: Decimal) return_value: Boolean
    var
        Itemob: Record Item;
    begin
        return_value := false;
        TbStoreRequisitionLine.Reset();
        if action = 'create' then begin
            TbStoreRequisitionLine.Reset();
            if TbStoreRequisitionLine.FindLast() then
                lineNo := TbStoreRequisitionLine."Line No." + 1
            else
                lineNo := 1;
            TbStoreRequisitionLine.Init();
            TbStoreRequisitionLine."Line No." := lineNo;
            TbStoreRequisitionLine."Requistion No" := reqNo;
            TbStoreRequisitionLine.Type := type;
            TbStoreRequisitionLine."No." := itemNo;
            TbStoreRequisitionLine."Issuing Store" := location;
            TbStoreRequisitionLine.Quantity := quantity;
            TbStoreRequisitionLine."Quantity Requested" := quantity;
            TbStoreRequisitionLine.Validate(Quantity);
            TbStoreRequisitionLine.Validate("Quantity Requested");
            TbStoreRequisitionLine.Validate(TbStoreRequisitionLine."No.");
            TbStoreRequisitionLine.Validate(TbStoreRequisitionLine."Unit Cost");
            //*********************** Check stock level**************
            Itemob.Reset();
            Itemob.SetRange(Itemob."No.", itemNo);
            Itemob.SetRange(Itemob."Location Filter", location);
            if Itemob.FindFirst() then begin
                Itemob.CalcFields(Itemob.Inventory);
                if (Itemob.Inventory - quantity) < 0 then begin
                    Error('This transaction will result in Negative stock %1,%2', Itemob.Inventory, quantity);
                end;
            end;
            TbStoreRequisitionLine.Insert(true);
            return_value := true;
        end else begin
            TbStoreRequisitionLine.SetRange("Requistion No", reqNo);
            TbStoreRequisitionLine.SetRange("Line No.", lineNo);
            if TbStoreRequisitionLine.FindFirst() then begin
                TbStoreRequisitionLine."Requistion No" := reqNo;
                TbStoreRequisitionLine.Type := type;
                TbStoreRequisitionLine."No." := itemNo;
                TbStoreRequisitionLine."Issuing Store" := location;
                TbStoreRequisitionLine.Quantity := quantity;
                TbStoreRequisitionLine."Quantity Requested" := quantity;
                TbStoreRequisitionLine.Validate(Quantity);
                TbStoreRequisitionLine.Validate("Quantity Requested");
                TbStoreRequisitionLine.Validate(TbStoreRequisitionLine."No.");
                TbStoreRequisitionLine.Validate(TbStoreRequisitionLine."Unit Cost");
                TbStoreRequisitionLine.Validate(TbStoreRequisitionLine.Quantity);
                //*********************** Check stock level**************
                Itemob.Reset();
                Itemob.SetRange(Itemob."No.", itemNo);
                Itemob.SetRange(Itemob."Location Filter", location);
                if Itemob.FindFirst() then begin
                    Itemob.CalcFields(Itemob.Inventory);
                    if (Itemob.Inventory - quantity) < 0 then begin
                        Error('This transaction will result in Negative stock %1,%2', Itemob.Inventory, quantity);
                    end;
                end;
                TbStoreRequisitionLine.Modify();
                return_value := true;
            end else begin
                Error('Requisition line is no longer editable or it does not exist.');
            end;
        end;
    end;

    procedure DeleteStoreReqLine(lineNo: Integer; requisitionNo: Code[100]) return_value: Boolean
    begin
        return_value := false;
        TbStoreRequisitionLine.Reset();
        TbStoreRequisitionLine.SetRange("Requistion No", requisitionNo);
        TbStoreRequisitionLine.SetRange("Line No.", lineNo);
        if TbStoreRequisitionLine.FindFirst() then begin
            TbStoreRequisitionLine.Delete();
            return_value := true;
        end else begin
            Error('Requisition line cannot be deleted or was not found');
        end;
    end;

    procedure CancelStoreRequisition(employeeNo: Code[100]; requisitionNo: Code[100]; tableID: Integer) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        return_value := false;
        TbStoreRequisition.Reset();
        TbStoreRequisition.SetRange("No.", requisitionNo);
        if TbStoreRequisition.FindFirst() then begin
            VarVariant := TbStoreRequisition;
            CuCustomApprovals.OnCancelDocApprovalRequest(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition cannot be cancelled or was not found');
        end;
    end;

    procedure RequestStoreReqApproval(employeeNo: Code[100]; reqNo: Code[50]; tableID: Integer) return_value: Boolean
    begin
        return_value := false;
        if not IsStoreReqLinesExists(reqNo) then
            Error('You must add store requisition lines before sENDing the requisition for approval.');
        TbStoreRequisition.Reset();
        TbStoreRequisition.SetRange("No.", reqNo);
        if TbStoreRequisition.FindFirst() then begin
            VarVariant := TbStoreRequisition;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition is no longer editable or it does not exist.');
        end;
    end;

    procedure IsStoreReqLinesExists(reqNo: Code[100]) hasLines: Boolean
    begin
        hasLines := false;
        TbStoreRequisitionLine.Reset();
        TbStoreRequisitionLine.SetRange(TbStoreRequisitionLine."Requistion No", reqNo);
        if TbStoreRequisitionLine.FindFirst() then begin
            hasLines := true;
        end;
    end;

    procedure PurchaseRequisitionHeader("action": Text; myUserId: Code[100]; reqNo: Code[100]; postingDescription: Text; orderDate: Date; pricesIncludingVAT: Boolean) return_value: Code[50]
    begin
        return_value := '';
        TbProcurementSetup.Get();
        TbProcurementSetup.TestField("Quote Nos.");
        TbPurchaseHeader.Reset();
        if action = 'create' then begin
            NextNo := CuNoSeriesMgt.GetNextNo(TbProcurementSetup."Quote Nos.", 0D, true);
            TbPurchaseHeader.Init();
            TbPurchaseHeader."No." := NextNo;
            TbPurchaseHeader.DocApprovalType := TbPurchaseHeader.Docapprovaltype::Requisition;
            TbPurchaseHeader."Document Type" := TbPurchaseHeader."document type"::Quote;
            TbPurchaseHeader."Assigned User ID" := myUserId;
            TbPurchaseHeader.Validate("Assigned User ID");
            TbPurchaseHeader."Requested Receipt Date" := orderDate;
            TbPurchaseHeader."Order Date" := orderDate;
            TbPurchaseHeader."Document Date" := Today;
            TbPurchaseHeader."Posting Description" := postingDescription;
            TbPurchaseHeader."Prices Including VAT" := pricesIncludingVAT;
            TbPurchaseHeader."Buy-from Vendor No." := 'DEF_VEND';
            TbPurchaseHeader."Pay-to Vendor No." := 'DEF_VEND';
            //
            TbUserSetup.Get(myUserId);
            TbUserSetup.TestField("Employee No.");
            TbEmployee.Reset();
            TbEmployee.SetRange("No.", TbUserSetup."Employee No.");
            if TbEmployee.FindFirst() then begin
                TbEmployee.TestField("Shortcut Dimension 1 Code");
                TbEmployee.TestField("Shortcut Dimension 2 Code");
                TbEmployee.TestField("Responsibility Center");
                TbPurchaseHeader."Shortcut Dimension 1 Code" := TbEmployee."Shortcut Dimension 1 Code";
                TbPurchaseHeader."Shortcut Dimension 2 Code" := TbEmployee."Shortcut Dimension 2 Code";
                TbPurchaseHeader."Responsibility Center" := 'PROCURE';
            end;
            TbPurchaseHeader.Insert(true);
            return_value := NextNo;
        end else begin
            TbPurchaseHeader.Reset();
            TbPurchaseHeader.SetRange("No.", reqNo);
            TbPurchaseHeader.SetRange(Status, TbPurchaseHeader.Status::Open);
            if TbPurchaseHeader.FindFirst() then begin
                TbPurchaseHeader.DocApprovalType := TbPurchaseHeader.Docapprovaltype::Requisition;
                TbPurchaseHeader."Document Type" := TbPurchaseHeader."document type"::Quote;
                TbPurchaseHeader."Assigned User ID" := myUserId;
                TbPurchaseHeader.Validate("Assigned User ID");
                TbPurchaseHeader."Requested Receipt Date" := orderDate;
                TbPurchaseHeader."Order Date" := Today;
                TbPurchaseHeader."Order Date" := orderDate;
                TbPurchaseHeader."Document Date" := Today;
                TbPurchaseHeader."Posting Description" := postingDescription;
                TbPurchaseHeader."Prices Including VAT" := pricesIncludingVAT;
                //
                TbUserSetup.Get(myUserId);
                TbUserSetup.TestField("Employee No.");
                TbEmployee.Reset();
                TbEmployee.SetRange("No.", TbUserSetup."Employee No.");
                if TbEmployee.FindFirst() then begin
                    TbEmployee.TestField("Shortcut Dimension 1 Code");
                    TbEmployee.TestField("Shortcut Dimension 2 Code");
                    TbEmployee.TestField("Responsibility Center");
                    TbPurchaseHeader."Shortcut Dimension 1 Code" := TbEmployee."Shortcut Dimension 1 Code";
                    TbPurchaseHeader."Shortcut Dimension 2 Code" := TbEmployee."Shortcut Dimension 2 Code";
                    TbPurchaseHeader."Responsibility Center" := TbEmployee."Responsibility Center";
                end;
                TbPurchaseHeader.Modify();
                return_value := reqNo;
            end else begin
                Error('Requisition is no longer editable or it does not exist.');
            end;
        end;
    end;

    procedure PurchaseRequisitionLine("action": Text; reqNo: Code[50]; lineNo: Integer; itemNo: Code[50]; location: Code[50]; quantity: Decimal; type: Integer; procurementPlan: Code[30]; reasonForRequest: Text) return_value: Boolean
    begin
        return_value := false;
        TbPurchaseLine.Reset();
        if action = 'create' then begin
            TbPurchaseHeader.Reset();
            TbPurchaseLine.SetRange("Document No.", reqNo);
            if TbPurchaseLine.FindLast() then
                lineNo := TbPurchaseLine."Line No." + 1
            else
                lineNo := 1;
            TbPurchaseLine.Reset();
            TbPurchaseLine.Init();
            TbPurchaseLine."Line No." := lineNo;
            TbPurchaseLine."Document No." := reqNo;
            TbPurchaseLine.Type := type;
            TbPurchaseLine.Validate(Type);
            TbPurchaseLine."No." := itemNo;
            TbPurchaseLine.Validate("No.");
            TbPurchaseLine."Location Code" := location;
            TbPurchaseLine.Quantity := quantity;
            TbPurchaseLine."Reason for Request" := reasonForRequest;
            TbPurchaseLine.Validate(Quantity);
            TbPurchaseLine.Insert(true);
            return_value := true;
        end else begin
            TbPurchaseLine.SetRange("Document No.", reqNo);
            TbPurchaseLine.SetRange("Line No.", lineNo);
            if TbPurchaseLine.FindFirst() then begin
                TbPurchaseLine.Type := type;
                TbPurchaseLine.Validate(Type);
                TbPurchaseLine."No." := itemNo;
                TbPurchaseLine.Validate("No.");
                TbPurchaseLine."Location Code" := location;
                TbPurchaseLine.Quantity := quantity;
                // TbPurchaseLine."Procurement Plan" := procurementPlan;
                TbPurchaseLine."Reason for Request" := reasonForRequest;
                TbPurchaseLine.Validate(Quantity);
                TbPurchaseLine.Modify();
                return_value := true;
            end else begin
                Error('Requisition line is no longer editable or it does not exist.');
            end;
        end;
    end;

    procedure DeletePurchaseReqLine(lineNo: Integer; requisitionNo: Code[100]) return_value: Boolean
    begin
        return_value := false;
        TbPurchaseLine.Reset();
        TbPurchaseLine.SetRange("Document No.", requisitionNo);
        TbPurchaseLine.SetRange("Line No.", lineNo);
        if TbPurchaseLine.FindFirst() then begin
            TbPurchaseLine.Delete();
            return_value := true;
        end else begin
            Error('Requisition line cannot be deleted or was not found');
        end;
    end;

    procedure CancelPurchaseRequisition(employeeNo: Code[100]; requisitionNo: Code[100]; tableID: Integer) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        return_value := false;
        TbPurchaseHeader.Reset();
        TbPurchaseHeader.SetRange("No.", requisitionNo);
        if TbPurchaseHeader.FindFirst() then begin
            //VarVariant:= TbPurchaseHeader;
            CuApprovalsManagement.OnCancelPurchaseApprovalRequest(TbPurchaseHeader);
            return_value := true;
        end else begin
            Error('Requisition cannot be cancelled or was not found');
        end;
    end;

    procedure RequestPurchaseReqApproval(employeeNo: Code[100]; reqNo: Code[50]; tableID: Integer) return_value: Boolean
    begin
        return_value := false;
        if not IsPurchaseReqLinesExists(reqNo) then
            Error('You must add purchase requisition lines before sENDing the requisition for approval.');
        TbPurchaseHeader.Reset();
        TbPurchaseHeader.SetRange("No.", reqNo);
        if TbPurchaseHeader.FindFirst() then begin
            if CuApprovalsManagement.IsPurchaseApprovalsWorkflowEnabled(TbPurchaseHeader) then
                CuApprovalsManagement.OnSendPurchaseDocForApproval(TbPurchaseHeader);
            return_value := true;
        end else begin
            Error('Requisition is no longer editable or it does not exist.');
        end;
    end;

    procedure IsPurchaseReqLinesExists(reqNo: Code[100]) hasLines: Boolean
    begin
        hasLines := false;
        TbPurchaseLine.Reset();
        TbPurchaseLine.SetRange(TbPurchaseLine."Document No.", reqNo);
        if TbPurchaseLine.FindFirst() then begin
            hasLines := true;
        end;
    end;

    procedure TransportRequisition(employeeNo: Code[100]; purpose: Text[250]; responsibilityCenter: Code[100]; "action": Text; reqNo: Code[50]; destination: Text; commenceFrom: Text[200]; dateOfTrip: Date; noOfDays: Integer; noOfPassengers: Integer; requestType: Integer; travelType: Integer; noSeries: Code[50]) return_value: Boolean
    var
        supervisorId: Text;
    begin
        /*return_value:=FALSE;
        TbTransportRequisition.RESET;
        IF action = 'create' THEN BEGIN
          TbTransportRequisition.INIT;
          NextNo := CuNoSeriesMgt.GetNextNo(noSeries, 0D, TRUE);
          TbEmployee.RESET;
          TbEmployee.SETRANGE(TbEmployee."No.",employeeNo);

          IF TbEmployee.FINDFIRST THEN BEGIN
              TbTransportRequisition."Requested By" := TbEmployee."User ID";
              TbTransportRequisition.Department := TbEmployee."Department Code";
              TbTransportRequisition.Name := TbEmployee."Search Name";
              TbUserSetup.RESET;
              TbUserSetup.SETRANGE(TbUserSetup."User ID", TbEmployee."User ID");
              IF TbUserSetup.FINDFIRST THEN BEGIN
                  supervisorId := TbUserSetup."Approver ID";
              END;
          END;
          TbTransportRequisition."Transport Requisition No" := NextNo;
          TbTransportRequisition.Commencement := commenceFrom;
          TbTransportRequisition.Destination := destination;
          TbTransportRequisition."Date of Request" := TODAY;
          TbTransportRequisition."Time Requested" := TIME;
          TbTransportRequisition."Date of Trip" := dateOfTrip;
          TbTransportRequisition."Purpose of Trip" := purpose;
          TbTransportRequisition."No. Series" := noSeries;
          TbTransportRequisition."Responsibility Center" := responsibilityCenter;
          TbTransportRequisition."No of Days Requested" := noOfDays;
          TbTransportRequisition."No Of Passangers" := noOfPassengers;
          TbTransportRequisition.INSERT;
          return_value:=TRUE;
        END ELSE BEGIN
          TbTransportRequisition.RESET;
          TbTransportRequisition.SETRANGE("Transport Requisition No", reqNo);
          TbTransportRequisition.SETRANGE(Status, TbTransportRequisition.Status::"0");
          IF TbTransportRequisition.FINDFIRST() THEN BEGIN
              TbTransportRequisition.Commencement := commenceFrom;
              TbTransportRequisition.Destination := destination;
              TbTransportRequisition."Date of Request" := TODAY;
              TbTransportRequisition."Time Requested" := TIME;
              TbTransportRequisition."Date of Trip" := dateOfTrip;
              TbTransportRequisition."Purpose of Trip" := purpose;
              TbTransportRequisition."No. Series" := noSeries;
              TbTransportRequisition."Responsibility Center" := responsibilityCenter;
              TbTransportRequisition."No of Days Requested" := noOfDays;
              TbTransportRequisition."No Of Passangers" := noOfPassengers;
              TbTransportRequisition.MODIFY;
              return_value:=TRUE;
          END ELSE BEGIN
            ERROR('Requisition is no longer editable or it does not exist.');
          END;
        END;*/
    end;

    procedure CancelTransportRequisition(employeeNo: Code[100]; requisitionNo: Code[100]; tableID: Integer) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        /*return_value:=FALSE;
        TbTransportRequisition.RESET;
        TbTransportRequisition.SETRANGE("Transport Requisition No",requisitionNo);
        //TbTransportRequisition.SETRANGE("Requested By",employeeNo);
        IF TbTransportRequisition.FINDFIRST() THEN BEGIN
          VarVariant := TbTransportRequisition;
          CuCustomApprovals.CancelApproval(tableID,DocType,requisitionNo,blnparam,blnparam);
          return_value:=TRUE;
          {IF CuCustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN BEGIN
              CuCustomApprovals.OnCancelDocApprovalRequest(VarVariant);
              return_value:=TRUE;
          END;}
        END ELSE BEGIN
          ERROR('Requisition cannot be cancelled or was not found');
        END;*/
    end;

    procedure RequestTransportReqApproval(employeeNo: Code[100]; reqNo: Code[50]; tableID: Integer) return_value: Boolean
    begin
        /*return_value:=FALSE;
        TbTransportRequisition.RESET;
        TbTransportRequisition.SETRANGE("Transport Requisition No",reqNo);
        IF TbTransportRequisition.FINDFIRST() THEN BEGIN
          DocType:=DocType::TransportRequest;
          IF TbTransportRequisition.Status<>TbTransportRequisition.Status::"0" THEN DocState:=DocState::"Pending Approval";
          CuCustomApprovals.SendApproval(tableID,reqNo,DocType,DocState);
          return_value:=TRUE;
        END ELSE BEGIN
          ERROR('Requisition is no longer editable or it does not exist.');
        END;*/
    end;

    procedure UploadDocumentAttachment(docNo: Code[100]; docNo2: Code[100]; fileName: Text[250]; file: BigText; tableID: Integer) return_value: Boolean
    var
        CuFileManagement: Codeunit "File Management";
        RecordID: RecordID;
        FromRecRef: RecordRef;
        RecordRef1: RecordRef;
        RecordRef2: RecordRef;
        FieldRef: FieldRef;
        isTableFound: Boolean;
        tableFound: Boolean;
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
    begin
        return_value := false;
        if tableID = 52202717 then begin
            TbStaffClaimHeader.Reset();
            TbStaffClaimHeader.SetRange(TbStaffClaimHeader."No.", docNo);
            if TbStaffClaimHeader.FindFirst() then begin
                FromRecRef.GetTable(TbStaffClaimHeader);
            end;
            tableFound := true;
        end;
        //
        if tableFound = true then begin
            if fileName <> '' then begin
                Clear(TbDocumentAttachment);
                TbDocumentAttachment.Init();
                TbDocumentAttachment.Validate("File Extension", CuFileManagement.GetExtension(fileName));
                TbDocumentAttachment.Validate("File Name", CopyStr(CuFileManagement.GetFileNameWithoutExtension(fileName), 1, MaxStrLen(fileName)));
                TbDocumentAttachment.Validate("Table ID", FromRecRef.Number);
                TbDocumentAttachment.Validate("No.", docNo);
                Bytes := Convert.FromBase64String(file);
                MemoryStream := MemoryStream.MemoryStream(Bytes);
                TbDocumentAttachment."Document Reference ID".ImportStream(MemoryStream, '', fileName);
                TbDocumentAttachment.Insert(true);
                return_value := true;
                if CuFileManagement.DeleteServerFile(fileName) then;
            end else
                Error('File name cannot be blank');
        end else begin
            Error('Related table or record for attached file was not found');
        end;
    end;

    procedure DeleteDocumentAttachment(docNo: Code[100]; docID: Integer; tableID: Integer) return_value: Boolean
    var
        CuFileManagement: Codeunit "File Management";
        RecordID: RecordID;
        FromRecRef: RecordRef;
        RecordRef1: RecordRef;
        RecordRef2: RecordRef;
        FieldRef: FieldRef;
        isTableFound: Boolean;
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        Ostream: OutStream;
    begin
        return_value := false;
        TbDocumentAttachment.Reset();
        TbDocumentAttachment.SetRange("Table ID", tableID);
        TbDocumentAttachment.SetRange("No.", docNo);
        TbDocumentAttachment.SetRange(ID, docID);
        if TbDocumentAttachment.FindFirst() then begin
            if TbDocumentAttachment."Document Reference ID".Hasvalue then begin
                Clear(TbDocumentAttachment."Document Reference ID");
                TbDocumentAttachment.Modify(true);
            end;
            TbDocumentAttachment.Delete(true);
            return_value := true;
        end;
    end;

    procedure RequestDocumentApproval(docNo: Code[100]; docNoFieldId: Integer; tableID: Integer) return_value: Boolean
    var
        RecordID: RecordID;
        FromRecRef: RecordRef;
        RecordRef1: RecordRef;
        RecordRef2: RecordRef;
        FieldRef: FieldRef;
    begin
        return_value := false;
        /*RecordRef1.OPEN(tableID);
        FieldRef := RecordRef1.FIELD(docNoFieldId);
        FieldRef.VALUE := docNo;
        IF RecordRef1.FIND('=') THEN BEGIN
          RecordRef2:=RecordRef1;
          VarVariant := RecordRef2;
          IF CuCustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
              CuCustomApprovals.OnSendDocForApproval(VarVariant);
        END ELSE BEGIN
          ERROR('Related table or record was not found');
        END;*/
    end;

    procedure GenerateLeaveStatement(employeeNo: Code[100]; filenameFromApp: Text[200]; leaveType: Code[50]) return_value: Text
    var
        CuTempBlob: codeunit "Temp Blob";
        MyRecordRef: RecordRef;
        MyOutstream: OutStream;
    begin
        return_value := '';
        HRSetup.GET();
        HRSetup.TESTFIELD("Portal Reports File Path");
        FILESPATH := HRSetup."Portal Reports File Path";
        filename := FILESPATH + filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
            
        TbLeaveLedger2.RESET();
        TbLeaveLedger2.SETRANGE(TbLeaveLedger2."Employee No", employeeNo);
        TbLeaveLedger2.SETRANGE("Leave Type", leaveType);
        IF TbLeaveLedger2.FindSet() THEN BEGIN
            RpLeaveStatement.SETTABLEVIEW(TbLeaveLedger2);
        END ELSE BEGIN
            ERROR('No data found');
        END;
        MyRecordRef.GetTable(TbLeaveLedger2);
        CuTempBlob.CreateOutStream(MyOutStream);
        RpLeaveStatement.SAVEAS(filename, REPORTFORMAT::Pdf, MyOutstream, MyRecordRef);
        CuTempBlob.CreateInStream(MyInStream);
        return_value := CuBase64Convert.ToBase64(MyInStream, true);
    end;

    procedure ClaimRequisitionHeader(myUserID: Code[30]; "action": Text; reqNo: Code[50]; staffNo: Code[30]; claimDescription: Text) return_value: Code[50]
    var
        custNo: Code[50];
    begin
        return_value := '';
        TbStaffClaimHeader.Reset();
        if action = 'create' then begin
            TbCashOfficeSetup.Get();
            TbCashOfficeSetup.TestField("Staff Claim No");
            NextNo := CuNoSeriesMgt.GetNextNo(TbCashOfficeSetup."Staff Claim No", 0D, true);
            //
            TbStaffClaimHeader.Init();
            TbStaffClaimHeader."No." := NextNo;
            TbStaffClaimHeader.Cashier := myUserID;
            TbStaffClaimHeader."Employee No" := staffNo;
            TbStaffClaimHeader.Validate("Employee No");
            TbStaffClaimHeader."Account No." := GetUserCustomerNo(myUserID, '');
            TbStaffClaimHeader."Account Type" := TbStaffClaimHeader."account type"::Customer;
            TbStaffClaimHeader.Validate("Account No.");
            TbStaffClaimHeader.Purpose := claimDescription;
            //
            TbEmployee.Reset();
            TbEmployee.SetRange("No.", staffNo);
            if TbEmployee.FindFirst() then begin
                TbEmployee.TestField("Shortcut Dimension 1 Code");
                TbEmployee.TestField("Shortcut Dimension 2 Code");
                TbEmployee.TestField("Responsibility Center");
                TbStaffClaimHeader."Global Dimension 1 Code" := TbEmployee."Shortcut Dimension 1 Code";
                TbStaffClaimHeader."Shortcut Dimension 2 Code" := TbEmployee."Shortcut Dimension 2 Code";
                TbStaffClaimHeader."Responsibility Center" := TbEmployee."Responsibility Center";
            end;
            TbStaffClaimHeader.Insert(true);
            return_value := NextNo;
        end else begin
            TbStaffClaimHeader.SetRange("No.", reqNo);
            TbStaffClaimHeader.SetRange("Employee No", staffNo);
            TbStaffClaimHeader.SetRange(Status, TbStaffClaimHeader.Status::Pending);
            if TbStaffClaimHeader.FindFirst() then begin
                TbStaffClaimHeader."Employee No" := staffNo;
                TbStaffClaimHeader.Validate("Employee No");
                TbStaffClaimHeader."Account No." := GetUserCustomerNo(myUserID, '');
                TbStaffClaimHeader."Account Type" := TbStaffClaimHeader."account type"::Customer;
                TbStaffClaimHeader.Validate("Account No.");
                TbStaffClaimHeader.Purpose := claimDescription;
                //
                TbEmployee.Reset();
                TbEmployee.SetRange("No.", staffNo);
                if TbEmployee.FindFirst() then begin
                    TbEmployee.TestField("Shortcut Dimension 1 Code");
                    TbEmployee.TestField("Shortcut Dimension 2 Code");
                    TbEmployee.TestField("Responsibility Center");
                    TbStaffClaimHeader."Global Dimension 1 Code" := TbEmployee."Shortcut Dimension 1 Code";
                    TbStaffClaimHeader."Shortcut Dimension 2 Code" := TbEmployee."Shortcut Dimension 2 Code";
                    TbStaffClaimHeader."Responsibility Center" := TbEmployee."Responsibility Center";
                end;
                TbStaffClaimHeader.Modify();
                return_value := reqNo;
            end else begin
                Error('Requisition is no longer editable or it does not exist.');
            end;
        end;
    end;

    procedure ClaimRequisitionLine("action": Text; reqNo: Code[50]; lineNo: Integer; claimType: Code[30]; accountNo: Code[30]; amount: Decimal; claimReceiptNo: Code[20]; expenditureDate: Date; expenditureDescription: Text) return_value: Integer
    begin
        return_value := 0;
        TbStaffClaimHeader.Reset();
        if action = 'create' then begin
            TbStaffClaimLines.Reset();
            TbStaffClaimLines.SetRange(No, reqNo);
            if TbStaffClaimLines.FindLast() then
                lineNo := TbStaffClaimLines."Line No." + 1
            else
                lineNo := 1;

            TbStaffClaimLines.Reset();
            TbStaffClaimLines.Init();
            TbStaffClaimLines.No := reqNo;
            TbStaffClaimLines."Line No." := lineNo;
            TbStaffClaimLines."Advance Type" := claimType;
            TbStaffClaimLines."Account No:" := accountNo;
            TbStaffClaimLines.Validate("Account No:");
            TbStaffClaimLines.Amount := amount;
            TbStaffClaimLines."Claim Receipt No" := claimReceiptNo;
            TbStaffClaimLines."Expenditure Date" := expenditureDate;
            TbStaffClaimLines.Purpose := expenditureDescription;
            TbStaffClaimLines.Insert(true);
            return_value := lineNo;
        end else begin
            TbStaffClaimLines.SetRange(No, reqNo);
            TbStaffClaimLines.SetRange("Line No.", lineNo);
            if TbStaffClaimLines.FindFirst() then begin
                TbStaffClaimLines."Advance Type" := claimType;
                TbStaffClaimLines."Account No:" := accountNo;
                TbStaffClaimLines.Validate("Account No:");
                TbStaffClaimLines.Amount := amount;
                TbStaffClaimLines."Claim Receipt No" := claimReceiptNo;
                TbStaffClaimLines."Expenditure Date" := expenditureDate;
                TbStaffClaimLines.Purpose := expenditureDescription;
                TbStaffClaimLines.Modify();
                return_value := lineNo;
            end else begin
                Error('Requisition line is no longer editable or it does not exist.');
            end;
        end;
    end;

    procedure DeleteClaimLine(lineNo: Integer; requisitionNo: Code[100]) return_value: Boolean
    begin
        return_value := false;
        TbStaffClaimLines.Reset();
        TbStaffClaimLines.SetRange(No, requisitionNo);
        TbStaffClaimLines.SetRange("Line No.", lineNo);
        if TbStaffClaimLines.FindFirst() then begin
            TbStaffClaimLines.Delete();
            return_value := true;
        end else begin
            Error('Requisition line cannot be deleted or was not found');
        end;
    end;

    procedure CancelClaimRequisition(employeeNo: Code[100]; requisitionNo: Code[100]; tableID: Integer) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        return_value := false;
        TbStaffClaimHeader.Reset();
        TbStaffClaimHeader.SetRange("No.", requisitionNo);
        TbStaffClaimHeader.SetRange("Employee No", employeeNo);
        if TbStaffClaimHeader.FindFirst() then begin
            VarVariant := TbStaffClaimHeader;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition cannot be cancelled or was not found');
        end;
    end;

    procedure RequestClaimApproval(employeeNo: Code[100]; reqNo: Code[50]) return_value: Boolean
    begin
        return_value := false;
        if not IsClaimLinesExists(reqNo) then
            Error('You must add claim lines before sending a claim for approval.');
        TbStaffClaimHeader.Reset();
        TbStaffClaimHeader.SetRange("No.", reqNo);
        TbStaffClaimHeader.SetRange("Employee No", employeeNo);
        if TbStaffClaimHeader.FindFirst() then begin
            VarVariant := TbStaffClaimHeader;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition is no longer editable or it does not exist.');
        end;
    end;

    procedure IsClaimLinesExists(reqNo: Code[100]) hasLines: Boolean
    begin
        hasLines := false;
        TbStaffClaimLines.Reset();
        TbStaffClaimLines.SetRange(TbStaffClaimLines.No, reqNo);
        if TbStaffClaimLines.FindFirst() then begin
            hasLines := true;
        end;
    end;

    local procedure GetUserCustomerNo(myUserID: Code[30]; employeeNo: Code[50]) customerNo: Code[20]
    begin
        customerNo := '';
        if employeeNo <> '' then begin
            TbUserSetup.Reset();
            TbUserSetup.SetRange("Employee No.", employeeNo);
            if TbUserSetup.FindFirst() then
                customerNo := TbUserSetup."Staff Travel Account";
        end;
        if myUserID <> '' then begin
            TbUserSetup.Reset();
            TbUserSetup.SetRange("User ID", myUserID);
            if TbUserSetup.FindFirst() then
                customerNo := TbUserSetup."Staff Travel Account";
        end;
    end;

    procedure GetDocumentAttachment(docNo: Code[100]; attachmentID: Integer; tableID: Integer) BaseImage: Text
    var
        CuFileManagement: Codeunit "File Management";
        RecordID: RecordID;
        FromRecRef: RecordRef;
        RecordRef1: RecordRef;
        RecordRef2: RecordRef;
        FieldRef: FieldRef;
        isTableFound: Boolean;
        tableFound: Boolean;
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        imageID: Guid;
        Istream: InStream;
        Ostream: OutStream;
    begin
        TbDocumentAttachment.Reset();
        TbDocumentAttachment.SetRange("Table ID", tableID);
        TbDocumentAttachment.SetRange("No.", docNo);
        TbDocumentAttachment.SetRange(ID, attachmentID);
        if TbDocumentAttachment.FindFirst() then begin
            if TbDocumentAttachment."Document Reference ID".Hasvalue then begin
                imageID := TbDocumentAttachment."Document Reference ID".MediaId;
                if TbTenantMedia.Get(imageID) then begin
                    TbTenantMedia.CalcFields(Content);
                    TbTenantMedia.Content.CreateInstream(Istream);
                    MemoryStream := MemoryStream.MemoryStream();
                    CopyStream(MemoryStream, Istream);
                    Bytes := MemoryStream.GetBuffer();
                    BaseImage := Convert.ToBase64String(Bytes);
                end;
            end;
        end;
    end;

    procedure GetPassportPhoto(no: Code[20]; userType: Text) BaseImage: Text
    var
        Bytes: dotnet Array;
        Convert: dotnet Convert;
        MemoryStream: dotnet MemoryStream;
        IStream: InStream;
        ToFile: Text;
    begin
        if userType = 'staff' then begin
            TbEmployee.Reset();
            TbEmployee.SetRange(TbEmployee."No.", no);

            if TbEmployee.FindFirst() then begin
                if TbEmployee.Picture.Hasvalue then begin
                    TbEmployee.CalcFields(Picture);
                    TbEmployee.Picture.CreateInstream(IStream);
                    MemoryStream := MemoryStream.MemoryStream();
                    CopyStream(MemoryStream, IStream);
                    Bytes := MemoryStream.GetBuffer();
                    BaseImage := Convert.ToBase64String(Bytes);
                end;
            end;
        end;
    end;

    procedure SendSMS(phoneNumber: Text; smsMessage: Text) ReturnValue: Text
    var
        BulkSMSSetup: Record Customer;
        RESTWSManagement: Codeunit "Employee/Resource Update";
        Window: Dialog;
        resultParts: dotnet Array;
        encoding: dotnet Encoding;
        HttpResponseMessage: dotnet HttpResponseMessage;
        httpUtility: dotnet HttpUtility;
        JsonConvert: dotnet JsonConvert;
        null: dotnet Object;
        result: dotnet String;
        separator: dotnet String;
        stringContent: dotnet StringContent;
        data: Text;
        statusCode: Text;
        statusText: Text;
    begin
        /*BulkSMSSetup.GET;
        BulkSMSSetup.TESTFIELD("User Name");
        BulkSMSSetup.TESTFIELD("Password Key");

         data := '{"apiKey":"e648029b8c21344a362ecd7b70177839",';
        data += '"mobile":"'+ phoneNumber+'",';
        data += '"message":"' + smsMessage+'",';
        data += '"shortcode":"WAKULIMADAI",';
        data += '"partnerID":"7153"}';

        stringContent := stringContent.StringContent(data,encoding.UTF8,'application/json');
        RESTWSManagement.CallRESTWebService('http://localhost:8001/api/SendSMSAftrinet/',
                                                           '',
                                                           'POST',
                                                           stringContent,
                                                           HttpResponseMessage);

         ReturnValue:= HttpResponseMessage.Content.ReadAsStringAsync.Result;
         //Error(ReturnValue);
         IF (STRPOS(ReturnValue,'"response-description":"Success"') > 0) THEN BEGIN
           ReturnValue:='sent'
         END ELSE BEGIN
           ReturnValue:='Not sent'
         END;*/
    end;

    procedure SendSMSAfrinet(phoneNumber: Text; smsMessage: Text) ReturnValue: Text
    var
        BulkSMSSetup: Record Customer;
        RESTWSManagement: Codeunit "Employee/Resource Update";
        Window: Dialog;
        resultParts: dotnet Array;
        encoding: dotnet Encoding;
        HttpResponseMessage: dotnet HttpResponseMessage;
        httpUtility: dotnet HttpUtility;
        JsonConvert: dotnet JsonConvert;
        null: dotnet Object;
        result: dotnet String;
        separator: dotnet String;
        stringContent: dotnet StringContent;
        data: Text;
        statusCode: Text;
        statusText: Text;
    begin
        /*data := '{"apiKey":"e648029b8c21344a362ecd7b70177839",';
        data += '"mobile":"'+ phoneNumber+'",';
        data += '"message":"' + smsMessage+'",';
        data += '"shortcode":"WAKULIMADAI",';
        data += '"partnerID":"7153"}';

        stringContent := stringContent.StringContent(data,encoding.UTF8,'application/json');
        RESTWSManagement.CallRESTWebService('http://localhost:8001/api/SendSMSAftrinet/',
                                                           '',
                                                           'POST',
                                                           stringContent,
                                                           HttpResponseMessage);

         ReturnValue:= HttpResponseMessage.Content.ReadAsStringAsync.Result;
         MESSAGE(ReturnValue);
         IF (FORMAT(ReturnValue) = '1') THEN BEGIN
           ReturnValue:='sent'
         END ELSE BEGIN
           ReturnValue:='Not sent'
         END;*/
    end;

    procedure FnMemoHeader(DocNo: Code[30]; toWho: Text; from: Text; subject: Text; dimension1: Code[20]; dimension2: Code[20]; body: Text[250]; body2: Text[250]; body3: Text[250]; activityDate: Date; MyAction: Text; MyUserID: Code[30]) return: Code[20]
    begin
        /*return:='';
        TbMemoHeader.RESET;
        CASE MyAction OF
          'create':
          BEGIN
            TbMemoHeader.INIT;
            TbProcurementSetup.GET;
            TbProcurementSetup.TESTFIELD("Memo Nos");
            NextNo:=FORMAT(DATE2DMY(TODAY,3))+'/'+CuNoSeriesMgt.GetNextNo(TbProcurementSetup."Memo Nos",TODAY,TRUE);
            TbMemoHeader."Memo No" := NextNo;
            TbMemoHeader."To:":= toWho;
            TbMemoHeader."From:":= from;
            TbMemoHeader.Subject:= subject;
            TbMemoHeader."Global Dimension 1 Code":= dimension1;
             TbMemoHeader."Global Dimension 2 Code":= dimension2;
            TbMemoHeader.Body:= body;
            TbMemoHeader."body 2":= body2;
            TbMemoHeader."body 3":= body3;
            TbMemoHeader."User ID":= MyUserID;
            TbMemoHeader."Activity Date":= activityDate;
            IF TbMemoHeader.INSERT(TRUE) THEN
              return:=NextNo;
          END;
          'edit':
          BEGIN
            TbMemoHeader.RESET;
            TbMemoHeader.SETRANGE("Memo No",DocNo);
            TbMemoHeader.SETRANGE(Status,TbMemoHeader.Status::Open);
            IF TbMemoHeader.FINDFIRST THEN BEGIN
              TbMemoHeader."To:":= toWho;
              TbMemoHeader."From:":= from;
              TbMemoHeader.Subject:= subject;
              TbMemoHeader."Global Dimension 1 Code":= dimension1;
              TbMemoHeader."Global Dimension 2 Code":= dimension2;
              TbMemoHeader.Body:= body;
              TbMemoHeader."body 2":= body2;
              TbMemoHeader."body 3":= body3;
              TbMemoHeader."Activity Date":= activityDate;
              IF TbMemoHeader.MODIFY THEN
                return:=DocNo;
            END;
          END;
        END;*/
    end;

    procedure FnMemoLine(docNo: Code[30]; lineNo: Integer; expenseCode: Code[30]; MyAction: Text) return: Boolean
    begin
        /*return:=FALSE;
        TbMemoLine.RESET;
        CASE MyAction OF
          'create':
          BEGIN
            TbMemoLine.RESET;
            IF TbMemoLine.FINDLAST THEN lineNo:= TbMemoLine."Line No"+1 ELSE lineNo:=1;
            TbMemoLine.INIT;
            TbMemoLine."Memo No" := docNo;
            TbMemoLine."Line No":= lineNo;
            TbMemoLine."Expense Code":= expenseCode;
            TbMemoLine.VALIDATE("Expense Code");
            {TbMemoLine.Quantity:= quantity;
            TbMemoLine.VALIDATE(Quantity);
            TbMemoLine."No of Attendees":= amount;
            TbMemoLine.VALIDATE("No of Attendees");
            TbMemoLine."Total Amount":= noOfDays;
            TbMemoLine.VALIDATE("Total Amount");}
            IF TbMemoLine.INSERT(TRUE) THEN
              return:=TRUE;
          END;
          'edit':
          BEGIN
            TbMemoLine.RESET;
            TbMemoLine.SETRANGE("Memo No",docNo);
            TbMemoLine.SETRANGE("Line No",lineNo);
            IF TbMemoLine.FINDFIRST THEN BEGIN
              TbMemoLine."Expense Code":= expenseCode;
              TbMemoLine.VALIDATE("Expense Code");
              {TbMemoLine.Quantity:= quantity;
              TbMemoLine.VALIDATE(Quantity);
              TbMemoLine."No of Attendees":= amount;
              TbMemoLine.VALIDATE("No of Attendees");
              TbMemoLine."Total Amount":= noOfDays;
              TbMemoLine.VALIDATE("Total Amount");}
              IF TbMemoLine.MODIFY(TRUE) THEN
                return:=TRUE;
            END;
          END;
           'delete':
          BEGIN
            TbMemoLine.RESET;
            TbMemoLine.SETRANGE("Memo No",docNo);
            TbMemoLine.SETRANGE("Line No",lineNo);
            IF TbMemoLine.FINDFIRST THEN BEGIN
              IF TbMemoLine.DELETE THEN
                return:=TRUE;
            END;
           END;
        END;*/
    end;

    procedure MemoApprovalAction(UserNo: Code[100]; MemoNo: Code[50]; MyAction: Text) return_value: Boolean
    begin
        /*return_value:=FALSE;
        TbMemoHeader.RESET;
        TbMemoHeader.SETRANGE("Memo No",MemoNo);
        TbMemoHeader.SETRANGE("User ID",UserNo);
        IF TbMemoHeader.FINDFIRST() THEN BEGIN
          IF MyAction = 'RequestApproval' THEN BEGIN
            CuCustomApprovals.OnSendMemoForApproval(TbMemoHeader);
            return_value:=TRUE;
            COMMIT;
            FnUpdateApprovalEntries(MemoNo,TbMemoHeader."User ID",TbMemoHeader.RECORDID);
          END
          ELSE IF MyAction = 'CancelApproval' THEN BEGIN
            CuCustomApprovals.OnCancelMemoApprovalRequest(TbMemoHeader);
            return_value:=TRUE;
          END;
        END ELSE BEGIN
          ERROR('TbMemoHeader is no longer editable or it does not exist.');
        END;*/
    end;

    local procedure FnUpdateApprovalEntries(DocID: Code[30]; ToUserID: Code[30]; RecID: RecordID)
    begin
        TbApprovalEntry.Reset();
        TbApprovalEntry.SetRange(TbApprovalEntry."Document No.", DocID);
        TbApprovalEntry.SetRange("Table ID", RecID.TableNo);
        TbApprovalEntry.SetFilter(TbApprovalEntry."Sender ID", '%1|%2', 'ADMIN', UserId);
        TbApprovalEntry.SetFilter(TbApprovalEntry.Status, '%1|%2', TbApprovalEntry.Status::Open, TbApprovalEntry.Status::Created);
        if TbApprovalEntry.FindSet() then begin
            repeat
                TbApprovalEntry."Sender ID" := ToUserID;
                TbApprovalEntry.Modify();
            until TbApprovalEntry.Next() = 0;
        end;
    end;

    procedure FnMemoLineAttendees(memoNo: Code[30]; expenseCode: Code[30]; type: Integer; idNoOrStaffNo: Code[30]; Name: Text; Amount: Decimal; NoOfDays: Integer; MyAction: Text) return: Boolean
    begin
        /*return:=FALSE;
        CASE MyAction OF
          'create':
          BEGIN
            TbPerdiemStaff.RESET;
            TbPerdiemStaff.INIT;
            TbPerdiemStaff."Memo No" := memoNo;
            TbPerdiemStaff."Expense Code":= expenseCode;
            TbPerdiemStaff.Type:= type;
            TbPerdiemStaff."ID No/Staff No":= idNoOrStaffNo;
            TbPerdiemStaff.Name:= Name;
            TbPerdiemStaff.Amount:= Amount;
            TbPerdiemStaff."No of Days":= NoOfDays;
            TbPerdiemStaff.VALIDATE("No of Days");
            IF TbPerdiemStaff.INSERT(TRUE) THEN
              return:=TRUE;
          END;
          'delete':
          BEGIN
            TbPerdiemStaff.RESET;
            TbPerdiemStaff.SETRANGE("Memo No",memoNo);
            TbPerdiemStaff.SETRANGE("Expense Code",expenseCode);
            TbPerdiemStaff.SETRANGE(Type,type);
            TbPerdiemStaff.SETRANGE("ID No/Staff No",idNoOrStaffNo);
            IF TbPerdiemStaff.FINDFIRST THEN BEGIN
              IF TbPerdiemStaff.DELETE THEN
                return:=TRUE;
            END;
           END;
        END;*/
    end;

    procedure GenerateMemoReport(employeeNo: Code[100]; memoNo: Code[30]; filenameFromApp: Text[200]; myUserID: Code[30]) return_value: Text
    var
        MyRecordRef: RecordRef;
        Convert: dotnet Convert;
        IOFile: dotnet File;
        MyOutstream: OutStream;
        base64txt: Text;
        // TbTempBlob: Record UnknownRecord99008535;
        FileName2: Text;
    begin
        /*return_value:='';
        TbGeneralSetup.GET;
        FILESPATH := TbGeneralSetup."Portal Reports File Path";
        filename := FILESPATH + filenameFromApp;
        FileName2 := FILESPATH +'-Encr-'+ filenameFromApp;
        IF EXISTS(filename) THEN
            ERASE(filename);
          TbMemoHeader.RESET;
          TbMemoHeader.SETFILTER(TbMemoHeader."Memo No",'=%1', memoNo);
          IF TbMemoHeader.FINDFIRST() THEN BEGIN
            RpMemo.SETTABLEVIEW(TbMemoHeader);
          END ELSE BEGIN
            ERROR('Memo not found');
          END;
          MyRecordRef.GETTABLE(TbMemoHeader);
          TbTempBlob.Blob.CREATEOUTSTREAM(MyOutstream);
          RpMemo.SAVEAS(filename, REPORTFORMAT::Pdf, MyOutstream, MyRecordRef);
          return_value := TbTempBlob.ToBase64String();
          IF EXISTS(filename) THEN
            ERASE(filename);*/
    end;

    procedure FnPVHeader(MyUserID: Code[30]; MyAction: Text; DocNo: Code[30]; dimension1: Code[30]; dimension2: Code[30]; responsibilityCenter: Code[30]; applyToDocType: Integer; applyToDocNo: Code[30]; payMode: Integer; chequeType: Integer; chequeNo: Code[10]; chequeAmount: Decimal; paymentType: Integer; payingBankAccount: Code[30]; paymentTo: Code[10]; paymentNarration: Code[20]) return: Code[20]
    begin
        return := '';
        TbPVHeader.Reset();
        case MyAction of
            'create':
                begin
                    TbPVHeader.Init();
                    TbCashOfficeSetup.Get();
                    TbCashOfficeSetup.TestField("Normal Payments No");
                    NextNo := CuNoSeriesMgt.GetNextNo(TbCashOfficeSetup."Normal Payments No", Today, true);
                    TbPVHeader."No." := NextNo;
                    TbPVHeader.Cashier := MyUserID;
                    TbPVHeader.Date := Today;
                    TbPVHeader."Payment Type" := TbPVHeader."payment type"::Normal;
                    TbPVHeader."Global Dimension 1 Code" := dimension1;
                    TbPVHeader."Shortcut Dimension 2 Code" := dimension2;
                    TbPVHeader."Responsibility Center" := responsibilityCenter;
                    TbPVHeader."Apply to Document Type" := applyToDocType;
                    TbPVHeader."Apply to Document No" := applyToDocNo;
                    TbPVHeader."Pay Mode" := payMode;
                    TbPVHeader."Cheque Type" := chequeType;
                    TbPVHeader."Cheque No." := chequeNo;
                    // TbPVHeader."Cheque Amount" := chequeAmount;
                    TbPVHeader."Payment Type" := paymentType;
                    TbPVHeader."Paying Bank Account" := payingBankAccount;
                    TbPVHeader.Validate("Paying Bank Account");
                    TbPVHeader.Payee := paymentTo;
                    TbPVHeader."Payment Narration" := paymentNarration;
                    if TbPVHeader.Insert(true) then
                        return := NextNo;
                end;
            'edit':
                begin
                    TbPVHeader.Reset();
                    TbPVHeader.SetRange("No.", DocNo);
                    TbPVHeader.SetRange(TbPVHeader.Status, TbPVHeader.Status::Pending);
                    if TbPVHeader.FindFirst() then begin
                        TbPVHeader."Payment Type" := TbPVHeader."payment type"::Normal;
                        TbPVHeader."Global Dimension 1 Code" := dimension1;
                        TbPVHeader."Shortcut Dimension 2 Code" := dimension2;
                        TbPVHeader."Responsibility Center" := responsibilityCenter;
                        TbPVHeader."Apply to Document Type" := applyToDocType;
                        TbPVHeader."Apply to Document No" := applyToDocNo;
                        TbPVHeader."Pay Mode" := payMode;
                        TbPVHeader."Cheque Type" := chequeType;
                        TbPVHeader."Cheque No." := chequeNo;
                        // TbPVHeader."Cheque Amount" := chequeAmount;
                        TbPVHeader."Payment Type" := paymentType;
                        TbPVHeader."Paying Bank Account" := payingBankAccount;
                        TbPVHeader.Validate("Paying Bank Account");
                        TbPVHeader.Payee := paymentTo;
                        TbPVHeader."Payment Narration" := paymentNarration;
                        if TbPVHeader.Modify(true) then
                            return := DocNo;
                    end else
                        Error('Error: Either the document was not found or it is no longer editable');
                end;
        end;
    end;

    procedure FnPVLine(myAction: Text; docNo: Code[30]; lineNo: Integer; type: Code[30]; accountType: Integer; accountNo: Code[30]; amount: Decimal; vatWithHoldCode: Code[20]; withHoldTaxCode: Code[20]) return: Boolean
    begin
        return := false;
        TbPVLine.Reset();
        case myAction of
            'create':
                begin
                    TbPVLine.Reset();
                    if TbPVLine.FindLast() then
                        lineNo := TbPVLine."Line No." + 1
                    else
                        lineNo := 1;
                    TbPVLine.Init();
                    TbPVLine.No := docNo;
                    TbPVLine."Line No." := lineNo;
                    TbPVLine."Account Type" := accountType;
                    TbPVLine."Account No." := accountNo;
                    TbPVLine.Validate("Account No.");
                    TbPVLine.Amount := amount;
                    TbPVLine."VAT Withheld Code" := vatWithHoldCode;
                    TbPVLine.Validate("VAT Withheld Code");
                    TbPVLine."Withholding Tax Code" := withHoldTaxCode;
                    TbPVLine.Validate("Withholding Tax Code");
                    if TbPVLine.Insert(true) then
                        return := true;
                end;
            'edit':
                begin
                    TbPVLine.Reset();
                    TbPVLine.SetRange(No, docNo);
                    TbPVLine.SetRange("Line No.", lineNo);
                    if TbPVLine.FindFirst() then begin
                        TbPVLine."Account Type" := accountType;
                        TbPVLine."Account No." := accountNo;
                        TbPVLine.Validate("Account No.");
                        TbPVLine.Amount := amount;
                        TbPVLine."VAT Withheld Code" := vatWithHoldCode;
                        TbPVLine.Validate("VAT Withheld Code");
                        TbPVLine."Withholding Tax Code" := withHoldTaxCode;
                        TbPVLine.Validate("Withholding Tax Code");
                        if TbPVLine.Modify(true) then
                            return := true;
                    end;
                end;
            'delete':
                begin
                    TbPVLine.Reset();
                    TbPVLine.SetRange(No, docNo);
                    TbPVLine.SetRange("Line No.", lineNo);
                    if TbPVLine.FindFirst() then begin
                        if TbPVLine.Delete() then
                            return := true;
                    end;
                end;
        end;
    end;

    procedure PVApprovalAction(docNo: Code[50]; MyAction: Text) return_value: Boolean
    begin
        return_value := false;
        TbPVHeader.Reset();
        TbPVHeader.SetRange("No.", docNo);
        if TbPVHeader.FindFirst() then begin
            if MyAction = 'RequestApproval' then begin
                VarVariant := TbPVHeader;
                CuCustomApprovals.OnSendDocForApproval(VarVariant);
                return_value := true;
                Commit();
                FnUpdateApprovalEntries(docNo, TbPVHeader.Cashier, TbPVHeader.RecordId);
            end
            else if MyAction = 'CancelApproval' then begin
                VarVariant := TbPVHeader;
                CuCustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                return_value := true;
            end;
        end else begin
            Error('PV header is no longer editable or it does not exist.');
        end;
    end;

    procedure GeneratePVReport(docNo: Code[30]; filenameFromApp: Text[200]; myUserID: Code[30]) return_value: Text
    var
        TbTempBlob: Codeunit "Temp Blob";
        MyRecordRef: RecordRef;
        Convert: dotnet Convert;
        IOFile: dotnet File;
        MyOutstream: OutStream;
        base64txt: Text;
        FileName2: Text;
    begin
        //TODO: Generate a Payment Voucher report
        return_value := '';
        HRSetup.Get();
        FILESPATH := HRSetup."Portal Reports File Path";
        filename := FILESPATH + filenameFromApp;
        if Exists(filename) then
            Erase(filename);
        TbPVHeader.Reset();
        TbPVHeader.SetFilter(TbPVHeader."No.", '=%1', docNo);
        if TbPVHeader.FindFirst() then begin
            RpPV.SetTableview(TbPVHeader);
        end else begin
            Error('Header not found');
        end;
        MyRecordRef.GetTable(TbPVHeader);
        TbTempBlob.CreateOutstream(MyOutstream);
        RpPV.SaveAs(filename, Reportformat::Pdf, MyOutstream, MyRecordRef);
        // return_value := TbTempBlob.
        if Exists(filename) then
            Erase(filename);
    end;

    local procedure FnGetCurrentLeavePeriod() return_value: Code[20]
    var
        HRLeaveCalendar: Record "HR Leave Calendar";
    begin
        HRLeaveCalendar.Reset();
        HRLeaveCalendar.SetRange(Current, true);
        if HRLeaveCalendar.FindLast() then begin
            return_value := HRLeaveCalendar.Code
        end;
    end;

    // procedure FnPayrollMasterRollReport(year: Integer; month: Integer; postingGroup: Code[30]; filenameFromApp: Text) return_value: Text
    // begin
    //     TbGeneralSetup.Get;
    //     TbGeneralSetup.TestField("Portal Reports File Path");
    //     FILESPATH := TbGeneralSetup."Portal Reports File Path";
    //     filename := FILESPATH + filenameFromApp;
    //     //
    //     TbPaPerTrans.Reset;
    //     TbPaPerTrans.SetRange("Payroll Period", Dmy2date(1, month, year));
    //     TbPaPerTrans.SetRange("Period Month", month);
    //     TbPaPerTrans.SetRange("Period Year", year);
    //     if TbPaPerTrans.FindSet then begin
    //         RpMasterRoll.SetTableview(TbPaPerTrans);
    //         MyRecordRef.GetTable(TbPaPerTrans);
    //         TbTempBlob.Blob.CreateOutstream(MyOutstream);
    //         RpMasterRoll.SaveAs(filename, Reportformat::Pdf, MyOutstream, MyRecordRef);
    //         return_value := TbTempBlob.ToBase64String();
    //         if Exists(filename) then
    //             Erase(filename);
    //     end else
    //         Error('No payaroll data found for period %1', Dmy2date(1, month, year));
    // end;

    // procedure FnTrainingRequest(MyUserID: Code[30]; MyAction: Text; DocNo: Code[30]; trainingNeedCode: Code[30]; comments: Text; employeeNo: Code[30]) return: Code[20]
    // begin
    //     return := '';
    //     TbTrainingHe.Reset;
    //     case MyAction of
    //         'create':
    //             begin
    //                 if TbTrainingHe.FindLast then NextNo := IncStr(TbTrainingHe."Application No.") else NextNo := 'TAP-00001';
    //                 TbTrainingHe.Init;
    //                 TbTrainingHe."Application No." := NextNo;
    //                 TbTrainingHe."User ID" := MyUserID;
    //                 TbTrainingHe."Application Date" := Today;
    //                 TbTrainingHe."Training Need Code" := trainingNeedCode;
    //                 TbTrainingHe.Validate("Training Need Code");
    //                 TbTrainingHe.Comments := comments;
    //                 if TbTrainingHe.Insert(true) then begin
    //                     TbTrainingParticipant.Init;
    //                     TbTrainingParticipant."Application No." := NextNo;
    //                     TbTrainingParticipant."Staff No." := employeeNo;
    //                     TbTrainingParticipant.Validate("Staff No.");
    //                     TbTrainingParticipant.Insert(true);
    //                     return := NextNo;
    //                 end;
    //             end;
    //         'edit':
    //             begin
    //                 TbTrainingHe.SetRange("Application No.", DocNo);
    //                 TbTrainingHe.SetRange(TbTrainingHe.Status, TbTrainingHe.Status::Open);
    //                 if TbTrainingHe.FindFirst then begin
    //                     TbTrainingHe."Application Date" := Today;
    //                     TbTrainingHe."Training Need Code" := trainingNeedCode;
    //                     TbTrainingHe.Validate("Training Need Code");
    //                     TbTrainingHe.Comments := comments;
    //                     if TbTrainingHe.Modify(true) then
    //                         return := DocNo;
    //                 end else
    //                     Error('Error: Either the document was not found or it is no longer editable');
    //             end;
    //     end;
    // end;

    // procedure TrainingApproval(docNo: Code[50]; MyAction: Text) return_value: Boolean
    // begin
    //     return_value := false;
    //     TbTrainingHe.Reset;
    //     TbTrainingHe.SetRange("Application No.", docNo);
    //     if TbTrainingHe.FindFirst() then begin
    //         if MyAction = 'requestApproval' then begin
    //             VarVariant := TbTrainingHe;
    //             CuCustomApprovals.OnSendDocForApproval(VarVariant);
    //             return_value := true;
    //             Commit;
    //             FnUpdateApprovalEntries(docNo, TbTrainingHe."User ID", TbTrainingHe.RecordId);
    //         end
    //         else if MyAction = 'cancelApproval' then begin
    //             VarVariant := TbTrainingHe;
    //             CuCustomApprovals.OnCancelDocApprovalRequest(VarVariant);
    //             return_value := true;
    //         end;
    //     end else begin
    //         Error('Training header is no longer editable or it does not exist.');
    //     end;
    // end;

    procedure FnCheckinCheckout(employeeNo: Code[30]; type: Text; myUserID: Code[10]; location: Text) return_value: Text
    var
        TbHrAtteLedg: record "HR Attendance Ledger";
        // TbHrAtteLedg: Record ;
        TbHrAtteLedg2: Record "HR Attendance Ledger";
        timeDifference: Integer;
        closingTime: Time;
        newTime: Time;
        reportingTime: Time;
    begin
        //
        return_value := '';
        reportingTime := 083000T;
        closingTime := 170000T;
        //
        TbHrAtteLedg2.Reset();
        TbHrAtteLedg2.SetRange(TbHrAtteLedg2."Staff No.", employeeNo);
        TbHrAtteLedg2.SetRange(TbHrAtteLedg2."Attendance Date", Today);
        if not TbHrAtteLedg2.FindFirst() then begin
            if (type = 'checkout') then
                Error('You cannot checkout before checking in.');

            HRSetup.Get();
            HRSetup.TestField(HRSetup."Attendance Nos");
            NextNo := CuNoSeriesMgt.GetNextNo(HRSetup."Attendance Nos", Today, true);
            TbHrAtteLedg."No." := NextNo;
            TbHrAtteLedg."Staff No." := employeeNo;
            TbHrAtteLedg.Validate("Staff No.");
            TbHrAtteLedg."Attendance Date" := Today;
            //TbHrAtteLedg."login date time" := CurrentDateTime;
            TbHrAtteLedg."Time In" := Time;
            TbHrAtteLedg."Time Out" := 0T;
            TbHrAtteLedg."Hours Worked" := 0;
            TbHrAtteLedg."Checked In By" := myUserID;
            timeDifference := ROUND((TbHrAtteLedg."Time In" - reportingTime) / 60000, 1, '=');
            if timeDifference > 0 then
                return_value := 'Signed in late by ' + Format(timeDifference) + ' minutes'
            else
                return_value := 'Signed in on time';
            TbHrAtteLedg."Location Coordinates" := location;
            TbHrAtteLedg."Sign in Comments" := return_value;
            TbHrAtteLedg.Insert(true);
            return_value := 'Signed in successfully - ' + return_value;
        end else begin
            if (type = 'checkin') then
                Error('You have already signed in at %1', TbHrAtteLedg2."Time In");
            if (type = 'checkout') and (TbHrAtteLedg2."Time In" = 0T) then
                Error('You cannot sign out before signing in.');
            if (type = 'checkout') and (TbHrAtteLedg2."Time Out" <> 0T) then
                Error('You have already signed out at %1', TbHrAtteLedg2."Time Out");
            TbHrAtteLedg2.Validate("Staff No.");
            TbHrAtteLedg2."Attendance Date" := Today;
            TbHrAtteLedg2."Time Out" := Time;
            TbHrAtteLedg2.Validate("Time Out");
            TbHrAtteLedg2."Checked Out By" := myUserID;
            timeDifference := ROUND((TbHrAtteLedg2."Time Out" - closingTime) / 60000, 1, '=');
            if timeDifference < 0 then
                return_value := 'You have signed out early by ' + Format(timeDifference) + ' minutes'
            else
                return_value := 'Signed out on time';
            TbHrAtteLedg2."Location Coordinates" := location;
            TbHrAtteLedg2."Sign out Comments" := return_value;
            TbHrAtteLedg2.Modify(true);
            return_value := 'Signed out successfully - ' + return_value;
        end;
    end;

    // procedure FnGetLeaveDetails(empNo: Code[30]; startDate: Date; endDate: Date; leaveType: Code[20]) returValue: Text
    // begin
    //     HRLeaveApplication.Reset();
    //     HRLeaveApplication.Init();
    //     HRLeaveApplication."Leave Type" := leaveType;
    //     HRLeaveApplication."Employee No" := empNo;
    //     HRLeaveApplication."Starting Date" := startDate;
    //     HRLeaveApplication."End Date" := endDate;
    //     HRLeaveApplication.Validate("End Date");
    //     returValue := Format(HRLeaveApplication."Return Date") + '##' + Format(HRLeaveApplication."Applied Days");
    // end;

    /* procedure FnAppraisalEmployeeRating(docNo: Code[30]; "area": Code[50]; measure: Text; employeeRating: Decimal; employeeComments: Text) return: Boolean
    begin
        return := false;
        TbAppraisalScore.Reset;
        TbAppraisalScore.SetRange("Appraisal No", docNo);
        TbAppraisalScore.SetRange("Key Result Area", area);
        TbAppraisalScore.SetRange("Performance Measure", measure);
        if TbAppraisalScore.FindFirst then begin
            TbAppraisalScore."Employee Rating" := employeeRating;
            TbAppraisalScore.Validate("Employee Rating");
            TbAppraisalScore."Employee Comments" := employeeComments;
            TbAppraisalScore.Modify;
            return := true;
        end;
    end; */

    /* procedure FnAppraisalSupervisorRating(docNo: Code[30]; "area": Code[50]; measure: Text; supervisorRating: Decimal; supervisorComments: Text) return: Boolean
    begin
        return := false;
        TbAppraisalScore.Reset;
        TbAppraisalScore.SetRange("Appraisal No", docNo);
        TbAppraisalScore.SetRange("Key Result Area", area);
        TbAppraisalScore.SetRange("Performance Measure", measure);
        if TbAppraisalScore.FindFirst then begin
            TbAppraisalScore."Supervisor Rating" := supervisorRating;
            TbAppraisalScore.Validate("Supervisor Rating");
            TbAppraisalScore."Supervisor Comments" := supervisorComments;
            TbAppraisalScore.Modify;
            return := true;
        end;
    end; */

    /*   procedure FnAppraisalSubmit(docNo: Code[30]; employeeNo: Code[30]) return: Boolean
      begin
          return := false;
          TbAppraisalHe.Reset;
          TbAppraisalHe.SetRange("Appraisal No", docNo);
          if TbAppraisalHe.FindFirst then begin
              if TbAppraisalHe."Employee No" = employeeNo then
                  TbAppraisalHe.Status := TbAppraisalHe.Status::"Pending Approval";
              if TbAppraisalHe.Supervisor = employeeNo then
                  TbAppraisalHe.Status := TbAppraisalHe.Status::Closed;
              TbAppraisalHe.Modify;
              return := true;
          end;
      end; */
}
