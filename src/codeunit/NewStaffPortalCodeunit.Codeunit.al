
Codeunit 85006 "New StaffPortal Codeunit"
{

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
        JsObject: JsonObject;
        DocState: Option Open,"Pending Approval",Cancelled,Approved;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Staff Advance","Staff Advance Accounting";
        MyOutstream: OutStream;
        filename: Text[350];
        FILESPATH: Text[350];
        VarVariant: Variant;



    [ServiceEnabled]
    procedure StaffForgotPassword(staffNo: Code[20]; randomValue: Text) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();

        if not SubmitStaffForgotPasswordRandom(staffNo, randomValue) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;

        JsObject.WriteTo(RetV);
    end;

    procedure SubmitStaffForgotPasswordRandom(StaffNo: Code[20]; RandomValue: Text): Boolean
    var
        mailMessage: Text;
    begin
        if TbEmployee.Get(StaffNo) then begin
            if TbEmployee."Company E-Mail" <> '' then begin
                TbEmployee.Password := RandomValue;
                TbEmployee."Changed Password" := false;

                if TbEmployee.Modify(true) then begin
                    mailMessage :=
                        '<br> Dear ' + TbEmployee."First Name" + ' ' + TbEmployee."Middle Name" +
                        ', your request for password reset was received successfully. Kindly use the One Time Password below to access your employee self service account ' +
                        '<br><strong>' + RandomValue + '</strong>' +
                        '<br><br><strong>[This is an automated message - Kindly do not reply]</strong>';

                    // send email notification
                    if FnSendEmail('Staff Portal Reset Password Code', TbEmployee."Company E-Mail", mailMessage, '') then begin
                        JsObject.Add('Error', 'FALSE');
                        exit(true);
                    end else
                        Error('An error occurred when sending the email. Kindly ask the administrator to check out email configurations.');
                end else
                    Error('Unable to reset user password. Kindly try again. Contact the administrator if this error persists');
            end else
                Error('Your company email is not yet set. Kindly contact HR to set up your email.');
        end else
            Error('Staff Number does not exist.');
    end;

    [ServiceEnabled]
    procedure ResetUserPassword(employeeNo: Code[20]; otp: Text; password: Text) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();

        if FnVerifyAccount(employeeNo, otp, password) then begin
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('Message', 'You have successfully reset your password.');
        end else begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());

        end;

        JsObject.WriteTo(RetV);
    end;

    procedure FnVerifyAccount(employeeNo: Code[20]; otp: Text; password: Text): Boolean
    begin

        TbEmployee.Reset();
        TbEmployee.SetRange("No.", employeeNo);
        //  TbEmployee.SetRange(Password, otp);

        if not TbEmployee.FindFirst() then begin
            Error('Invalid employee number or OTP entered.');
            exit(false);
        end;


        TbEmployee.Password := password;
        TbEmployee."Changed Password" := true;
        TbEmployee.Modify();

        exit(true);
    end;



    [ServiceEnabled]
    procedure ChangeUserPassword(employeeNo: Code[20]; newPassword: Text) RetV: Text
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not ChangePassword(employeeNo, newPassword) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RetV);
    end;


    procedure ChangePassword(employeeNo: Code[20]; password: Text) return_value: Boolean
    begin
        return_value := false;
        TbEmployee.Reset();
        TbEmployee.SetRange("No.", employeeNo);
        if TbEmployee.FindFirst() then begin
            TbEmployee.Password := password;
            TbEmployee."Changed Password" := true;
            TbEmployee.Modify();
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('Staff_Name', TbEmployee."First Name" + ' ' + TbEmployee."Middle Name" + ' ' + TbEmployee."Last Name");
            JsObject.Add('Message', 'Password updated successfully');
            exit(true);
        end else
            ERROR('Employee Number does not exist. Cannot update the user password.');

    end;

    [ServiceEnabled]
    procedure GetReturnDate(leaveNo: Code[100]; empNo: Code[30]; startDate: Date; endDate: Date; leaveType: Code[20]) RetV: Text
    begin
        Clear(JsObject);
        ClearLastError();

        if FnGetLeaveDetails(leaveNo, empNo, startDate, endDate, leaveType) then begin
            // Success
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('Error_Message', '');
        end else begin
            // Failure
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GetLastErrorText());
        end;

        JsObject.WriteTo(RetV);
    end;


    procedure FnGetLeaveDetails(leaveNo: Code[100]; empNo: Code[30]; startDate: Date; endDate: Date; leaveType: Code[20]) Result: Boolean
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "HR Setup";
    begin
        Result := false;

        if leaveNo = '' then begin
            HRLeaveApplication.Reset();
            HRLeaveApplication.SetRange(Status, HRLeaveApplication.Status::Open);
            HRLeaveApplication.SetRange("Employee No", empNo);

            if HRLeaveApplication.FindSet(true) then begin
                Error('Sorry, you already have an open leave application. Kindly use it.');
            end else begin

                if not HRSetup.Get() then
                    Error('Human Resources Setup must be configured before leave applications can be created.');

                HRSetup.TestField("Leave Application Nos.");

                leaveNo := NoSeriesMgt.GetNextNo(HRSetup."Leave Application Nos.", Today, true);

                HRLeaveApplication.Init();
                HRLeaveApplication."No." := leaveNo;
                HRLeaveApplication."Application Date" := Today;
                HRLeaveApplication."Employee No" := empNo;
                HRLeaveApplication.Validate("Employee No");
                HRLeaveApplication."Leave Type" := leaveType;
                HRLeaveApplication."Starting Date" := startDate;
                HRLeaveApplication."End Date" := endDate;
                HRLeaveApplication.Validate("End Date");

                if HRLeaveApplication.Insert(true) then begin
                    JsObject.Add('DocNo', HRLeaveApplication."No.");
                    JsObject.Add('ReturnDate', Format(HRLeaveApplication."Return Date") + '##' + Format(HRLeaveApplication."Applied Days"));
                    JsObject.Add('EndDate', Format(HRLeaveApplication."End Date"));
                    JsObject.Add('Message', 'Leave application created successfully');
                    Result := true;
                end;
            end;
        end else begin
            HRLeaveApplication.Reset();
            HRLeaveApplication.SetRange("No.", leaveNo);
            HRLeaveApplication.SetRange("Employee No", empNo);

            if HRLeaveApplication.FindSet(true) then begin
                HRLeaveApplication."Application Date" := Today;
                HRLeaveApplication."Employee No" := empNo;
                HRLeaveApplication.Validate("Employee No");
                HRLeaveApplication."Leave Type" := leaveType;
                HRLeaveApplication."Starting Date" := startDate;
                HRLeaveApplication."End Date" := endDate;
                HRLeaveApplication.Validate("End Date");

                if HRLeaveApplication.Modify(true) then begin
                    JsObject.Add('DocNo', HRLeaveApplication."No.");
                    JsObject.Add('ReturnDate', Format(HRLeaveApplication."Return Date") + '##' + Format(HRLeaveApplication."Applied Days"));
                    JsObject.Add('EndDate', Format(HRLeaveApplication."End Date"));
                    JsObject.Add('Message', 'Leave application updated successfully');
                    Result := true;
                end else
                    Error('Unable to fetch the return date. Kindly try again. Contact the administrator if this error persists');
            end;
        end;
    end;


    [ServiceEnabled]
    procedure FnCreateLeaveApplication(leaveNo: Code[100]; employeeNo: Code[30]; leaveType: Code[30]; reason: Text[250]; daysApplied: Integer; startDate: DateTime; reliever: Code[30]; endDate: DateTime) RetV: Text
    begin
        Clear(JsObject);
        ClearLastError();

        if SubmitLeaveApplication(leaveNo, employeeNo, leaveType, reason, daysApplied, startDate, reliever, endDate) then begin
            // Success
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('Error_Message', '');
        end else begin
            // Failure
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GetLastErrorText());
        end;

        JsObject.WriteTo(RetV);
    end;


    procedure SubmitLeaveApplication(leaveNo: Code[100]; employeeNo: Code[30]; leaveType: Code[30]; reason: Text[250]; daysApplied: Integer; startDate: DateTime; reliever: Code[30]; endDate: DateTime) return_value: Boolean
    begin
        return_value := false;
        HRLeaveApplication.Reset();
        HRLeaveApplication.SETRANGE("No.", leaveNo);
        HRLeaveApplication.SetRange("Employee No", employeeNo);
        if HRLeaveApplication.FindSet(true) then begin
            ///HRLeaveApplication."User ID" := myUserID;
            HRLeaveApplication."Leave Type" := leaveType;
            HRLeaveApplication.Purpose := reason;
            HRLeaveApplication.Validate("Employee No");
            HRLeaveApplication."Leave Period" := FnGetCurrentLeavePeriod();
            HRLeaveApplication."Starting Date" := Dt2Date(startDate);
            HRLeaveApplication.Validate("Starting Date");
            HRLeaveApplication."End Date" := Dt2Date(endDate);
            HRLeaveApplication.Validate("End Date");
            HRLeaveApplication."Reliever No." := reliever;
            HRLeaveApplication.Validate("Reliever No.");

            if HRLeaveApplication.Modify(true) then begin
                JsObject.Add('DocNo', HRLeaveApplication."No.");
                JsObject.Add('ReturnDate', Format(HRLeaveApplication."Return Date") + '##' + Format(HRLeaveApplication."Applied Days"));
                JsObject.Add('EndDate', Format(HRLeaveApplication."End Date"));
                JsObject.Add('Message', 'Leave application has been submitted successfully. Please send leave for approval.');
                return_value := true;
            end else begin
                Error('Unable to submit leave application. Kindly try again. Contact the administrator if this error persists');
            end;
        end else begin
            Error('Leave application does not exist. Kindly create a new leave application.');
        end;
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

    [ServiceEnabled]
    procedure FnCancelLeaveApproval(employeeNo: Code[100]; requisitionNo: Code[100]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CancelLeaveApplication(employeeNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
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

    [ServiceEnabled]
    procedure FnSendLeaveApproval(employeeNo: Code[100]; requisitionNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not RequestLeaveApproval(employeeNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    procedure RequestLeaveApproval(employeeNo: Code[100]; requisitionNo: Code[30]) return_value: Boolean
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

    [ServiceEnabled]
    procedure fnGenerateLeaveStatement(employeeNo: Code[100]; filenameFromApp: Text[200]; leaveType: Code[50]) RetV: Text
    var
        baseImage: Text;
    begin
        Clear(JsObject);
        ClearLastError();

        if not GenerateLeaveStatement(employeeNo, filenameFromApp, leaveType, baseImage) then begin
            if GetLastErrorText() <> '' then begin
                JsObject.Add('Error', 'TRUE');
                JsObject.Add('Error_Message', GetLastErrorText());
            end else begin
                JsObject.Add('Error', 'TRUE');
                JsObject.Add('Error_Message', 'No leave records found for employee.');
            end;
        end else begin
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('BaseImage', baseImage);
        end;

        JsObject.WriteTo(RetV);
    end;

    procedure GenerateLeaveStatement(employeeNo: Code[100]; filenameFromApp: Text[200]; leaveType: Code[50]; var RetV: Text) result: Boolean
    var
        CuTempBlob: Codeunit "Temp Blob";
        MyRecordRef: RecordRef;
        MyOutstream: OutStream;
        MyInStream: InStream;
    begin
        RetV := '';
        result := false;

        filename := filenameFromApp;

        if Exists(filename) then
            Erase(filename);

        TbLeaveLedger2.Reset();
        TbLeaveLedger2.SetRange("Employee No", employeeNo);
        TbLeaveLedger2.SetRange("Leave Type", leaveType);

        if not TbLeaveLedger2.FindSet() then
            exit(false); // business error

        RpLeaveStatement.SetTableView(TbLeaveLedger2);
        MyRecordRef.GetTable(TbLeaveLedger2);

        // If SaveAs fails, system error is thrown automatically
        CuTempBlob.CreateOutStream(MyOutstream);
        RpLeaveStatement.SaveAs('', ReportFormat::Pdf, MyOutstream, MyRecordRef);

        CuTempBlob.CreateInStream(MyInStream);
        RetV := CuBase64Convert.ToBase64(MyInStream, true);

        result := true;
    end;


    [ServiceEnabled]
    procedure fnGeneratePayslip(employeeNo: Code[100]; year: Integer; month: Integer; filenameFromApp: Text[200]) RetV: Text
    var
        baseImage: Text;
    begin
        Clear(JsObject);
        ClearLastError();

        if not GeneratePayslip(employeeNo, year, month, filenameFromApp, baseImage) then begin
            if GetLastErrorText() <> '' then begin
                JsObject.Add('Error', 'TRUE');
                JsObject.Add('Error_Message', GetLastErrorText());
            end else begin
                JsObject.Add('Error', 'TRUE');
                JsObject.Add('Error_Message', 'No payslip found for employee in this period.');
            end;
        end else begin
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('BaseImage', baseImage);
        end;

        JsObject.WriteTo(RetV);
    end;

    procedure GeneratePayslip(employeeNo: Code[100]; year: Integer; month: Integer; filenameFromApp: Text[200]; var RetV: Text) result: Boolean
    var
        MyRecordRef: RecordRef;
        MyOutstream: OutStream;
        MyInStream: InStream;
    begin
        RetV := '';
        result := false;

        filename := filenameFromApp;

        if Exists(filename) then
            Erase(filename);

        PRSalaryCard.Reset();
        PRSalaryCard.SetRange("Employee Code", employeeNo);
        PRSalaryCard.SetFilter("Period Filter", '%1', Dmy2Date(1, month, year));

        if not PRSalaryCard.FindFirst() then
            exit(false);

        IndividualPayslip.SetTableView(PRSalaryCard);
        MyRecordRef.GetTable(PRSalaryCard);

        TbTempBlob.CreateOutstream(MyOutstream);
        IndividualPayslip.SaveAs('', ReportFormat::Pdf, MyOutstream, MyRecordRef);

        TbTempBlob.CreateInStream(MyInStream);
        RetV := CuBase64Convert.ToBase64(MyInStream, true);

        result := true;
    end;



    [ServiceEnabled]
    procedure fnGenerateP9(employeeNo: Code[100]; year: Integer; filenameFromApp: Text[200]) RetV: Text
    var
        baseImage: Text;
    begin
        Clear(JsObject);
        ClearLastError();

        if not GenerateP9(employeeNo, year, filenameFromApp, baseImage) then begin
            if GetLastErrorText() <> '' then begin
                JsObject.Add('Error', 'TRUE');
                JsObject.Add('Error_Message', GetLastErrorText());
            end else begin
                JsObject.Add('Error', 'TRUE');
                JsObject.Add('Error_Message', 'No P9 found for employee in this period.');
            end;
        end else begin
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('BaseImage', baseImage);
        end;

        JsObject.WriteTo(RetV);
    end;

    procedure GenerateP9(employeeNo: Code[100]; year: Integer; filenameFromApp: Text[200]; var RetV: Text) result: Boolean
    var
        MyRecordRef: RecordRef;
        MyOutstream: OutStream;
        MyInStream: InStream;
    begin
        RetV := '';
        result := false;

        filename := filenameFromApp;

        if Exists(filename) then
            Erase(filename);

        // RpPnine.FnInitiateYear(year);
        TbEmployee.Reset();
        TbEmployee.SetFilter(TbEmployee."No.", '=%1', employeeNo);
        TbEmployee.SetFilter(TbEmployee."Period Year Filter", '=%1', year);
        if TbEmployee.FindFirst() then begin
            RpPnine.SetTableview(TbEmployee);
        end else begin
            Error('No data found in Employee');
        end;
        TbEmp99Info.Reset;
        TbEmp99Info.SetFilter("Employee Code", '=%1', employeeNo);
        TbEmp99Info.SetFilter("Payroll Period", '%1..%2', Dmy2date(1, 1, year), Dmy2date(31, 12, year));
        if TbEmp99Info.FindSet then begin
            RpPnine.SetTableview(TbEmp99Info);
        end;
        MyRecordRef.GetTable(PRSalaryCard);

        TbTempBlob.CreateOutstream(MyOutstream);
        RpPnine.SaveAs('', ReportFormat::Pdf, MyOutstream, MyRecordRef);

        TbTempBlob.CreateInStream(MyInStream);
        RetV := CuBase64Convert.ToBase64(MyInStream, true);

        result := true;
    end;



    [ServiceEnabled]
    procedure FnCreateImprestRequisition(employeeNo: Code[100]; docNo: Code[50]; requestDate: Date; responsibilityCenter: Code[50]; purpose: Text) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not ImprestRequisitionHeader(employeeNo, docNo, requestDate, responsibilityCenter, purpose) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure ImprestRequisitionHeader(employeeNo: Code[100]; docNo: Code[50]; requestDate: Date; responsibilityCenter: Code[50]; purpose: Text) return_value: Boolean
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "HR Setup";

    begin
        return_value := false;
        if docNo = '' then begin
            TbImprestRequisitionHeader.Reset();
            TbImprestRequisitionHeader.SetRange(Status, TbImprestRequisitionHeader.Status::Pending);
            TbImprestRequisitionHeader.SetRange("Requested By", employeeNo);

            if TbImprestRequisitionHeader.FindSet(true) then begin
                Error('Sorry, you already have an open imprest requisition. Kindly use it.');
            end else begin

                if not TbCashOfficeSetup.Get() then
                    Error('Cash office Setup must be configured before imprest requisitions can be created.');

                TbCashOfficeSetup.Get();
                TbCashOfficeSetup.TestField("Imprest Req No");
                docNo := CuNoSeriesMgt.GetNextNo(TbCashOfficeSetup."Imprest Req No", 0D, true);

                TbImprestRequisitionHeader.Init();
                TbImprestRequisitionHeader."No." := docNo;
                TbImprestRequisitionHeader.Date := requestDate;
                TbImprestRequisitionHeader."Requested By" := employeeNo;
                TbImprestRequisitionHeader.Cashier := employeeNo;
                TbImprestRequisitionHeader."Responsibility Center" := responsibilityCenter;
                TbImprestRequisitionHeader.Purpose := purpose;
                if TbImprestRequisitionHeader.Insert(true) then begin
                    JsObject.Add('DocNo', TbImprestRequisitionHeader."No.");
                    JsObject.Add('Message', 'Imprest requisition created successfully');
                    return_value := true;
                end;
            end;
        end else begin
            TbImprestRequisitionHeader.Reset();
            TbImprestRequisitionHeader.SetRange("No.", docNo);
            TbImprestRequisitionHeader.SetRange("Requested By", employeeNo);

            if TbImprestRequisitionHeader.FindSet(true) then begin
                TbImprestRequisitionHeader.Date := requestDate;
                TbImprestRequisitionHeader."Responsibility Center" := responsibilityCenter;
                TbImprestRequisitionHeader.Purpose := purpose;

                if TbImprestRequisitionHeader.Modify(true) then begin
                    JsObject.Add('DocNo', TbImprestRequisitionHeader."No.");
                    JsObject.Add('Message', 'Imprest requisition updated successfully');
                    return_value := true;
                end else
                    Error('Unable to fetch the imprest requisition. Kindly try again. Contact the administrator if this error persists');
            end;
        end;
    end;

    [ServiceEnabled]
    procedure FnCreateImprestLine(documentNo: Code[100]; lineNo: Integer; expenditureType: Code[50]; amount: Decimal) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not ImprestRequisitionLine(documentNo, lineNo, expenditureType, amount) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure ImprestRequisitionLine(documentNo: Code[100]; lineNo: Integer; expenditureType: Code[50]; amount: Decimal) return_value: Boolean
    begin
        return_value := false;
        TbImprestRequisitionLines.Reset();
        TbImprestRequisitionLines.SetRange(No, documentNo);

        if lineNo = 0 then begin
            // ---- INSERT NEW LINE ----
            TbImprestRequisitionLines.Init();

            if TbImprestRequisitionLines.FindLast() then
                lineNo := TbImprestRequisitionLines."Line No." + 1
            else
                lineNo := 1;

            TbImprestRequisitionLines."Line No." := lineNo;
            TbImprestRequisitionLines.No := documentNo;
            TbImprestRequisitionLines."Advance Type" := expenditureType;
            TbImprestRequisitionLines.Validate("Advance Type");
            TbImprestRequisitionLines.Amount := amount;
            TbImprestRequisitionLines."Imprest Holder" := TbImprestRequisitionHeader."Account No.";

            // If this fails, the system will raise its own error automatically
            TbImprestRequisitionLines.Insert(true);

            JsObject.Add('Message', 'Imprest requisition line created successfully');
            return_value := true;

        end else begin
            TbImprestRequisitionLines.SetRange("Line No.", lineNo);

            if TbImprestRequisitionLines.FindFirst() then begin
                TbImprestRequisitionLines."Advance Type" := expenditureType;
                TbImprestRequisitionLines.Validate("Advance Type");
                TbImprestRequisitionLines.Amount := amount;

                TbImprestRequisitionLines.Modify(true);

                JsObject.Add('Message', 'Imprest requisition line updated successfully');
                return_value := true;
            end else
                Error('Imprest requisition line does not exist. Kindly create a new imprest requisition line.');
        end;
    end;


    [ServiceEnabled]
    procedure FnDeleteImprestLine(docNo: Code[100]; lineNo: Integer) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteImprestLine(docNo, lineNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure DeleteImprestLine(docNo: Code[100]; lineNo: Integer) return_value: Boolean
    begin
        return_value := false;
        TbImprestRequisitionLines.Reset();
        TbImprestRequisitionLines.SetRange(No, docNo);
        TbImprestRequisitionLines.SetRange("Line No.", lineNo);
        if TbImprestRequisitionLines.FindFirst() then begin
            TbImprestRequisitionLines.Delete(true);
            JsObject.Add('Message', 'Imprest requisition line deleted successfully');
            return_value := true;
        end else
            Error('Imprest requisition line does not exist. Cannot delete the imprest requisition line.');
    end;

    [ServiceEnabled]
    procedure FnSendImprestApproval(employeeNo: Code[100]; requisitionNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not RequestImprestApproval(employeeNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    procedure RequestImprestApproval(employeeNo: Code[100]; docNo: Code[30]) return_value: Boolean
    begin
        return_value := false;
        if not IsImprestLinesExists(docNo) then
            Error('You must add imprest lines before sending an imprest for approval.');
        TbImprestRequisitionHeader.Reset();
        TbImprestRequisitionHeader.SetRange("No.", docNo);
        TbImprestRequisitionHeader.SetRange("Employee No.", employeeNo);
        TbImprestRequisitionHeader.SetRange(Status, TbImprestRequisitionHeader.Status::Pending);
        if TbImprestRequisitionHeader.FindFirst() then begin
            VarVariant := TbImprestRequisitionHeader;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;

        end
    end;


    [ServiceEnabled]
    procedure FnCancelImprestApproval(employeeNo: Code[100]; docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CancelImprestRequisition(employeeNo, docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure CancelImprestRequisition(employeeNo: Code[100]; docNo: Code[30]) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        return_value := false;
        TbImprestRequisitionHeader.Reset();
        TbImprestRequisitionHeader.SetRange("No.", docNo);
        TbImprestRequisitionHeader.SetRange("Employee No.", employeeNo);
        TbImprestRequisitionHeader.SetRange(Status, TbImprestRequisitionHeader.Status::"Pending Approval");
        if TbImprestRequisitionHeader.FindFirst() then begin
            VarVariant := TbImprestRequisitionHeader;
            CuCustomApprovals.OnCancelDocApprovalRequest(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition cannot be cancelled or was not found');
        end;
    end;


    [ServiceEnabled]
    procedure FnCreateImprestSurrenderDocument(myUserID: Code[30]; surrenderDocNo: Code[50]; imprestIssueDocNo: Code[30]; receivedFrom: Code[50]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CreateImprestSurrenderDocument(myUserID, surrenderDocNo, imprestIssueDocNo, receivedFrom) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure CreateImprestSurrenderDocument(
        myUserID: Code[30];
        surrenderDocNo: Code[50];
        imprestIssueDocNo: Code[30];
        receivedFrom: Code[50]
    ) return_value: Boolean
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TbEmployee: Record "HR-Employee";
        TbImprestSurrenderHeader: Record "Imprest Surrender Header";
        TbCashOfficeSetup: Record "Cash Office Setup";
        NextNo: Code[50];
        JsObject: JsonObject;
    begin
        return_value := false;

        if surrenderDocNo = '' then begin
            TbCashOfficeSetup.Get();
            TbCashOfficeSetup.TestField("Imprest Surrender No");

            NextNo := NoSeriesMgt.GetNextNo(TbCashOfficeSetup."Imprest Surrender No", 0D, true);

            TbImprestSurrenderHeader.Init();
            TbImprestSurrenderHeader."No" := NextNo;
            TbImprestSurrenderHeader."Surrender Date" := today;
            TbImprestSurrenderHeader."User ID" := myUserID;
            TbImprestSurrenderHeader."Account No." := myUserID;
            TbImprestSurrenderHeader."Imprest Issue Doc. No" := imprestIssueDocNo;
            TbImprestSurrenderHeader.Validate("Imprest Issue Doc. No", imprestIssueDocNo);
            TbImprestSurrenderHeader."Received From" := receivedFrom;

            if TbImprestSurrenderHeader.Insert(true) then begin
                if TbEmployee.Get(myUserID) then begin
                    TbImprestSurrenderHeader."Account Name" := TbEmployee."Search Name";

                    TbImprestSurrenderHeader."Responsibility Center" := TbEmployee."Responsibility Center";

                    TbImprestSurrenderHeader.Validate("Global Dimension 1 Code", TbEmployee."Shortcut Dimension 1 Code");
                    TbImprestSurrenderHeader.Validate("Shortcut Dimension 2 Code", TbEmployee."Shortcut Dimension 2 Code");
                    TbImprestSurrenderHeader.Modify(true);
                end;

                JsObject.Add('DocNo', TbImprestSurrenderHeader."No");
                JsObject.Add('Message', 'You have successfully created a surrender document.');
                return_value := true;
            end;

        end else begin
            if TbImprestSurrenderHeader.Get(surrenderDocNo) then begin
                if TbImprestSurrenderHeader.Status = TbImprestSurrenderHeader.Status::Pending then begin
                    TbImprestSurrenderHeader.Validate("Imprest Issue Doc. No", imprestIssueDocNo);
                    TbImprestSurrenderHeader."Surrender Date" := today;

                    if TbImprestSurrenderHeader.Modify(true) then begin
                        JsObject.Add('DocNo', TbImprestSurrenderHeader."No");
                        JsObject.Add('Message', 'You have updated your surrender document.');
                        return_value := true;
                    end;
                end;
            end;
        end;

        exit(return_value);
    end;

    [ServiceEnabled]
    procedure FnCreateImprestSurrenderLine(docNo: Code[50]; actualSpent: Decimal; cashReceiptNo: Code[20]; cashReceiptAmount: Decimal) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CreateImprestSurrenderLine(docNo, actualSpent, cashReceiptNo, cashReceiptAmount) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    procedure CreateImprestSurrenderLine(docNo: Code[50]; actualSpent: Decimal; cashReceiptNo: Code[20]; cashReceiptAmount: Decimal) return_value: Boolean
    begin
        return_value := false;

        TbImprestSurrenderLines.Reset();
        TbImprestSurrenderLines.SetRange("Surrender Doc No.", docNo);
        if TbImprestSurrenderLines.FindFirst() then begin
            TbImprestSurrenderLines.Validate("Actual Spent", actualSpent);
            TbImprestSurrenderLines."Cash Receipt No" := cashReceiptNo;
            TbImprestSurrenderLines.Validate("Cash Receipt Amount", cashReceiptAmount);

            if TbImprestSurrenderLines.Modify(true) then begin
                JsObject.Add('DocNo', TbImprestSurrenderLines."Surrender Doc No.");

                JsObject.Add('Message', 'You have updated your surrender line successfully.');
                return_value := true;
            end;
        end else begin
            Error('Imprest surrender line %1 for document %2 is no longer editable or does not exist.', docNo);
        end;
    end;

    [ServiceEnabled]
    procedure FnDeleteImprestSurrederLine(docNo: Code[100]; accountNo: Code[50]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteImprestSurrederLine(docNo, accountNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure DeleteImprestSurrederLine(docNo: Code[100]; accountNo: Code[50]) return_value: Boolean
    begin
        return_value := false;
        TbImprestSurrenderLines.Reset();
        TbImprestSurrenderLines.SetRange("Surrender Doc No.", docNo);
        TbImprestSurrenderLines.SetRange("Account No:", accountNo);
        if TbImprestSurrenderLines.FindFirst() then begin
            TbImprestSurrenderLines.Delete(true);
            JsObject.Add('Message', 'You have successfully deleted imprest surrender line.');
            return_value := true;
        end else
            Error('Imprest surrender details cannot be deleted or was not found');
    end;

    [ServiceEnabled]
    procedure FnRequestImprestSurrenderApproval(employeeNo: Code[100]; requisitionNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not RequestImprestSurrenderApproval(employeeNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    procedure RequestImprestSurrenderApproval(employeeNo: Code[100]; docNo: Code[30]) return_value: Boolean
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


    [ServiceEnabled]
    procedure FnCancelImprestSurrenderApproval(employeeNo: Code[100]; docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CancelImprestSurrenderApproval(employeeNo, docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure CancelImprestSurrenderApproval(employeeNo: Code[100]; docNo: Code[30]) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        return_value := false;
        TbImprestSurrenderHeader.Reset();
        TbImprestSurrenderHeader.SetRange(No, docNo);
        if TbImprestSurrenderHeader.FindFirst() then begin
            VarVariant := TbImprestSurrenderHeader;
            CuCustomApprovals.OnCancelDocApprovalRequest(VarVariant);
        end else begin
            Error('Imprest Surrender cannot be cancelled or was not found');
        end;
    end;

    [ServiceEnabled]
    procedure FnClaimRequisitionHeader(myUserID: Code[30]; requisitionNo: Code[50]; claimDescription: Text; responsibilityCenter: Code[50]
   ) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not ClaimRequisitionHeader(myUserID, requisitionNo, claimDescription, responsibilityCenter) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure ClaimRequisitionHeader(
       myUserID: Code[30]; requisitionNo: Code[50]; claimDescription: Text;
        responsibilityCenter: Code[50]
    ) return_value: Boolean
    var

        NextNo: Code[50];
        JsObject: JsonObject;
    begin
        return_value := false;

        if requisitionNo = '' then begin
            TbCashOfficeSetup.Get();
            TbCashOfficeSetup.TestField("Staff Claim No");
            NextNo := CuNoSeriesMgt.GetNextNo(TbCashOfficeSetup."Staff Claim No", 0D, true);

            TbStaffClaimHeader.Init();
            TbStaffClaimHeader."No." := NextNo;
            TbStaffClaimHeader."Employee No" := myUserID;
            TbStaffClaimHeader.Validate("Employee No");
            TbImprestSurrenderHeader."Account No." := myUserID;
            TbStaffClaimHeader."Account Type" := TbStaffClaimHeader."account type"::Customer;
            TbStaffClaimHeader.Validate("Account No.");
            TbStaffClaimHeader.Purpose := claimDescription;
            TbEmployee.Reset();
            TbEmployee.SetRange("No.", myUserID);
            if TbEmployee.FindFirst() then begin
                TbEmployee.TestField("Shortcut Dimension 1 Code");
                TbEmployee.TestField("Shortcut Dimension 2 Code");
                TbEmployee.TestField("Responsibility Center");
                TbStaffClaimHeader."Global Dimension 1 Code" := TbEmployee."Shortcut Dimension 1 Code";
                TbStaffClaimHeader."Shortcut Dimension 2 Code" := TbEmployee."Shortcut Dimension 2 Code";
                TbStaffClaimHeader."Responsibility Center" := TbEmployee."Responsibility Center";
            end;

            if TbStaffClaimHeader.Insert(true) then begin

                JsObject.Add('DocNo', TbStaffClaimHeader."No.");
                JsObject.Add('Message', 'You have successfully created a claim document.');
                return_value := true;
            end;

        end else begin
            TbStaffClaimHeader.SetRange("No.", requisitionNo);
            TbStaffClaimHeader.SetRange("Employee No", myUserID);
            TbStaffClaimHeader.SetRange(Status, TbStaffClaimHeader.Status::Pending);
            if TbStaffClaimHeader.FindFirst() then begin
                TbStaffClaimHeader."Employee No" := myUserID;
                TbStaffClaimHeader.Validate("Employee No");
                TbImprestSurrenderHeader."Account No." := myUserID;
                TbStaffClaimHeader."Account Type" := TbStaffClaimHeader."account type"::Customer;
                TbStaffClaimHeader.Validate("Account No.");
                TbStaffClaimHeader.Purpose := claimDescription;
                //
                TbEmployee.Reset();
                TbEmployee.SetRange("No.", myUserID);
                if TbEmployee.FindFirst() then begin
                    TbEmployee.TestField("Shortcut Dimension 1 Code");
                    TbEmployee.TestField("Shortcut Dimension 2 Code");
                    TbEmployee.TestField("Responsibility Center");
                    TbStaffClaimHeader."Global Dimension 1 Code" := TbEmployee."Shortcut Dimension 1 Code";
                    TbStaffClaimHeader."Shortcut Dimension 2 Code" := TbEmployee."Shortcut Dimension 2 Code";
                    TbStaffClaimHeader."Responsibility Center" := TbEmployee."Responsibility Center";
                end;

                if TbStaffClaimHeader.Modify(true) then begin
                    JsObject.Add('DocNo', TbStaffClaimHeader."No.");
                    JsObject.Add('Message', 'You have updated your claim document.');
                    return_value := true;
                end;
            end;
        end;
    end;

    [ServiceEnabled]
    procedure FnCreateClaimRequisitionLine(docNo: Code[50]; lineNo: Integer; claimType: Code[30]; accountNo: Code[30]; amount: Decimal; claimReceiptNo: Code[20]; expenditureDate: Date; expenditureDescription: Text) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not ClaimRequisitionLine(docNo, lineNo, claimType, accountNo, amount, claimReceiptNo, expenditureDate, expenditureDescription) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    procedure ClaimRequisitionLine(docNo: Code[50]; lineNo: Integer; claimType: Code[30]; accountNo: Code[30]; amount: Decimal; claimReceiptNo: Code[20]; expenditureDate: Date; expenditureDescription: Text) return_value: Boolean
    begin
        return_value := false;

        TbStaffClaimHeader.Reset();
        if docNo = '' then begin
            TbStaffClaimLines.Reset();
            TbStaffClaimLines.SetRange(No, docNo);
            if TbStaffClaimLines.FindLast() then
                lineNo := TbStaffClaimLines."Line No." + 1
            else
                lineNo := 1;

            TbStaffClaimLines.Reset();
            TbStaffClaimLines.Init();
            TbStaffClaimLines.No := docNo;
            TbStaffClaimLines."Line No." := lineNo;
            TbStaffClaimLines."Advance Type" := claimType;
            TbStaffClaimLines."Account No:" := accountNo;
            TbStaffClaimLines.Validate("Account No:");
            TbStaffClaimLines.Amount := amount;
            TbStaffClaimLines."Claim Receipt No" := claimReceiptNo;
            TbStaffClaimLines."Expenditure Date" := expenditureDate;
            TbStaffClaimLines.Purpose := expenditureDescription;
            if TbStaffClaimLines.Insert(true) then begin
                JsObject.Add('DocNo', TbStaffClaimLines."No");
                JsObject.Add('Line No', TbStaffClaimLines."Line No.");
                JsObject.Add('Message', 'You have submitted your claim Line request.');
                return_value := true;
            end;
        end else begin
            TbStaffClaimLines.SetRange(No, docNo);
            TbStaffClaimLines.SetRange("Line No.", lineNo);
            if TbStaffClaimLines.FindFirst() then begin
                TbStaffClaimLines."Advance Type" := claimType;
                TbStaffClaimLines."Account No:" := accountNo;
                TbStaffClaimLines.Validate("Account No:");
                TbStaffClaimLines.Amount := amount;
                TbStaffClaimLines."Claim Receipt No" := claimReceiptNo;
                TbStaffClaimLines."Expenditure Date" := expenditureDate;
                TbStaffClaimLines.Purpose := expenditureDescription;
                if TbStaffClaimLines.Modify(true) then begin
                    JsObject.Add('DocNo', TbStaffClaimLines."No");
                    JsObject.Add('Line No', TbStaffClaimLines."Line No.");
                    JsObject.Add('Message', 'You have updated your claim Line request.');
                    return_value := true;
                end
            end else begin
                Error('Requisition line is no longer editable or it does not exist.');
            end;
        end;
    end;

    [ServiceEnabled]
    procedure FnDeleteClaimLine(requisitionNo: Code[100]; lineNo: Integer) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteClaimLine(requisitionNo, lineNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure DeleteClaimLine(requisitionNo: Code[100]; lineNo: Integer) return_value: Boolean
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

    [ServiceEnabled]
    procedure FnRequestClaimApproval(employeeNo: Code[100]; requisitionNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not RequestClaimApproval(employeeNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    procedure RequestClaimApproval(employeeNo: Code[100]; docNo: Code[30]) return_value: Boolean
    begin
        return_value := false;
        if not IsClaimLinesExists(docNo) then
            Error('You must add claim lines before sending a claim for approval.');
        TbStaffClaimHeader.Reset();
        TbStaffClaimHeader.SetRange("No.", docNo);
        TbStaffClaimHeader.SetRange("Employee No", employeeNo);
        if TbStaffClaimHeader.FindFirst() then begin
            VarVariant := TbStaffClaimHeader;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition is no longer editable or it does not exist.');
        end;
    end;


    [ServiceEnabled]
    procedure FnCancelClaimRequisition(employeeNo: Code[100]; docNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CancelClaimRequisition(employeeNo, docNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure CancelClaimRequisition(employeeNo: Code[100]; docNo: Code[30]) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        return_value := false;
        TbStaffClaimHeader.Reset();
        TbStaffClaimHeader.SetRange("No.", docNo);
        TbStaffClaimHeader.SetRange("Employee No", employeeNo);
        if TbStaffClaimHeader.FindFirst() then begin
            VarVariant := TbStaffClaimHeader;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition cannot be cancelled or was not found');
        end;
    end;

    [ServiceEnabled]
    procedure FnStoreRequisitionHeader(employeeNo: Code[100]; docNo: Code[30]; requestType: Option; requestDate: Date; requestDescription: Text) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not StoreRequisitionHeader(employeeNo, docNo, requestType, requestDate, requestDescription) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure StoreRequisitionHeader(employeeNo: Code[100]; docNo: Code[30]; requestType: Option; requestDate: Date; requestDescription: Text) return_value: Boolean
    begin
        return_value := false;
        TbStoreRequisition.Reset();
        if docNo = '' then begin
            TbCashOfficeSetup.Get();
            TbCashOfficeSetup.TestField("Stores Requisition No");
            NextNo := CuNoSeriesMgt.GetNextNo(TbCashOfficeSetup."Stores Requisition No", 0D, true);
            TbStoreRequisition.Init();
            TbStoreRequisition."No." := NextNo;
            TbStoreRequisition."Requisition Type" := requestType;
            TbStoreRequisition."User ID" := employeeNo;
            TbStoreRequisition."Employee No" := employeeNo;
            TbStoreRequisition."Request date" := Today;
            TbStoreRequisition."Required Date" := requestDate;
            TbStoreRequisition."Request Description" := requestDescription;

            //

            TbEmployee.Reset();
            TbEmployee.SetRange("No.", employeeNo);
            if TbEmployee.FindFirst() then begin
                TbEmployee.TestField("Shortcut Dimension 1 Code");
                TbEmployee.TestField("Shortcut Dimension 2 Code");
                TbEmployee.TestField("Responsibility Center");
                TbStoreRequisition."Global Dimension 1 Code" := TbEmployee."Shortcut Dimension 1 Code";
                TbStoreRequisition."Shortcut Dimension 2 Code" := TbEmployee."Shortcut Dimension 2 Code";
                TbStoreRequisition."Responsibility Center" := TbEmployee."Responsibility Center";
            end;
            if TbStoreRequisition.Insert(true) then begin
                JsObject.Add('DocNo', TbStoreRequisition."No.");

                JsObject.Add('Message', 'You store request has been created successfully.');
                return_value := true;
            end
        end else begin
            TbStoreRequisition.SetRange("No.", docNo);
            if TbStoreRequisition.FindFirst() then begin
                TbStoreRequisition."Requisition Type" := requestType;
                TbStoreRequisition."Request date" := Today;
                TbStoreRequisition."Required Date" := requestDate;
                TbStoreRequisition."Request Description" := requestDescription;
                //

                TbEmployee.Reset();
                TbEmployee.SetRange("No.", employeeNo);
                if TbEmployee.FindFirst() then begin
                    TbEmployee.TestField("Shortcut Dimension 1 Code");
                    TbEmployee.TestField("Shortcut Dimension 2 Code");
                    TbEmployee.TestField("Responsibility Center");
                    TbStoreRequisition."Global Dimension 1 Code" := TbEmployee."Shortcut Dimension 1 Code";
                    TbStoreRequisition."Shortcut Dimension 2 Code" := TbEmployee."Shortcut Dimension 2 Code";
                    TbStoreRequisition."Responsibility Center" := TbEmployee."Responsibility Center";
                end;
                if TbStoreRequisition.Modify(true) then begin
                    JsObject.Add('DocNo', TbStoreRequisition."No.");
                    JsObject.Add('Message', 'You store request has been updated successfully.');
                    return_value := true;
                end;
            end else begin
                Error('Requisition is no longer editable or it does not exist.');
            end;
        end;
    end;

    [ServiceEnabled]
    procedure FnStoreRequisitionLine(lineNo: Integer; docNo: Code[50]; type: Integer; itemNo: Code[100]; location: Code[30]; quantity: Decimal) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not StoreRequisitionLine(lineNo, docNo, type, itemNo, location, quantity) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure StoreRequisitionLine(lineNo: Integer; docNo: Code[50]; type: Integer; itemNo: Code[100]; location: Code[30]; quantity: Decimal) return_value: Boolean
    var
        Itemob: Record Item;
    begin
        return_value := false;
        TbStoreRequisitionLine.Reset();
        if lineNo = 0 then begin
            TbStoreRequisitionLine.Reset();
            if TbStoreRequisitionLine.FindLast() then
                lineNo := TbStoreRequisitionLine."Line No." + 1
            else
                lineNo := 1;
            TbStoreRequisitionLine.Init();
            TbStoreRequisitionLine."Line No." := lineNo;
            TbStoreRequisitionLine."Requistion No" := docNo;
            TbStoreRequisitionLine.Type := type;
            TbStoreRequisitionLine."No." := itemNo;
            TbStoreRequisitionLine."Issuing Store" := location;
            TbStoreRequisitionLine.Quantity := quantity;
            TbStoreRequisitionLine."Quantity Requested" := quantity;
            TbStoreRequisitionLine.Validate(Quantity);
            TbStoreRequisitionLine.Validate("Quantity Requested");
            TbStoreRequisitionLine.Validate(TbStoreRequisitionLine."No.");
            TbStoreRequisitionLine.Validate(TbStoreRequisitionLine."Unit Cost");
            Itemob.Reset();
            Itemob.SetRange(Itemob."No.", itemNo);
            Itemob.SetRange(Itemob."Location Filter", location);
            if Itemob.FindFirst() then begin
                Itemob.CalcFields(Itemob.Inventory);
                if (Itemob.Inventory - quantity) < 0 then begin
                    Error('This transaction will result in Negative stock %1,%2', Itemob.Inventory, quantity);
                end;
            end;
            if TbStoreRequisitionLine.Insert(true) then begin
                JsObject.Add('DocNo', TbStaffClaimLines."No");
                JsObject.Add('Line No', TbStoreRequisitionLine."Line No.");
                JsObject.Add('Message', 'You have submitted your store line request.');
                return_value := true;
            end
        end else begin
            TbStoreRequisitionLine.SetRange("Requistion No", docNo);
            TbStoreRequisitionLine.SetRange("Line No.", lineNo);
            if TbStoreRequisitionLine.FindFirst() then begin
                TbStoreRequisitionLine."Requistion No" := docNo;
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

                Itemob.Reset();
                Itemob.SetRange(Itemob."No.", itemNo);
                Itemob.SetRange(Itemob."Location Filter", location);
                if Itemob.FindFirst() then begin
                    Itemob.CalcFields(Itemob.Inventory);
                    if (Itemob.Inventory - quantity) < 0 then begin
                        Error('This transaction will result in Negative stock %1,%2', Itemob.Inventory, quantity);
                    end;
                end;
                if TbStoreRequisitionLine.Modify(true) then begin
                    JsObject.Add('DocNo', TbStaffClaimLines."No");
                    JsObject.Add('Line No', TbStoreRequisitionLine."Line No.");
                    JsObject.Add('Message', 'You have updated your store line request.');
                    return_value := true;
                end
            end else begin
                Error('Requisition line is no longer editable or it does not exist.');
            end;
        end;
    end;

    [ServiceEnabled]
    procedure FnDeleteStoreReqLine(lineNo: Integer; requisitionNo: Code[100]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeleteStoreReqLine(lineNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
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

    [ServiceEnabled]
    procedure FnRequestStoreReqApproval(employeeNo: Code[100]; requisitionNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not RequestStoreReqApproval(employeeNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    procedure RequestStoreReqApproval(employeeNo: Code[100]; requisitionNo: Code[50]) return_value: Boolean
    begin
        return_value := false;
        if not IsStoreReqLinesExists(requisitionNo) then
            Error('You must add store requisition lines before sENDing the requisition for approval.');
        TbStoreRequisition.Reset();
        TbStoreRequisition.SetRange("No.", requisitionNo);
        if TbStoreRequisition.FindFirst() then begin
            VarVariant := TbStoreRequisition;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition is no longer editable or it does not exist.');
        end;
    end;

    procedure IsStoreReqLinesExists(requisitionNo: Code[100]) hasLines: Boolean
    begin
        hasLines := false;
        TbStoreRequisitionLine.Reset();
        TbStoreRequisitionLine.SetRange(TbStoreRequisitionLine."Requistion No", requisitionNo);
        if TbStoreRequisitionLine.FindFirst() then begin
            hasLines := true;
        end;
    end;

    [ServiceEnabled]
    procedure FnCancelStoreRequisition(employeeNo: Code[100]; requisitionNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CancelStoreRequisition(employeeNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure CancelStoreRequisition(employeeNo: Code[100]; requisitionNo: Code[100]) return_value: Boolean
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

    [ServiceEnabled]
    procedure FnPurchaseRequisitionHeader(
    employeeNo: Code[100];
    reqNo: Code[100];
    postingDescription: Text;
    orderDate: Date;
    pricesIncludingVAT: Boolean
) RtnV: Text;
    begin
        Clear(JsObject);
        ClearLastError();

        if PurchaseRequisitionHeader(employeeNo, reqNo, postingDescription, orderDate, pricesIncludingVAT) <> '' then
            JsObject.Add('Success', 'TRUE')
        else begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GetLastErrorText());
        end;

        JsObject.WriteTo(RtnV);
    end;

    procedure PurchaseRequisitionHeader(
        employeeNo: Code[100];
        reqNo: Code[100];
        postingDescription: Text;
        orderDate: Date;
        pricesIncludingVAT: Boolean
    ) return_value: Code[50]
    var
        NextNo: Code[50];
    begin
        return_value := '';

        TbProcurementSetup.Get();
        TbProcurementSetup.TestField("Quote Nos.");

        TbPurchaseHeader.Reset();

        if reqNo = '' then begin
            // --- Create a new requisition
            NextNo := CuNoSeriesMgt.GetNextNo(TbProcurementSetup."Quote Nos.", 0D, true);

            TbPurchaseHeader.Init();
            TbPurchaseHeader."No." := NextNo;
            TbPurchaseHeader.DocApprovalType := TbPurchaseHeader.DocApprovalType::Requisition;
            TbPurchaseHeader."Document Type" := TbPurchaseHeader."Document Type"::Quote;
            TbPurchaseHeader."Assigned User ID" := employeeNo;
            TbPurchaseHeader.Validate("Assigned User ID");
            TbPurchaseHeader."Requested Receipt Date" := orderDate;
            TbPurchaseHeader."Order Date" := orderDate;
            TbPurchaseHeader."Document Date" := Today;
            TbPurchaseHeader."Posting Description" := postingDescription;
            TbPurchaseHeader."Prices Including VAT" := pricesIncludingVAT;
            TbPurchaseHeader."Buy-from Vendor No." := 'DEF_VEND';
            TbPurchaseHeader."Pay-to Vendor No." := 'DEF_VEND';

            // --- Set dimensions and responsibility
            // TbUserSetup.Get(employeeNo);
            // TbUserSetup.TestField("Employee No.");

            TbEmployee.Reset();
            TbEmployee.SetRange("No.", employeeNo);

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
            // --- Modify existing open requisition
            TbPurchaseHeader.Reset();
            TbPurchaseHeader.SetRange("No.", reqNo);
            TbPurchaseHeader.SetRange(Status, TbPurchaseHeader.Status::Open);

            if TbPurchaseHeader.FindFirst() then begin
                TbPurchaseHeader.DocApprovalType := TbPurchaseHeader.DocApprovalType::Requisition;
                TbPurchaseHeader."Document Type" := TbPurchaseHeader."Document Type"::Quote;
                TbPurchaseHeader."Assigned User ID" := employeeNo;
                TbPurchaseHeader.Validate("Assigned User ID");
                TbPurchaseHeader."Requested Receipt Date" := orderDate;
                TbPurchaseHeader."Order Date" := orderDate;
                TbPurchaseHeader."Document Date" := Today;
                TbPurchaseHeader."Posting Description" := postingDescription;
                TbPurchaseHeader."Prices Including VAT" := pricesIncludingVAT;

                // TbUserSetup.Get(employeeNo);
                // TbUserSetup.TestField("Employee No.");

                TbEmployee.Reset();
            TbEmployee.SetRange("No.", employeeNo);

                if TbEmployee.FindFirst() then begin
                    TbEmployee.TestField("Shortcut Dimension 1 Code");
                    TbEmployee.TestField("Shortcut Dimension 2 Code");
                    TbEmployee.TestField("Responsibility Center");

                    TbPurchaseHeader."Shortcut Dimension 1 Code" := TbEmployee."Shortcut Dimension 1 Code";
                    TbPurchaseHeader."Shortcut Dimension 2 Code" := TbEmployee."Shortcut Dimension 2 Code";
                    TbPurchaseHeader."Responsibility Center" := TbEmployee."Responsibility Center";
                end;

                TbPurchaseHeader.Modify(true);
                return_value := reqNo;
            end else
                Error('Requisition is no longer editable or does not exist.');
        end;
    end;



    [ServiceEnabled]
    procedure FnPurchaseRequisitionLine(
  reqNo: Code[50]; lineNo: Integer; itemNo: Code[50]; location: Code[50]; quantity: Decimal; type: Integer; procurementPlan: Code[30]; reasonForRequest: Text
) RtnV: Text;
    begin
        Clear(JsObject);
        ClearLastError();

        if PurchaseRequisitionLine(reqNo, lineNo, itemNo, location, quantity, type, procurementPlan, reasonForRequest) <> 0 then
            JsObject.Add('Success', 'TRUE')
        else begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GetLastErrorText());
        end;

        JsObject.WriteTo(RtnV);
    end;


    procedure PurchaseRequisitionLine(reqNo: Code[50]; lineNo: Integer; itemNo: Code[50]; location: Code[50]; quantity: Decimal; type: Integer; procurementPlan: Code[30]; reasonForRequest: Text) return_value: Integer
    begin
        return_value := 0;
        TbPurchaseLine.Reset();
        if lineNo = 0 then begin
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
            return_value := lineNo;
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
                return_value := lineNo;
            end else begin
                Error('Requisition line is no longer editable or it does not exist.');
            end;
        end;
    end;

    [ServiceEnabled]
    procedure FnDeletePurchaseReqLine(lineNo: Integer; requisitionNo: Code[100]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not DeletePurchaseReqLine(lineNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
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


    [ServiceEnabled]
    procedure FnRequestPurchaseReqApproval(employeeNo: Code[100]; requisitionNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not RequestPurchaseReqApproval(employeeNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    procedure RequestPurchaseReqApproval(employeeNo: Code[100]; reqNo: Code[50]) return_value: Boolean
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

    [ServiceEnabled]
    procedure FnCancelPurchaseRequisition(employeeNo: Code[100]; requisitionNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CancelPurchaseRequisition(employeeNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure CancelPurchaseRequisition(employeeNo: Code[100]; requisitionNo: Code[100]) return_value: Boolean
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

    procedure IsPurchaseReqLinesExists(reqNo: Code[100]) hasLines: Boolean
    begin
        hasLines := false;
        TbPurchaseLine.Reset();
        TbPurchaseLine.SetRange(TbPurchaseLine."Document No.", reqNo);
        if TbPurchaseLine.FindFirst() then begin
            hasLines := true;
        end;
    end;



    [ServiceEnabled]
    procedure FnCreateTrainingRequest(MyUserID: Code[30]; DocNo: Code[30]; trainingNeedCode: Code[30]; comments: Text; employeeNo: Code[30]) RetV: Text
    begin
        Clear(JsObject);
        ClearLastError();

        if CreateTrainingRequest(MyUserID, DocNo, trainingNeedCode, comments, employeeNo) then begin
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('Error_Message', '');
        end else begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GetLastErrorText());
        end;

        JsObject.WriteTo(RetV);
    end;

    procedure CreateTrainingRequest(MyUserID: Code[30]; DocNo: Code[30]; trainingNeedCode: Code[30]; comments: Text; employeeNo: Code[30]) return_value: Boolean
    var
        NextNo: Code[30];
    begin
        if DocNo = '' then begin
            TbTrainingHe.Reset();
            if TbTrainingHe.FindLast() then
                NextNo := IncStr(TbTrainingHe."Application No")
            else
                NextNo := 'TRN0001';

            TbTrainingHe.Init();
            TbTrainingHe."Application No" := NextNo;
            TbTrainingHe."User ID" := MyUserID;
            TbTrainingHe."Application Date" := Today;
            TbTrainingHe."Course Title" := trainingNeedCode;
            TbTrainingHe.Validate("Course Title");
            TbTrainingHe."Purpose of Training" := comments;

            if TbTrainingHe.Insert(true) then begin
                TbTrainingParticipant.Init();
                TbTrainingParticipant."Employee Code" := employeeNo;
                TbTrainingParticipant.Validate("Employee Code");
                TbTrainingParticipant.Insert(true);
                JsObject.Add('DocNo', TbTrainingHe."Application No");
                JsObject.Add('Message', 'You have successfully submitted your training request. Please send it for approval.');
                return_value := true;
                exit(return_value);
            end else begin
                Error('Failed to insert training request.');
            end;

        end else begin
            TbTrainingHe.Reset();
            TbTrainingHe.SetRange("Application No", DocNo);
            if TbTrainingHe.FindFirst() then begin
                TbTrainingHe."Application Date" := Today;
                TbTrainingHe."Course Title" := trainingNeedCode;
                TbTrainingHe.Validate("Course Title");
                TbTrainingHe."Purpose of Training" := comments;

                if TbTrainingHe.Modify(true) then begin
                    JsObject.Add('DocNo', TbTrainingHe."Application No");
                    JsObject.Add('Message', 'You have updated your training request. Please send it for approval.');
                    return_value := true;
                    exit(return_value);
                end else
                    Error('Error modifying training request %1.', DocNo);
            end else
                Error('Error: Training request %1 not found.', DocNo);
        end;
    end;

    procedure FnRequestTrainingReqApproval(employeeNo: Code[100]; requisitionNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not RequestTrainingReqApproval(employeeNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;


    procedure RequestTrainingReqApproval(employeeNo: Code[100]; requisitionNo: Code[50]) return_value: Boolean
    begin
        return_value := false;

        TbTrainingHe.Reset();
        TbTrainingHe.SetRange("Application No", requisitionNo);
        if TbTrainingHe.FindFirst() then begin
            VarVariant := TbTrainingHe;
            CuCustomApprovals.OnSendDocForApproval(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition is no longer editable or it does not exist.');
        end;
    end;

    [ServiceEnabled]
    procedure FnCancelTrainingRequisition(employeeNo: Code[100]; requisitionNo: Code[30]) RtnV: Text;
    begin
        Clear(JsObject);
        CLEARLASTERROR();
        if not CancelTrainingRequisition(employeeNo, requisitionNo) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GETLASTERRORTEXT());
        end;
        JsObject.WriteTo(RtnV);
    end;

    procedure CancelTrainingRequisition(employeeNo: Code[100]; requisitionNo: Code[100]) return_value: Boolean
    var
        blnparam: Boolean;
    begin
        return_value := false;
        TbTrainingHe.Reset();
        TbTrainingHe.SetRange("Application No", requisitionNo);
        if TbTrainingHe.FindFirst() then begin
            VarVariant := TbTrainingHe;
            CuCustomApprovals.OnCancelDocApprovalRequest(VarVariant);
            return_value := true;
        end else begin
            Error('Requisition cannot be cancelled or was not found');
        end;
    end;



    [ServiceEnabled]
    procedure FnDocumentApproval(entryNo: Integer; docNo: Code[100]; userID: Code[100]; isApproved: Boolean; comments: Text[250]) RtnV: Text;
    begin
        Clear(JsObject);
        ClearLastError();

        if not DocumentApproval(entryNo, docNo, userID, isApproved, comments) then begin
            if GetLastErrorText() <> '' then begin
                JsObject.Add('Error', 'TRUE');
                JsObject.Add('Error_Message', GetLastErrorText());
            end;
        end;

        JsObject.WriteTo(RtnV);
    end;

    procedure DocumentApproval(entryNo: Integer; docNo: Code[100]; userID: Code[100]; isApproved: Boolean; comments: Text[250]) return_value: Boolean
    begin
        return_value := false;

        TbApprovalEntry.Reset();
        TbApprovalEntry.SetRange("Entry No.", entryNo);
        TbApprovalEntry.SetRange("Document No.", docNo);
        TbApprovalEntry.SetRange("Approver ID", userID);
        TbApprovalEntry.SetRange(Status, TbApprovalEntry.Status::Open);

        if not TbApprovalEntry.FindFirst() then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', 'Record to approve not found.');
            exit(false);
        end;
        if isApproved then begin
            CuApprovalsManagement.ApproveApprovalRequests(TbApprovalEntry);
            JsObject.Add('Message', StrSubstNo('You have successfully approved document %1.', TbApprovalEntry."Document No."));
        end else begin
            CuApprovalsManagement.RejectApprovalRequests(TbApprovalEntry);
            JsObject.Add('Message', StrSubstNo('You have rejected document %1.', TbApprovalEntry."Document No."));
        end;

        DocumentApprovalComments(
            docNo,
            comments,
            userID,
            TbApprovalEntry."Document Type",
            TbApprovalEntry."Record ID to Approve",
            TbApprovalEntry."Sequence No.",
            TbApprovalEntry."Table ID"
        );

        return_value := true;
    end;

    procedure DocumentApprovalComments(docNo: Code[100]; comments: Text[250]; userID: Code[100]; docType: Integer; recordID: RecordID; sequenceNo: Integer; tableID: Integer) return_value: Boolean
    var
        NextEntryNo: Integer;
    begin
        return_value := false;

        TbApprovalCommentLine.Reset();
        if TbApprovalCommentLine.FindLast() then
            NextEntryNo := TbApprovalCommentLine."Entry No." + 1
        else
            NextEntryNo := 1;

        TbApprovalCommentLine.Init();
        TbApprovalCommentLine."Entry No." := NextEntryNo;
        TbApprovalCommentLine."Table ID" := tableID;
        TbApprovalCommentLine."Document Type" := docType;
        TbApprovalCommentLine."Document No." := docNo;
        TbApprovalCommentLine."User ID" := userID;
        TbApprovalCommentLine.Comment := comments;
        TbApprovalCommentLine."Date and Time" := CurrentDateTime;
        //TbApprovalCommentLine."Sequence No." := sequenceNo;
        TbApprovalCommentLine."Record ID to Approve" := recordID;

        TbApprovalCommentLine.Insert();
        return_value := true;
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

    procedure IsImprestLinesExists(docNo: Code[100]) hasLines: Boolean
    begin
        hasLines := false;
        TbImprestRequisitionLines.Reset();
        TbImprestRequisitionLines.SetRange(TbImprestRequisitionLines.No, docNo);
        if TbImprestRequisitionLines.FindFirst() then begin
            hasLines := true;
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

    procedure FnSendEmail(subject: Text[150]; recipients: Text[200]; emailMessage: Text[1000]; ccRecipients: Text[100]) returnValue: Boolean
    var
        CuEmailMessage: Codeunit "Email Message";
        CuEmail: Codeunit "Email";
        recipientsList: List of [Text];
        ccRecipientsList: List of [Text];
        bccRecipientsList: List of [Text];
        recipient: Text;
    begin
        returnValue := false;
        if recipients <> '' then begin
            recipientsList := recipients.Split(';');
            ccRecipientsList := ccRecipients.Split(';');
        end;
        CuEmailMessage.Create(recipientsList, subject, emailMessage, true, ccRecipientsList, bccRecipientsList);
        if CuEmail.Send(CuEmailMessage, Enum::"Email Scenario"::Default) then
            returnValue := true;
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

    [ServiceEnabled]
    procedure fnDownloadHRDocuments(DocumentNo: Code[30]) RetV: Text
    var
        baseImage: Text;
    begin
        Clear(JsObject);
        ClearLastError();

        baseImage := DownloadHRDocuments(DocumentNo);

        if baseImage = '' then begin
            if GetLastErrorText() <> '' then begin
                JsObject.Add('Error', 'TRUE');
                JsObject.Add('Error_Message', GetLastErrorText());
            end else begin
                JsObject.Add('Error', 'TRUE');
                JsObject.Add('Error_Message', 'No document found or unable to retrieve file.');
            end;
        end else begin
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('BaseImage', baseImage);
        end;

        JsObject.WriteTo(RetV);
    end;


    procedure DownloadHRDocuments(DocumentNo: Code[30]) return_value: Text
    var
        DocumentAttachment: Record "Document Attachment";
        CuTempBlob: Codeunit "Temp Blob";
        MyInStream: InStream;
        MyOutStream: OutStream;
        Convert: DotNet Convert;
        Bytes: DotNet Array;
        MemoryStream: DotNet MemoryStream;
    begin
        Clear(return_value);

        DocumentAttachment.Reset();
        DocumentAttachment.SetRange("Table ID", Database::"Hr Documents");
        DocumentAttachment.SetRange("No.", DocumentNo);

        if DocumentAttachment.FindFirst() then begin
            if DocumentAttachment."Document Reference ID".HasValue then begin
                CuTempBlob.CreateOutStream(MyOutStream);
                DocumentAttachment."Document Reference ID".ExportStream(MyOutStream);

                CuTempBlob.CreateInStream(MyInStream);
                MemoryStream := MemoryStream.MemoryStream();
                COPYSTREAM(MemoryStream, MyInStream);

                Bytes := MemoryStream.GetBuffer();
                return_value := Convert.ToBase64String(Bytes);
            end else
                Error('The selected document has no file reference.');
        end else
            Error('Document %1 not found.', DocumentNo);
    end;

}
