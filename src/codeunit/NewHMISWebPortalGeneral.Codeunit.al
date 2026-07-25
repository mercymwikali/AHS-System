namespace HMISBC.HMISBC;
using Microsoft.Foundation.NoSeries;
using PTL.Hospital;
using PTL.HMISBC;
using System.Environment;
using Microsoft.Finance.Dimension;
using System;
using System.IO;
using System.Security.AccessControl;
using Microsoft.Foundation.Attachment;
using System.Security.User;
using PTL.HMIS;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Posting;
using Microsoft.Sales.History;
using System.Utilities;
using System.Text;
using Microsoft.Sales.Document;
using System.Email;

codeunit 85015 "New HMIS WebPortal General"
{
    var
        HMSPatientTbl: record "HMS Patient";
        TbPatient2: record "HMS Patient";
        TbEmployee: Record "HR-Employee";
        TbAppointment: Record "HMS Appointment Form Header";
        NextNo: Code[30];
        DocNo: Code[30];
        NextNo2: Code[30];
        CuNoSeries: Codeunit "No. Series";
        TbHMSSetup: record "HMS Setup";
        TbSecSetup: record "Security Setups";
        TbUserSetup: record "User Setup";
        CuHMSProcesses: Codeunit "HMS Processes";
        HMSPatientintegration: Codeunit "HMS Patient-integration";
        ErrorSthWrong: Label '{"status":"failed","msg":"Something went wrong. Please try again."}';
        ErrorInvalidAction: Label '{"status":"failed","msg":"Invalid action"}';
        TbHRSetup2: Record "HR Setup";
        FILESPATH: Label 'C:\inetpub\wwwroot\PortalFiles';

        HMSAdmissionFormHeaderT: Record "HMS Admission Form Header";
        HMSTreatmentFormHeaderT: Record "HMS Treatment Form Header";
        HMSSetupt: Record "HMS Setup";
        NoSeriesMgt: Codeunit "No. Series";
        jObjectT: JsonObject;
        jTokenT: JsonToken;
        ActionT: Text;
        EncounterTypeT: Text;
        PatientNoT: Code[20];
        ClinicT: Code[20];
        AdmissionDateT: Date;
        DischargeDateT: Date;
        OldFileNumberT: Code[30];
        EncounterNoT: Code[20];
        UserT: Code[50];
        ResponseT: Text;
    //
    procedure FnSaveSessionToken(userNo: Code[30]; sessionToken: Text[200]) returnValue: Boolean
    begin
        /**************************New Auth Session Based Authentication************************* */
        /* 
            ******Api Side*************
            - On Login, return the session ID and User Details
            - When Making requests. A middleware will:
                1. Check the current save token for the user.
                2. If no session is found return a 401 error.
                3. Check the expiry of the session record. 
            ******Business Central Side**********
            - Get the new session Token from the API,
            - Save New and Delete Any old Sessions
        */
        returnValue := false;
        TbEmployee.Reset();
        TbEmployee.SetRange("No.", userNo);
        if TbEmployee.FindFirst() then begin
            TbEmployee."Portal Session Token" := sessionToken;
            TbEmployee."Portal OTP Code" := '';
            if TbEmployee.Modify(true) then
                returnValue := true;
        end;
    end;

    procedure FnAuthSaveSession(UserID: Code[30]; SessionID: Text[200]; ExpiresAt: DateTime) returnValue: Boolean
    var
        PortalSessions: Record "Portal Sessions";
    begin
        returnValue := false;
        PortalSessions.Init();
        PortalSessions."User ID" := UserID;
        PortalSessions."Session ID" := SessionID;
        PortalSessions."Creation Date" := Today;
        PortalSessions.ExpiresAt := ExpiresAt;
        if PortalSessions.Insert() then
            returnValue := true;

        exit(returnValue);
    end;

    procedure FnAuthUpdateSessionExpiry(SessionId: Text[200]; ExpiresAt: DateTime) returnValue: Boolean
    var
        PortalSessions: Record "Portal Sessions";
    begin
        returnValue := false;
        if PortalSessions.Get(SessionId) then begin
            PortalSessions.ExpiresAt := ExpiresAt;
            if PortalSessions.Modify() then
                returnValue := true;
        end;

        exit(returnValue);
    end;

    procedure FnAuthDeleteSession(SessionID: Text[200]) returnValue: Boolean
    var
        PortalSessions: Record "Portal Sessions";
    begin
        returnValue := false;
        if PortalSessions.Get(SessionId) then
            if PortalSessions.delete() then
                returnValue := true;

        exit(returnValue);
    end;

    /* Begin OTP Handling */
    procedure FnAuthUpdateOTPCode(userNo: Code[20]; OTPCode: code[10]; OTPDevice: Text[50]) returnValue: Boolean
    var
        PortalUser: Record "Portal User";
    begin
        returnValue := false;
        PortalUser.Reset();
        PortalUser.SetRange("User ID", userNo);
        if PortalUser.FindFirst() then begin
            PortalUser."Portal OTP Code" := OTPCode;
            PortalUser."OTP Code Used Today" := false;
            PortalUser."Portal OTP Device" := OTPDevice;
            PortalUser."Portal OTP Date" := Today();
            if PortalUser.Modify() then
                returnValue := true;
        end;
    end;

    procedure FnAuthSendOTPNotification(userNo: Code[20]) returnValue: Boolean
    var
        PortalUser: Record "Portal User";
        SMSSenderCodeunit: Codeunit "SMS Integration Management";
        mailMessage: Text[1000];
        smsMsg: text;
        MailContentLbl: label 'Dear %1,<br/> Kindly use the OTP code <b> %2 </b> to login to the portal. Kindly note the OTP authentication expires after 24 hours.', comment = '%1 = Staff name %2 = OTP Code';
    begin
        returnValue := false;
        PortalUser.Reset();
        PortalUser.SetRange("User ID", userNo);
        if PortalUser.FindFirst() then begin
            PortalUser.CalcFields("Staff E-mail", "Staff Phone No.");
            if PortalUser."Staff E-mail" <> '' then begin
                mailMessage := StrSubstNo(MailContentLbl, PortalUser."Staff Name", PortalUser."Portal OTP Code");
                FnSendEmail('Staff Portal Login OTP Code', PortalUser."Staff E-mail", mailMessage, '');
            end;

            smsMsg := 'Your OTP: ' + PortalUser."Portal OTP Code";
            if PortalUser."Staff Phone No." <> '' then
                SMSSenderCodeunit.SendSMS(PortalUser."Staff Phone No.", smsMsg);

            returnValue := true;
        end;
    end;

    procedure FnAuthVerifyOTP(UserNo: Code[20]; OTPCode: code[20]) returnValue: Boolean
    var
        PortalUser: Record "Portal User";
    begin
        PortalUser.Reset();
        PortalUser.SetRange("User ID", UserNo);
        if PortalUser.FindFirst() then begin
            if (PortalUser."Portal OTP Code" <> OTPCode) or ((PortalUser."Portal OTP Code" = OTPCode) and (PortalUser."Portal OTP Date" <> Today)) then
                Error('The reset token is invalid or expired');

            PortalUser."OTP Code Used Today" := true;
            if PortalUser.Modify() then
                returnValue := true;
        end
    end;

    procedure FnAuthSavePasswordResetToken(userNo: Code[20]; resetToken: Code[10]) returnValue: Boolean
    var
        PortalUser: Record "Portal User";
    begin
        returnValue := false;
        PortalUser.Reset();
        PortalUser.SetRange(PortalUser."User ID", userNo);
        if PortalUser.FindFirst() then begin
            PortalUser."Portal Reset Token" := resetToken;
            PortalUser."Portal Reset Token Expired" := false;
            if PortalUser.Modify(true) then
                returnValue := true;
        end;
    end;

    procedure FnAuthResetPassword(userNo: Code[20]; resetToken: Code[20]; newPassword: Text[100]) returnValue: Boolean
    var
        PortalUser: Record "Portal User";
    begin
        returnValue := false;
        PortalUser.Reset();
        PortalUser.SetRange(PortalUser."User ID", userNo);
        if PortalUser.FindFirst() then begin
            if (PortalUser."Portal Reset Token" <> resetToken) or PortalUser."Portal Reset Token Expired" then
                Error('The reset token is invalid or expired');

            PortalUser.Password := newPassword;
            PortalUser."Portal Reset Token Expired" := true;
            if PortalUser.Modify(true) then
                returnValue := true;
        end;
    end;

    procedure FnAuthChangePassword(userNo: Code[20]; newPassword: Text[100]) returnValue: Boolean
    var
        PortalUser: Record "Portal User";
    begin
        returnValue := false;
        PortalUser.Reset();
        PortalUser.SetRange(PortalUser."User ID", userNo);
        if PortalUser.FindFirst() then begin
            PortalUser.Password := newPassword;
            if PortalUser.Modify(true) then
                returnValue := true;
        end;
    end;

    procedure FnSavePasswordResetToken(userNo: Code[20]; resetToken: Code[20]) returnValue: Boolean
    begin
        returnValue := false;
        TbEmployee.Reset();
        TbEmployee.SetRange("No.", userNo);
        if TbEmployee.FindFirst() then begin
            TbEmployee."Portal Reset Token" := resetToken;
            TbEmployee."Portal Reset Token Expired" := false;
            if TbEmployee.Modify(true) then
                returnValue := true;
        end;
    end;

    procedure FnResetPassword(userNo: Code[20]; resetToken: Code[20]; newPassword: Text[200]) returnValue: Boolean
    begin
        returnValue := false;
        TbEmployee.Reset();
        TbEmployee.SetRange("No.", userNo);
        if TbEmployee.FindFirst() then begin
            if (TbEmployee."Portal Reset Token" <> resetToken) or TbEmployee."Portal Reset Token Expired" then
                Error('The reset token is invalid or expired');
            TbEmployee."Portal Password" := newPassword;
            TbEmployee."Portal Reset Token Expired" := true;
            if TbEmployee.Modify(true) then
                returnValue := true;
        end;
    end;

    procedure FnChangePassword(userNo: Code[20]; newPassword: Text[200]) returnValue: Boolean
    begin
        returnValue := false;
        TbEmployee.Reset();
        TbEmployee.SetRange("No.", userNo);
        if TbEmployee.FindFirst() then begin
            TbEmployee."Portal Password" := newPassword;
            if TbEmployee.Modify(true) then
                returnValue := true;
        end;
    end;

    procedure FnMFALogin(userNo: Code[20]; OTPCode: code[20]) returnValue: Boolean
    begin
        returnValue := false;
        TbEmployee.Reset();
        TbEmployee.SetRange("No.", userNo);
        if TbEmployee.FindFirst() then begin
            if (TbEmployee."Portal OTP Code" <> OTPCode) or ((TbEmployee."Portal OTP Code" = OTPCode) and (TbEmployee."Portal OTP Date" <> Today)) then
                Error('The reset token is invalid or expired');
            TbEmployee."OTP Code Used Today" := true;
            if TbEmployee.Modify(true) then
                returnValue := true;
        end;
    end;

    procedure FnUpdateOTPCode(userNo: Code[20]; OTPCode: code[20]; OTPDevice: Text[150]) returnValue: Boolean
    var
        mailMessage: Text;
        SMSSenderCodeunit: Codeunit "SMS Integration Management";
        smsMsg: text;
        SMSSender: Record "SMS Sender";
    begin
        returnValue := false;
        TbEmployee.Reset();
        TbEmployee.SetRange("No.", userNo);
        if TbEmployee.FindFirst() then begin
            TbEmployee."Portal OTP Code" := OTPCode;
            TbEmployee."Portal OTP Date" := Today;
            TbEmployee."Portal OTP Device" := OTPDevice;
            TbEmployee."OTP Code Used Today" := false;
            if TbEmployee.Modify(true) then begin
                IF (TbEmployee."Company E-Mail" = '') AND (TbEmployee."E-Mail" = '') THEN
                    ERROR('Email not setup for staff no %1', userNo);
                mailMessage := 'Dear ' + TbEmployee."First Name" + ',<br/> Kindly use the OTP code <b>' + OTPCode + '</b> to login to the portal. Kindly note the ' +
                  'OTP authentication expires after 24 hours or upon change of device or browser.';
                IF TbEmployee."Company E-Mail" <> '' THEN
                    FnSendEmail('Staff Portal Login OTP Code', TbEmployee."Company E-Mail", mailMessage, '')
                ELSE IF TbEmployee."E-Mail" <> '' THEN
                    FnSendEmail('Staff Portal Login OTP Code', TbEmployee."E-Mail", mailMessage, '');


                smsMsg := 'Your OTP: ' + OTPCode;
                if TbEmployee."Work Phone Number" <> '' then
                    SMSSenderCodeunit.SendSMS(TbEmployee."Work Phone Number", smsMsg);

                returnValue := true;
            end;
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

    procedure FnGetDimensionCodeValue(dimensionsString: Text; dimNo: Integer; isMandatory: Boolean) returnValue: Code[30]
    var
        jObjectDims: JsonObject;
        jToken: JsonToken;
    begin
        returnValue := '';
        if (dimensionsString <> '') then begin
            jObjectDims.ReadFrom(dimensionsString);
            case dimNo of
                1:
                    begin
                        jObjectDims.Get('dimension1Code', jToken);
                        returnValue := jToken.AsValue().AsText();
                    end;
                2:
                    begin
                        jObjectDims.Get('dimension2Code', jToken);
                        returnValue := jToken.AsValue().AsText();
                    end;
                3:
                    begin
                        jObjectDims.Get('dimension3Code', jToken);
                        returnValue := jToken.AsValue().AsText();
                    end;
                4:
                    begin
                        jObjectDims.Get('dimension4Code', jToken);
                        returnValue := jToken.AsValue().AsText();
                    end;
                5:
                    begin
                        jObjectDims.Get('dimension5Code', jToken);
                        returnValue := jToken.AsValue().AsText();
                    end;
                6:
                    begin
                        jObjectDims.Get('dimension6Code', jToken);
                        returnValue := jToken.AsValue().AsText();
                    end;
                7:
                    begin
                        jObjectDims.Get('dimension7Code', jToken);
                        returnValue := jToken.AsValue().AsText();
                    end;
                8:
                    begin
                        jObjectDims.Get('dimension8Code', jToken);
                        returnValue := jToken.AsValue().AsText();
                    end;
            end;
            if isMandatory and (returnValue = '') then
                Error('Dimension %1 Code cannot be blank', dimNo);
        end;
    end;

    procedure FnGetStaffUserID(staffNo: Code[30]) returnValue: Code[50]
    begin
        TbUserSetup.Reset();
        TbUserSetup.SetRange("Employee No.", staffNo);
        if TbUserSetup.FindFirst() then
            returnValue := TbUserSetup."User ID"
        else
            returnValue := UserId;
    end;

procedure FnUploadAttachedFile(jString: Text) return_value: Boolean
var
    TableFound: Boolean;
    FromRecRef: RecordRef;
    Convert: Codeunit "Base64 Convert";
    TempBlob: Codeunit "Temp Blob";

    Ostream: OutStream;
    InStr: InStream;

    DocNo: Code[50];
    DocNo2: Code[50];
    DocNos: array[20] of Code[50];
    lineNo: Integer;

    ObjUsers: Record User;
    TbDocumentAttachment: Record "Document Attachment";

    jObject: JsonObject;
    jToken: JsonToken;

    tableId: Integer;
    fileName: Text;
    attachment: Text;
    myUserId: Code[30];

    TbRadiologyLine: Record "HMS Radiology Form Line";
begin
    TableFound := false;
    return_value := false;

    // 🔹 Parse JSON (unchanged)
    jObject.ReadFrom(jString);

    jObject.Get('tableId', jToken);
    tableId := jToken.AsValue().AsInteger();

    jObject.Get('docNo', jToken);
    DocNo := jToken.AsValue().AsText();

    jObject.Get('fileName', jToken);
    fileName := jToken.AsValue().AsText();

    jObject.Get('fileBase64', jToken);
    attachment := jToken.AsValue().AsText();

    jObject.Get('myUserId', jToken);
    myUserId := jToken.AsValue().AsText();

    case tableId of
        Database::"HMS Radiology Form Line":
            begin
                jObject.Get('docNo2', jToken);
                DocNo2 := jToken.AsValue().AsText();

                TbRadiologyLine.Reset();
                TbRadiologyLine.SetRange("Radiology no.", DocNo);
                TbRadiologyLine.SetRange("Radiology Type Code", DocNo2);

                if TbRadiologyLine.Find('-') then
                    FromRecRef.GetTable(TbRadiologyLine);

                TableFound := true;
            end;
    end;

    // 🔹 Save file (same behavior)
    if TableFound then begin
        if fileName = '' then
            Error('File name cannot be blank');

        Clear(TbDocumentAttachment);
        TbDocumentAttachment.Init();

        // 🔥 Replace FileManagement usage with pure text handling
        TbDocumentAttachment.Validate("File Extension", CopyStr(fileName, StrLen(fileName) - 3, 4));
        TbDocumentAttachment.Validate("File Name",
            CopyStr(fileName, 1, MaxStrLen(TbDocumentAttachment."File Name")));

        TbDocumentAttachment.Validate("No.", DocNo);
        TbDocumentAttachment."Table ID" := tableId;

        if lineNo <> 0 then
            TbDocumentAttachment.Validate("Line No.", lineNo);

        if DocNos[2] <> '' then
            TbDocumentAttachment.Validate("No. 2", DocNos[2]);

        // 🔥 Base64 → Stream (unchanged, already SaaS-safe)
        TempBlob.CreateOutStream(Ostream);
        Convert.FromBase64(attachment, Ostream);

        TempBlob.CreateInStream(InStr);
        TbDocumentAttachment."Document Reference ID".ImportStream(InStr, '', fileName);

        // 🔹 User mapping (unchanged)
        ObjUsers.Reset();
        ObjUsers.SetRange("User Name", myUserId);
        if ObjUsers.Find('-') then
            TbDocumentAttachment."Attached By" := ObjUsers."User Security ID";

        TbDocumentAttachment.Validate("Attached Date", CurrentDateTime);
        TbDocumentAttachment.Insert();

        return_value := true;

        // ❌ Removed: DeleteServerFile (not allowed in SaaS)
    end else
        Error('Related table or record for attached file was not found');
end;
    //procedure FnGetDocumentAttachmentBase64(docNo: Code[100]; attachmentID: Integer; tableID: Integer) BaseImage: Text;
    procedure FnGetDocumentAttachmentBase64(jString: Text) BaseImage: Text;
    var
        FromRecRef: RecordRef;
        CuFileManagement: Codeunit "File Management";
        Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        Ostream: OutStream;
        isTableFound: Boolean;
        tableFound: Boolean;
        imageID: GUID;
        Istream: InStream;
        TbDocumentAttachment: record "Document Attachment";
        TbTenantMedia: Record "Tenant Media";
        jObject: JsonObject;
        jToken: JsonToken;
        tableID: Integer;
        attachmentID: Integer;
        docNo: Code[30];
    begin
        jObject.ReadFrom(jString);
        jObject.Get('tableId', jToken);
        tableId := jToken.AsValue().AsInteger();
        jObject.Get('attachmentID', jToken);
        attachmentID := jToken.AsValue().AsInteger();
        jObject.Get('docNo', jToken);
        docNo := jToken.AsValue().AsCode();
        TbDocumentAttachment.RESET();
        TbDocumentAttachment.SETRANGE("Table ID", tableID);
        TbDocumentAttachment.SETRANGE("No.", docNo);
        TbDocumentAttachment.SETRANGE(ID, attachmentID);
        if TbDocumentAttachment.FINDFIRST() then begin
            if TbDocumentAttachment."Document Reference ID".HASVALUE then begin
                imageID := TbDocumentAttachment."Document Reference ID".MEDIAID;
                if TbTenantMedia.GET(imageID) then begin
                    TbTenantMedia.CALCFIELDS(Content);
                    TbTenantMedia.Content.CREATEINSTREAM(Istream);
                    TempBlob.CreateOutStream(Ostream, TEXTENCODING::UTF8);
                    COPYSTREAM(Ostream, Istream);
                    BaseImage := Convert.ToBase64(Istream);
                end;
            end;
        end;
    end;

    procedure FnPatientRegistration(jString: Text) returnValue: Text
    var
        jObject: JsonObject;//
        jToken: JsonToken;
        myAction: Text;
        status: Text;
        msg: Text;
        DocNo: Code[30];
        dimensions: Text;
        jstring2: Text;
        SMSSenderCodeunit: Codeunit "SMS Integration Management";
        smsMsg: text;
        PatientPhone: Code[30];
        FirstName: Text;
    begin
        if jObject.ReadFrom(jString) then begin
            jObject.Get('myAction', jToken);
            myAction := jToken.AsValue().AsText();
            case myAction of
                'create', 'create#save':
                    begin
                        TbHMSSetup.Get;
                        TbHMSSetup.TestField("Patient Nos");
                        NextNo := CuNoSeries.GetNextNo(TbHMSSetup."Patient Nos", 0D, true);
                        HMSPatientTbl.Init();
                        HMSPatientTbl."Patient No." := NextNo;
                        HMSPatientTbl."Date Registered" := Today;
                        if jObject.Get('branchCode', jToken) then
                            HMSPatientTbl."Global Dimension 1 Code" := jToken.AsValue().AsText();
                        if jObject.Get('firstName', jToken) then
                            HMSPatientTbl.Surname := jToken.AsValue().AsText();
                        FirstName := jToken.AsValue().AsText();
                        if jObject.Get('middleName', jToken) then
                            HMSPatientTbl."Middle Name" := jToken.AsValue().AsText();
                        if jObject.Get('lastName', jToken) then
                            HMSPatientTbl."Last Name" := jToken.AsValue().AsText();
                        HMSPatientTbl.validate("Last Name");
                        if jObject.Get('gender', jToken) then
                            if jToken.AsValue().AsInteger() = 0 then
                                HMSPatientTbl.Gender := HMSPatientTbl.Gender::" ";
                        HMSPatientTbl.Gender := jToken.AsValue().AsInteger();
                        if jObject.Get('dob', jToken) then
                            HMSPatientTbl."Date Of Birth" := jToken.AsValue().AsDate();
                        if jObject.Get('nationality', jToken) then
                            HMSPatientTbl.Nationality := jToken.AsValue().AsText();
                        if jObject.Get('county', jToken) then
                            HMSPatientTbl."Place of Birth District" := jToken.AsValue().AsText();
                        if jObject.Get('subcounty', jToken) then begin
                            HMSPatientTbl."Sub-County code" := jToken.AsValue().AsText();
                            HMSPatientTbl.validate("Sub-County code");
                        end;
                        if jObject.Get('countyWard', jToken) then begin
                            HMSPatientTbl."County Ward" := jToken.AsValue().AsText();
                            HMSPatientTbl.validate("County Ward");
                        end;
                        if jObject.Get('idNumber', jToken) then
                            HMSPatientTbl."ID Number" := jToken.AsValue().AsText();
                        HMSPatientTbl.Validate("ID Number");
                        if jObject.Get('phoneNumber', jToken) then
                            HMSPatientTbl."Telephone No. 1" := jToken.AsValue().AsText();
                        PatientPhone := jToken.AsValue().AsText();
                        if jObject.Get('paymentMode', jToken) then
                            HMSPatientTbl."Patient Type" := jToken.AsValue().AsInteger();
                        if jObject.Get('nextOfKinRelationship', jToken) then
                            HMSPatientTbl."Next of kin Relationship" := jToken.AsValue().AsText();
                        if jObject.Get('nextOfKinFullName', jToken) then
                            HMSPatientTbl."Next Of kin Full Name" := jToken.AsValue().AsText();
                        if jObject.Get('nextOfKinPhoneNo', jToken) then
                            HMSPatientTbl."Next Of kin Address 1" := jToken.AsValue().AsText();
                        if HMSPatientTbl."Patient Type" = HMSPatientTbl."Patient Type"::Corporate then begin
                            if jObject.Get('insuranceNo', jToken) then
                                HMSPatientTbl."Insurance No." := jToken.AsValue().AsText();
                            if jObject.Get('insuranceName', jToken) then
                                HMSPatientTbl."Insurance Name" := jToken.AsValue().AsText();
                            if jObject.Get('insurancePrinicipalMemberName', jToken) then
                                HMSPatientTbl."Principal Member Name" := jToken.AsValue().AsText();
                            if jObject.Get('isPrincipleMember', jToken) then
                                HMSPatientTbl.Principal := jToken.AsValue().AsBoolean();
                            if jObject.Get('membershipNo', jToken) then
                                HMSPatientTbl."Membership No" := jToken.AsValue().AsText();
                            if jObject.Get('schemeName', jToken) then
                                HMSPatientTbl."Scheme Name" := jToken.AsValue().AsText();
                        end;
                        if jObject.Get('howYouKnewABoutUs', jToken) then
                            HMSPatientTbl."How you Knew About Us" := jToken.AsValue().AsText();
                        if jObject.Get('staffNo', jToken) then
                            HMSPatientTbl."User ID" := FnGetStaffUserID(jToken.AsValue().AsText());
                        if jObject.Get('email', jToken) then begin
                            HMSPatientTbl.Email := jToken.AsValue().AsText();
                        end;
                        if jObject.Get('residence', jToken) then
                            HMSPatientTbl."Place of Birth Village" := jToken.AsValue().AsText();
                        // if jObject.Get('patientStatus', jToken) then begin
                        //     TbPatient."Patient Status" := jToken.AsValue().AsInteger();
                        // end;


                        if HMSPatientTbl.Insert(true) then begin
                            status := 'success';
                            msg := NextNo;

                            smsMsg := 'Hello ' + FirstName + ', thankyou for visiting us. Your Registration number is  ' + Format(NextNo);
                            if PatientPhone <> '' then
                                SMSSenderCodeunit.SendSMS(PatientPhone, smsMsg);

                            returnValue := '{"status":"' + status + '","DocNo":"' + NextNo + '","msg":"' + msg + '"}';
                        end;
                    end;
                'edit', 'edit#save':
                    begin
                        jObject.Get('patientNo', jToken);
                        DocNo := jToken.AsValue().AsText();
                        HMSPatientTbl.Reset();
                        HMSPatientTbl.SetRange("Patient No.", DocNo);
                        if HMSPatientTbl.FindFirst() then begin
                            if jObject.Get('branchCode', jToken) then
                                HMSPatientTbl."Global Dimension 1 Code" := jToken.AsValue().AsText();
                            if jObject.Get('firstName', jToken) then
                                HMSPatientTbl.Surname := jToken.AsValue().AsText();
                            if jObject.Get('middleName', jToken) then
                                HMSPatientTbl."Middle Name" := jToken.AsValue().AsText();
                            if jObject.Get('lastName', jToken) then
                                HMSPatientTbl."Last Name" := jToken.AsValue().AsText();
                            HMSPatientTbl.validate("Last Name");
                            if jObject.Get('gender', jToken) then
                                if jToken.AsValue().AsInteger() = 0 then
                                    HMSPatientTbl.Gender := HMSPatientTbl.Gender::" "
                                else
                                    HMSPatientTbl.Gender := jToken.AsValue().AsInteger();
                            if jObject.Get('dob', jToken) then
                                HMSPatientTbl."Date Of Birth" := jToken.AsValue().AsDate();
                            if jObject.Get('nationality', jToken) then
                                HMSPatientTbl.Nationality := jToken.AsValue().AsText();
                            if jObject.Get('county', jToken) then
                                HMSPatientTbl."Place of Birth District" := jToken.AsValue().AsText();
                            if jObject.Get('subcounty', jToken) then begin
                                HMSPatientTbl."Sub-County code" := jToken.AsValue().AsText();
                                HMSPatientTbl.validate("Sub-County code");
                            end;
                            if jObject.Get('countyWard', jToken) then begin
                                HMSPatientTbl."County Ward" := jToken.AsValue().AsText();
                                HMSPatientTbl.validate("County Ward");
                            end;
                            if jObject.Get('idNumber', jToken) then
                                HMSPatientTbl."ID Number" := jToken.AsValue().AsText();
                            if jObject.Get('phoneNumber', jToken) then
                                HMSPatientTbl."Telephone No. 1" := jToken.AsValue().AsText();
                            if jObject.Get('paymentMode', jToken) then
                                HMSPatientTbl."Patient Type" := jToken.AsValue().AsInteger();
                            // TbPatient.Validate("Patient Type");
                            if jObject.Get('nextOfKinRelationship', jToken) then
                                HMSPatientTbl."Next of kin Relationship" := jToken.AsValue().AsText();
                            if jObject.Get('nextOfKinFullName', jToken) then
                                HMSPatientTbl."Next Of kin Full Name" := jToken.AsValue().AsText();
                            if jObject.Get('nextOfKinPhoneNo', jToken) then
                                HMSPatientTbl."Next Of kin Address 1" := jToken.AsValue().AsText();
                            if HMSPatientTbl."Patient Type" = HMSPatientTbl."Patient Type"::Corporate then begin
                                if jObject.Get('insuranceNo', jToken) then
                                    HMSPatientTbl."Insurance No." := jToken.AsValue().AsText();
                                if jObject.Get('insuranceName', jToken) then
                                    HMSPatientTbl."Insurance Name" := jToken.AsValue().AsText();
                                if jObject.Get('insurancePrinicipalMemberName', jToken) then
                                    HMSPatientTbl."Principal Member Name" := jToken.AsValue().AsCode();
                                if jObject.Get('isPrincipleMember', jToken) then begin
                                    HMSPatientTbl.Principal := jToken.AsValue().AsBoolean();
                                    HMSPatientTbl.Validate(Principal);
                                end;
                                if jObject.Get('membershipNo', jToken) then
                                    HMSPatientTbl."Membership No" := jToken.AsValue().AsText();
                                if jObject.Get('schemeName', jToken) then
                                    HMSPatientTbl."Scheme Name" := jToken.AsValue().AsText();
                            end;
                            if jObject.Get('howYouKnewABoutUs', jToken) then
                                HMSPatientTbl."How you Knew About Us" := jToken.AsValue().AsText();
                            if jObject.Get('dependant', jToken) then
                                HMSPatientTbl.Dependant := jToken.AsValue().AsBoolean();
                            if jObject.Get('staffNo', jToken) then
                                HMSPatientTbl."User ID" := FnGetStaffUserID(jToken.AsValue().AsText());
                            if jObject.Get('email', jToken) then begin
                                HMSPatientTbl.Email := jToken.AsValue().AsText();
                            end;
                            if jObject.Get('residence', jToken) then
                                HMSPatientTbl."Place of Birth Village" := jToken.AsValue().AsText();
                            // if jObject.Get('patientStatus', jToken) then begin
                            //     TbPatient."Patient Status" := jToken.AsValue().AsInteger();
                            // end;
                            if HMSPatientTbl.Modify(true) then begin
                                status := 'success';
                                msg := DocNo;
                                returnValue := '{"status":"' + status + '","DocNo":"' + DocNo + '","msg":"' + msg + '"}';
                            end;
                        end;
                    end;
                'delete':
                    begin
                        jObject.Get('patientNo', jToken);
                        DocNo := jToken.AsValue().AsText();
                        HMSPatientTbl.Reset();
                        HMSPatientTbl.SetRange("Patient No.", DocNo);
                        if HMSPatientTbl.FindFirst() then begin
                            if HMSPatientTbl.Delete(true) then begin
                                status := 'success';
                                msg := '';
                                returnValue := '{"status":"' + status + '","DocNo":"' + DocNo + '","msg":"' + msg + '"}';
                            end;
                        end;
                    end;
                else begin
                    status := 'error';
                    msg := 'Invalid action';
                    returnValue := '{"status":"' + status + '","DocNo":"' + DocNo + '","msg":"' + msg + '"}';
                end;
            end;
        end;
    end;
    //
    procedure FnCreateVisit(jString: Text) returnValue: Text
    var
        jObject: JsonObject;//
        jToken: JsonToken;
        myAction: Text;
        status: Text;
        msg: Text;
        NextNo: Code[30];
        NextNo2: Code[30];
        CuNoSeries: Codeunit "No. Series";
        TbHMSSetup: record "HMS Setup";
        patientNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        dispatchArea: Integer;
        dimensions: Text;
        jstring2: Text;
        observationNo: Text;
        TbCust: record Customer;
        DaysBtwnTodayAndLastVisit: Integer;
        ItsNew: Option New,Revisit;
    begin
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        HMSPatientTbl.Reset();
        HMSPatientTbl.SetRange("Patient No.", patientNo);
        if HMSPatientTbl.FindFirst() then begin
            HMSPatientTbl.TestField("Place of Birth Village");
            HMSPatientTbl.TestField("Next Of kin Full Name");
            HMSPatientTbl."Global Dimension 1 Code" := branchCode;
            IF (HMSPatientTbl."Global Dimension 1 Code" = '') THEN
                ERROR('Patient Branch cannot be blank');

            IF (HMSPatientTbl."Date Of Birth" = 0D) THEN
                ERROR('Patient Date of birth cannot be blank');
            //
            if jObject.Get('paymentMode', jToken) then
                HMSPatientTbl."Patient Type" := jToken.AsValue().AsInteger();
            if HMSPatientTbl."Patient Type" = HMSPatientTbl."Patient Type"::Corporate then begin
                if jObject.Get('insuranceNo', jToken) then
                    HMSPatientTbl."Insurance No." := jToken.AsValue().AsText();
                if jObject.Get('insuranceName', jToken) then
                    HMSPatientTbl."Insurance Name" := jToken.AsValue().AsText();
                if jObject.Get('insurancePrinicipalMemberName', jToken) then
                    HMSPatientTbl."Principal Member Name" := jToken.AsValue().AsCode();
                if jObject.Get('isPrincipleMember', jToken) then begin
                    HMSPatientTbl.Principal := jToken.AsValue().AsBoolean();
                    HMSPatientTbl.Validate(Principal);
                end;
                if jObject.Get('membershipNo', jToken) then
                    HMSPatientTbl."Membership No" := jToken.AsValue().AsText();
                if jObject.Get('schemeName', jToken) then
                    HMSPatientTbl."Scheme Name" := jToken.AsValue().AsText();
            end;
            if HMSPatientTbl."Patient Type" = HMSPatientTbl."Patient Type"::Corporate then begin
                if HMSPatientTbl."Insurance No." = '' then ERROR('Please provide patients Insurance No');
                if HMSPatientTbl."Membership No" = '' then ERROR('Please provide patients Insurance Membership Number');
                if TbCust.get(HMSPatientTbl."Insurance No.") then
                    TbCust.TestField(Blocked, 0);
            end;
            TbAppointment.SETRANGE(TbAppointment."Patient No.", HMSPatientTbl."Patient No.");
            TbAppointment.SETRANGE(TbAppointment."Appointment Date", TODAY);
            TbAppointment.SETRANGE(TbAppointment."Patient Type", HMSPatientTbl."Patient Type");
            TbAppointment.SetRange(TbAppointment.Status, TbAppointment.Status::New);
            IF TbAppointment.FindLast() THEN begin
                HMSPatientTbl.Activated := TRUE;
                HMSPatientTbl."Active Visit No" := TbAppointment."Appointment No.";
                HMSPatientTbl.Inpatient := false;
                HMSPatientTbl.Modify();

                returnValue := '{"status":"success","DocNo":"' + TbAppointment."Appointment No." + '"}';
                // ERROR('The patient already has an open visit for today! Go to appointment to dispatch patient');
            end else begin

                // if not TbPatient."Walk-in" then
                //     TbPatient.testfields();

                //Reverse------------
                DaysBtwnTodayAndLastVisit := HMSPatientTbl.isLastVisitDayWithin7days(ItsNew);
                TbHMSSetup.GET;
                TbHMSSetup.TESTFIELD("Appointment Nos");
                NextNo := CuNoSeries.GetNextNo(TbHMSSetup."Appointment Nos", 0D, TRUE);
                HMSPatientTbl.Activated := TRUE;
                HMSPatientTbl."Active Visit No" := NextNo;
                HMSPatientTbl."Age in Years" := DATE2DMY(TODAY, 3) - DATE2DMY(HMSPatientTbl."Date Of Birth", 3);
                HMSPatientTbl.MODIFY;
                //
                TbAppointment.INIT;
                TbAppointment."Appointment No." := NextNo;
                IF HMSPatientTbl."Patient Type" = HMSPatientTbl."Patient Type"::Corporate THEN
                    TbAppointment."Settlement Type" := TbAppointment."Settlement Type"::Insurance;
                IF HMSPatientTbl."Patient Type" = HMSPatientTbl."Patient Type"::Cash THEN
                    TbAppointment."Settlement Type" := TbAppointment."Settlement Type"::Cash;

                TbAppointment."Patient No." := patientNo;
                TbAppointment."Appointment Date" := TODAY;
                TbAppointment."Appointment Time" := TIME;
                IF DaysBtwnTodayAndLastVisit <= 7 THEN
                    // IF TbPatient."Patient Type" = TbPatient."Patient Type"::Corporate THEN
                    TbAppointment."Appointment Type" := 'REVIEW'
                // ELSE
                //     TbAppointment."Appointment Type" := 'REVIEW'
                ELSE
                    TbAppointment."Appointment Type" := 'REVISIT';

                IF HMSPatientTbl."Date Registered" = Today then
                    TbAppointment."Appointment Type" := 'NORMAL';

                TbAppointment."Visit Type" := TbAppointment."Appointment Type";
                TbAppointment."Insurance No" := HMSPatientTbl."Insurance No.";
                TbAppointment.Validate("Insurance No");
                TbAppointment."Insurance Member No" := HMSPatientTbl."Membership No";
                TbAppointment."Patient Type" := HMSPatientTbl."Patient Type";
                TbAppointment.visitType := ItsNew;
                TbAppointment."Age in Years" := HMSPatientTbl."Age in Years";
                TbAppointment.Gender := HMSPatientTbl.Gender;
                TbAppointment."User ID" := FnGetStaffUserID(staffNo);
                TbAppointment.Status := TbAppointment.Status::New;
                TbAppointment.Names := HMSPatientTbl."Search Name";

                IF (TbAppointment.Names = '') THEN
                    TbAppointment.Names := HMSPatientTbl.Surname + '  ' + HMSPatientTbl."Middle Name" + ' ' + HMSPatientTbl."Last Name";
                TbAppointment.SearchNames := HMSPatientTbl.Surname + '  ' + HMSPatientTbl."Middle Name" + ' ' + HMSPatientTbl."Last Name";
                TbAppointment.Branch := HMSPatientTbl."Global Dimension 1 Code";
                jObject.Get('clinic', jToken);
                TbAppointment."Special Clinics" := jToken.AsValue().AsText();
                TbAppointment.Validate("Special Clinics");
                if jObject.Get('doctor', jToken) then begin
                    TbAppointment.Doctor := jToken.AsValue().AsText();
                    TbAppointment.Validate(Doctor);
                end;
                if TbAppointment.INSERT then begin
                    returnValue := '{"status":"success","DocNo":"' + NextNo + '"}';
                end;
            end;
        end else
            Error('Patient no %1 not found.', patientNo);
    end;
    // Appointment Form Header OPerations New Ndirangu
    procedure FnAppointmentFormHeader(jString: Text) returnValue: Text
    var
        AppointmentFormHeader: record "HMS Appointment Form Header";
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        myAction: Text;
        recId: Text;
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        case myAction of
            'edit', 'edit#save':
                begin
                    AppointmentFormHeader.reset();
                    AppointmentFormHeader.setrange(systemId, recId);
                    if AppointmentFormHeader.FindFirst() then begin

                        if jObject.Get('clinic', jToken) then begin
                            AppointmentFormHeader."Special Clinics" := jToken.asValue().AsCode();
                            AppointmentFormHeader.Validate("Special Clinics");
                        end;
                        if jObject.Get('settlementType', jToken) then begin
                            AppointmentFormHeader."Settlement Type" := jToken.asValue().AsInteger();
                            AppointmentFormHeader.Validate("Settlement Type");
                        end;
                        if jObject.Get('doctor', jToken) then begin
                            AppointmentFormHeader.Doctor := jToken.AsValue().AsCode();
                            AppointmentFormHeader.validate(Doctor);
                        end;
                        // Add Insuarance/Corporate Fields
                        if jObject.Get('remarks', jToken) then
                            AppointmentFormHeader.Remarks := CopyStr(jToken.AsValue().AsText(), 1, MaxStrLen(AppointmentFormHeader.Remarks));
                        if jObject.Get('insuranceLOUAmount', jToken) then begin
                            AppointmentFormHeader."Insurance LOU Amount" := jToken.AsValue().AsDecimal();
                            AppointmentFormHeader.Validate("Insurance LOU Amount");
                        end;
                        if jObject.Get('status', jToken) then
                            AppointmentFormHeader.Status := jToken.AsValue().AsInteger();


                        AppointmentFormHeader."User ID" := FnGetStaffUserID(staffNo);

                        if AppointmentFormHeader.Modify(true) then
                            returnValue := '{"status":"success","DocNo":"' + AppointmentFormHeader."Appointment No." + '"}'
                        else
                            returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}';

                    end;
                end;

        end;
    end;

    procedure FnEncounterHeaderTranscribe(jString: Text) returnValue: Text
    var
        AppointmentFormHeader: record "HMS Appointment Form Header";
        HMSSetup: Record "HMS Setup";
        NoSeriesManagement: Codeunit "No. Series";
        AppointmentNo: Code[20];
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        myAction: Text;
        recId: Text;
        status: Text;
        msg: Text;
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    HMSSetup.Get();
                    HMSSetup.TestField("Appointment Nos");
                    AppointmentNo := NoSeriesManagement.GetNextNo(HMSSetup."Appointment Nos", 0D, true);

                    AppointmentFormHeader.Init();
                    AppointmentFormHeader."Appointment No." := AppointmentNo;

                    jObject.Get('patientNo', jToken);
                    AppointmentFormHeader."Patient No." := jToken.AsValue().AsCode();

                    jObject.Get('appointmentDate', jToken);
                    AppointmentFormHeader."Appointment Date" := jToken.AsValue().AsDate();

                    jObject.Get('appointmentType', jToken);
                    AppointmentFormHeader."Appointment Type" := jToken.AsValue().AsCode();

                    jObject.Get('doctor', jToken);
                    AppointmentFormHeader.Doctor := jToken.AsValue().AsCode();

                    jObject.Get('clinic', jToken);
                    AppointmentFormHeader."Special Clinics" := jToken.AsValue().AsCode();

                    jObject.Get('remarks', jToken);
                    AppointmentFormHeader.Remarks := jToken.AsValue().AsCode();

                    AppointmentFormHeader."Transcribed By" := staffNo;
                    AppointmentFormHeader."Transcribed Date" := Today;
                    AppointmentFormHeader."Appointment Time" := Time;
                    AppointmentFormHeader.isTranscription := true;

                    if AppointmentFormHeader.Insert() then
                        returnValue := '{"status":"success","DocNo":"' + AppointmentFormHeader."Appointment No." + '"}'
                    else
                        returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}';

                end;
            'edit', 'edit#save':
                begin
                    AppointmentFormHeader.reset();
                    AppointmentFormHeader.setrange(systemId, recId);
                    if AppointmentFormHeader.FindFirst() then begin

                        jObject.Get('patientNo', jToken);
                        AppointmentFormHeader."Patient No." := jToken.AsValue().AsCode();

                        jObject.Get('appointmentDate', jToken);
                        AppointmentFormHeader."Appointment Date" := jToken.AsValue().AsDate();

                        jObject.Get('appointmentType', jToken);
                        AppointmentFormHeader."Appointment Type" := jToken.AsValue().AsCode();

                        jObject.Get('doctor', jToken);
                        AppointmentFormHeader.Doctor := jToken.AsValue().AsCode();

                        jObject.Get('clinic', jToken);
                        AppointmentFormHeader."Special Clinics" := jToken.AsValue().AsCode();
                        AppointmentFormHeader.Validate("Special Clinics");

                        jObject.Get('branch', jToken);
                        AppointmentFormHeader.Branch := jToken.AsValue().AsCode();

                        jObject.Get('remarks', jToken);
                        AppointmentFormHeader.Remarks := jToken.AsValue().AsCode();

                        AppointmentFormHeader."Transcribed By" := staffNo;

                        AppointmentFormHeader."Transcribed Date" := Today;
                        AppointmentFormHeader."Appointment Time" := Time;
                        AppointmentFormHeader.isTranscription := true;

                        if AppointmentFormHeader.Modify(true) then
                            returnValue := '{"status":"success","DocNo":"' + AppointmentFormHeader."Appointment No." + '"}'
                        else
                            returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}';

                    end;
                end;
            'delete':
                begin
                    AppointmentFormHeader.Reset();
                    AppointmentFormHeader.SetRange(SystemId, recId);
                    if AppointmentFormHeader.FindFirst() then
                        if AppointmentFormHeader.Delete(true) then begin
                            status := 'success';
                            msg := '';
                            returnValue := '{"status":"' + status + '","DocNo":"' + DocNo + '","msg":"' + msg + '"}';
                        end;
                end;

        end;
    end;

    procedure FnDispatchToTriage(jString: Text) returnValue: Text
    var
        jObject: JsonObject;//
        jToken: JsonToken;
        appointmentNo: Code[30];
        staffNo: Code[30];
    begin
        jObject.ReadFrom(jString);
        jObject.Get('appointmentNo', jToken);
        appointmentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbAppointment.Reset();
        TbAppointment.SetRange("Appointment No.", appointmentNo);
        if TbAppointment.FindFirst() then begin
            DocNo := CuHMSProcesses.FnDispatchToTriage(TbAppointment);

            if DocNo <> '' then
                returnValue := '{"status":"success","observationNo":"' + DocNo + '"}'
            else
                Error('Something went wrong while dispatching to client. Kindly ensure the appropriate appointment type setup exists.');
        end;
    end;
    //
    procedure FnTriageDispatchToDoctor(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        observationNo: Code[30];
        staffNo: Code[30];
        TbObsFoHea: record "HMS Observation Form Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('observationNo', jToken);
        observationNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbObsFoHea.Reset();
        TbObsFoHea.SetRange(TbObsFoHea."Observation No.", observationNo);
        if TbObsFoHea.FindFirst() then begin
            if jObject.Get('urgencyStatus', jToken) then
                TbObsFoHea."Urgency Status" := jToken.AsValue().AsInteger();
            if jObject.Get('tcaStatusRemarks', jToken) then
                TbObsFoHea."TCA Status Remarks" := jToken.AsValue().AsText();
            if jObject.Get('observationRemarks', jToken) then
                TbObsFoHea."Observation Remarks" := jToken.AsValue().AsText();
            TbObsFoHea.Modify();
            Commit();
            if CuHMSProcesses.FnDispatchToDoctor(TbObsFoHea) then
                returnValue := '{"status":"success","treatmentNo":"' + DocNo + '"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnPatientVitals(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        observationNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbObsFoHea: record "HMS Observation Form Header";
        TbObsFoLi: record "HMS Observation Form Line Proc";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('observationNo', jToken);
        observationNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbObsFoLi.Init();
                    TbObsFoLi."Observation No." := observationNo;
                    jObject.Get('type', jToken);
                    TbObsFoLi.Type := jToken.AsValue().AsInteger();
                    jObject.Get('patientNo', jToken);
                    TbObsFoLi."Patient No." := jToken.AsValue().AsCode();
                    TbObsFoLi.Validate("Patient No.");
                    jObject.Get('pulseRate', jToken);
                    TbObsFoLi."Pulse Rate" := jToken.AsValue().AsCode();
                    jObject.Get('pain', jToken);
                    TbObsFoLi.Pain := jToken.AsValue().AsDecimal();
                    jObject.Get('systolicBp', jToken);
                    TbObsFoLi."Systolic BP" := jToken.AsValue().AsDecimal();
                    jObject.Get('diastolicBp', jToken);
                    TbObsFoLi."Diastolic Bp" := jToken.AsValue().AsDecimal();
                    jObject.Get('temperature', jToken);
                    TbObsFoLi.Temperature := jToken.AsValue().AsDecimal();
                    jObject.Get('height', jToken);
                    TbObsFoLi.Height := jToken.AsValue().AsDecimal();
                    jObject.Get('weight', jToken);
                    TbObsFoLi.Weight := jToken.AsValue().AsDecimal();
                    TbObsFoLi.Validate(Weight);
                    jObject.Get('SP02', jToken);
                    TbObsFoLi.SP02 := jToken.AsValue().AsText();
                    jObject.Get('respirationRate', jToken);
                    TbObsFoLi."Respiration Rate" := jToken.AsValue().AsText();
                    TbObsFoLi."Date Created" := CurrentDateTime;
                    TbObsFoLi."Date Taken" := Today;
                    TbObsFoLi.Time := Time;
                    if TbObsFoLi.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbObsFoLi.Reset();
                    TbObsFoLi.SetRange(TbObsFoLi."Observation No.", observationNo);
                    jObject.Get('lineNo', jToken);
                    TbObsFoLi.SetRange(TbObsFoLi."Line No", jToken.AsValue().AsInteger());
                    if TbObsFoLi.FindFirst() then begin
                        jObject.Get('type', jToken);
                        TbObsFoLi.Type := jToken.AsValue().AsInteger();
                        jObject.Get('patientNo', jToken);
                        TbObsFoLi."Patient No." := jToken.AsValue().AsCode();
                        TbObsFoLi.Validate("Patient No.");
                        jObject.Get('pulseRate', jToken);
                        TbObsFoLi."Pulse Rate" := jToken.AsValue().AsCode();
                        jObject.Get('pain', jToken);
                        TbObsFoLi.Pain := jToken.AsValue().AsDecimal();
                        jObject.Get('systolicBp', jToken);
                        TbObsFoLi."Systolic BP" := jToken.AsValue().AsDecimal();
                        jObject.Get('diastolicBp', jToken);
                        TbObsFoLi."Diastolic Bp" := jToken.AsValue().AsDecimal();
                        jObject.Get('temperature', jToken);
                        TbObsFoLi.Temperature := jToken.AsValue().AsDecimal();
                        jObject.Get('height', jToken);
                        TbObsFoLi.Height := jToken.AsValue().AsDecimal();
                        jObject.Get('weight', jToken);
                        TbObsFoLi.Weight := jToken.AsValue().AsDecimal();
                        TbObsFoLi.Validate(Weight);
                        jObject.Get('SP02', jToken);
                        TbObsFoLi.SP02 := jToken.AsValue().AsText();
                        jObject.Get('respirationRate', jToken);
                        TbObsFoLi."Respiration Rate" := jToken.AsValue().AsText();
                        TbObsFoLi."Date Created" := CurrentDateTime;
                        TbObsFoLi."Date Taken" := Today;
                        TbObsFoLi.Time := Time;
                        if TbObsFoLi.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbObsFoLi.Reset();
                    TbObsFoLi.SetRange(TbObsFoLi."Observation No.", observationNo);
                    jObject.Get('lineNo', jToken);
                    TbObsFoLi.SetRange(TbObsFoLi."Line No", jToken.AsValue().AsInteger());
                    if TbObsFoLi.FindFirst() then begin
                        if TbObsFoLi.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end
            else begin
                returnValue := '{"status":"error","msg":"Invalid Action"}';
            end;

        end;
    end;

    procedure FnTriageAlergiesMedication(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        observationNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbAllMed: record "Tr Allergy and Medication form";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('observationNo', jToken);
        observationNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbAllMed.Init();
                    TbAllMed."Observation No." := observationNo;
                    jObject.Get('complaints', jToken);
                    TbAllMed.Complaints := jToken.AsValue().AsText();
                    jObject.Get('foodAllergy', jToken);
                    TbAllMed."Food Allergy" := jToken.AsValue().AsText();
                    jObject.Get('drugAllergy', jToken);
                    TbAllMed."Drug Allergy" := jToken.AsValue().AsText();
                    jObject.Get('allergen', jToken);
                    TbAllMed.Allergen := jToken.AsValue().AsText();
                    jObject.Get('assessedBy', jToken);
                    TbAllMed."Assessed By" := jToken.AsValue().AsText();
                    if jObject.Get('type', jToken) then
                        TbAllMed.Type := jToken.AsValue().AsInteger();
                    if TbAllMed.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbAllMed.Reset();
                    TbAllMed.SetRange(TbAllMed."Observation No.", observationNo);
                    if TbAllMed.FindFirst() then begin
                        jObject.Get('complaints', jToken);
                        TbAllMed.Complaints := jToken.AsValue().AsText();
                        jObject.Get('foodAllergy', jToken);
                        TbAllMed."Food Allergy" := jToken.AsValue().AsText();
                        jObject.Get('drugAllergy', jToken);
                        TbAllMed."Drug Allergy" := jToken.AsValue().AsText();
                        jObject.Get('allergen', jToken);
                        TbAllMed.Allergen := jToken.AsValue().AsText();
                        jObject.Get('assessedBy', jToken);
                        TbAllMed."Assessed By" := jToken.AsValue().AsText();
                        if jObject.Get('type', jToken) then
                            TbAllMed.Type := jToken.AsValue().AsInteger();
                        if TbAllMed.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbAllMed.Reset();
                    TbAllMed.SetRange(TbAllMed."Observation No.", observationNo);
                    if TbAllMed.FindFirst() then begin
                        if TbAllMed.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnTriageInjections(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        observationNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbInje: record "HMS Observation Form Injection";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('observationNo', jToken);
        observationNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbInje.Init();
                    TbInje."Observation No." := observationNo;
                    jObject.Get('injectionNo', jToken);
                    TbInje."Injection No." := jToken.AsValue().AsText();
                    jObject.Get('quantity', jToken);
                    TbInje.Quantity := jToken.AsValue().AsDecimal();
                    jObject.Get('injectionDate', jToken);
                    TbInje."Injection Date" := jToken.AsValue().AsDate();
                    jObject.Get('injectionTime', jToken);
                    TbInje."Injection Time" := jToken.AsValue().AsTime();
                    jObject.Get('injectionRemarks', jToken);
                    TbInje."Injection Remarks" := jToken.AsValue().AsText();
                    jObject.Get('posted', jToken);
                    TbInje.Posted := jToken.AsValue().AsBoolean();
                    if TbInje.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbInje.Reset();
                    TbInje.SetRange(TbInje."Observation No.", observationNo);
                    jObject.Get('injectionNo', jToken);
                    TbInje.SetRange(TbInje."Injection No.", jToken.AsValue().AsText());
                    if TbInje.FindFirst() then begin
                        jObject.Get('injectionNo', jToken);
                        TbInje."Injection No." := jToken.AsValue().AsText();
                        jObject.Get('quantity', jToken);
                        TbInje.Quantity := jToken.AsValue().AsDecimal();
                        jObject.Get('injectionDate', jToken);
                        TbInje."Injection Date" := jToken.AsValue().AsDate();
                        jObject.Get('injectionTime', jToken);
                        TbInje."Injection Time" := jToken.AsValue().AsTime();
                        jObject.Get('injectionRemarks', jToken);
                        TbInje."Injection Remarks" := jToken.AsValue().AsText();
                        jObject.Get('posted', jToken);
                        TbInje.Posted := jToken.AsValue().AsBoolean();
                        if TbInje.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbInje.Reset();
                    TbInje.SetRange(TbInje."Observation No.", observationNo);
                    jObject.Get('injectionNo', jToken);
                    TbInje.SetRange(TbInje."Injection No.", jToken.AsValue().AsText());
                    if TbInje.FindFirst() then begin
                        if TbInje.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnTriageDressings(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        observationNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbDress: record "HMS Observation Dressings";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('observationNo', jToken);
        observationNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbDress.Init();
                    TbDress."Observation No." := observationNo;
                    jObject.Get('processNo', jToken);
                    TbDress."Process No." := jToken.AsValue().AsText();
                    jObject.Get('itemNo', jToken);
                    TbDress."Item No." := jToken.AsValue().AsText();
                    jObject.Get('unitOfMeasure', jToken);
                    TbDress."Unit of Measure" := jToken.AsValue().AsText();
                    jObject.Get('quantity', jToken);
                    TbDress.Quantity := jToken.AsValue().AsDecimal();
                    jObject.Get('remarks', jToken);
                    TbDress.Remarks := jToken.AsValue().AsText();
                    if TbDress.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbDress.Reset();
                    TbDress.SetRange(TbDress."Observation No.", observationNo);
                    jObject.Get('processNo', jToken);
                    TbDress.SetRange(TbDress."Process No.", jToken.AsValue().AsText());
                    if TbDress.FindFirst() then begin
                        TbDress."Observation No." := observationNo;
                        jObject.Get('processNo', jToken);
                        TbDress."Process No." := jToken.AsValue().AsText();
                        jObject.Get('itemNo', jToken);
                        TbDress."Item No." := jToken.AsValue().AsText();
                        jObject.Get('unitOfMeasure', jToken);
                        TbDress."Unit of Measure" := jToken.AsValue().AsText();
                        jObject.Get('quantity', jToken);
                        TbDress.Quantity := jToken.AsValue().AsDecimal();
                        jObject.Get('remarks', jToken);
                        TbDress.Remarks := jToken.AsValue().AsText();
                        if TbDress.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbDress.Reset();
                    TbDress.SetRange(TbDress."Observation No.", observationNo);
                    jObject.Get('processNo', jToken);
                    TbDress.SetRange(TbDress."Process No.", jToken.AsValue().AsText());
                    if TbDress.FindFirst() then begin
                        if TbDress.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnTriageCheckinPatient(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        observationNo: Code[30];
        staffNo: Code[30];
        TbObse: record "HMS Observation Form Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('observationNo', jToken);
        observationNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbObse.Reset();
        TbObse.SetRange(TbObse."Observation No.", observationNo);
        if TbObse.FindFirst() then begin
            TbObse.Status := TbObse.Status::Pending;
            if TbObse.Modify(true) then
                returnValue := '{"status":"success","patientNo":"' + DocNo + '"}'
            else
                returnValue := ErrorSthWrong;
        end;
    end;



    /**
        DOCTORS PROCESSES
    */
    procedure FnDoctorPatientSigns(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbSigns: record "HMS Observation Signs";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbSigns.Init();
                    TbSigns."Treatment No." := treatmentNo;
                    jObject.Get('system', jToken);
                    TbSigns.System := jToken.AsValue().AsText();
                    jObject.Get('signNo', jToken);
                    TbSigns."Sign Code" := jToken.AsValue().AsText();
                    TbSigns.Validate("Sign Code");
                    jObject.Get('description', jToken);
                    TbSigns."Sign Description" := jToken.AsValue().AsText();
                    if TbSigns.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbSigns.Reset();
                    TbSigns.SetRange(TbSigns."Treatment No.", treatmentNo);
                    jObject.Get('system', jToken);
                    TbSigns.SetRange(TbSigns.System, jToken.AsValue().AsText());
                    if TbSigns.FindFirst() then begin
                        jObject.Get('system', jToken);
                        TbSigns.System := jToken.AsValue().AsText();
                        jObject.Get('signNo', jToken);
                        TbSigns."Sign Code" := jToken.AsValue().AsText();
                        TbSigns.Validate("Sign Code");
                        jObject.Get('description', jToken);
                        TbSigns."Sign Description" := jToken.AsValue().AsText();
                        if TbSigns.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbSigns.Reset();
                    TbSigns.SetRange(TbSigns."Treatment No.", treatmentNo);
                    jObject.Get('system', jToken);
                    TbSigns.SetRange(TbSigns.System, jToken.AsValue().AsText());
                    if TbSigns.FindFirst() then begin
                        if TbSigns.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnDoctorPatientSymptoms(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbSymptoms: record "HMS Observation Symptoms";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbSymptoms.Init();
                    TbSymptoms."Treatment No." := treatmentNo;
                    jObject.Get('symptomCode', jToken);
                    TbSymptoms."Symptom Code" := jToken.AsValue().AsText();
                    TbSymptoms.Validate("Symptom Code");
                    jObject.Get('system', jToken);
                    TbSymptoms.System := jToken.AsValue().AsText();
                    jObject.Get('duration', jToken);
                    TbSymptoms.Duration := jToken.AsValue().AsText();
                    jObject.Get('description', jToken);
                    TbSymptoms.Description := jToken.AsValue().AsText();
                    jObject.Get('characteristics', jToken);
                    TbSymptoms.Characteristics := jToken.AsValue().AsText();
                    if TbSymptoms.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbSymptoms.Reset();
                    TbSymptoms.SetRange(TbSymptoms."Treatment No.", treatmentNo);
                    jObject.Get('symptomCode', jToken);
                    TbSymptoms.SetRange(TbSymptoms."Symptom Code", jToken.AsValue().AsText());
                    if TbSymptoms.FindFirst() then begin
                        jObject.Get('symptomCode', jToken);
                        TbSymptoms."Symptom Code" := jToken.AsValue().AsText();
                        TbSymptoms.Validate("Symptom Code");
                        jObject.Get('system', jToken);
                        TbSymptoms.System := jToken.AsValue().AsText();
                        jObject.Get('duration', jToken);
                        TbSymptoms.Duration := jToken.AsValue().AsText();
                        jObject.Get('description', jToken);
                        TbSymptoms.Description := jToken.AsValue().AsText();
                        jObject.Get('characteristics', jToken);
                        TbSymptoms.Characteristics := jToken.AsValue().AsText();
                        if TbSymptoms.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbSymptoms.Reset();
                    TbSymptoms.SetRange(TbSymptoms."Treatment No.", treatmentNo);
                    jObject.Get('symptomCode', jToken);
                    TbSymptoms.SetRange(TbSymptoms."Symptom Code", jToken.AsValue().AsText());
                    if TbSymptoms.FindFirst() then begin
                        if TbSymptoms.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnDoctorPatientLaboratory(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbLab: record "HMS Treatment Form Laboratory";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbLab.Init();
                    TbLab."Treatment No." := treatmentNo;
                    jObject.Get('testPackageCode', jToken);
                    TbLab."Laboratory Test Package Code" := jToken.AsValue().AsText();
                    TbLab.Validate("Laboratory Test Package Code");
                    TbLab."Date Due" := Today;
                    TbLab.Time := Time;
                    jObject.Get('results', jToken);
                    TbLab.Results := jToken.AsValue().AsText();
                    if jObject.Get('description', jToken) then
                        TbLab."Brief History" := jToken.AsValue().AsText();
                    if TbLab.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbLab.Reset();
                    TbLab.SetRange(TbLab."Treatment No.", treatmentNo);
                    jObject.Get('lineNo', jToken);
                    TbLab.SetRange(TbLab."Line No", jToken.AsValue().AsInteger());
                    if TbLab.FindFirst() then begin
                        jObject.Get('testPackageCode', jToken);
                        TbLab."Laboratory Test Package Code" := jToken.AsValue().AsText();
                        TbLab.Validate("Laboratory Test Package Code");
                        jObject.Get('dueDate', jToken);
                        TbLab."Date Due" := Today;
                        jObject.Get('results', jToken);
                        TbLab.Results := jToken.AsValue().AsText();
                        if jObject.Get('description', jToken) then
                            TbLab."Brief History" := jToken.AsValue().AsText();
                        if TbLab.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbLab.Reset();
                    TbLab.SetRange(TbLab."Treatment No.", treatmentNo);
                    jObject.Get('lineNo', jToken);
                    TbLab.SetRange(TbLab."Line No", jToken.AsValue().AsInteger());
                    if TbLab.FindFirst() then begin
                        if TbLab.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnDoctorRequestPatientLaboratoryTests(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        TbTreForm: record "HMS Treatment Form Laboratory";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbTreForm.Reset();
        TbTreForm.SetRange(TbTreForm."Treatment No.", treatmentNo);
        if TbTreForm.FindFirst() then begin
            DocNo := CuHMSProcesses.RequestLaboratoryTests(TbTreForm);
            if DocNo <> '' then
                returnValue := '{"status":"success","laboratoryNo":"' + DocNo + '"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnDoctorPatientRadiology(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbRadi: record "HMS Treatment Form Radiology";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbRadi.Init();
                    TbRadi."Treatment No." := treatmentNo;
                    jObject.Get('radiologyCode', jToken);
                    TbRadi."Radiology Type Code" := jToken.AsValue().AsText();
                    // TbRadi."Radiology Type Code" := 'RAD265';
                    TbRadi.Validate("Radiology Type Code");
                    jObject.Get('dueDate', jToken);
                    TbRadi."Date Due" := jToken.AsValue().AsDate();
                    if jObject.Get('requiredInvestigation', jToken) then
                        TbRadi."Required Investigation" := jToken.AsValue().AsText();
                    if TbRadi.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbRadi.Reset();
                    TbRadi.SetRange(TbRadi."Treatment No.", treatmentNo);
                    jObject.Get('radiologyCode', jToken);
                    TbRadi.SetRange(TbRadi."Radiology Type Code", jToken.AsValue().AsText());
                    if TbRadi.FindFirst() then begin
                        jObject.Get('dueDate', jToken);
                        TbRadi."Date Due" := jToken.AsValue().AsDate();
                        if jObject.Get('requiredInvestigation', jToken) then
                            TbRadi."Required Investigation" := jToken.AsValue().AsText();
                        if TbRadi.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRadi.Reset();
                    TbRadi.SetRange(TbRadi."Treatment No.", treatmentNo);
                    jObject.Get('radiologyCode', jToken);
                    TbRadi.SetRange(TbRadi."Radiology Type Code", jToken.AsValue().AsText());
                    if TbRadi.FindFirst() then begin
                        if TbRadi.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnDoctorRequestPatientRadiologyTests(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        TbRad: record "HMS Treatment Form Radiology";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbRad.Reset();
        TbRad.SetRange(TbRad."Treatment No.", treatmentNo);
        if TbRad.FindFirst() then begin
            DocNo := CuHMSProcesses.FnRequestRadiologyTests(TbRad);
            if DocNo <> '' then
                returnValue := '{"status":"success","radiologyNo":"' + DocNo + '"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnDoctorPatientDiagnosis(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbDiag: record "HMS Treatment Form Diagnosis";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbDiag.Init();
                    TbDiag."Treatment No." := treatmentNo;
                    jObject.Get('diagnosisType', jToken);
                    TbDiag."Diagnosis Type" := jToken.AsValue().AsInteger();
                    jObject.Get('diagnosisNo', jToken);
                    TbDiag."Diagnosis No." := jToken.AsValue().AsText();
                    TbDiag.Validate("Diagnosis No.");
                    jObject.Get('confirmed', jToken);
                    TbDiag.Confirmed := jToken.AsValue().AsBoolean();
                    if jObject.Get('remarks', jToken) then
                        TbDiag.Remarks := jToken.AsValue().AsText();
                    if TbDiag.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbDiag.Reset();
                    TbDiag.SetRange(TbDiag."Treatment No.", treatmentNo);
                    jObject.Get('diagnosisNo', jToken);
                    TbDiag.SetRange(TbDiag."Diagnosis No.", jToken.AsValue().AsText());
                    if TbDiag.FindFirst() then begin
                        jObject.Get('diagnosisType', jToken);
                        TbDiag."Diagnosis Type" := jToken.AsValue().AsInteger();
                        jObject.Get('diagnosisNo', jToken);
                        TbDiag."Diagnosis No." := jToken.AsValue().AsText();
                        TbDiag.Validate("Diagnosis No.");
                        jObject.Get('confirmed', jToken);
                        TbDiag.Confirmed := jToken.AsValue().AsBoolean();
                        if jObject.Get('remarks', jToken) then
                            TbDiag.Remarks := jToken.AsValue().AsText();
                        if TbDiag.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbDiag.Reset();
                    TbDiag.SetRange(TbDiag."Treatment No.", treatmentNo);
                    jObject.Get('diagnosisNo', jToken);
                    TbDiag.SetRange(TbDiag."Diagnosis No.", jToken.AsValue().AsText());
                    if TbDiag.FindFirst() then begin
                        if TbDiag.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnDoctorPatientInjections(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbInj: record "HMS Treatment Form Injection";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbInj.Init();
                    TbInj."Treatment No." := treatmentNo;
                    jObject.Get('injectionNo', jToken);
                    TbInj."Injection No." := jToken.AsValue().AsText();
                    TbInj.Validate("Injection No.");
                    TbInj.Validate("Item No.");
                    jObject.Get('location', jToken);
                    TbInj.Location := jToken.AsValue().AsText();
                    jObject.Get('injectionGiven', jToken);
                    TbInj."Injection Given" := jToken.AsValue().AsBoolean();
                    jObject.Get('injectionUnitOfMeasure', jToken);
                    TbInj."Injection Unit of Measure" := jToken.AsValue().AsText();
                    jObject.Get('injectionQuantity', jToken);
                    TbInj."Injection Quantity" := jToken.AsValue().AsDecimal();
                    jObject.Get('duration', jToken);
                    TbInj.Duration := jToken.AsValue().AsText();
                    if jObject.Get('remarks', jToken) then
                        TbInj."Injection Remarks" := jToken.AsValue().AsText();
                    if TbInj.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbInj.Reset();
                    TbInj.SetRange(TbInj."Treatment No.", treatmentNo);
                    jObject.Get('injectionNo', jToken);
                    TbInj.SetRange(TbInj."Injection No.", jToken.AsValue().AsText());
                    jObject.Get('itemNo', jToken);
                    TbInj.SetRange(TbInj."Item No.", jToken.AsValue().AsText());
                    if TbInj.FindFirst() then begin
                        jObject.Get('location', jToken);
                        TbInj.Location := jToken.AsValue().AsText();
                        jObject.Get('injectionGiven', jToken);
                        TbInj."Injection Given" := jToken.AsValue().AsBoolean();
                        jObject.Get('injectionUnitOfMeasure', jToken);
                        TbInj."Injection Unit of Measure" := jToken.AsValue().AsText();
                        jObject.Get('injectionQuantity', jToken);
                        TbInj."Injection Quantity" := jToken.AsValue().AsDecimal();
                        jObject.Get('duration', jToken);
                        TbInj.Duration := jToken.AsValue().AsText();
                        if jObject.Get('remarks', jToken) then
                            TbInj."Injection Remarks" := jToken.AsValue().AsText();
                        if TbInj.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbInj.Reset();
                    TbInj.SetRange(TbInj."Treatment No.", treatmentNo);
                    jObject.Get('injectionNo', jToken);
                    TbInj.SetRange(TbInj."Injection No.", jToken.AsValue().AsText());
                    jObject.Get('itemNo', jToken);
                    TbInj.SetRange(TbInj."Item No.", jToken.AsValue().AsText());
                    if TbInj.FindFirst() then begin
                        if TbInj.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnDoctorPostPatientInjectionItems(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        TbInj: record "HMS Treatment Form Injection";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbInj.Reset();
        TbInj.SetRange(TbInj."Treatment No.", treatmentNo);
        if TbInj.FindFirst() then begin
            DocNo := CuHMSProcesses.FnPostInjectionItemsUsage(TbInj);
            if DocNo <> '' then
                returnValue := '{"status":"success","pharmacyNo":"' + DocNo + '"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnDoctorPatientPrescriptions(jString: Text) returnValue: Text
    var
        TbDrug: record "HMS Treatment Form Drug";
        HMSTreatmentFormDrug: Record "HMS Treatment Form Drug";
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        DrugNo: Code[30];
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        jObject.Get('drugNo', jToken);
        DrugNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    HMSTreatmentFormDrug.Reset();
                    HMSTreatmentFormDrug.SetRange("Treatment No.", treatmentNo);
                    HMSTreatmentFormDrug.SetRange("Drug No.", DrugNo);
                    HMSTreatmentFormDrug.SetRange(Status, HMSTreatmentFormDrug.Status::Forwarded);
                    if HMSTreatmentFormDrug.IsEmpty() then begin
                        TbDrug.Init();
                        TbDrug."Treatment No." := treatmentNo;
                        TbDrug."Drug No." := DrugNo;
                        DrugNo := TbDrug."Drug No.";
                        TbDrug.Validate("Drug No.");
                        jObject.Get('quantity', jToken);
                        TbDrug.Quantity := jToken.AsValue().AsInteger();
                        jObject.Get('remarks', jToken);
                        TbDrug.Remarks := jToken.AsValue().AsText();
                        jObject.Get('prescriptionDose', jToken);
                        TbDrug."Prescription Dose" := jToken.AsValue().AsInteger();
                        jObject.Get('duration', jToken);
                        TbDrug."Number of Days" := jToken.AsValue().AsInteger();
                        if TbDrug.Insert(true) then
                            returnValue := '{"status":"success"}'
                    end else
                        returnValue := '{"status":"Already Exists"}';
                end;
            'edit', 'edit#save':
                begin
                    TbDrug.Reset();
                    TbDrug.SetRange(TbDrug."Treatment No.", treatmentNo);
                    jObject.Get('lineNo', jToken);
                    TbDrug.SetRange(TbDrug."Lline No", jToken.AsValue().AsInteger());
                    if TbDrug.FindFirst() then begin
                        jObject.Get('drugNo', jToken);
                        TbDrug."Drug No." := jToken.AsValue().AsText();
                        TbDrug.Validate("Drug No.");
                        jObject.Get('quantity', jToken);
                        TbDrug.Quantity := jToken.AsValue().AsInteger();
                        jObject.Get('remarks', jToken);
                        TbDrug.Remarks := jToken.AsValue().AsText();
                        jObject.Get('prescriptionDose', jToken);
                        TbDrug."Prescription Dose" := jToken.AsValue().AsInteger();
                        jObject.Get('duration', jToken);
                        TbDrug."Number of Days" := jToken.AsValue().AsInteger();
                        if TbDrug.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbDrug.Reset();
                    TbDrug.SetRange(TbDrug."Treatment No.", treatmentNo);
                    jObject.Get('lineNo', jToken);
                    TbDrug.SetRange(TbDrug."Lline No", jToken.AsValue().AsInteger());
                    if TbDrug.FindFirst() then begin
                        if TbDrug.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnDoctorPrescribeDrugs(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        TbDrug: record "HMS Treatment Form Drug";
    begin
        returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}';

        jObject.ReadFrom(jString);
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbDrug.Reset();
        TbDrug.SetRange(TbDrug."Treatment No.", treatmentNo);
        TbDrug.SetRange(TbDrug.Status, TbDrug.Status::New);
        if TbDrug.FindFirst() then begin
            DocNo := CuHMSProcesses.FnPrescribeDrugs(TbDrug);
            if DocNo <> '' then
                returnValue := '{"status":"success","pharmacyNo":"' + DocNo + '"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnDoctorPatientAdmission(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbAdm: record "HMS Treatment Admission";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbAdm.Reset();
                    TbAdm.SetRange(TbAdm."Treatment No.", treatmentNo);
                    if TbAdm.FindFirst() then
                        Error('An admission for this patient has already been initiated. Kindly edit existing record or use request admission action.');
                    TbAdm.Reset();
                    TbAdm.Init();
                    TbAdm."Treatment No." := treatmentNo;
                    jObject.Get('dateOfAdmission', jToken);
                    TbAdm."Date Of Admission" := jToken.AsValue().AsDate();
                    jObject.Get('admissionReason', jToken);
                    TbAdm."Admission Reason" := jToken.AsValue().AsText();
                    if jObject.Get('admissionRemarks', jToken) then
                        TbAdm."Admission Remarks" := jToken.AsValue().AsText();
                    if TbAdm.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbAdm.Reset();
                    TbAdm.SetRange(TbAdm."Treatment No.", treatmentNo);
                    if TbAdm.FindFirst() then begin
                        jObject.Get('dateOfAdmission', jToken);
                        TbAdm."Date Of Admission" := jToken.AsValue().AsDate();
                        jObject.Get('admissionReason', jToken);
                        TbAdm."Admission Reason" := jToken.AsValue().AsText();
                        if jObject.Get('admissionRemarks', jToken) then
                            TbAdm."Admission Remarks" := jToken.AsValue().AsText();
                        if TbAdm.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbAdm.Reset();
                    TbAdm.SetRange(TbAdm."Treatment No.", treatmentNo);
                    if TbAdm.FindFirst() then begin
                        if TbAdm.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            else
                Error(ErrorInvalidAction);
        end;
    end;

    procedure FnDoctorRequestPatientAdmission(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        TbAdm: record "HMS Treatment Admission";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbAdm.Reset();
        TbAdm.SetRange(TbAdm."Treatment No.", treatmentNo);
        if TbAdm.FindFirst() then begin
            DocNo := CuHMSProcesses.FnRequestPatientAdmission(TbAdm);
            if DocNo <> '' then
                returnValue := '{"status":"success","admissionNo":"' + DocNo + '"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnDoctorPatientReferral(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbRef: record "HMS Treatment Referral";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        case myAction of
            'create', 'create#save':
                begin
                    TbRef.Init();
                    TbRef."Treatment No." := treatmentNo;
                    jObject.Get('dateReferred', jToken);
                    TbRef."Date Referred" := jToken.AsValue().AsDate();
                    jObject.Get('hospitalNo', jToken);
                    TbRef."Hospital No." := jToken.AsValue().AsText();
                    TbRef.validate("Hospital No.");
                    jObject.Get('referralReason', jToken);
                    TbRef."Referral Reason" := jToken.AsValue().AsText();
                    jObject.Get('referralRemarks', jToken);
                    TbRef."Referral Remarks" := jToken.AsValue().AsText();
                    if TbRef.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbRef.Reset();
                    TbRef.SetRange(TbRef."Treatment No.", treatmentNo);
                    if TbRef.FindFirst() then begin
                        jObject.Get('dateReferred', jToken);
                        TbRef."Date Referred" := jToken.AsValue().AsDate();
                        jObject.Get('hospitalNo', jToken);
                        TbRef."Hospital No." := jToken.AsValue().AsText();
                        TbRef.validate("Hospital No.");
                        jObject.Get('referralReason', jToken);
                        TbRef."Referral Reason" := jToken.AsValue().AsText();
                        jObject.Get('referralRemarks', jToken);
                        TbRef."Referral Remarks" := jToken.AsValue().AsText();
                        if TbRef.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRef.Reset();
                    TbRef.SetRange(TbRef."Treatment No.", treatmentNo);
                    if TbRef.FindFirst() then begin
                        if TbRef.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnDoctorRequestPatientReferral(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        TbRef: record "HMS Treatment Referral";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbRef.Reset();
        TbRef.SetRange(TbRef."Treatment No.", treatmentNo);
        if TbRef.FindFirst() then begin
            DocNo := CuHMSProcesses.FnRegisterReferral(TbRef);
            if DocNo <> '' then
                returnValue := '{"status":"success","treatmentNo":"' + DocNo + '"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;
    //
    procedure FnDoctorTreatmentNotes(jString: Text) returnValue: Text
    var
        TbHMSNotes: record "HMS Notes";
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        treatmentNo: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbHMSNotes.Init();
                    TbHMSNotes.TreatmentNo := treatmentNo;
                    TbHMSNotes."User ID" := FnGetStaffUserID(staffNo);
                    TbHMSNotes."Created Date" := Today;
                    TbHMSNotes."Creation DateTime" := CurrentDateTime;
                    jObject.Get('patientNo', jToken);
                    TbHMSNotes."Patient No" := jToken.AsValue().AsText();
                    TbHMSNotes.Validate("Patient No");
                    jObject.Get('notes', jToken);
                    TbHMSNotes.Notes := jToken.AsValue().AsText();
                    // jObject.Get('SectionId', jToken);
                    // TbHMSNotes."Notes Section ID" := jToken.AsValue().AsCode();
                    jObject.Get('notesType', jToken);
                    TbHMSNotes."Notes Type" := jToken.AsValue().AsInteger();
                    if TbHMSNotes.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbHMSNotes.Reset();
                    TbHMSNotes.SetRange(TbHMSNotes.SystemId, recId);
                    if TbHMSNotes.FindFirst() then begin
                        TbHMSNotes.TreatmentNo := treatmentNo;
                        TbHMSNotes."User ID" := FnGetStaffUserID(staffNo);
                        TbHMSNotes."Created Date" := Today;
                        TbHMSNotes."Creation DateTime" := CurrentDateTime;
                        jObject.Get('patientNo', jToken);
                        TbHMSNotes."Patient No" := jToken.AsValue().AsText();
                        TbHMSNotes.Validate("Patient No");
                        jObject.Get('notes', jToken);
                        TbHMSNotes.Notes := jToken.AsValue().AsText();
                        jObject.Get('notesType', jToken);
                        TbHMSNotes."Notes Type" := jToken.AsValue().AsInteger();
                        // jObject.Get('SectionId', jToken);
                        // TbHMSNotes."Notes Section ID" := jToken.AsValue().AsCode();
                        if TbHMSNotes.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbHMSNotes.Reset();
                    TbHMSNotes.SetRange(TbHMSNotes.SystemId, recId);
                    if TbHMSNotes.FindFirst() then begin
                        if TbHMSNotes.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    //SickSheet Ndirangu new
    procedure FnDoctorSickSHeet(jString: Text) returnValue: Text
    var
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Text;
        inPatient: boolean;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        if jObject.Get('documentNo', jToken) then
            documentNo := jToken.AsValue().AsText();
        jObject.Get('inPatient', jToken);
        inPatient := jToken.AsValue().AsBoolean();
        if inPatient then begin
            HMSAdmissionFormHeader.Reset();
            HMSAdmissionFormHeader.SetRange("Admission No.", documentNo);
            if HMSAdmissionFormHeader.FindFirst() then begin
                jObject.Get('OffDutyDays', jToken);
                HMSAdmissionFormHeader."Off Duty Days" := jToken.AsValue().AsDecimal();
                jObject.Get('StartDate', jToken);
                HMSAdmissionFormHeader."Sick Off Start Date" := jToken.AsValue().AsDate();
                jObject.Get('OffDutyComments', jToken);
                HMSAdmissionFormHeader."Off Duty Comments" := jToken.AsValue().AsText();
                HMSAdmissionFormHeader."Off Duty" := true;
                if HMSAdmissionFormHeader.Modify() then
                    returnValue := '{"status":"success"}';
            end;
        end else begin
            HMSTreatmentFormHeader.Reset();
            HMSTreatmentFormHeader.SetRange("Treatment No.", documentNo);
            if HMSTreatmentFormHeader.FindFirst() then begin
                jObject.Get('OffDutyDays', jToken);
                HMSTreatmentFormHeader."Off Duty Days" := jToken.AsValue().AsDecimal();
                jObject.Get('StartDate', jToken);
                HMSTreatmentFormHeader."Sick Off Start Date" := jToken.AsValue().AsDate();
                jObject.Get('OffDutyComments', jToken);
                HMSTreatmentFormHeader."Off Duty Comments" := jToken.AsValue().AsText();
                HMSTreatmentFormHeader."Off Duty" := true;
                if HMSTreatmentFormHeader.Modify() then
                    returnValue := '{"status":"success"}';
            end;
        end;

    end;

    procedure FnGateCreateVisitor(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        myAction: Text;
        TbVisi: record "Sec-Visitor Management";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('visitorNo', jToken);
        DocNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#admit':
                begin
                    TbSecSetup.Get;
                    TbSecSetup.TestField("Visitors Nos");
                    NextNo := CuNoSeries.GetNextNo(TbSecSetup."Visitors Nos", 0D, true);
                    TbVisi.Init();
                    TbVisi.No := NextNo;
                    jObject.Get('visitorCategory', jToken);
                    TbVisi."Visitor Category" := jToken.AsValue().AsInteger();
                    if jObject.Get('firstName', jToken) then
                        TbVisi."First Name" := jToken.AsValue().AsText();
                    if jObject.Get('middleName', jToken) then
                        TbVisi."Middle Name" := jToken.AsValue().AsText();
                    if jObject.Get('lastName', jToken) then
                        TbVisi."Last Name" := jToken.AsValue().AsText();
                    TbVisi.validate("Last Name");
                    jObject.Get('purposeOfVisit', jToken);
                    TbVisi."Purpose of Visit" := jToken.AsValue().AsText();
                    if jObject.Get('reasonForVisit', jToken) then
                        TbVisi."Reason For Visit" := jToken.AsValue().AsInteger();
                    if jObject.Get('idNumber', jToken) then
                        TbVisi."ID Number" := CopyStr(jToken.AsValue().AsCode(), 1, MAXSTRLEN(TbVisi."ID Number"));
                    jObject.Get('phoneNumber', jToken);
                    TbVisi."Phone Number" := jToken.AsValue().AsText();
                    if jObject.Get('carRegistrationNo', jToken) then
                        TbVisi."Visitor Car Reg Number" := jToken.AsValue().AsText();
                    if jObject.Get('personToVisitNo', jToken) then
                        TbVisi."Visitor Number" := jToken.AsValue().AsText();
                    if jObject.Get('personToVisit', jToken) then
                        TbVisi."Person To See" := jToken.AsValue().AsText();
                    if TbVisi."Person To See" = '' then
                        TbVisi."Person To See" := 'Reception';
                    jObject.Get('branchCode', jToken);
                    TbVisi."Global Dimension 1 Code" := jToken.AsValue().AsText();
                    if jObject.Get('department', jToken) then
                        TbVisi.Department := jToken.AsValue().AsText();
                    if jObject.Get('visitorPassNo', jToken) then
                        TbVisi."Visitor Pass No." := jToken.AsValue().AsText();
                    if TbVisi."Visitor Pass No." = '' then
                        TbVisi."Visitor Pass No." := NextNo;
                    if jObject.Get('firstName', jToken) then
                        TbVisi."First Name" := jToken.AsValue().AsText();
                    if jObject.Get('middleName', jToken) then
                        TbVisi."Middle Name" := jToken.AsValue().AsText();
                    if jObject.Get('lastName', jToken) then
                        TbVisi."Last Name" := jToken.AsValue().AsText();
                    if TbVisi.Insert(true) then begin
                        if myAction = 'create#admit' then
                            FnGateAdmitVisitor('{"visitorNo":"' + NextNo + '","staffNo":"' + staffNo + '"}');
                        returnValue := '{"status":"success","visitorNo":"' + NextNo + '","DocNo":"' + NextNo + '"}'
                    end;
                end;
            'edit':
                begin
                    TbVisi.Reset();
                    TbVisi.SetRange(TbVisi.No, DocNo);
                    if TbVisi.FindFirst() then begin
                        jObject.Get('visitorCategory', jToken);
                        TbVisi."Visitor Category" := jToken.AsValue().AsInteger();
                        if jObject.Get('firstName', jToken) then
                            TbVisi."First Name" := jToken.AsValue().AsText();
                        if jObject.Get('middleName', jToken) then
                            TbVisi."Middle Name" := jToken.AsValue().AsText();
                        if jObject.Get('lastName', jToken) then
                            TbVisi."Last Name" := jToken.AsValue().AsText();
                        TbVisi.validate("Last Name");
                        jObject.Get('purposeOfVisit', jToken);
                        TbVisi."Purpose of Visit" := jToken.AsValue().AsText();
                        if jObject.Get('reasonForVisit', jToken) then
                            TbVisi."Reason For Visit" := jToken.AsValue().AsInteger();
                        jObject.Get('idNumber', jToken);
                        TbVisi."ID Number" := jToken.AsValue().AsText();
                        jObject.Get('phoneNumber', jToken);
                        TbVisi."Phone Number" := jToken.AsValue().AsText();
                        if jObject.Get('carRegistrationNo', jToken) then
                            TbVisi."Visitor Car Reg Number" := jToken.AsValue().AsText();
                        if jObject.Get('personToVisitNo', jToken) then
                            TbVisi."Visitor Number" := jToken.AsValue().AsText();
                        if jObject.Get('personToVisit', jToken) then
                            TbVisi."Person To See" := jToken.AsValue().AsText();
                        if TbVisi."Person To See" = '' then
                            TbVisi."Person To See" := 'Reception';
                        jObject.Get('branchCode', jToken);
                        TbVisi."Global Dimension 1 Code" := jToken.AsValue().AsText();
                        if jObject.Get('department', jToken) then
                            TbVisi.Department := jToken.AsValue().AsText();
                        if jObject.Get('visitorPassNo', jToken) then
                            TbVisi."Visitor Pass No." := jToken.AsValue().AsText();
                        if TbVisi."Visitor Pass No." = '' then
                            TbVisi."Visitor Pass No." := DocNo;
                        if TbVisi.Modify(true) then
                            returnValue := '{"status":"success","DocNo":"' + DocNo + '"}'
                    end;
                end;
            'delete':
                begin
                    TbVisi.Reset();
                    TbVisi.SetRange(TbVisi.No, DocNo);
                    if TbVisi.FindFirst() then begin
                        if TbVisi.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnGateAdmitVisitor(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        visitorNo: Code[30];
        staffNo: Code[30];
        TbVisi: record "Sec-Visitor Management";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('visitorNo', jToken);
        visitorNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbVisi.Reset();
        TbVisi.SetRange(TbVisi.No, visitorNo);
        if TbVisi.FindFirst() then begin
            if CuHMSProcesses.FnGateAdmitVisitor(TbVisi) then
                returnValue := '{"status":"success","visitorNo":"' + TbVisi.No + '"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnGateClearVisitor(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        visitorNo: Code[30];
        staffNo: Code[30];
        TbVisi: record "Sec-Visitor Management";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('visitorNo', jToken);
        visitorNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbVisi.Reset();
        TbVisi.SetRange(TbVisi.No, visitorNo);
        if TbVisi.FindFirst() then begin
            if CuHMSProcesses.FnGateClearVisitor(TbVisi) then
                returnValue := '{"status":"success","visitorNo":"' + TbVisi.No + '"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnReceptionConvertVisitorToPatient(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        visitorNo: Code[30];
        staffNo: Code[30];
        TbVisi: record "Sec-Visitor Management";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('visitorNo', jToken);
        visitorNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbVisi.Reset();
        TbVisi.SetRange(TbVisi.No, visitorNo);
        if TbVisi.FindFirst() then begin
            DocNo := CuHMSProcesses.FnReceptionConvertVisitorToPatient(TbVisi);
            if DocNo <> '' then
                returnValue := '{"status":"success","patientNo":"' + DocNo + '"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;
    /**
    INPATIENT
    */
    procedure FnInpatientVisitorsListForm(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        visitorNo: Code[30];
        admissionNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbVisi: record "IP Visitors List";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('admissionNo', jToken);
        admissionNo := jToken.AsValue().AsText();
        case myAction of
            'create':
                begin
                    TbVisi.Init();
                    TbVisi."Admission No." := admissionNo;
                    jObject.Get('idNumber', jToken);
                    TbVisi."Id Number" := jToken.AsValue().AsText();
                    jObject.Get('visitorName', jToken);
                    TbVisi."Visitor Name" := jToken.AsValue().AsText();
                    jObject.Get('phoneNumber', jToken);
                    TbVisi."Phone Number" := jToken.AsValue().AsText();
                    if TbVisi.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit':
                begin
                    TbVisi.Reset();
                    TbVisi.SetRange(TbVisi."Admission No.", admissionNo);
                    jObject.Get('lineNo', jToken);
                    TbVisi.SetRange(TbVisi."Line No", jToken.AsValue().AsInteger());
                    if TbVisi.FindFirst() then begin
                        jObject.Get('idNumber', jToken);
                        TbVisi."Id Number" := jToken.AsValue().AsText();
                        jObject.Get('visitorName', jToken);
                        TbVisi."Visitor Name" := jToken.AsValue().AsText();
                        jObject.Get('phoneNumber', jToken);
                        TbVisi."Phone Number" := jToken.AsValue().AsText();
                        if TbVisi.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbVisi.Reset();
                    TbVisi.SetRange(TbVisi."Admission No.", admissionNo);
                    jObject.Get('lineNo', jToken);
                    TbVisi.SetRange(TbVisi."Line No", jToken.AsValue().AsInteger());
                    if TbVisi.FindFirst() then begin
                        if TbVisi.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnInpatientSuicidalPrecautionForm(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        visitorNo: Code[30];
        admissionNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbSui: record "Suicidal Precaution Form";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('admissionNo', jToken);
        admissionNo := jToken.AsValue().AsText();
        case myAction of
            'create':
                begin
                    TbSui.Init();
                    TbSui."Admission No." := admissionNo;
                    jObject.Get('date', jToken);
                    TbSui.Date := jToken.AsValue().AsDate();
                    jObject.Get('time', jToken);
                    TbSui.Time := jToken.AsValue().AsTime();
                    jObject.Get('handingOver', jToken);
                    TbSui."Handing Over" := jToken.AsValue().AsText();
                    jObject.Get('takingOver', jToken);
                    TbSui."Taking Over" := jToken.AsValue().AsText();
                    jObject.Get('remarks', jToken);
                    TbSui.Remarks := jToken.AsValue().AsText();
                    if TbSui.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit':
                begin
                    TbSui.Reset();
                    TbSui.SetRange(TbSui."Admission No.", admissionNo);
                    jObject.Get('lineNo', jToken);
                    TbSui.SetRange(TbSui."Line No", jToken.AsValue().AsInteger());
                    if TbSui.FindFirst() then begin
                        jObject.Get('date', jToken);
                        TbSui.Date := jToken.AsValue().AsDate();
                        jObject.Get('time', jToken);
                        TbSui.Time := jToken.AsValue().AsTime();
                        jObject.Get('handingOver', jToken);
                        TbSui."Handing Over" := jToken.AsValue().AsText();
                        jObject.Get('takingOver', jToken);
                        TbSui."Taking Over" := jToken.AsValue().AsText();
                        jObject.Get('remarks', jToken);
                        TbSui.Remarks := jToken.AsValue().AsText();
                        if TbSui.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbSui.Reset();
                    TbSui.SetRange(TbSui."Admission No.", admissionNo);
                    jObject.Get('lineNo', jToken);
                    TbSui.SetRange(TbSui."Line No", jToken.AsValue().AsInteger());
                    if TbSui.FindFirst() then begin
                        if TbSui.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnInpatientMentalStatusCheckForm(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        visitorNo: Code[30];
        admissionNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbMenCh: record "Mental Status Level Checklist";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('admissionNo', jToken);
        admissionNo := jToken.AsValue().AsText();
        case myAction of
            'create':
                begin
                    TbMenCh.Init();
                    TbMenCh."Admission No." := admissionNo;
                    jObject.Get('date', jToken);
                    TbMenCh.Date := jToken.AsValue().AsDate();
                    jObject.Get('comments', jToken);
                    TbMenCh.Comments := jToken.AsValue().AsText();
                    jObject.Get('status', jToken);
                    TbMenCh.Status := jToken.AsValue().AsText();
                    if TbMenCh.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit':
                begin
                    TbMenCh.Reset();
                    TbMenCh.SetRange(TbMenCh."Admission No.", admissionNo);
                    jObject.Get('lineNo', jToken);
                    TbMenCh.SetRange(TbMenCh."Line No", jToken.AsValue().AsInteger());
                    if TbMenCh.FindFirst() then begin
                        jObject.Get('date', jToken);
                        TbMenCh.Date := jToken.AsValue().AsDate();
                        jObject.Get('comments', jToken);
                        TbMenCh.Comments := jToken.AsValue().AsText();
                        jObject.Get('status', jToken);
                        TbMenCh.Status := jToken.AsValue().AsText();
                        if TbMenCh.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbMenCh.Reset();
                    TbMenCh.SetRange(TbMenCh."Admission No.", admissionNo);
                    jObject.Get('lineNo', jToken);
                    TbMenCh.SetRange(TbMenCh."Line No", jToken.AsValue().AsInteger());
                    if TbMenCh.FindFirst() then begin
                        if TbMenCh.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnInpatientDietaryIntakeFormLines(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        visitorNo: Code[30];
        admissionNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbDietLi: record "Dietary Intake Form Lines";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('admissionNo', jToken);
        admissionNo := jToken.AsValue().AsText();
        case myAction of
            'create':
                begin
                    TbDietLi.Init();
                    TbDietLi."Admission No." := admissionNo;
                    jObject.Get('category', jToken);
                    TbDietLi.Category := jToken.AsValue().AsText();
                    jObject.Get('comments', jToken);
                    TbDietLi.Comment := jToken.AsValue().AsText();
                    if TbDietLi.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit':
                begin
                    TbDietLi.Reset();
                    TbDietLi.SetRange(TbDietLi."Admission No.", admissionNo);
                    jObject.Get('lineNo', jToken);
                    TbDietLi.SetRange(TbDietLi."Line No", jToken.AsValue().AsInteger());
                    if TbDietLi.FindFirst() then begin
                        jObject.Get('category', jToken);
                        TbDietLi.Category := jToken.AsValue().AsText();
                        jObject.Get('comments', jToken);
                        TbDietLi.Comment := jToken.AsValue().AsText();
                        if TbDietLi.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbDietLi.Reset();
                    TbDietLi.SetRange(TbDietLi."Admission No.", admissionNo);
                    jObject.Get('lineNo', jToken);
                    TbDietLi.SetRange(TbDietLi."Line No", jToken.AsValue().AsInteger());
                    if TbDietLi.FindFirst() then begin
                        if TbDietLi.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnInpatientJacksonVisualForm(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        visitorNo: Code[30];
        admissionNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        TbJackVi: record "Jackson Visual Form";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('admissionNo', jToken);
        admissionNo := jToken.AsValue().AsText();
        case myAction of
            'create':
                begin
                    TbJackVi.Init();
                    TbJackVi."Admission No" := admissionNo;
                    jObject.Get('date', jToken);
                    TbJackVi."Date " := jToken.AsValue().AsDate();
                    jObject.Get('score', jToken);
                    TbJackVi.Score := jToken.AsValue().AsDecimal();
                    jObject.Get('ivLine', jToken);
                    TbJackVi."IV Line " := jToken.AsValue().AsInteger();
                    TbJackVi.Nurse := staffNo;
                    if TbJackVi.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit':
                begin
                    TbJackVi.Reset();
                    TbJackVi.SetRange(TbJackVi."Admission No", admissionNo);
                    jObject.Get('lineNo', jToken);
                    TbJackVi.SetRange(TbJackVi."Line No", jToken.AsValue().AsInteger());
                    if TbJackVi.FindFirst() then begin
                        jObject.Get('date', jToken);
                        TbJackVi."Date " := jToken.AsValue().AsDate();
                        jObject.Get('score', jToken);
                        TbJackVi.Score := jToken.AsValue().AsDecimal();
                        jObject.Get('ivLine', jToken);
                        TbJackVi."IV Line " := jToken.AsValue().AsInteger();
                        TbJackVi.Nurse := staffNo;
                        if TbJackVi.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbJackVi.Reset();
                    TbJackVi.SetRange(TbJackVi."Admission No", admissionNo);
                    jObject.Get('lineNo', jToken);
                    TbJackVi.SetRange(TbJackVi."Line No", jToken.AsValue().AsInteger());
                    if TbJackVi.FindFirst() then begin
                        if TbJackVi.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnConsultationMarkAsCompleted(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        treatmentNo: Code[30];
        staffNo: Code[30];
        TbTreat: record "HMS Treatment Form Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('treatmentNo', jToken);
        treatmentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbTreat.Reset();
        TbTreat.SetRange(TbTreat."Treatment No.", treatmentNo);
        if TbTreat.FindFirst() then begin
            if CuHMSProcesses.FnConsultationMarkAsCompleted(TbTreat) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnLaboratoryTestLine(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        visitorNo: Code[30];
        laboratoryNo: Code[30];
        staffNo: Code[30];
        myAction: Text;
        specimenCode: Text;
        recId: Text;
        TbLabLine: record "HMS Laboratory Test Line";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('laboratoryNo', jToken);
        laboratoryNo := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbLabLine.Init();
                    TbLabLine."Laboratory No." := laboratoryNo;
                    if jObject.Get('labTestCode', jToken) then begin
                        TbLabLine."Laboratory Test Code" := jToken.AsValue().AsText();
                        TbLabLine.Validate("Laboratory Test Code");
                    end;
                    if jObject.Get('specimenCode', jToken) then
                        TbLabLine."Specimen Code" := jToken.AsValue().AsText();
                    if jObject.Get('unitOfMeasure', jToken) then
                        TbLabLine."Measuring Unit Code" := jToken.AsValue().AsText();
                    if jObject.Get('countValue', jToken) then
                        TbLabLine."Count Value" := jToken.AsValue().AsInteger();
                    jObject.Get('remarks', jToken);
                    // TbLabLine."Assigned User ID" := FnGetStaffUserID(staffNo);
                    TbLabLine.Remarks := jToken.AsValue().AsText();
                    TbLabLine."Lab Request Date" := Today;
                    TbLabLine."Lab Request Time" := Time;
                    TbLabLine."Staff No" := staffNo;
                    TbLabLine.Validate("Staff No");
                    if TbLabLine.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbLabLine.Reset();
                    TbLabLine.SetRange(TbLabLine.SystemId, recId);
                    if TbLabLine.FindFirst() then begin
                        if jObject.Get('labTestCode', jToken) then
                            TbLabLine."Laboratory Test Code" := jToken.AsValue().AsText();
                        if jObject.Get('specimenCode', jToken) then
                            TbLabLine."Specimen Code" := jToken.AsValue().AsText();
                        if jObject.Get('unitOfMeasure', jToken) then
                            TbLabLine."Measuring Unit Code" := jToken.AsValue().AsText();
                        if jObject.Get('countValue', jToken) then
                            TbLabLine."Count Value" := jToken.AsValue().AsInteger();
                        jObject.Get('remarks', jToken);
                        TbLabLine.Remarks := jToken.AsValue().AsText();
                        TbLabLine.Completed := true;
                        TbLabLine."Completion Date" := Today;
                        TbLabLine."Completion Time" := Time;
                        TbLabLine."Assigned User ID" := FnGetStaffUserID(staffNo);
                        TbLabLine."Staff No" := staffNo;
                        TbLabLine.Validate("Staff No");
                        if TbLabLine.Rename(laboratoryNo, TbLabLine."Laboratory Test Code", TbLabLine."Specimen Code", TbLabLine."Duplicate test") then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbLabLine.Reset();
                    TbLabLine.SetRange(TbLabLine.SystemId, recId);
                    if TbLabLine.FindFirst() then begin
                        if TbLabLine.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    /**
    **NURSE [ServiceEnabled]
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
    **/
    procedure FnNurseAdmissionNotes(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        //
        TbAdmFoNurse: record "HMS Admission Form Nurse";
        admissionNo: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('admissionNo', jToken);
        admissionNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbAdmFoNurse.Init();
                    TbAdmFoNurse."Admission No." := admissionNo;
                    TbAdmFoNurse."Nurse ID" := staffNo;
                    TbAdmFoNurse."Notes Date" := Today;
                    TbAdmFoNurse."Notes Time" := Time;
                    jObject.Get('notes', jToken);
                    TbAdmFoNurse.Notes := jToken.AsValue().AsText();
                    if TbAdmFoNurse.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbAdmFoNurse.Reset();
                    TbAdmFoNurse.SetRange(TbAdmFoNurse.SystemId, recId);
                    if TbAdmFoNurse.FindFirst() then begin
                        TbAdmFoNurse."Admission No." := admissionNo;
                        TbAdmFoNurse."Nurse ID" := staffNo;
                        TbAdmFoNurse."Notes Date" := Today;
                        TbAdmFoNurse."Notes Time" := Time;
                        jObject.Get('notes', jToken);
                        TbAdmFoNurse.Notes := jToken.AsValue().AsText();
                        if TbAdmFoNurse.Rename(admissionNo, staffNo, Today, Time, TbAdmFoNurse.LineNo) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbAdmFoNurse.Reset();
                    TbAdmFoNurse.SetRange(TbAdmFoNurse.SystemId, recId);
                    if TbAdmFoNurse.FindFirst() then begin
                        if TbAdmFoNurse.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            else
                Error(ErrorSthWrong);
        end;
    end;
    /**
    **GENERAL
    **/
    procedure FnPatientConsumables(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        TbPres: record "HMS Admission Drug Prescribe";
        documentNo: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('documentNo', jToken);
        documentNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbPres.Init();
                    TbPres."Admission No." := documentNo;
                    TbPres."Date Created" := Today;
                    jObject.Get('item', jToken);
                    TbPres."Drug No." := jToken.AsValue().AsText();
                    TbPres.Validate("Drug No.");
                    jObject.Get('location', jToken);
                    TbPres."Location Code" := jToken.AsValue().AsText();
                    jObject.Get('quantity', jToken);
                    TbPres.Quantity := jToken.AsValue().AsInteger();
                    jObject.Get('remarks', jToken);
                    TbPres.Remarks := jToken.AsValue().AsText();
                    if TbPres.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbPres.Reset();
                    TbPres.SetRange(TbPres.SystemId, recId);
                    TbPres.SetRange(TbPres.Posted, false);
                    if TbPres.FindFirst() then begin
                        TbPres."Date Created" := Today;
                        jObject.Get('item', jToken);
                        TbPres."Drug No." := jToken.AsValue().AsText();
                        TbPres.Validate("Drug No.");
                        jObject.Get('location', jToken);
                        TbPres."Location Code" := jToken.AsValue().AsText();
                        jObject.Get('quantity', jToken);
                        TbPres.Quantity := jToken.AsValue().AsInteger();
                        jObject.Get('remarks', jToken);
                        TbPres.Remarks := jToken.AsValue().AsText();
                        if TbPres.Rename(documentNo, TbPres."Drug No.", TbPres."Location Code", TbPres."Line No") then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbPres.Reset();
                    TbPres.SetRange(TbPres.SystemId, recId);
                    TbPres.SetRange(TbPres.Posted, false);
                    if TbPres.FindFirst() then begin
                        if TbPres.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnPatientCharges(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        TbCharges: record "HMS Patient Charges";
        documentNo: Text;
        HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('visitNo', jToken);
        documentNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbCharges.Init();
                    HMSAppointmentFormHeader.Reset();
                    HMSAppointmentFormHeader.Setrange("Appointment No.", documentNo);
                    if HMSAppointmentFormHeader.FindFirst() then
                        TbCharges."Patient No." := HMSAppointmentFormHeader."Patient No."
                    else begin
                        HMSAdmissionFormHeader.Reset();
                        HMSAdmissionFormHeader.SetRange("Admission No.", documentNo);
                        if HMSAdmissionFormHeader.FindFirst() then begin
                            TbCharges."Patient No." := HMSAdmissionFormHeader."Patient No.";
                        end
                    end;
                    TbCharges."Visit No" := documentNo;
                    jObject.Get('creationDate', jToken);
                    TbCharges.Date := jToken.AsValue().AsDate();
                    // jObject.Get('patientNo', jToken);
                    // TbCharges."Patient No." := jToken.AsValue().AsText();
                    jObject.Get('transactionType', jToken);
                    TbCharges."Transaction Type" := jToken.AsValue().AsText();
                    TbCharges.Validate("Transaction Type");
                    jObject.Get('charge', jToken);
                    TbCharges.Code := jToken.AsValue().AsText();
                    TbCharges.Validate(Code);
                    jObject.Get('quantity', jToken);
                    TbCharges.Quantity := jToken.AsValue().AsInteger();
                    TbCharges.Validate(Quantity);
                    jObject.Get('remarks', jToken);
                    TbCharges.Remarks := jToken.AsValue().AsText();
                    TbCharges."User ID" := FnGetStaffUserID(staffNo);
                    if jObject.Get('doctorId', jToken) then begin
                        TbCharges."Doctor ID" := jToken.AsValue().AsCode();
                        TbCharges.Validate("Doctor ID");
                    end;
                    if TbCharges.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbCharges.Reset();
                    TbCharges.SetRange(TbCharges.SystemId, recId);
                    TbCharges.SetRange(TbCharges.Posted, false);
                    if TbCharges.FindFirst() then begin
                        jObject.Get('creationDate', jToken);
                        TbCharges.Date := jToken.AsValue().AsDate();
                        jObject.Get('transactionType', jToken);
                        TbCharges."Transaction Type" := jToken.AsValue().AsText();
                        TbCharges.Validate("Transaction Type");
                        jObject.Get('charge', jToken);
                        TbCharges.Code := jToken.AsValue().AsText();
                        TbCharges.Validate(Code);
                        jObject.Get('quantity', jToken);
                        TbCharges.Quantity := jToken.AsValue().AsInteger();
                        TbCharges.Validate(Quantity);
                        jObject.Get('remarks', jToken);
                        TbCharges.Remarks := jToken.AsValue().AsText();
                        TbCharges."User ID" := FnGetStaffUserID(staffNo);
                        if jObject.Get('doctorId', jToken) then begin
                            TbCharges."Doctor ID" := jToken.AsValue().AsCode();
                            TbCharges.Validate("Doctor ID");
                        end;
                        if TbCharges.Rename(TbCharges."Transaction Type", TbCharges."Line No", TbCharges."Patient No.", TbCharges."Link No", TbCharges."Treatment No.", TbCharges.Code) then
                            returnValue := '{"status":"success"}'
                    end else
                        Error('You cannot edit a posted charge.');
                end;
            'delete':
                begin
                    TbCharges.Reset();
                    TbCharges.SetRange(TbCharges.SystemId, recId);
                    TbCharges.SetRange(TbCharges.Posted, false);
                    if TbCharges.FindFirst() then begin
                        if TbCharges.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    //
    procedure FnAdmissionVerifyAdmission(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        TbAdm: record "HMS Admission Form Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbAdm.Reset();
        TbAdm.SetRange(TbAdm."Admission No.", documentNo);
        if TbAdm.FindFirst() then begin
            if CuHMSProcesses.FnVerifyAdmissionRequest(TbAdm) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;
    //
    procedure FnAdmissionAdmitPatient(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        TbAdm: record "HMS Admission Form Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbAdm.Reset();
        TbAdm.SetRange(TbAdm."Admission No.", documentNo);
        if TbAdm.FindFirst() then begin
            if CuHMSProcesses.FnAdmitPatient(TbAdm) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;
    //
    procedure FnAdmissionCancelAdmission(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbAdm: record "HMS Admission Form Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbAdm.Reset();
        TbAdm.SetRange(TbAdm."Admission No.", documentNo);
        if TbAdm.FindFirst() then begin
            TbAdm.Status := TbAdm.Status::Cancelled;
            if TbAdm.Modify() then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;
    //
    procedure FnInpatientInitiateDischarge(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbAdm: Record "HMS Admission Form Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbAdm.Reset();
        TbAdm.SetRange(TbAdm."Admission No.", documentNo);
        if TbAdm.FindFirst() then begin
            if CuHMSProcesses.FnInpatientInitiateDischarge(TbAdm) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;
    //
    procedure FnInpatientCancelDischarge(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbDisc: Record "HMS Admission Discharge Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbDisc.Reset();
        TbDisc.SetRange(TbDisc."Admission No.", documentNo);
        if TbDisc.FindFirst() then begin
            if CuHMSProcesses.FnInpatientCancelDischarge(TbDisc) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnInpatientDischargeSummary(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        HMSDischargeSummary: Record "HMS Discharge Summary";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsCode();
        // Get Admission No.
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('recId', jToken);
        recId := jToken.AsValue().AsText();
        jObject.Get('type', jToken);
        case myAction of
            'create', 'create#save':
                begin
                    HMSDischargeSummary.Init();
                    HMSDischargeSummary."Admission No" := documentNo;
                    HMSDischargeSummary."Discharge Code" := documentNo;
                    jObject.Get('type', jToken);
                    HMSDischargeSummary.Type := jToken.AsValue().AsInteger();
                    jObject.Get('description', jToken);
                    HMSDischargeSummary.Description := jToken.AsValue().AsText();
                    if HMSDischargeSummary.Insert(true) then
                        returnValue := '{"status":"success"}'
                    else
                        returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}';
                end;
            'edit', 'edit#save':
                begin
                    HMSDischargeSummary.Reset();
                    HMSDischargeSummary.SetRange(HMSDischargeSummary.SystemId, recId);
                    if HMSDischargeSummary.FindFirst() then begin
                        jObject.Get('description', jToken);
                        HMSDischargeSummary.Description := jToken.AsValue().AsText();
                        if HMSDischargeSummary.Modify(true) then
                            returnValue := '{"status":"success"}'
                        else
                            returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}';
                    end;
                end;
        end;

    end;
    //
    procedure FnInpatientPostDischarge(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        UserID: Code[30];
        branchCode: Code[30];
        TbDisc: Record "HMS Admission Discharge Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbDisc.Reset();
        TbDisc.SetRange(TbDisc."Admission No.", documentNo);
        if TbDisc.FindFirst() then begin
            UserID := FnGetStaffUserID(staffNo);

            if CuHMSProcesses.FnInpatientPostDischarge(TbDisc, UserID) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnInpatientReleaseBed(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbDisc: Record "HMS Admission Discharge Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbDisc.Reset();
        TbDisc.SetRange(TbDisc."Admission No.", documentNo);
        if TbDisc.FindFirst() then begin
            if CuHMSProcesses.FnInpatientReleaseBed(TbDisc) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnRadiologyRequestLine(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        //
        TbRec: record "HMS Radiology Form Line";
        documentNo: Text;
        fileJson: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        jObject.Get('recId', jToken);
        recId := jToken.AsValue().AsText();
        //
        jObject.Get('radiologyNo', jToken);
        documentNo := jToken.AsValue().AsText();
        case myAction of
            'edit', 'edit#save':
                begin
                    // jObject.Get('radiologyTypeCode', jToken);
                    // documentNo := jToken.AsValue().AsText();
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    TbRec.SetRange(TbRec.Completed, false);
                    if TbRec.FindFirst() then begin
                        TbRec."Performed Date" := Today;
                        TbRec."Performed Time" := Time;
                        jObject.Get('remarks', jToken);
                        TbRec.Remarks := jToken.AsValue().AsText();
                        TbRec.Completed := true;
                        if TbRec.Modify() then begin
                            fileJson := '{';
                            fileJson := fileJson + '"tableId":"' + format(Database::"HMS Radiology Form Line") + '",';
                            fileJson := fileJson + '"docNo":"' + TbRec."Radiology no." + '",';
                            fileJson := fileJson + '"docNo2":"' + TbRec."Radiology Type Code" + '",';
                            fileJson := fileJson + '"fileName":"Radiology-Image-' + TbRec."Radiology no." + '-' + TbRec."Radiology Type Code" + '",';
                            jObject.Get('fileBase64', jToken);
                            fileJson := fileJson + '"fileBase64":"' + jToken.AsValue().AsText() + '",';
                            fileJson := fileJson + '"myUserId":"' + FnGetStaffUserID(staffNo) + '"';
                            fileJson := fileJson + '}';
                            FnUploadAttachedFile(fileJson);
                            returnValue := '{"status":"success"}';
                        end;
                    end;
                end;
        end;
    end;

    procedure FnRadiologyForwardRequest(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Radiology Form Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('radiologyNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbRec.Reset();
        TbRec.SetRange(TbRec."Radiology No.", documentNo);
        if TbRec.FindFirst() then begin
            if CuHMSProcesses.FnRadiologyForwardRequest(TbRec) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnPharmacyPostDrugIssuance(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Pharmacy Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('pharmacyNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbRec.Reset();
        TbRec.SetRange(TbRec."Pharmacy No.", documentNo);
        if TbRec.FindFirst() then begin
            if CuHMSProcesses.FnPharmacyPostDrugIssuance(TbRec) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnPharmacyArchivePrescription(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Pharmacy Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('pharmacyNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbRec.Reset();
        TbRec.SetRange(TbRec."Pharmacy No.", documentNo);
        if TbRec.FindFirst() then begin
            if CuHMSProcesses.FnPharmacyArchivePrescription(TbRec) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;
    //

    // Ndirangu
    procedure FnPostPharmacyReturn(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        TbRec: Record "HMS Pharmacy Header";
        PharmacyLine: Record "HMS Pharmacy Line";
        PharmacyProcesses: Codeunit "HMS Pharmacy Processes";
        returnQty: decimal;
        recId: Text;
        returnRemarks: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('recId', jToken);
        recId := jToken.AsValue().AsText();
        jObject.Get('returnQty', jToken);
        returnQty := jToken.AsValue().AsDecimal();
        jObject.Get('returnRemarks', jToken);
        returnRemarks := jToken.AsValue().AsText();

        PharmacyLine.Reset();
        PharmacyLine.SetRange(SystemId, recId);
        if PharmacyLine.FindFirst() then begin
            if returnQty > PharmacyLine.Quantity then
                Error('Return quantity cannot be greater than the quantity issued.');

            PharmacyLine."Returns Quantity" := returnQty;
            PharmacyLine.Remarks := returnRemarks;

            PharmacyLine.Modify();
            Commit();

            if PharmacyProcesses.PostPharmacyReturns(PharmacyLine) then // Will this work without getting the record again?
                returnValue := '{"status":"success"}'
        end;
    end;

    procedure FnLaboratoryDispatchToDoctor(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Laboratory Form Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('laboratoryNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbRec.Reset();
        TbRec.SetRange(TbRec."Laboratory No.", documentNo);
        if TbRec.FindFirst() then begin
            if CuHMSProcesses.FnLaboratoryDispatchToDoctor(TbRec) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;
    //
    procedure FnAdmissionFormDetails(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        //
        TbRec: record "HMS Admission Form Header";
        documentNo: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        jObject.Get('recId', jToken);
        recId := jToken.AsValue().AsText();
        //  jObject.Get('visitNo', jToken);
        documentNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbHMSSetup.Get();
                    TbHMSSetup.TestField("Admission Request Nos");
                    NextNo := CuNoSeries.GetNextNo(TbHMSSetup."Admission Request Nos", 0D, true);
                    TbRec.Init();
                    TbRec."Admission No." := NextNo;
                    // TbRec."Admission Date" := Today;
                    TbRec."Admission Time" := Time;
                    TbRec.Branch := branchCode;
                    jObject.Get('patientNo', jToken);
                    TbRec."Patient No." := jToken.AsValue().AsText();
                    jObject.Get('ward', jToken);
                    TbRec.Ward := jToken.AsValue().AsText();
                    jObject.Get('wardRoom', jToken);
                    TbRec."Ward Room" := jToken.AsValue().AsText();
                    jObject.Get('bed', jToken);
                    TbRec.Bed := jToken.AsValue().AsText();
                    if jObject.Get('doctor', jToken) then begin
                        TbRec.Doctor := jToken.AsValue().AsCode();
                        TbRec.Validate(Doctor);
                    end;
                    if jObject.Get('admissionDate', jToken) then
                        TbRec."Admission Date" := jToken.AsValue().AsDate();
                    if TbRec.Insert(true) then
                        returnValue := '{"status":"success","admissionNo":"' + NextNo + '"}';
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        // TbRec.TestField(Status, TbRec.Status::Verified);
                        TbRec.Branch := branchCode;
                        jObject.Get('ward', jToken);
                        TbRec.Ward := jToken.AsValue().AsText();
                        jObject.Get('wardRoom', jToken);
                        TbRec."Ward Room" := jToken.AsValue().AsText();
                        jObject.Get('bed', jToken);
                        TbRec.Bed := jToken.AsValue().AsText();
                        if jObject.Get('doctor', jToken) then begin
                            TbRec.Doctor := jToken.AsValue().AsCode();
                            TbRec.Validate(Doctor);
                        end;
                        if jObject.Get('admissionDate', jToken) then
                            TbRec."Admission Date" := jToken.AsValue().AsDate();
                        if TbRec.Modify(true) then
                            returnValue := '{"status":"success"}';
                    end;
                end;
            else
                Error(ErrorInvalidAction);

        end;
    end;
    //
    procedure FnInpatientDailyProcedureOrProcess(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;        //
        TbRec: record "HMS Admission Form Process";
        HMSNotes: Record "HMS Notes";
        documentNo: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbRec.Init();
                    TbRec."Admission No." := documentNo;
                    TbRec."Process Date" := Today;
                    TbRec."Process Time" := Time;
                    jObject.Get('processCode', jToken);
                    TbRec."Process Code" := jToken.AsValue().AsText();
                    jObject.Get('processDescription', jToken);
                    TbRec.Process := jToken.AsValue().AsText();
                    jObject.Get('remarks', jToken);
                    TbRec.Remarks := jToken.AsValue().AsText();
                    if TbRec.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        TbRec."Process Date" := Today;
                        TbRec."Process Time" := Time;
                        jObject.Get('processCode', jToken);
                        TbRec."Process Code" := jToken.AsValue().AsText();
                        jObject.Get('processDescription', jToken);
                        TbRec.Process := jToken.AsValue().AsText();
                        jObject.Get('remarks', jToken);
                        TbRec.Remarks := jToken.AsValue().AsText();
                        if TbRec.Rename(documentNo, TbRec."Process Code", Today, Time) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    //
    procedure FnInpatientInjection(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        //
        TbRec: record "HMS Admission Injection";
        documentNo: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbRec.Init();
                    TbRec."Admission No." := documentNo;
                    jObject.Get('injectionDate', jToken);
                    TbRec.Date := jToken.AsValue().AsDate();
                    jObject.Get('injectionTime', jToken);
                    TbRec.Time := jToken.AsValue().AsTime();
                    jObject.Get('injection', jToken);
                    TbRec."Injection Code" := jToken.AsValue().AsText();
                    jObject.Get('remarks', jToken);
                    TbRec.Remarks := jToken.AsValue().AsText();
                    if TbRec.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        jObject.Get('injectionDate', jToken);
                        TbRec.Date := jToken.AsValue().AsDate();
                        jObject.Get('injectionTime', jToken);
                        TbRec.Time := jToken.AsValue().AsTime();
                        jObject.Get('injection', jToken);
                        TbRec."Injection Code" := jToken.AsValue().AsText();
                        jObject.Get('remarks', jToken);
                        TbRec.Remarks := jToken.AsValue().AsText();
                        if TbRec.Rename(documentNo, TbRec."Injection Code", Today, Time) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    //
    procedure FnInpatientPrescription(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        //
        TbRec: record "HMS Admission Drug Prescribe";
        HMSAdmissionDrugPrescribe: Record "HMS Admission Drug Prescribe";
        documentNo: Text;
        DrugNo: Code[30];
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsText();
        jObject.Get('drug', jToken);
        DrugNo := jToken.AsValue().AsText();

        case myAction of
            'create', 'create#save':
                begin
                    HMSAdmissionDrugPrescribe.Reset();
                    HMSAdmissionDrugPrescribe.SetRange("Admission No.", documentNo);
                    HMSAdmissionDrugPrescribe.SetRange("Drug No.", DrugNo);
                    HMSAdmissionDrugPrescribe.SetRange(Posted, false);
                    if HMSAdmissionDrugPrescribe.IsEmpty() then begin
                        TbRec.Init();
                        TbRec."Admission No." := documentNo;
                        jObject.Get('drug', jToken);
                        TbRec."Drug No." := DrugNo;
                        TbRec.Validate("Drug No.");
                        if jObject.Get('location', jToken) then
                            TbRec."Location Code" := jToken.AsValue().AsText();
                        if jObject.Get('quantityIssued', jToken) then begin
                            TbRec.Quantity := jToken.AsValue().AsDecimal();
                            TbRec.Validate(Quantity);
                        end;
                        // TbRec."Actual Quantity Issued" := jToken.AsValue().AsDecimal();
                        if jObject.Get('remarks', jToken) then
                            TbRec.Remarks := jToken.AsValue().AsText();
                        if jObject.Get('dosage', jToken) then
                            TbRec.Dosage := jToken.AsValue().AsText();
                        if jObject.Get('duration', jToken) then
                            TbRec."Number of Days" := jToken.AsValue().AsInteger();
                        if jObject.Get('prescriptionDose', jToken) then
                            TbRec."Prescription Dose" := jToken.AsValue().AsInteger();
                        TbRec."Created By" := FnGetStaffUserID(staffNo);
                        if TbRec.Insert(true) then
                            returnValue := '{"status":"success"}'
                    end else
                        returnValue := '{"status":"Item Was already Prescribed but not Forwarded"}'
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        jObject.Get('drug', jToken);
                        TbRec."Drug No." := jToken.AsValue().AsText();
                        if jObject.Get('location', jToken) then
                            TbRec."Location Code" := jToken.AsValue().AsText();
                        if jObject.Get('quantityIssued', jToken) then begin
                            TbRec.Quantity := jToken.AsValue().AsDecimal();
                            TbRec.Validate(Quantity);
                        end;
                        // TbRec."Actual Quantity Issued" := jToken.AsValue().AsDecimal();
                        if jObject.Get('remarks', jToken) then
                            TbRec.Remarks := jToken.AsValue().AsText();
                        if jObject.Get('dosage', jToken) then
                            TbRec.Dosage := jToken.AsValue().AsText();
                        if jObject.Get('duration', jToken) then
                            TbRec."Number of Days" := jToken.AsValue().AsInteger();
                        if jObject.Get('prescriptionDose', jToken) then
                            TbRec."Prescription Dose" := jToken.AsValue().AsInteger();
                        if TbRec.Rename(documentNo, TbRec."Drug No.", TbRec."Location Code", TbRec."Line No") then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    //
    procedure FnInpatientPostDrugPrescriptions(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Admission Drug Prescribe";
        StaffUserID: Code[20];
    begin
        jObject.ReadFrom(jString);
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();

        StaffUserID := FnGetStaffUserID(staffNo);
        TbRec.Reset();
        TbRec.SetRange(TbRec."Admission No.", documentNo);
        if TbRec.FindFirst() then begin
            if CuHMSProcesses.FnInpatientPostDrugPrescriptions(TbRec."Admission No.", StaffUserID) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;
    
    
    //
    // procedure FnLaboratoryResultsReport(jString: Text) returnValue: Text
    // var
    //     jObject: JsonObject;
    //     jToken: JsonToken;
    //     treatmentNo: Code[30];
    //     staffNo: Code[30];
    //     branchCode: Code[30];
    //     TbLabFo: Record "HMS Laboratory Form Header";
    //     TbLabRes: Record "HMS Laboratory Results Entry";
    //     laboratoryNo: Code[50];
    //     LabTestCode: Code[30];
    //     RpLabResults: report "HMS Lab Results2";
    //     filename: Text;
    //     Convert: Codeunit "Base64 Convert";
    //     IOFile: DotNet File;
    // begin
    //     returnValue := '';
    //     filename := FILESPATH + '\' + 'Lab Results - ' + laboratoryNo + '.pdf';
    //     if EXISTS(filename) then
    //         ERASE(filename);

    //     jObject.ReadFrom(jString);
    //     jObject.Get('laboratoryNo', jToken);
    //     laboratoryNo := jToken.AsValue().AsCode();
    //     jObject.Get('laboratoryTestCode', jToken);
    //     LabTestCode := jToken.AsValue().AsCode();

    //     TbLabRes.reset();
    //     TbLabRes.SetRange("Laboratory No.", laboratoryNo);
    //     if LabTestCode <> '' then
    //         TbLabRes.SetRange("Laboratory Test Code", LabTestCode);
    //     if TbLabRes.FindFirst() then begin
    //         RpLabResults.SetTableView(TbLabRes);
    //     end else
    //         Error('No results found');

    //     RpLabResults.SaveAsPdf(filename);
    //     returnValue := '{"base64":"' + Convert.ToBase64String(IOFile.ReadAllBytes(filename)) + '"}';
    //     if EXISTS(filename) then
    //         ERASE(filename);
    // end;


    //
    // procedure FnPatientInterimInvoice(jString: Text) returnValue: Text
    // var
    //     jObject: JsonObject;
    //     jToken: JsonToken;
    //     documentNo: Code[30];
    //     visitNo: Code[30];
    //     staffNo: Code[30];
    //     branchCode: Code[30];
    //     TbPatieChar: Record "HMS Patient Charges";
    //     HmsPatient: Record "HMS Patient";
    //     filename: Text;
    //     Convert: DotNet Convert;
    //     IOFile: DotNet File;
    //     RpInterimInv: Report "HMS Patient Invoice";
    // begin
    //     jObject.ReadFrom(jString);
    //     jObject.Get('patientNo', jToken);
    //     documentNo := jToken.AsValue().AsCode();
    //     jObject.Get('staffNo', jToken);
    //     staffNo := jToken.AsValue().AsCode();
    //     jObject.Get('visitNo', jToken);
    //     visitNo := jToken.AsValue().AsCode();
    //     TbPatieChar.Reset();
    //     TbPatieChar.SetRange(TbPatieChar."Patient No.", documentNo);
    //     TbPatieChar.SetRange(TbPatieChar."Visit No", visitNo);
    //     if TbPatieChar.FindSet() then begin
    //         returnValue := '';
    //         filename := FILESPATH + '\' + 'Interim Invoice - ' + documentNo + '.pdf';
    //         IF EXISTS(filename) THEN
    //             ERASE(filename);
    //         RpInterimInv.SetTableView(TbPatieChar);
    //         RpInterimInv.SaveAsPdf(filename);
    //         returnValue := '{"base64":"' + Convert.ToBase64String(IOFile.ReadAllBytes(filename)) + '"}';
    //         IF EXISTS(filename) THEN
    //             ERASE(filename);
    //     end else
    //         error('No patient charges found for patient %1 visit %2', documentNo, visitNo);
    // end;

    //
    procedure FnPatientHistoryNotes(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        //
        TbRec: record "HMS Patient History Notes";
        documentNo: Text;
        patientNo: Text;
        notes: Text;
        oStream: OutStream;
        TbPatHis: record "HMS Patient History";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('treatmentNo', jToken);
        documentNo := jToken.AsValue().AsText();
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbPatHis.Reset();
                    TbPatHis.SetRange("Treatment No.", documentNo);
                    TbPatHis.SetRange(TbPatHis."Patient No.", patientNo);
                    if not TbPatHis.FindFirst() then begin
                        TbPatHis.Init();
                        TbPatHis."Treatment No." := documentNo;
                        TbPatHis."Patient No." := patientNo;
                        TbPatHis."Intake Date" := Today;
                        TbPatHis.Insert(true);
                    end;
                    TbRec.Init();
                    TbRec."Treatment No" := documentNo;
                    TbRec."Patient No" := patientNo;
                    jObject.Get('notesType', jToken);
                    TbRec."Notes Type" := jToken.AsValue().AsInteger();
                    jObject.Get('notes', jToken);
                    notes := jToken.AsValue().AsText();
                    TbRec.Notes.CreateOutStream(oStream);
                    oStream.Write(notes);
                    TbRec."Date Taken" := Today;
                    TbRec."Created By" := staffNo;
                    if TbRec.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        jObject.Get('notesType', jToken);
                        TbRec."Notes Type" := jToken.AsValue().AsInteger();
                        jObject.Get('notes', jToken);
                        notes := jToken.AsValue().AsText();
                        TbRec.Notes.CreateOutStream(oStream);
                        oStream.Write(notes);
                        TbRec."Date Taken" := Today;
                        TbRec."Created By" := staffNo;
                        if TbRec.Modify() then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    //
    procedure FnPatientHistorySystemicReview(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        //
        TbRec: record "MSE Form List";
        documentNo: Text;
        patientNo: Text;
        notes: Text;
        oStream: OutStream;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbRec.Init();
                    TbRec."Patient No." := patientNo;
                    TbRec."Observation Type" := TbRec."Observation Type"::History;
                    jObject.Get('date', jToken);
                    TbRec.Date := jToken.AsValue().AsDate();
                    jObject.Get('category', jToken);
                    TbRec.Category := jToken.AsValue().AsText();
                    jObject.Get('descriptor', jToken);
                    TbRec.Descriptor := jToken.AsValue().AsText();
                    jObject.Get('comments', jToken);
                    TbRec.Comments := jToken.AsValue().AsText();
                    if TbRec.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        jObject.Get('date', jToken);
                        TbRec.Date := jToken.AsValue().AsDate();
                        jObject.Get('category', jToken);
                        TbRec.Category := jToken.AsValue().AsText();
                        jObject.Get('descriptor', jToken);
                        TbRec.Descriptor := jToken.AsValue().AsText();
                        jObject.Get('comments', jToken);
                        TbRec.Comments := jToken.AsValue().AsText();
                        if TbRec.Modify() then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnConsultationRoomCheckin(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Treatment Form Header";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('treatmentNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbRec.Reset();
        TbRec.SetRange(TbRec."Treatment No.", documentNo);
        if TbRec.FindFirst() then begin
            if CuHMSProcesses.FnConsultationRoomCheckin(TbRec) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;
    //
    procedure FnPatientECT_Ketamine_Implant_Request(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        //
        TbRec: record "HMS Procedure Requests";
        documentNo: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('linkNo', jToken);
        documentNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbRec.Init();
                    TbRec."Link No" := documentNo;
                    TbRec."Request Date" := Today;
                    jObject.Get('patientNo', jToken);
                    TbRec."Patient No" := jToken.AsValue().AsText();
                    jObject.Get('procedureType', jToken);
                    TbRec."Procedure Type" := jToken.AsValue().AsInteger();
                    jObject.Get('doctorId', jToken);
                    TbRec."Doctor ID" := jToken.AsValue().AsText();
                    jObject.Get('procedureDate', jToken);
                    TbRec."Procedure Date" := jToken.AsValue().AsDate();
                    jObject.Get('status', jToken);
                    TbRec.Status := jToken.AsValue().AsInteger();
                    if TbRec.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        TbRec."Request Date" := Today;
                        jObject.Get('patientNo', jToken);
                        TbRec."Patient No" := jToken.AsValue().AsText();
                        jObject.Get('procedureType', jToken);
                        TbRec."Procedure Type" := jToken.AsValue().AsInteger();
                        jObject.Get('doctorId', jToken);
                        TbRec."Doctor ID" := jToken.AsValue().AsText();
                        TbRec.Validate("Doctor ID");
                        jObject.Get('procedureDate', jToken);
                        TbRec."Procedure Date" := jToken.AsValue().AsDate();
                        jObject.Get('status', jToken);
                        TbRec.Status := jToken.AsValue().AsInteger();
                        if TbRec.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    //
    procedure FnInpatientNursingCarePlan(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        //
        TbRec: record "Nursing Care Plan";
        documentNo: Text;
        oStream: OutStream;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbRec.Init();
                    TbRec."Admission No." := documentNo;
                    jObject.Get('patientNo', jToken);
                    TbRec."Patient No." := jToken.AsValue().AsText();
                    jObject.Get('dateTaken', jToken);
                    TbRec."Date Taken" := jToken.AsValue().AsDate();
                    jObject.Get('timeTaken', jToken);
                    TbRec."Time Taken" := jToken.AsValue().AsTime();
                    TbRec."Created By" := staffNo;
                    TbRec.Validate("Created By");
                    jObject.Get('pysicalAssessment', jToken);
                    TbRec."Physical Assessmet(MSA)" := jToken.AsValue().AsText();
                    jObject.Get('nursingDiagnosis', jToken);
                    TbRec."Nursing Diagnosis" := jToken.AsValue().AsText();
                    jObject.Get('plan', jToken);
                    TbRec.Plan := jToken.AsValue().AsText();
                    jObject.Get('implementation', jToken);
                    TbRec.Implementation := jToken.AsValue().AsText();
                    jObject.Get('rationale', jToken);
                    TbRec.Rationale := jToken.AsValue().AsText();
                    jObject.Get('evaluation', jToken);
                    TbRec.Evaluation := jToken.AsValue().AsText();
                    if TbRec.Insert(true) then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        jObject.Get('dateTaken', jToken);
                        TbRec."Date Taken" := jToken.AsValue().AsDate();
                        jObject.Get('timeTaken', jToken);
                        TbRec."Time Taken" := jToken.AsValue().AsTime();
                        TbRec."Created By" := staffNo;
                        TbRec.Validate("Created By");
                        jObject.Get('pysicalAssessment', jToken);
                        TbRec."Physical Assessmet(MSA)" := jToken.AsValue().AsText();
                        jObject.Get('nursingDiagnosis', jToken);
                        TbRec."Nursing Diagnosis" := jToken.AsValue().AsText();
                        jObject.Get('plan', jToken);
                        TbRec.Plan := jToken.AsValue().AsText();
                        jObject.Get('implementation', jToken);
                        TbRec.Implementation := jToken.AsValue().AsText();
                        jObject.Get('rationale', jToken);
                        TbRec.Rationale := jToken.AsValue().AsText();
                        jObject.Get('evaluation', jToken);
                        TbRec.Evaluation := jToken.AsValue().AsText();
                        if TbRec.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    
    //
    procedure FnDirectDispatchToPharmacy(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        PatientNo: Code[30];
        HMSPatient: Record "HMS Patient";
        PTLFactory: Codeunit "PTL Factory";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsCode();
        jObject.Get('PatientNo', jToken);
        PatientNo := jToken.AsValue().AsCode();

        HMSPatient.Reset();
        HMSPatient.SetRange("Patient No.", PatientNo);
        if HMSPatient.FindFirst() then begin
            if PTLFactory.DispatchToPharmacy(HMSPatient) then
                returnValue := '{"status":"success"}'
        end;
    end;

    procedure FnPharmacyHeader(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        TbRec: record "HMS Pharmacy Header";
        documentNo: Text;
        oStream: OutStream;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        case myAction of
            'create', 'create#save':
                begin
                    TbRec.Init();
                    TbHMSSetup.Get();
                    TbHMSSetup.TestField("Pharmacy Nos");
                    NextNo := CuNoSeries.GetNextNo(TbHMSSetup."Pharmacy Nos", 0D, true);
                    TbRec."Pharmacy No." := NextNo;
                    jObject.Get('patientNo', jToken);
                    TbRec."Patient No." := jToken.AsValue().AsText();
                    TbRec."Global Dimension 1 Code" := branchCode;
                    TbRec.Validate("Global Dimension 1 Code");
                    // jObject.Get('issuingLocation', jToken);
                    // TbRec."Issuing Location" := branchCode; //REFACTOR: Add Setup of getting pharmacy location for ea
                    TbRec.Validate("Issuing Location");
                    jObject.Get('cashSale', jToken);
                    TbRec."Cash Sale" := jToken.AsValue().AsBoolean();
                    if jObject.Get('status', jToken) then
                        TbRec.Status := jToken.AsValue().AsInteger();
                    // if jObject.Get('transactionType', jToken) then                    
                    TbRec."Transaction Type" := 'PHARMACY';
                    TbRec."Issued By" := FnGetStaffUserID(staffNo);
                    TbRec."Pharmacy Date" := Today();
                    TbRec."Pharmacy Time" := Time();
                    if TbRec.Insert(true) then
                        returnValue := '{"status":"success","phamarcyNo":"' + NextNo + '"}';
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        jObject.Get('patientNo', jToken);
                        TbRec."Patient No." := jToken.AsValue().AsText();
                        TbRec."Global Dimension 1 Code" := branchCode;
                        TbRec.Validate("Global Dimension 1 Code");
                        jObject.Get('cashSale', jToken);
                        TbRec."Cash Sale" := jToken.AsValue().AsBoolean();
                        TbRec."Transaction Type" := 'PHARMACY';
                        if jObject.Get('status', jToken) then
                            TbRec.Status := jToken.AsValue().AsInteger();
                        TbRec."Issued By" := FnGetStaffUserID(staffNo);
                        if TbRec.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    //
    procedure FnPharmacyLine(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        //
        TbRec: record "HMS Pharmacy Line";
        documentNo: Text;
        fileJson: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        jObject.Get('recId', jToken);
        recId := jToken.AsValue().AsText();
        jObject.Get('pharmacyNo', jToken);
        documentNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbRec.Init();
                    TbRec."Pharmacy No." := documentNo;
                    TbRec.Validate("Pharmacy No.");
                    jObject.Get('drugNo', jToken);
                    TbRec."No." := jToken.AsValue().AsText();
                    TbRec.Validate("No.");
                    if jObject.Get('quantity', jToken) then
                        TbRec.Quantity := jToken.AsValue().AsDecimal();
                    if jObject.Get('take', jToken) then
                        TbRec.Take := jToken.AsValue().AsDecimal();
                    if jObject.Get('frequency', jToken) then
                        TbRec.Frequency := jToken.AsValue().AsDecimal();
                    if jObject.Get('noOfDays', jToken) then
                        TbRec."Number of Days" := jToken.AsValue().AsDecimal();
                    if jObject.Get('remarks', jToken) then
                        TbRec.Remarks := jToken.AsValue().AsText();
                    if jObject.Get('dosage', jToken) then
                        TbRec.Dosage := jToken.AsValue().AsText();
                    if jObject.Get('prescriptionDose', jToken) then
                        TbRec."Prescription Dose" := jToken.AsValue().AsInteger();
                    TbRec.Validate(Quantity);
                    if TbRec.Insert(true) then begin
                        returnValue := '{"status":"success"}';

                    end;
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    TbRec.SetRange(TbRec.Posted, false);
                    if TbRec.FindFirst() then begin
                        jObject.Get('quantity', jToken);
                        TbRec.Quantity := jToken.AsValue().AsDecimal();
                        TbRec.Validate(Quantity);
                        if jObject.Get('take', jToken) then
                            TbRec.Take := jToken.AsValue().AsDecimal();
                        if jObject.Get('frequency', jToken) then
                            TbRec.Frequency := jToken.AsValue().AsDecimal();
                        if jObject.Get('noOfDays', jToken) then
                            TbRec."Number of Days" := jToken.AsValue().AsDecimal();
                        if jObject.Get('remarks', jToken) then
                            TbRec.Remarks := jToken.AsValue().AsText();
                        if jObject.Get('dosage', jToken) then
                            TbRec.Dosage := jToken.AsValue().AsText();
                        if jObject.Get('returnQty', jToken) then
                            TbRec."Returns Quantity" := jToken.AsValue().AsDecimal();
                        if jObject.Get('prescriptionDose', jToken) then
                            TbRec."Prescription Dose" := jToken.AsValue().AsInteger();
                        if TbRec.Modify(true) then
                            returnValue := '{"status":"success"}';
                    end else
                        returnValue := '{"status":"failed","msg":"Pharmacy line not found or already posted."}';
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end
            else
                returnValue := ErrorInvalidAction;
        end;
    end;
    //
    procedure FnGenerateInsuranceInvoice(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        patientNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
    begin
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := FnGetStaffUserID(jToken.AsValue().AsCode());
        if CuHMSProcesses.FnGenerateInsuranceInvoice(patientNo, staffNo) then
            returnValue := '{"status":"success"}'
        else
            returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
    end;

    // procedure FnInsuranceInvoiceReport(jString: Text) returnValue: Text
    // var
    //     jObject: JsonObject;
    //     jToken: JsonToken;
    //     documentNo: Code[30];
    //     staffNo: Code[30];
    //     branchCode: Code[30];
    //     RpPatientInvoice: report "Final Patient Invoice";
    //     filename: Text;
    //     Convert: DotNet Convert;
    //     IOFile: DotNet File;
    //     TbCharges: record "HMS Patient Charges";
    //     HMSPatient: Record "HMS Patient";
    //     VisitNo: Code[30];
    // begin
    //     jObject.ReadFrom(jString);
    //     jObject.Get('patientNo', jToken);
    //     documentNo := jToken.AsValue().AsCode();
    //     jObject.Get('staffNo', jToken);
    //     staffNo := jToken.AsValue().AsCode();
    //     jObject.Get('EncounterNO', jToken);
    //     VisitNo := jToken.AsValue().AsCode();
    //     TbCharges.Reset();
    //     TbCharges.SetRange(TbCharges."Patient No.", documentNo);
    //     TbCharges.SetRange("Visit No", VisitNo);
    //     TbCharges.SetRange(TbCharges.Posted, true);
    //     if TbCharges.FindSet() then begin
    //         returnValue := '';
    //         filename := FILESPATH + '\' + 'Final invoice - ' + documentNo + '.pdf';
    //         IF EXISTS(filename) THEN
    //             ERASE(filename);
    //         RpPatientInvoice.SetTableView(TbCharges);
    //     end else
    //         Error('No charges found');
    //     RpPatientInvoice.SaveAsPdf(filename);
    //     returnValue := '{"base64":"' + Convert.ToBase64String(IOFile.ReadAllBytes(filename)) + '"}';
    //     IF EXISTS(filename) THEN
    //         ERASE(filename);
    // end;


    //
    procedure FnReceiptHeader(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        CoPayTempFix: text;
        //
        TbRec: record "Receipts Header";
        documentNo: Text;
        oStream: OutStream;
        TbDimVal: record "Dimension Value";
        TbCashOff: Record "Cash Office Setup";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        //
        jObject.Get('patientNo', jToken);
        documentNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin

                    if TbUserSetup."Branch Code" <> '' then begin
                        TbDimVal.reset();
                        TbDimVal.setrange(Code, TbUserSetup."Branch Code");
                        if TbDimVal.find('-') then begin
                            TbDimVal.testfield("Receipt No. Series");
                            NextNo := CuNoSeries.GetNextNo(TbDimVal."Receipt No. Series", 0D, true);
                        end;
                    end else begin
                        TbCashOff.Get();
                        TbCashOff.TestField(TbCashOff."Receipts No");
                        NextNo := CuNoSeries.GetNextNo(TbCashOff."Receipts No", 0D, true);
                    end;
                    TbRec.Init();
                    TbRec."No." := NextNo;
                    TbRec."Patient No." := documentNo;
                    jObject.Get('receiptDate', jToken);
                    TbRec.Date := jToken.AsValue().AsDate();
                    jObject.Get('depositDate', jToken);
                    TbRec."Document Date" := jToken.AsValue().AsDate();
                    if jObject.Get('payMode', jToken) then
                        TbRec."Pay Mode" := jToken.AsValue().AsInteger();
                    if jObject.Get('amountReceived', jToken) then
                        TbRec."Amount Recieved" := jToken.AsValue().AsDecimal();
                    if jObject.Get('coPay', jToken) then begin
                        TbRec."Co-Pay" := jToken.AsValue().AsBoolean();
                    end;
                    if jObject.Get('remarks', jToken) then
                        TbRec.Remarks := jToken.AsValue().AsText();
                    TbRec."Global Dimension 1 Code" := branchCode;
                    if jObject.Get('transactionCode', jToken) then
                        TbRec."Transaction Code" := jToken.AsValue().AsText();
                    if jObject.Get('splitAmount', jToken) then begin
                        TbRec."Split Amount" := jToken.AsValue().AsBoolean();
                        TbRec.Validate("Split Amount");
                    end;
                    TbRec.Cashier := staffNo;
                    if jObject.Get('isPartialPayment', jToken) then begin
                        TbRec.isPartialPayment := jToken.AsValue().AsBoolean();
                        TbRec.Validate(isPartialPayment);
                    end;
                    if TbRec.Insert(true) then begin
                        TbRec.Reset();
                        TbRec.SetRange("No.", NextNo);
                        if TbRec.FindFirst() then begin
                            TbRec.Validate("Patient No.");
                            TbRec.Validate("Pay Mode");
                            TbRec.Validate("Co-Pay");
                            TbRec.Validate(isPartialPayment);
                            TbRec.Modify();
                        end;
                        returnValue := '{"status":"success","ReceiptNo":"' + NextNo + '"}'
                    end;

                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        jObject.Get('receiptDate', jToken);
                        TbRec.Date := jToken.AsValue().AsDate();
                        jObject.Get('depositDate', jToken);
                        TbRec."Document Date" := jToken.AsValue().AsDate();
                        jObject.Get('payMode', jToken);
                        TbRec."Pay Mode" := jToken.AsValue().AsInteger();
                        jObject.Get('amountReceived', jToken);
                        TbRec."Amount Recieved" := jToken.AsValue().AsDecimal();
                        if jObject.Get('coPay', jToken) then
                            TbRec."Co-Pay" := jToken.AsValue().AsBoolean();
                        if jObject.Get('transactionCode', jToken) then
                            TbRec."Transaction Code" := jToken.AsValue().AsText();
                        if jObject.Get('splitAmount', jToken) then begin
                            TbRec."Split Amount" := jToken.AsValue().AsBoolean();
                            TbRec.Validate("Split Amount");
                        end;
                        if jObject.Get('remarks', jToken) then
                            TbRec.Remarks := jToken.AsValue().AsText();
                        if TbRec.Cashier <> staffNo then
                            TbRec.Cashier := staffNo;
                        if jObject.Get('isPartialPayment', jToken) then begin
                            TbRec.isPartialPayment := jToken.AsValue().AsBoolean();
                            TbRec.Validate(isPartialPayment);
                        end;
                        if TbRec.Modify() then begin
                            returnValue := '{"status":"success"}'
                        end;
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    //
    procedure FnPostReceipt(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        patientNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "Receipts Header";
        receiptNo: Code[30];
        PostReceiptCodeunit: Codeunit "Post Receipt";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('receiptNo', jToken);
        receiptNo := jToken.AsValue().AsCode();
        TbRec.Reset();
        TbRec.SetRange("No.", receiptNo);
        TbRec.SetRange("Patient No.", patientNo);
        if TbRec.FindFirst() then
            if PostReceiptCodeunit.FnPostReceiptHeader(TbRec) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
    end;

    procedure FnLaboratoryTestSample(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        visitorNo: Code[30];
        laboratoryNo: Code[30];
        laboratoryTestCode: Code[50];
        remarks: Text[250];
        staffNo: Code[30];
        myAction: Text;
        // specimenCode: Text;
        recId: Text;
        TbLHMSSample: record "HMS Sample";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('laboratoryNo', jToken);
        laboratoryNo := jToken.AsValue().AsText();
        jObject.Get('labTestCode', jToken);
        laboratoryTestCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbLHMSSample.Init();
                    TbLHMSSample."Laboratory No" := laboratoryNo;
                    TbLHMSSample."Lab Test Code" := laboratoryTestCode;
                    jObject.Get('remarks', jToken);
                    TbLHMSSample.Remarks := jToken.AsValue().AsText();
                    TbLHMSSample."Collected By" := staffNo;
                    TbLHMSSample."Collection Date" := Today;
                    TbLHMSSample."Collection Time" := Time;
                    if TbLHMSSample.Insert(true) then begin
                        CuHMSProcesses.FnLaboratorySubmitSamples(laboratoryNo, laboratoryTestCode);
                        returnValue := '{"status":"success"}'
                    end;
                end;
            'edit', 'edit#save':
                begin
                    TbLHMSSample.Reset();
                    TbLHMSSample.SetRange(TbLHMSSample.SystemId, recId);
                    if TbLHMSSample.FindFirst() then begin
                        jObject.Get('remarks', jToken);
                        TbLHMSSample.Remarks := jToken.AsValue().AsText();
                        TbLHMSSample."Collected By" := staffNo;
                        TbLHMSSample."Collection Date" := Today;
                        TbLHMSSample."Collection Time" := Time;
                        if TbLHMSSample.Rename(laboratoryNo, TbLHMSSample."Lab Test Code", TbLHMSSample."Collection Time") then // REFACTOR: HOW TO RENAME KEYS
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbLHMSSample.Reset();
                    TbLHMSSample.SetRange(TbLHMSSample.SystemId, recId);
                    if TbLHMSSample.FindFirst() then begin
                        if TbLHMSSample.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;

    procedure FnLaboratoryTestResultsEntry(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jResultsArray: JsonArray;
        jToken: JsonToken;
        jResultsToken: JsonToken;
        jResultToken: JsonToken;
        visitorNo: Code[30];
        laboratoryNo: Code[30];
        laboratoryTestCode: Code[50];
        remarks: Text[2000];
        staffNo: Code[30];
        myAction: Text;
        specimenCode: Text;
        recId: Text;
        TbResultsEntry: Record "HMS Laboratory Results Entry";
        LabResultsEntry: Record "HMS Laboratory Results Entry";
        TbLabLine: Record "HMS Laboratory Test Line";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('laboratoryNo', jToken);
        laboratoryNo := jToken.AsValue().AsText();
        jObject.Get('labTestCode', jToken);
        laboratoryTestCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbResultsEntry.Init();
                    TbResultsEntry."Laboratory No." := laboratoryNo;
                    TbResultsEntry."Laboratory Test Code" := laboratoryTestCode;
                    jObject.Get('specimenCode', jToken);
                    TbResultsEntry."Specimen Code" := jToken.AsValue().AsText();
                    TbResultsEntry."Collection Date" := Today;
                    TbResultsEntry."Collection Time" := Time;
                    jObject.Get('results', jToken);
                    TbResultsEntry.Results := jToken.AsValue().AsDecimal();
                    if jObject.Get('remarks', jToken) then
                        TbResultsEntry.Remarks := jToken.AsValue().AsText();
                    // if jObject.Get('narration', jToken) then
                    //     TbResultsEntry."Narration Results" := jToken.AsValue().AsText();

                    if jObject.Get('TestNormalRanges', jToken) then
                        TbResultsEntry."Test Normal Ranges" := jToken.AsValue().AsText();
                    if TbResultsEntry.Remarks <> '' then
                        TbResultsEntry.Completed := true;
                    TbResultsEntry."Reviewed By" := FnGetStaffUserID(staffNo);
                    if TbResultsEntry.Insert(true) then begin
                        returnValue := '{"status":"success"}';
                        // Check if all results have complete status
                        LabResultsEntry.Reset();
                        LabResultsEntry.SetRange("Laboratory No.", laboratoryNo);
                        LabResultsEntry.SetRange("Laboratory Test Code", laboratoryTestCode);
                        LabResultsEntry.SetRange(Completed, false);
                        if LabResultsEntry.IsEmpty() then begin
                            TbLabLine.Reset();
                            TbLabLine.SetRange(TbLabLine."Laboratory No.", laboratoryNo);
                            TbLabLine.SetRange(TbLabLine."Laboratory Test Code", laboratoryTestCode);
                            if TbLabLine.FindFirst() then begin
                                TbLabLine."Results Added" := true;
                                TbLabLine.Modify();
                            end;
                        end;
                    end;
                end;
            'edit', 'edit#save':
                begin
                    TbResultsEntry.Reset();
                    TbResultsEntry.SetRange(TbResultsEntry.SystemId, recId);
                    if TbResultsEntry.FindFirst() then begin
                        TbResultsEntry."Laboratory No." := laboratoryNo;
                        TbResultsEntry."Laboratory Test Code" := laboratoryTestCode;
                        jObject.Get('specimenCode', jToken);
                        TbResultsEntry."Specimen Code" := jToken.AsValue().AsText();
                        TbResultsEntry."Collection Date" := Today;
                        TbResultsEntry."Collection Time" := Time;
                        jObject.Get('results', jToken);
                        TbResultsEntry.Results := jToken.AsValue().AsDecimal();
                        if jObject.Get('remarks', jToken) then
                            TbResultsEntry.Remarks := jToken.AsValue().AsText();
                        if jObject.Get('TestNormalRanges', jToken) then
                            TbResultsEntry."Test Normal Ranges" := jToken.AsValue().AsText();
                        // if TbResultsEntry.Remarks <> '' then //TODO: What does it mean by Completed result entry
                        //     TbResultsEntry.Completed := true;
                        // if TbResultsEntry.Results <> '' then
                        TbResultsEntry.Completed := true;
                        TbResultsEntry."Reviewed By" := FnGetStaffUserID(staffNo);
                        if TbResultsEntry.Rename(TbResultsEntry."Laboratory No.", TbResultsEntry."Laboratory Test Code", TbResultsEntry."Specimen Code") then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbResultsEntry.Reset();
                    TbResultsEntry.SetRange(TbResultsEntry.SystemId, recId);
                    if TbResultsEntry.FindFirst() then begin
                        if TbResultsEntry.Delete(true) then
                            returnValue := '{"status":"success"}';
                    end;
                end;
        end;
    end;
    //
    procedure FnReversePatientCharge(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        patientNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Patient Charges";
        receiptNo: Code[30];
        TbUserSetup: record "User Setup";
    begin
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbRec.Reset();
        TbRec.SetRange("Patient No.", patientNo);
        jObject.Get('recId', jToken);
        TbRec.SetRange(TbRec.SystemId, jToken.AsValue().AsText());
        if TbRec.FindFirst() then begin
            TbUserSetup.Reset();
            TbUserSetup.SetRange("Employee No.", staffNo);
            if TbUserSetup.FindFirst() then begin
                TbRec."User ID" := TbUserSetup."User ID";
                TbRec.Modify();
                Commit();
            end;
            if CuHMSProcesses.FnPatientChargeReversal(TbRec) then
                returnValue := '{"status":"success"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;

    procedure FnWalkinPatientRegistration(jString: Text) returnValue: Text
    var
        jObject: JsonObject;//
        jToken: JsonToken;
        myAction: Text;
        status: Text;
        msg: Text;
        DocNo: Code[30];
        dimensions: Text;
        jstring2: Text;
        SMSSenderCodeunit: Codeunit "SMS Integration Management";
        smsMsg: text;
        PatientPhone: Code[30];
        FirstName: Text;
        IDNumber: Code[30];
    begin
        if jObject.ReadFrom(jString) then begin
            jObject.Get('myAction', jToken);
            myAction := jToken.AsValue().AsText();
            case myAction of
                'create', 'create#save':
                    begin
                        TbHMSSetup.Get;
                        TbHMSSetup.TestField("Walkin Nos");
                        NextNo := CuNoSeries.GetNextNo(TbHMSSetup."Walkin Nos", 0D, true);
                        HMSPatientTbl.Init();
                        HMSPatientTbl."Patient No." := NextNo;
                        HMSPatientTbl."Date Registered" := Today;
                        // TbPatient.Activated := true;
                        jObject.Get('branchCode', jToken);
                        HMSPatientTbl."Global Dimension 1 Code" := jToken.AsValue().AsText();
                        jObject.Get('firstName', jToken);
                        HMSPatientTbl.Surname := jToken.AsValue().AsText();
                        FirstName := jToken.AsValue().AsText();
                        jObject.Get('middleName', jToken);
                        HMSPatientTbl."Middle Name" := jToken.AsValue().AsText();
                        jObject.Get('lastName', jToken);
                        HMSPatientTbl."Last Name" := jToken.AsValue().AsText();
                        HMSPatientTbl.validate("Last Name");
                        jObject.Get('gender', jToken);
                        if jToken.AsValue().AsInteger() = 0 then
                            Error('Gender cannot be blank');
                        HMSPatientTbl.Gender := jToken.AsValue().AsInteger();
                        jObject.Get('dob', jToken);
                        HMSPatientTbl."Date Of Birth" := jToken.AsValue().AsDate();
                        jObject.Get('idNumber', jToken);
                        HMSPatientTbl."ID Number" := jToken.AsValue().AsText();
                        HMSPatientTbl.Validate("ID Number");
                        jObject.Get('phoneNumber', jToken);
                        HMSPatientTbl."Telephone No. 1" := jToken.AsValue().AsText();
                        PatientPhone := jToken.AsValue().AsText();
                        jObject.Get('paymentMode', jToken);
                        HMSPatientTbl."Patient Type" := jToken.AsValue().AsInteger();
                        if HMSPatientTbl."Patient Type" = HMSPatientTbl."Patient Type"::Corporate then begin
                            if jObject.Get('insuranceNo', jToken) then
                                HMSPatientTbl."Insurance No." := jToken.AsValue().AsText();
                            if jObject.Get('insuranceName', jToken) then
                                HMSPatientTbl."Insurance Name" := jToken.AsValue().AsText();
                            if jObject.Get('insurancePrinicipalMemberName', jToken) then
                                HMSPatientTbl."Principal Member Name" := jToken.AsValue().AsCode();
                            if jObject.Get('isPrincipleMember', jToken) then
                                HMSPatientTbl.Principal := jToken.AsValue().AsBoolean();
                            if jObject.Get('membershipNo', jToken) then
                                HMSPatientTbl."Membership No" := jToken.AsValue().AsText();
                            if jObject.Get('schemeName', jToken) then
                                HMSPatientTbl."Scheme Name" := jToken.AsValue().AsText();
                        end;
                        if jObject.Get('howYouKnewABoutUs', jToken) then
                            HMSPatientTbl."How you Knew About Us" := jToken.AsValue().AsText();
                        jObject.Get('staffNo', jToken);
                        HMSPatientTbl."User ID" := FnGetStaffUserID(jToken.AsValue().AsText());
                        HMSPatientTbl."Walk-in" := true;
                        if jObject.Get('email', jToken) then begin
                            HMSPatientTbl.Email := jToken.AsValue().AsText();
                        end;
                        jObject.Get('residence', jToken);
                        HMSPatientTbl."Place of Birth Village" := jToken.AsValue().AsText();
                        if HMSPatientTbl.Insert(true) then begin
                            status := 'success';
                            msg := NextNo;
                            smsMsg := 'Hello ' + FirstName + ', thankyou for visiting us. Your Registration number is  ' + Format(NextNo);
                            if PatientPhone <> '' then
                                SMSSenderCodeunit.SendSMS(PatientPhone, smsMsg);

                            returnValue := '{"status":"' + status + '","DocNo":"' + NextNo + '","msg":"' + msg + '"}';
                        end;
                    end;
                'edit', 'edit#save':
                    begin
                        jObject.Get('patientNo', jToken);
                        DocNo := jToken.AsValue().AsText();
                        HMSPatientTbl.Reset();
                        HMSPatientTbl.SetRange("Patient No.", DocNo);
                        if HMSPatientTbl.FindFirst() then begin
                            jObject.Get('branchCode', jToken);
                            HMSPatientTbl."Global Dimension 1 Code" := jToken.AsValue().AsText();
                            jObject.Get('firstName', jToken);
                            HMSPatientTbl.Surname := jToken.AsValue().AsText();
                            jObject.Get('middleName', jToken);
                            HMSPatientTbl."Middle Name" := jToken.AsValue().AsText();
                            jObject.Get('lastName', jToken);
                            HMSPatientTbl."Last Name" := jToken.AsValue().AsText();
                            HMSPatientTbl.validate("Last Name");
                            jObject.Get('gender', jToken);
                            if jToken.AsValue().AsInteger() = 0 then
                                Error('Gender cannot be blank');
                            HMSPatientTbl.Gender := jToken.AsValue().AsInteger();
                            jObject.Get('dob', jToken);
                            HMSPatientTbl."Date Of Birth" := jToken.AsValue().AsDate();
                            jObject.Get('nationality', jToken);
                            HMSPatientTbl.Nationality := jToken.AsValue().AsText();
                            jObject.Get('idNumber', jToken);
                            HMSPatientTbl."ID Number" := jToken.AsValue().AsText();
                            jObject.Get('phoneNumber', jToken);
                            HMSPatientTbl."Telephone No. 1" := jToken.AsValue().AsText();
                            jObject.Get('paymentMode', jToken);
                            HMSPatientTbl."Patient Type" := jToken.AsValue().AsInteger();
                            if HMSPatientTbl."Patient Type" = HMSPatientTbl."Patient Type"::Corporate then begin
                                if jObject.Get('insuranceNo', jToken) then
                                    HMSPatientTbl."Insurance No." := jToken.AsValue().AsText();
                                if jObject.Get('insuranceName', jToken) then
                                    HMSPatientTbl."Insurance Name" := jToken.AsValue().AsText();
                                if jObject.Get('insurancePrinicipalMemberName', jToken) then
                                    HMSPatientTbl."Principal Member Name" := jToken.AsValue().AsCode();
                                if jObject.Get('isPrincipleMember', jToken) then
                                    HMSPatientTbl.Principal := jToken.AsValue().AsBoolean();
                                if jObject.Get('membershipNo', jToken) then
                                    HMSPatientTbl."Membership No" := jToken.AsValue().AsText();
                                if jObject.Get('schemeName', jToken) then
                                    HMSPatientTbl."Scheme Name" := jToken.AsValue().AsText();
                            end;
                            if jObject.Get('howYouKnewABoutUs', jToken) then
                                HMSPatientTbl."How you Knew About Us" := jToken.AsValue().AsText();
                            jObject.Get('staffNo', jToken);
                            HMSPatientTbl."User ID" := FnGetStaffUserID(jToken.AsValue().AsText());
                            if jObject.Get('email', jToken) then begin
                                HMSPatientTbl.Email := jToken.AsValue().AsText();
                            end;
                            jObject.Get('residence', jToken);
                            HMSPatientTbl."Place of Birth Village" := jToken.AsValue().AsText();
                            if HMSPatientTbl.Modify(true) then begin
                                status := 'success';
                                msg := DocNo;
                                returnValue := '{"status":"' + status + '","DocNo":"' + DocNo + '","msg":"' + msg + '"}';
                            end;
                        end;
                    end;
                'delete':
                    begin
                        jObject.Get('patientNo', jToken);
                        DocNo := jToken.AsValue().AsText();
                        HMSPatientTbl.Reset();
                        HMSPatientTbl.SetRange("Patient No.", DocNo);
                        if HMSPatientTbl.FindFirst() then begin
                            if HMSPatientTbl.Delete(true) then begin
                                status := 'success';
                                msg := '';
                                returnValue := '{"status":"' + status + '","DocNo":"' + DocNo + '","msg":"' + msg + '"}';
                            end;
                        end;
                    end;
                else begin
                    status := 'error';
                    msg := 'Invalid action';
                    returnValue := ErrorInvalidAction;
                end;
            end;
        end;
    end;
    //
    //
    // procedure FnReceiptReport(jString: Text) returnValue: Text
    // var
    //     jObject: JsonObject;
    //     jToken: JsonToken;
    //     documentNo: Code[30];
    //     staffNo: Code[30];
    //     branchCode: Code[30];
    //     TbReceiptH: Record "Receipts Header";
    //     laboratoryNo: Code[50];
    //     RpReceipt: report "HMS Receipts Report";
    //     filename: Text;
    //     Convert: DotNet Convert;
    //     IOFile: DotNet File;
    // begin
    //     jObject.ReadFrom(jString);
    //     jObject.Get('receiptNo', jToken);
    //     documentNo := jToken.AsValue().AsCode();
    //     jObject.Get('staffNo', jToken);
    //     staffNo := jToken.AsValue().AsCode();
    //     TbReceiptH.Reset();
    //     TbReceiptH.SetRange(TbReceiptH."No.", documentNo);
    //     if TbReceiptH.FindFirst() then begin
    //         returnValue := '';
    //         filename := FILESPATH + '\' + 'Receipt - ' + documentNo + '.pdf';
    //         IF EXISTS(filename) THEN
    //             ERASE(filename);
    //         RpReceipt.SetTableView(TbReceiptH);
    //         RpReceipt.SaveAsPdf(filename);
    //         returnValue := '{"base64":"' + Convert.ToBase64String(IOFile.ReadAllBytes(filename)) + '"}';
    //         IF EXISTS(filename) THEN
    //             ERASE(filename);
    //     end else
    //         error('Receipt no % does not exist', documentNo);
    // end;


    //
    //
    //
    procedure FnLaboratoryTestHeader(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        //
        TbRec: record "HMS Laboratory Form Header";
        documentNo: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbHMSSetup.Get();
                    TbHMSSetup.TestField("Lab Test Request Nos");
                    NextNo := CuNoSeries.GetNextNo(TbHMSSetup."Lab Test Request Nos", 0D, true);
                    TbRec.Init();
                    TbRec."Laboratory Date" := Today;
                    TbRec."Laboratory Time" := Time;
                    TbRec."Laboratory No." := NextNo;
                    if jObject.Get('status', jToken) then
                        TbRec.Status := jToken.AsValue().AsInteger();
                    jObject.Get('cashSale', jToken);
                    TbRec."Cash Sale" := jToken.AsValue().AsBoolean();
                    jObject.Get('visitNo', jToken);
                    TbRec."Link No." := jToken.AsValue().AsText();
                    jObject.Get('patientNo', jToken);
                    TbRec."Patient No." := jToken.AsValue().AsText();
                    TbRec."Doctor ID" := staffNo;
                    if TbRec.Insert(true) then
                        returnValue := '{"status":"success","laboratoryNo":"' + NextNo + '"}';
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        TbRec."Laboratory Date" := Today;
                        TbRec."Laboratory Time" := Time;
                        if jObject.Get('status', jToken) then begin
                            TbRec.Status := jToken.AsValue().AsInteger();
                            // TbRec.Validate(Status);
                        end;
                        jObject.Get('cashSale', jToken);
                        TbRec."Cash Sale" := jToken.AsValue().AsBoolean();
                        jObject.Get('visitNo', jToken);
                        TbRec."Link No." := jToken.AsValue().AsText();
                        jObject.Get('patientNo', jToken);
                        TbRec."Patient No." := jToken.AsValue().AsText();
                        TbRec."Doctor ID" := staffNo;
                        if TbRec.Modify() then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    //
    //
    procedure FnChargesReopenPostedCharges(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        patientNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Patient Charges";
        receiptNo: Code[30];
        TbUserSetup: record "User Setup";
        appointmentNo: Code[30];
    begin
        returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}';
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('appointmentNo', jToken);
        appointmentNo := jToken.AsValue().AsText();
        TbRec.Reset();
        TbRec.SetRange(TbRec."Patient No.", patientNo);
        TbRec.SetRange(TbRec."Visit No", appointmentNo);
        TbRec.SetRange(TbRec.Posted, true);
        if TbRec.FindSet() then begin
            repeat
                // TODO: Implement Correct reopening of charges to check for exists in GL charges.
                TbRec.Posted := false;
                TbRec.Closed := false;
                TbRec.Modify();
            until TbRec.Next() = 0;
            returnValue := '{"status":"success"}';
        end else
            Error('No posted charges found for patient no %1, appointment no %2', patientNo, appointmentNo);
    end;
    //
    procedure FnPostSalesInvoice(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        patientNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        SalesHeader: Record "Sales Header";
        HMSPatient: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoicePerUserBuffer: Record "Invoice Per User Buffer";
        receiptNo: Code[30];
        documentNo: Code[30];
    begin
        returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}';
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('invoiceNo', jToken);
        documentNo := jToken.AsValue().AsText();


        SalesHeader.Reset();
        SalesHeader.SetRange(SalesHeader."Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange(SalesHeader."No.", documentNo);
        if SalesHeader.FindFirst() then begin
            if SalesHeader.SendToPosting(CODEUNIT::"Sales-Post (Yes/No)") then begin
                SalesInvoicePerUserBuffer.Reset();
                SalesInvoicePerUserBuffer.SetRange("Sales Invoice No", documentNo);
                if SalesInvoicePerUserBuffer.FindFirst() then begin
                    SalesInvoicePerUserBuffer."Posted By" := FnGetStaffUserID(StaffNo);
                    // SalesInvoicePerUserBuffer.Posted := true;
                    SalesInvoicePerUserBuffer.Modify();
                end else begin
                    SalesInvoicePerUserBuffer.Init();
                    SalesInvoicePerUserBuffer."Sales Invoice No" := documentNo;
                    SalesInvoicePerUserBuffer."Generated By" := FnGetStaffUserID(StaffNo);
                    SalesInvoicePerUserBuffer."Posted By" := FnGetStaffUserID(StaffNo);
                    // SalesInvoicePerUserBuffer.Posted := true;
                    SalesInvoicePerUserBuffer.Insert(true);
                end;


                SalesInvoiceHeader.Reset();
                SalesInvoiceHeader.SetRange("No.", documentNo);
                if SalesInvoiceHeader.FindFirst() then begin
                    SalesInvoiceHeader."User ID" := FnGetStaffUserID(StaffNo);
                    SalesInvoiceHeader.Modify();
                end;

            end;

            returnValue := '{"status":"success"}';
        end else
            Error('Sales invoice no %1 not found', documentNo);
    end;
    //
    procedure FnReceiptSplitLine(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jResultsArray: JsonArray;
        jToken: JsonToken;
        jResultsToken: JsonToken;
        jResultToken: JsonToken;
        visitorNo: Code[30];
        receiptNo: Code[30];
        laboratoryTestCode: Code[50];
        remarks: Text[250];
        staffNo: Code[30];
        myAction: Text;
        specimenCode: Text;
        recId: Text;
        TbReceiptSplit: Record "Receipt Split";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('receiptNo', jToken);
        receiptNo := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbReceiptSplit.Init();
                    TbReceiptSplit."Receipt No" := receiptNo;
                    jObject.Get('payMode', jToken);
                    TbReceiptSplit."Pay Mode" := jToken.AsValue().AsInteger();
                    jObject.Get('bankAccountNo', jToken);
                    TbReceiptSplit."Bank Account No" := jToken.AsValue().AsText();
                    jObject.Get('transactionNo', jToken);
                    TbReceiptSplit."Transaction No" := jToken.AsValue().AsText();
                    jObject.Get('amount', jToken);
                    TbReceiptSplit.Amount := jToken.AsValue().AsDecimal();
                    if (TbReceiptSplit."Pay Mode" = TbReceiptSplit."Pay Mode"::MPESA) or (TbReceiptSplit."Pay Mode" = TbReceiptSplit."Pay Mode"::PDQ) then
                        TbReceiptSplit.Validate("Pay Mode");
                    if TbReceiptSplit.Insert(true) then begin
                        returnValue := '{"status":"success"}';

                    end;
                end;
            'edit', 'edit#save':
                begin
                    TbReceiptSplit.Reset();
                    TbReceiptSplit.SetRange(TbReceiptSplit.SystemId, recId);
                    if TbReceiptSplit.FindFirst() then begin
                        jObject.Get('payMode', jToken);
                        TbReceiptSplit."Pay Mode" := jToken.AsValue().AsInteger();
                        jObject.Get('bankAccountNo', jToken);
                        TbReceiptSplit."Bank Account No" := jToken.AsValue().AsText();
                        jObject.Get('transactionNo', jToken);
                        TbReceiptSplit."Transaction No" := jToken.AsValue().AsText();
                        jObject.Get('amount', jToken);
                        TbReceiptSplit.Amount := jToken.AsValue().AsDecimal();
                        if (TbReceiptSplit."Pay Mode" = TbReceiptSplit."Pay Mode"::MPESA) or (TbReceiptSplit."Pay Mode" = TbReceiptSplit."Pay Mode"::Cash) then
                            TbReceiptSplit.Validate("Pay Mode");
                        if TbReceiptSplit.Rename(TbReceiptSplit."Receipt No", TbReceiptSplit."Pay Mode") then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbReceiptSplit.Reset();
                    TbReceiptSplit.SetRange(TbReceiptSplit.SystemId, recId);
                    if TbReceiptSplit.FindFirst() then begin
                        if TbReceiptSplit.Delete(true) then
                            returnValue := '{"status":"success"}';
                    end;
                end;
        end;
    end;
    //
    procedure FnInpatientBedTransferLine(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jResultsArray: JsonArray;
        jToken: JsonToken;
        jResultsToken: JsonToken;
        jResultToken: JsonToken;
        documentNo: Code[50];
        staffNo: Code[30];
        myAction: Text;
        recId: Text;
        TbRec: Record "HMS Beds Transfer";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbRec.Init();
                    TbRec."Admission No." := documentNo;
                    TbRec.Date := Today;
                    jObject.Get('currentWard', jToken);
                    TbRec."Current Ward" := jToken.AsValue().AsText();
                    jObject.Get('currentBedNo', jToken);
                    TbRec."Current Bed No" := jToken.AsValue().AsText();
                    jObject.Get('newWard', jToken);
                    TbRec."New Ward" := jToken.AsValue().AsText();
                    jObject.Get('newBedNo', jToken);
                    TbRec."New Bed No" := jToken.AsValue().AsText();
                    if TbRec.Insert(true) then begin
                        returnValue := '{"status":"success"}';
                    end;
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        TbRec.Date := Today;
                        jObject.Get('currentWard', jToken);
                        TbRec."Current Ward" := jToken.AsValue().AsText();
                        jObject.Get('currentBedNo', jToken);
                        TbRec."Current Bed No" := jToken.AsValue().AsText();
                        jObject.Get('newWard', jToken);
                        TbRec."New Ward" := jToken.AsValue().AsText();
                        jObject.Get('newBedNo', jToken);
                        TbRec."New Bed No" := jToken.AsValue().AsText();
                        if TbRec.Rename(TbRec."Admission No.") then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}';
                    end;
                end;
            else
                Error(ErrorInvalidAction);
        end;
    end;
    //
    procedure FnInpatientPostBedTransferLine(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        patientNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Beds Transfer";
        receiptNo: Code[30];
        documentNo: Code[30];
        recId: Text[50];
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsText();
        jObject.Get('recId', jToken);
        recId := jToken.AsValue().AsText();
        TbRec.Reset();
        TbRec.SetRange(TbRec."Admission No.", documentNo);
        TbRec.SetRange(TbRec.SystemId, recId);
        if TbRec.FindFirst() then begin
            if CuHMSProcesses.FnPostBedTransferRequest(TbRec) then
                returnValue := '{"status":"success"}';
        end else
            Error('Sales invoice no %1 not found', documentNo);
    end;
    
    //
    //
    procedure FnSHIFRebatesCalculation(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        patientNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Patient";
        receiptNo: Code[30];
        documentNo: Code[30];
        recId: Text[50];
        RebateAmount: Decimal;
        ChargeDate: date;
        InsuaranceCode: Code[30];
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('rebateAmount', jToken);
        RebateAmount := jToken.AsValue().AsDecimal();
        jObject.Get('chargeDate', jToken);
        ChargeDate := jToken.AsValue().AsDate();
        jObject.Get('insuaranceCode', jToken);
        InsuaranceCode := jToken.AsValue().AsCode();
        TbRec.Reset();
        TbRec.SetRange(TbRec."Patient No.", patientNo);
        if TbRec.FindFirst() then begin
            if CuHMSProcesses.FnSHIFRebatesCalculation(TbRec, RebateAmount, ChargeDate, InsuaranceCode) then
                returnValue := '{"status":"success"}';
        end else
            Error('Patient no %1 not found', patientNo);
    end;
    //
    procedure FnDiscountCalculation(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        patientNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Patient";
        receiptNo: Code[30];
        documentNo: Code[30];
        recId: Text[50];
        DiscountPercentage: Decimal;
        DiscountAmount: Decimal;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('discountPercentage', jToken);
        DiscountPercentage := jToken.AsValue().AsDecimal();
        jObject.Get('discountAmount', jToken);
        DiscountAmount := jToken.AsValue().AsDecimal();
        TbRec.Reset();
        TbRec.SetRange(TbRec."Patient No.", patientNo);
        if TbRec.FindFirst() then begin
            if CuHMSProcesses.FnDiscountCalculation(TbRec, DiscountPercentage, DiscountAmount) then
                returnValue := '{"status":"success"}';
        end else
            Error('Patient no %1 not found', patientNo);
    end;
    //
    procedure FnTreatmentSheetLine(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        recId: Text;
        documentNo: Text;
        //
        TbRec: record "HMS Admission Drug Nurse";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();
        jObject.Get('admissionNo', jToken);
        documentNo := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    TbRec.Init();
                    TbRec."Admission No." := documentNo;
                    jObject.Get('drugNo', jToken);
                    TbRec."Drug No." := jToken.AsValue().AsText();
                    TbRec.Validate("Drug No.");
                    jObject.Get('quantity', jToken);
                    TbRec.Quantity := jToken.AsValue().AsDecimal();
                    jObject.Get('dosage', jToken);
                    TbRec.Dosage := jToken.AsValue().AsText();
                    if jObject.Get('remarks', jToken) then
                        TbRec.Remarks := jToken.AsValue().AsText();
                    if jObject.Get('issuedDate', jToken) then
                        TbRec."Issued Date" := jToken.AsValue().AsDate();
                    if jObject.Get('issuedTime', jToken) then
                        TbRec."Issued Time" := jToken.AsValue().AsTime();
                    TbRec.Issued := true;
                    if TbRec.Insert(true) then
                        returnValue := '{"status":"success"}';
                end;
            'edit', 'edit#save':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        jObject.Get('drugNo', jToken);
                        TbRec."Drug No." := jToken.AsValue().AsText();
                        TbRec.Validate("Drug No.");
                        jObject.Get('quantity', jToken);
                        TbRec.Quantity := jToken.AsValue().AsDecimal();
                        jObject.Get('dosage', jToken);
                        TbRec.Dosage := jToken.AsValue().AsText();
                        if jObject.Get('remarks', jToken) then
                            TbRec.Remarks := jToken.AsValue().AsText();
                        if jObject.Get('issuedDate', jToken) then
                            TbRec."Issued Date" := jToken.AsValue().AsDate();
                        if jObject.Get('issuedTime', jToken) then
                            TbRec."Issued Time" := jToken.AsValue().AsTime();
                        if TbRec.Rename(TbRec."Admission No.", TbRec."Drug No.", TbRec."Issued Date", TbRec."Issued Time") then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    TbRec.Reset();
                    TbRec.SetRange(TbRec.SystemId, recId);
                    if TbRec.FindFirst() then begin
                        if TbRec.Delete(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
        end;
    end;
    //
    /* ****** Appointment Management ************* */
    procedure FnCloseBill(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        patientNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        TbRec: Record "HMS Patient";
        HMSCodeUnit: Codeunit "HMS Processes";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        TbRec.Reset();
        TbRec.SetRange(TbRec."Patient No.", patientNo);
        if TbRec.FindFirst() then begin
            if (HMSCodeUnit.FnCloseBill(TbRec)) then begin
                TbRec."Active Cashier" := FnGetStaffUserID(staffNo);
                returnValue := '{"status":"success"}'
            end
            else
                returnValue := '{"status":"failed","msg":"Failed to close bill"}';
        end else
            Error('Patient no %1 not found', patientNo);
    end;

    // procedure FnSickOffSheet(jString: Text) returnValue: Text
    // var
    //     jObject: JsonObject;
    //     jToken: JsonToken;
    //     PatientNo: Code[30];
    //     staffNo: Code[30];
    //     ReportHMSSickoffOP: Report "HMS Sickoff OP";
    //     ReportHMSSickoffIP: Report "HMS Sickoff IP";
    //     HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
    //     HMSAdmissionFormHeader: Record "HMS Admission Form Header";
    //     InPatient: Boolean;
    //     filename: Text;
    //     Convert: DotNet Convert;
    //     IOFile: DotNet File;
    //     TbCharges: record "HMS Patient Charges";
    //     HMSPatient: Record "HMS Patient";
    //     VisitNo: Code[30];
    // begin
    //     jObject.ReadFrom(jString);
    //     jObject.Get('patientNo', jToken);
    //     PatientNo := jToken.AsValue().AsCode();
    //     jObject.Get('staffNo', jToken);
    //     staffNo := jToken.AsValue().AsCode();
    //     jObject.Get('EncounterNo', jToken);
    //     VisitNo := jToken.AsValue().AsCode();
    //     jObject.Get('isInpatient', jToken);
    //     InPatient := jToken.AsValue().AsBoolean();

    //     if InPatient then begin
    //         HMSAdmissionFormHeader.Reset();
    //         HMSAdmissionFormHeader.SetRange("Admission No.", VisitNo);
    //         if HMSAdmissionFormHeader.FindFirst() then begin
    //             returnValue := '';
    //             filename := FILESPATH + '\' + 'Sick Off - ' + PatientNo + '.pdf';
    //             if EXISTS(filename) then
    //                 ERASE(filename);
    //             ReportHMSSickoffIP.SetTableView(HMSAdmissionFormHeader);
    //         end else
    //             Error('No charges found');
    //         ReportHMSSickoffIP.SaveAsPdf(filename);
    //         returnValue := '{"base64":"' + Convert.ToBase64String(IOFile.ReadAllBytes(filename)) + '"}';
    //         if EXISTS(filename) then
    //             ERASE(filename);
    //     end else begin
    //         HMSTreatmentFormHeader.Reset();
    //         HMSTreatmentFormHeader.SetRange("Treatment No.", VisitNo);
    //         if HMSTreatmentFormHeader.FindFirst() then begin
    //             returnValue := '';
    //             filename := FILESPATH + '\' + 'Sick Off - ' + PatientNo + '.pdf';
    //             if EXISTS(filename) then
    //                 ERASE(filename);
    //             ReportHMSSickoffOP.SetTableView(HMSTreatmentFormHeader);
    //         end else
    //             Error('No charges found');
    //         ReportHMSSickoffOP.SaveAsPdf(filename);
    //         returnValue := '{"base64":"' + Convert.ToBase64String(IOFile.ReadAllBytes(filename)) + '"}';
    //         if EXISTS(filename) then
    //             ERASE(filename);
    //     end;
    // end;

    // New Form by Ndirangu
    procedure FnPatientNotesFormItem(jString: Text) returnValue: Text
    var
        ConsultationNotesForm: Record "Consultation Notes Form";
        ConsultationNotesForm2: Record "Consultation Notes Form";
        jObject: JsonObject;
        jToken: JsonToken;
        lineNo: integer;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        encounterNo: Code[30];
        selectedItemId: text;
        itemId: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('itemId', jToken) then
            itemId := jToken.AsValue().AsText();
        if jObject.Get('encounterNo', jToken) then
            encounterNo := jToken.AsValue().AsCode();
        if jObject.Get('systemId', jToken) then
            selectedItemId := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    ConsultationNotesForm2.Reset();
                    ConsultationNotesForm2.SetCurrentKey("Entry No");
                    if ConsultationNotesForm2.FindLast() then
                        lineNo := ConsultationNotesForm2."Entry No";

                    ConsultationNotesForm.Init();
                    ConsultationNotesForm."Entry No" := lineNo + 10;
                    ConsultationNotesForm."Date Taken" := Today;
                    ConsultationNotesForm."Encounter No" := encounterNo;
                    ConsultationNotesForm.validate("Encounter No");
                    jObject.Get('sectionId', jToken);
                    ConsultationNotesForm."Section ID" := jToken.AsValue().AsCode();
                    jObject.Get('categoryId', jToken);
                    ConsultationNotesForm."Category ID" := jToken.AsValue().AsCode();
                    ConsultationNotesForm."Item ID" := itemId;
                    // ConsultationNotesForm.Validate("Item ID");
                    jObject.Get('isSelected', jToken);
                    ConsultationNotesForm.IsSelected := jToken.AsValue().AsBoolean();
                    ConsultationNotesForm.Validate("Item ID");
                    if jObject.Get('specifiedText', jToken) then
                        ConsultationNotesForm."Other (Specify)" := jToken.AsValue().AsText();
                    if ConsultationNotesForm.Insert() then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    ConsultationNotesForm.Reset();
                    ConsultationNotesForm.SetRange("Encounter No", encounterNo);
                    ConsultationNotesForm.SetRange(ConsultationNotesForm."Item ID", itemId);
                    if ConsultationNotesForm.FindFirst() then begin
                        jObject.Get('isSelected', jToken);
                        ConsultationNotesForm.IsSelected := jToken.AsValue().AsBoolean();
                        if jObject.Get('specifiedText', jToken) then
                            ConsultationNotesForm."Other (Specify)" := jToken.AsValue().AsText();
                        if ConsultationNotesForm.Modify() then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    ConsultationNotesForm.Reset();
                    ConsultationNotesForm.SetRange(SystemId, selectedItemId);
                    if ConsultationNotesForm.FindFirst() then begin
                        ConsultationNotesForm.Delete();

                        returnValue := '{"status":"success"}'
                    end
                end;
        end;

    end;

    procedure GetFormItems(JString: Text) returnValue: Text
    var
        ConsultationNotesForm: Record "Consultation Notes Form";
        FormBuilder: Codeunit "GenPatientForm";
        encounterNo: Code[30];
        formValues: Text;
        HierachyJson: JsonObject;
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        inPatient: Boolean;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(JString);
        jObject.Get('EncounterNo', jToken);
        encounterNo := jToken.AsValue().AsText();
        jObject.Get('inPatient', jToken);
        inPatient := jToken.AsValue().AsBoolean();
        if CuHMSProcesses.FnGeneratePatientNotesForm(encounterNo, inPatient) then begin
            returnValue := '{"status":"success"}';
        end;
    end;

    procedure PostWeiver(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[20];
        BillingCodeunit: Codeunit "Patient Billing";
        WeiverRequest: record "HMS Patient Charges Weiver";
    begin
        jObject.ReadFrom(JString);
        jObject.Get('staffNo', jToken);
        staffNo := FnGetStaffUserID(jToken.AsValue.AsText());
        WeiverRequest.Reset();
        // WeiverRequest.SetRange("Line No);



    end;

    procedure FnPostNurseOrderSheet(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[20];
        myAction: Text;
        recId: Text;
        NurseOrderSheet: Record "Nurse Order Sheet";

    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(JString);
        jObject.Get('StaffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('MyAction', jToken);
        myAction := jToken.AsValue().AsText();
        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();

        case myAction of
            'create', 'create#save':
                begin
                    NurseOrderSheet.init();
                    jObject.Get('AdmissionNo', jToken);
                    NurseOrderSheet."Admission No" := jToken.AsValue().AsCode();
                    NurseOrderSheet.Validate("Admission No");
                    jObject.Get('DrugNo', jToken);
                    NurseOrderSheet."Drug No" := jToken.AsValue().AsCode();
                    jObject.Get('PrescriptionDose', jToken);
                    NurseOrderSheet."Prescription Dose" := jToken.AsValue().AsInteger();
                    jObject.Get('Quantity', jToken);
                    NurseOrderSheet.Quantity := jToken.AsValue().AsDecimal();
                    NurseOrderSheet."Requesting Nurse" := FnGetStaffUserID(staffNo);
                    if NurseOrderSheet.Insert(true) then
                        returnValue := '{"status":"success"}';
                end;
            'edit', 'edit#save':
                begin
                    NurseOrderSheet.Reset();
                    NurseOrderSheet.SetRange(SystemId, recId);
                    if NurseOrderSheet.FindFirst() then begin
                        jObject.Get('DrugNo', jToken);
                        NurseOrderSheet."Drug No" := jToken.AsValue().AsCode();
                        jObject.Get('PrescriptionDose', jToken);
                        NurseOrderSheet."Prescription Dose" := jToken.AsValue().AsInteger();
                        NurseOrderSheet."Requesting Nurse" := FnGetStaffUserID(staffNo);
                        jObject.Get('Quantity', jToken);
                        NurseOrderSheet.Quantity := jToken.AsValue().AsDecimal();
                        if NurseOrderSheet.Modify() then
                            returnValue := '{"status":"success"}';
                    end;

                end;
            'delete':
                begin
                    NurseOrderSheet.Reset();
                    NurseOrderSheet.SetRange(SystemId, recId);
                    if NurseOrderSheet.FindFirst() then
                        if NurseOrderSheet.Delete() then
                            returnValue := '{"status":"success"}';

                end;
        end;
    end;

    procedure FnSendOrderSheetToPharmacy(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[20];
        myAction: Text;
        recId: Text;
        AdmissionNo: Code[30];
        HMSPharmacyProcesses: Codeunit "HMS Pharmacy Processes";
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(JString);
        jObject.Get('StaffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('AdmissionNo', jToken);
        AdmissionNo := jToken.AsValue().AsCode();
        HMSAdmissionFormHeader.Reset();
        HMSAdmissionFormHeader.SetRange("Admission No.", AdmissionNo);
        if HMSAdmissionFormHeader.FindFirst() then begin
            if HMSPharmacyProcesses.SendInpatientOrdersheetToPharmacy(HMSAdmissionFormHeader."Admission No.") then
                returnValue := '{"status":"success"}';
        end
    end;

    procedure FnBriefMSEFormItem(jString: Text) returnValue: Text
    var
        BriefMSEForm: Record "Brief MSE Form";
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        encounterNo: Code[30];
        itemId: Text;
        systemID: Text;
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('branchCode', jToken);
        branchCode := jToken.AsValue().AsText();
        if jObject.Get('itemId', jToken) then
            itemId := jToken.AsValue().AsText();
        if jObject.Get('encounterNo', jToken) then
            encounterNo := jToken.AsValue().AsCode();
        if jObject.Get('systemId', jToken) then
            systemID := jToken.AsValue().AsText();
        case myAction of
            'create', 'create#save':
                begin
                    BriefMSEForm.Init();
                    BriefMSEForm."Date Taken" := Today;
                    BriefMSEForm."Encounter No" := encounterNo;
                    jObject.Get('sectionId', jToken);
                    BriefMSEForm."Section ID" := jToken.AsValue().AsCode();
                    jObject.Get('categoryId', jToken);
                    BriefMSEForm."Category ID" := jToken.AsValue().AsCode();
                    BriefMSEForm."Item ID" := itemId;
                    jObject.Get('isSelected', jToken);
                    BriefMSEForm.IsSelected := jToken.AsValue().AsBoolean();
                    if jObject.Get('specifiedText', jToken) then
                        BriefMSEForm."Other (Specify)" := jToken.AsValue().AsText();
                    BriefMSEForm."Administered By" := staffNo;
                    if BriefMSEForm.Insert() then
                        returnValue := '{"status":"success"}'
                end;
            'edit', 'edit#save':
                begin
                    BriefMSEForm.Reset();
                    BriefMSEForm.SetRange("Encounter No", encounterNo);
                    BriefMSEForm.SetRange(BriefMSEForm."Item ID", itemId);
                    if BriefMSEForm.FindFirst() then begin
                        BriefMSEForm."Administered By" := staffNo;
                        jObject.Get('isSelected', jToken);
                        BriefMSEForm.IsSelected := jToken.AsValue().AsBoolean();
                        if jObject.Get('specifiedText', jToken) then
                            BriefMSEForm."Other (Specify)" := jToken.AsValue().AsText();
                        if BriefMSEForm.Modify(true) then
                            returnValue := '{"status":"success"}'
                    end;
                end;
            'delete':
                begin
                    BriefMSEForm.Reset();
                    BriefMSEForm.SetRange(SystemId, systemID);
                    if BriefMSEForm.FindFirst() then begin
                        BriefMSEForm.Delete();
                        returnValue := '{"status":"success"}'
                    end
                end;
        end;
    end;

    procedure FnSaveTCADetails(jString: Text) returnValue: Text
    var
        HMSPatient: Record "HMS Patient";
        PatientManagement: Codeunit "Patient Management";
        jObject: JsonObject;
        jToken: JsonToken;
        staffNo: Code[30];
        branchCode: Code[30];
        myAction: Text;
        AppointmentDate: Date;
        AppointmentTime: Time;
        encounterNo: Code[30];
        PatientNo: Code[30];
        DoctorId: Code[30];
        Remarks: Text[100];
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('PatientNo', jToken);
        PatientNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsText();
        jObject.Get('VisitNo', jToken);
        encounterNo := jToken.AsValue().AsCode();
        jObject.Get('AppointmentDate', jToken);
        AppointmentDate := jToken.AsValue().AsDate();
        jObject.Get('AppointmentTime', jToken);
        AppointmentTime := jToken.AsValue().AsTime();
        jObject.Get('DoctorID', jToken);
        DoctorId := jToken.AsValue().AsCode();
        jObject.Get('Remarks', jToken);
        Remarks := jToken.AsValue().AsText();
        // REFACTOR: Explore Other implementations

        if PatientManagement.FnBookPatientAppointment(PatientNo, encounterNo, AppointmentDate, AppointmentTime, DoctorId, Remarks) then begin
            HMSPatient.Get(PatientNo);
            if HMSPatient.Inpatient then
                returnValue := '{"status":"success", "PatientType":"IP"}'
            else
                returnValue := '{"status":"success","PatientType":"OP"}'
        end;

    end;

    procedure FnInPatientFinalDiagnosis(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        AdmissionNo: Code[30];
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('AdmissionNo', jToken);
        AdmissionNo := jToken.AsValue().AsCode();

        HMSAdmissionFormHeader.Reset();
        HMSAdmissionFormHeader.SetRange("Admission No.", AdmissionNo);
        if HMSAdmissionFormHeader.FindFirst() then begin
            jObject.Get('DiagnosisNo', jToken);
            HMSAdmissionFormHeader."Final Diagnosis" := jToken.AsValue().AsCode();
            if HMSAdmissionFormHeader.Modify() then
                returnValue := '{"status":"success"}';
        end
    end;

    procedure FnRefreshPatientChargesAll(jString: Text) returnValue: Text
    var
        PatientBilling: Codeunit "Patient Billing";
        jObject: JsonObject;
        jToken: JsonToken;
        VisitNo: Code[30];
        PatientNo: Code[30];
        StaffNo: Code[30];
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('VisitNo', jToken);
        VisitNo := jToken.AsValue().AsCode();
        jObject.Get('PatientNo', jToken);
        PatientNo := jToken.AsValue().AsCode();

        if HMSPatientTbl.Get(PatientNo) then
            if PatientBilling.RefreshPatientChargesAll(VisitNo, PatientNo) then
                returnValue := '{"status":"success"}';
    end;

    procedure FnLaboratoryDirectRequest(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        VisitNo: Code[30];
        PatientNo: Code[30];
        StaffNo: Code[30];
        Result: Code[100];
    begin
        returnValue := ErrorSthWrong;
        jObject.ReadFrom(jString);
        jObject.Get('PatientNo', jToken);
        PatientNo := jToken.AsValue().AsCode();

        if HMSPatientTbl.Get(PatientNo) then begin
            Result := CuHMSProcesses.FnDirectDispatchLaboratory(HMSPatientTbl."Patient No.");
            if Result <> '' then begin
                returnValue := Result;
            end
        end;
    end;

    procedure FnGenerateRebatesInvoice(PatientNo: Code[20]; VisitNo: Code[20]) returnValue: Boolean
    var
        GeneratedInvoiceNumber: Code[30];
    begin
        returnValue := false;
        GeneratedInvoiceNumber := '';

        TbHMSSetup.Get();
        TbHMSSetup.TestField("SHIF Customer Code");
        GeneratedInvoiceNumber := HMSPatientintegration.GenerateNHIF_Rebates_Invoice(PatientNo, VisitNo, TbHMSSetup."SHIF Customer Code");
        if GeneratedInvoiceNumber <> '' then
            returnValue := true;
    end;

    // procedure FnPrintCashSHAInvoice(patientNo: Code[20]; VisitNo: Code[30]) returnValue: Text
    // var
    //     HMSPatientCharges: Record "HMS Patient Charges";
    //     FileName: Text[100];
    //     FinalPatientInvoiceNHIF: Report "Final Patient Invoice-NHIF";
    //     Convert: DotNet Convert;
    //     IOFile: DotNet File;
    // begin
    //     HMSPatientCharges.Reset();
    //     HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", patientNo);
    //     HMSPatientCharges.SetRange("Visit No", VisitNo);
    //     HMSPatientCharges.SetRange(HMSPatientCharges.Posted, true);
    //     if HMSPatientCharges.FindSet() then begin
    //         returnValue := '';
    //         filename := FILESPATH + '\' + 'Final invoice - ' + patientNo + '.pdf';
    //         if EXISTS(filename) then
    //             ERASE(filename);
    //         FinalPatientInvoiceNHIF.SetTableView(HMSPatientCharges);
    //     end else
    //         Error('No charges found');
    //     FinalPatientInvoiceNHIF.SaveAsPdf(filename);
    //     returnValue := '{"base64":"' + Convert.ToBase64String(IOFile.ReadAllBytes(filename)) + '"}';
    //     if EXISTS(filename) then
    //         ERASE(filename);
    // end;

    procedure FnManageTranscriptions(jString: Text): Text
    begin
        Clear(ResponseT);
        Clear(jObjectT);
        jObjectT.ReadFrom(jString);

        // Parse JSON values safely
        if jObjectT.Get('myAction', jTokenT) then
            ActionT := LowerCase(jTokenT.AsValue().AsText());
        if jObjectT.Get('encounterType', jTokenT) then
            EncounterTypeT := LowerCase(jTokenT.AsValue().AsText());
        if jObjectT.Get('patientNo', jTokenT) then
            PatientNoT := jTokenT.AsValue().AsCode();
        if jObjectT.Get('clinic', jTokenT) then
            ClinicT := jTokenT.AsValue().AsCode();
        if jObjectT.Get('oldFileNumber', jTokenT) then
            OldFileNumberT := jTokenT.AsValue().AsCode();
        if jObjectT.Get('user', jTokenT) then
            UserT := jTokenT.AsValue().AsCode();
        if jObjectT.Get('encounterNo', jTokenT) then
            EncounterNoT := jTokenT.AsValue().AsCode();
        if jObjectT.Get('admissionDate', jTokenT) then
            Evaluate(AdmissionDateT, jTokenT.AsValue().AsText());
        if jObjectT.Get('dischargeDate', jTokenT) then
            Evaluate(DischargeDateT, jTokenT.AsValue().AsText());

        // Validate required inputs
        if PatientNoT = '' then
            exit('{"status":"error","message":"Patient number is required."}');

        if (ActionT in ['edit', 'delete']) and (EncounterNoT = '') then
            exit('{"status":"error","message":"Encounter number required for edit/delete."}');

        case ActionT of
            'create', 'create#save':
                CreateEncounter();
            'edit', 'edit#save':
                EditEncounter();
            'delete':
                DeleteEncounter();
            else
                exit('{"status":"error","message":"Invalid action."}');
        end;

        exit(ResponseT);
    end;

    local procedure CreateEncounter()
    begin
        HMSSetupT.Get();
        HMSSetupT.TestField("Transcription Nos");
        EncounterNoT := NoSeriesMgt.GetNextNo(HMSSetupT."Transcription Nos", 0D, true);

        case EncounterTypeT of
            'inpatient':
                begin
                    HMSAdmissionFormHeaderT.Init();
                    HMSAdmissionFormHeaderT."Admission No." := EncounterNoT;
                    HMSAdmissionFormHeaderT."Patient No." := PatientNoT;
                    HMSAdmissionFormHeaderT."Admission Date" := AdmissionDateT;
                    HMSAdmissionFormHeaderT."Discharged Date" := DischargeDateT;
                    HMSAdmissionFormHeaderT."Transcribed File No" := OldFileNumberT;
                    HMSAdmissionFormHeaderT."Created By" := UserT;
                    HMSAdmissionFormHeaderT."Clinic Visited" := ClinicT;
                    HMSAdmissionFormHeaderT.isTranscription := true;
                    HMSAdmissionFormHeaderT.Status := HMSAdmissionFormHeaderT.Status::Discharged;
                    HMSAdmissionFormHeaderT.Insert(true);
                end;
            'outpatient':
                begin
                    HMSTreatmentFormHeaderT.Init();
                    HMSTreatmentFormHeaderT."Treatment No." := EncounterNoT;
                    HMSTreatmentFormHeaderT."Patient No." := PatientNoT;
                    HMSTreatmentFormHeaderT."Treatment Date" := AdmissionDateT;
                    HMSTreatmentFormHeaderT."Transcribed File No" := OldFileNumberT;
                    HMSTreatmentFormHeaderT."Clinic Visited" := ClinicT;
                    HMSTreatmentFormHeaderT."Created By" := UserT;
                    HMSTreatmentFormHeaderT.isTranscription := true;
                    HMSTreatmentFormHeaderT.Status := HMSTreatmentFormHeaderT.Status::Completed;
                    HMSTreatmentFormHeaderT.Insert(true);
                end;
            else
                Error('Invalid encounter type.');
        end;

        ResponseT := '{"status":"success","encounterNo":"' + Format(EncounterNoT) + '"}';
    end;

    local procedure EditEncounter()
    begin
        case EncounterTypeT of
            'inpatient':
                if HMSAdmissionFormHeaderT.Get(EncounterNoT) then begin
                    if AdmissionDateT <> 0D then
                        HMSAdmissionFormHeaderT."Admission Date" := AdmissionDateT;
                    if DischargeDateT <> 0D then
                        HMSAdmissionFormHeaderT."Discharged Date" := DischargeDateT;
                    if OldFileNumberT <> '' then
                        HMSAdmissionFormHeaderT."Transcribed File No" := OldFileNumberT;
                    if ClinicT <> '' then
                        HMSAdmissionFormHeaderT."Clinic Visited" := ClinicT;
                    HMSAdmissionFormHeaderT."Modified By" := UserT;
                    HMSAdmissionFormHeaderT.Modify(true);
                end else
                    Error('Inpatient encounter %1 not found.', EncounterNoT);

            'outpatient':
                if HMSTreatmentFormHeaderT.Get(EncounterNoT) then begin
                    if AdmissionDateT <> 0D then
                        HMSTreatmentFormHeaderT."Treatment Date" := AdmissionDateT;
                    if OldFileNumberT <> '' then
                        HMSTreatmentFormHeaderT."Transcribed File No" := OldFileNumberT;
                    if ClinicT <> '' then
                        HMSTreatmentFormHeaderT."Clinic Visited" := ClinicT;
                    HMSTreatmentFormHeaderT."Modified By" := UserT;
                    HMSTreatmentFormHeaderT.Modify(true);
                end else
                    Error('Outpatient encounter %1 not found.', EncounterNoT);
        end;

        ResponseT := '{"status":"success"}';
    end;

    local procedure DeleteEncounter()
    begin
        case EncounterTypeT of
            'inpatient':
                if HMSAdmissionFormHeaderT.Get(EncounterNoT) then begin
                    if HMSAdmissionFormHeaderT.isTranscription then
                        HMSAdmissionFormHeaderT.Delete(true);
                    ResponseT := '{"status":"success"}';
                end else
                    Error('Inpatient encounter %1 not found.', EncounterNoT);
            'outpatient':
                if HMSTreatmentFormHeaderT.Get(EncounterNoT) then begin
                    if HMSTreatmentFormHeaderT.isTranscription then
                        HMSTreatmentFormHeaderT.Delete(true);
                    ResponseT := '{"status":"success"}';
                end else
                    Error('Outpatient encounter %1 not found.', EncounterNoT);
        end;
    end;

}