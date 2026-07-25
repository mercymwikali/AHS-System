namespace HMISBC.HMISBC;
using System.Email;
using System.Security.User;
using System.IO;
using Microsoft.Finance.Dimension;
using PTL.HMIS;
using System.Environment;
using Microsoft.Sales.History;
using Microsoft.Sales.Document;
using System.Text;
using System.Utilities;
using Microsoft.Sales.Posting;
using Microsoft.Foundation.Attachment;
using System.Security.AccessControl;
using System;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.NoSeries;

codeunit 85014 NewHMISPortal
{
    // Make the function available as a web service
    [ServiceEnabled]
    procedure StaffForgotPassword(StaffNo: Code[20]; RandomValue: Text): Text
    var
        mailMessage: Text;
        ResponseText: Text;

    begin
        Clear(JsObject);
        ClearLastError();

        if not TbEmployee.Get(StaffNo) then
            Error('Staff Number does not exist.');

        if TbEmployee."Company E-Mail" = '' then
            Error('Your company email is not yet set. Kindly contact HR to set up your email.');

        TbEmployee."Portal Password" := RandomValue;
        TbEmployee."Changed Password" := false;

        if not TbEmployee.Modify(true) then
            Error('Unable to reset user password. Kindly try again. Contact the administrator if this error persists.');

        // // Create email message body
        // mailMessage :=
        //     '<br> Dear ' + TbEmployee."First Name" + ' ' + TbEmployee."Middle Name" +
        //     ', your request for password reset was received successfully. Kindly use the One Time Password below to access your employee self service account ' +
        //     '<br><strong>' + RandomValue + '</strong>' +
        //     '<br><br><strong>[This is an automated message - Kindly do not reply]</strong>';

        // // Try sending email
        // if not FnSendEmail('Staff Portal Reset Password Code', TbEmployee."Company E-Mail", mailMessage, '') then
        //     Error('An error occurred when sending the email. Kindly ask the administrator to check out email configurations.');

        // Compose return JSON
        JsObject.Add('Error', 'FALSE');
        JsObject.Add('Message', 'OTP sent successfully.');

        JsObject.WriteTo(ResponseText);
        exit(ResponseText);
    end;

    [ServiceEnabled]
    procedure FnResetUserPassword(employeeNo: Code[20]; otp: Text; password: Text): Text
    var
        ResponseText: Text;
    begin
        Clear(JsObject);
        ClearLastError();

        TbEmployee.Reset();
        TbEmployee.SetRange("No.", employeeNo);

        if not TbEmployee.FindFirst() then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', 'Invalid employee number or OTP entered.');
            JsObject.WriteTo(ResponseText);
            exit(ResponseText);
        end;

        // Validate OTP
        if TbEmployee."Portal Password" <> otp then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', 'Invalid employee number or OTP entered.');
            JsObject.WriteTo(ResponseText);
            exit(ResponseText);
        end;

        // Update Password
        TbEmployee."Portal Password" := password;
        TbEmployee."Changed Password" := true;

        if TbEmployee.Modify(true) then begin
            JsObject.Add('Error', 'FALSE');
            JsObject.Add('Message', 'You have successfully reset your password.');
        end else begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GetLastErrorText());
        end;

        JsObject.WriteTo(ResponseText);
        exit(ResponseText);
    end;

    [ServiceEnabled]
    procedure FnChangeUserPassword(employeeNo: Code[20]; password: Text): Text
    var
        ResponseText: Text;

    begin
        Clear(JsObject);
        ClearLastError();

        TbEmployee.Reset();
        TbEmployee.SetRange("No.", employeeNo);

        if not TbEmployee.FindFirst() then
            Error('Employee Number does not exist. Cannot update the user password.');

        TbEmployee."Portal Password" := password;
        TbEmployee."Changed Password" := true;

        if not TbEmployee.Modify(true) then begin
            JsObject.Add('Error', 'TRUE');
            JsObject.Add('Error_Message', GetLastErrorText());
            JsObject.WriteTo(ResponseText);
            exit(ResponseText);
        end;

        JsObject.Add('Error', 'FALSE');
        JsObject.Add('Staff_Name', TbEmployee."First Name" + ' ' + TbEmployee."Middle Name" + ' ' + TbEmployee."Last Name");
        JsObject.Add('Message', 'Password updated successfully');

        JsObject.WriteTo(ResponseText);
        exit(ResponseText);
    end;

    [ServiceEnabled]
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
                            HMSPatientTbl.Validate("Insurance No.");
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

                            // smsMsg := 'Hello ' + FirstName + ', thankyou for visiting us. Your Registration number is  ' + Format(NextNo);
                            // if PatientPhone <> '' then
                            //     SMSSenderCodeunit.SendSMS(PatientPhone, smsMsg);

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
    [ServiceEnabled]
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
            // HMSPatientTbl.TestField("Place of Birth Village");
            // HMSPatientTbl.TestField("Next Of kin Full Name");
            // HMSPatientTbl."Global Dimension 1 Code" := branchCode;
            // IF (HMSPatientTbl."Global Dimension 1 Code" = '') THEN
            //     ERROR('Patient Branch cannot be blank');

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
    [ServiceEnabled]
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
                            // AppointmentFormHeader.validate(Doctor);
                        end;
                        // Add Insuarance/Corporate Fields
                        if jObject.Get('dispatchArea', jToken) then
                            AppointmentFormHeader."Dispatch To" := jToken.AsValue().AsOption();
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

    [ServiceEnabled]
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
                returnValue := '{"status":"success","DocNo":"' + DocNo + '"}'
            else
                returnValue := '{"status":"failed","msg":"Something went wrong. Please try again."}'
        end;
    end;


    [ServiceEnabled]
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


    [ServiceEnabled]
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

    [ServiceEnabled]
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
                        returnValue := '{"status":"success", message:"patient vitals saved Successfully"}'
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

    [ServiceEnabled]
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
                    jObject.Get('chronicIlness', jToken);
                    TbAllMed."Chronic Illness" := jToken.AsValue().AsText();
                    jObject.Get('staffNo', jToken);
                    TbAllMed."Assessed By" := jToken.AsValue().AsText();
                    if jObject.Get('type', jToken) then
                        TbAllMed.Type := jToken.AsValue().AsInteger();
                    if TbAllMed.Insert(true) then
                        returnValue := '{"status":"success", Message:"Allergy & chronics data saved successfully."}'
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
                            returnValue := '{"status":"success", Message:"Allergy & chronics data saved successfully."}'
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

    [ServiceEnabled]
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

    [ServiceEnabled]
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

    [ServiceEnabled]
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

    [ServiceEnabled]
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

    [ServiceEnabled]
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

    [ServiceEnabled]
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

    [ServiceEnabled]
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

    [ServiceEnabled]
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

    [ServiceEnabled]
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

    [ServiceEnabled]
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

    [ServiceEnabled]
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

    [ServiceEnabled]
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
        recId: Text;
        TbLHMSSample: record "HMS Sample";
        CuHMSProcesses: Codeunit "HMS Processes"; // Assumed variable definition for your process codeunit
    begin
        returnValue := '{"status":"error","message":"Something went wrong."}'; // Fallback error string

        if not jObject.ReadFrom(jString) then
            exit('{"status":"error","message":"Invalid JSON payload format."}');

        jObject.Get('myAction', jToken);
        myAction := jToken.AsValue().AsText();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('laboratoryNo', jToken);
        laboratoryNo := jToken.AsValue().AsCode();
        jObject.Get('labTestCode', jToken);
        laboratoryTestCode := jToken.AsValue().AsCode();

        if jObject.Get('recId', jToken) then
            recId := jToken.AsValue().AsText();

        case myAction of
            'create', 'create#save':
                begin
                    TbLHMSSample.Init();
                    TbLHMSSample."Laboratory No" := laboratoryNo;
                    TbLHMSSample."Lab Test Code" := laboratoryTestCode;

                    // Core fields populated from frontend sample entry
                    if jObject.Get('typeOfTube', jToken) then
                        TbLHMSSample."Type of Tube" := jToken.AsValue().AsCode();
                    if jObject.Get('quantity', jToken) then
                        TbLHMSSample.Quantity := jToken.AsValue().AsCode();
                    if jObject.Get('unitOfMeasure', jToken) then
                        TbLHMSSample."Unit of Measure" := jToken.AsValue().AsCode();
                    if jObject.Get('sampleRetained', jToken) then
                        TbLHMSSample."Sample Retained" := jToken.AsValue().AsBoolean();
                    if jObject.Get('labUniqueId', jToken) then
                        TbLHMSSample."Lab Unique ID" := jToken.AsValue().AsInteger();

                    // Status handling defaults to New
                    TbLHMSSample.Status := TbLHMSSample.Status::New;
                    if jObject.Get('status', jToken) then begin
                        case jToken.AsValue().AsText() of
                            'Received':
                                TbLHMSSample.Status := TbLHMSSample.Status::Received;
                            'Rejected':
                                TbLHMSSample.Status := TbLHMSSample.Status::Rejected;
                        end;
                    end;

                    if jObject.Get('remarks', jToken) then
                        TbLHMSSample.Remarks := jToken.AsValue().AsText();

                    // Set Primary Key creation timestamp parameters safely on Insert
                    TbLHMSSample."Collected By" := staffNo;
                    TbLHMSSample."Collection Date" := Today;
                    TbLHMSSample."Collection Time" := Time;

                    if TbLHMSSample.Insert(true) then begin
                        CuHMSProcesses.FnLaboratorySubmitSamples(laboratoryNo, laboratoryTestCode);
                        returnValue := '{"status":"success"}';
                    end;
                end;

            'edit', 'edit#save':
                begin
                    TbLHMSSample.Reset();
                    TbLHMSSample.SetRange(SystemId, recId);
                    if TbLHMSSample.FindFirst() then begin
                        // Update modifying payload criteria safely
                        if jObject.Get('typeOfTube', jToken) then
                            TbLHMSSample."Type of Tube" := jToken.AsValue().AsCode();
                        if jObject.Get('quantity', jToken) then
                            TbLHMSSample.Quantity := jToken.AsValue().AsCode();
                        if jObject.Get('unitOfMeasure', jToken) then
                            TbLHMSSample."Unit of Measure" := jToken.AsValue().AsCode();
                        if jObject.Get('sampleRetained', jToken) then
                            TbLHMSSample."Sample Retained" := jToken.AsValue().AsBoolean();
                        if jObject.Get('labUniqueId', jToken) then
                            TbLHMSSample."Lab Unique ID" := jToken.AsValue().AsInteger();

                        if jObject.Get('status', jToken) then begin
                            case jToken.AsValue().AsText() of
                                'New':
                                    TbLHMSSample.Status := TbLHMSSample.Status::New;
                                'Received':
                                    TbLHMSSample.Status := TbLHMSSample.Status::Received;
                                'Rejected':
                                    TbLHMSSample.Status := TbLHMSSample.Status::Rejected;
                            end;
                        end;

                        if jObject.Get('remarks', jToken) then
                            TbLHMSSample.Remarks := jToken.AsValue().AsText();

                        // NOTE: Collection Date and Collection Time are removed here 
                        // because modifying primary keys mid-stream breaks SQL pointer indexing.

                        TbLHMSSample.Modify(true);
                        returnValue := '{"status":"success"}';
                    end else begin
                        returnValue := '{"status":"error","message":"Target sample record could not be found."}';
                    end;
                end;

            'delete':
                begin
                    TbLHMSSample.Reset();
                    TbLHMSSample.SetRange(SystemId, recId);
                    if TbLHMSSample.FindFirst() then begin
                        if TbLHMSSample.Delete(true) then
                            returnValue := '{"status":"success"}';
                    end else begin
                        returnValue := '{"status":"error","message":"Target sample record could not be found for deletion."}';
                    end;
                end;
        end;
    end;

    [ServiceEnabled]
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

    [ServiceEnabled]
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
                    // if jObject.Get('status', jToken) then
                    //     TbRec.Status := jToken.AsValue().AsInteger();
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

    [ServiceEnabled]
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
                    if jObject.Get('positive', jToken) then
                        TbLabLine.Positive := jToken.AsValue().AsBoolean();
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
                    TbLabLine.SetRange(SystemId, recId);
                    if TbLabLine.FindFirst() then begin
                        // 1. Handle primary key changes FIRST if they have altered
                        // Extract the target primary key changes from payload variables cleanly
                        if jObject.Get('labTestCode', jToken) then begin
                            if TbLabLine."Laboratory Test Code" <> jToken.AsValue().AsText() then
                                TbLabLine.Rename(laboratoryNo, jToken.AsValue().AsText(), TbLabLine."Specimen Code", TbLabLine."Duplicate test");
                        end;

                        if jObject.Get('specimenCode', jToken) then begin
                            if TbLabLine."Specimen Code" <> jToken.AsValue().AsText() then
                                TbLabLine.Rename(laboratoryNo, TbLabLine."Laboratory Test Code", jToken.AsValue().AsText(), TbLabLine."Duplicate test");
                        end;

                        // 2. Now map all other standard modifications safely
                        if jObject.Get('unitOfMeasure', jToken) then
                            TbLabLine."Measuring Unit Code" := jToken.AsValue().AsText();
                        if jObject.Get('countValue', jToken) then
                            TbLabLine."Count Value" := jToken.AsValue().AsInteger();

                        jObject.Get('remarks', jToken);
                        TbLabLine.Remarks := jToken.AsValue().AsText();

                        if jObject.Get('positive', jToken) then
                            TbLabLine.Positive := jToken.AsValue().AsBoolean();

                        TbLabLine.Completed := true;
                        TbLabLine."Completion Date" := Today;
                        TbLabLine."Completion Time" := Time;
                        TbLabLine."Staff No" := staffNo;

                        // 3. Commit change tracking values via Modify instead of Rename
                        TbLabLine.Modify(true);
                        returnValue := '{"status":"success"}';
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

    [ServiceEnabled]
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




    [ServiceEnabled]
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
                            //FnUploadAttachedFile(fileJson);
                            returnValue := '{"status":"success"}';
                        end;
                    end;
                end;
        end;
    end;

    [ServiceEnabled]
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
                    // 1. Fetch Appointment Header if it exists
                    HMSAppointmentFormHeader.Reset();
                    HMSAppointmentFormHeader.SetRange("Appointment No.", documentNo); // Added filter to prevent grabbing a random first record
                    if HMSAppointmentFormHeader.FindFirst() then begin
                        TbCharges."Patient No." := HMSAppointmentFormHeader."Patient No.";
                        TbCharges."Doctor ID" := HMSAppointmentFormHeader.Doctor;
                        TbCharges.Validate("Doctor ID");
                    end else begin
                        // 2. Fallback to Admission Header if Appointment isn't found
                        HMSAdmissionFormHeader.Reset();
                        HMSAdmissionFormHeader.SetRange("Admission No.", documentNo);
                        if HMSAdmissionFormHeader.FindFirst() then begin
                            TbCharges."Patient No." := HMSAdmissionFormHeader."Patient No.";
                            TbCharges."Doctor ID" := HMSAdmissionFormHeader.Doctor;
                            TbCharges.Validate("Doctor ID");
                        end;
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
                    TbRec.Validate("Pay Mode");
                    if jObject.Get('amountReceived', jToken) then
                        TbRec."Amount Recieved" := jToken.AsValue().AsDecimal();
                    if jObject.Get('coPay', jToken) then begin
                        TbRec."Co-Pay" := jToken.AsValue().AsBoolean();
                        TbRec.Validate("Co-Pay");
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
                returnValue := StrSubstNo('{"status":"error", "message":"%1"}', GetLastErrorText());
    end;

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

    procedure FnReceiptReport(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        TbReceiptH: Record "Receipts Header";
        RpReceipt: Report "HMS Receipts Report";

        // Cloud-safe streaming variables
        OStream: OutStream;
        IStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef; // Added to handle the compiler error

        // Structured JSON response handling
        ResponseJObject: JsonObject;
        Base64Text: Text;
    begin
        if not jObject.ReadFrom(jString) then
            Error('Invalid JSON format received.');

        if jObject.Get('receiptNo', jToken) then
            documentNo := jToken.AsValue().AsCode();

        if jObject.Get('staffNo', jToken) then
            staffNo := jToken.AsValue().AsCode();

        TbReceiptH.Reset();
        TbReceiptH.SetRange("No.", documentNo);
        if TbReceiptH.FindFirst() then begin
            // Set report parameters/filters
            RpReceipt.SetTableView(TbReceiptH);

            // Link the temporary blob output stream to the report
            TempBlob.CreateOutStream(OStream);

            // FIX: Bind the filtered record to a RecordRef instance
            RecRef.GetTable(TbReceiptH);
            Report.SaveAs(Report::"HMS Receipts Report", '', ReportFormat::Pdf, OStream, RecRef);


            // Convert the generated blob stream to an input stream for Base64 conversion
            TempBlob.CreateInStream(IStream);
            Base64Text := Base64Convert.ToBase64(IStream);

            // Build the return JSON structurally to prevent string manipulation bugs
            ResponseJObject.Add('base64', Base64Text);
            ResponseJObject.WriteTo(returnValue);
        end else
            Error('Receipt no %1 does not exist.', documentNo);
    end;

    procedure FnGenerateInsuranceInvoice(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        patientNo: Code[30];
        staffNo: Code[30];
        branchCode: Code[30];
        HMSCharges: Record "HMS Patient Charges";

    begin
        ClearLastError();

        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        patientNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := FnGetStaffUserID(jToken.AsValue().AsCode());
        if CuHMSProcesses.FnGenerateInsuranceInvoice(patientNo, staffNo) then begin
            HMSCharges.Reset();
            HMSCharges.SetRange("Patient No.", patientNo);

            if HMSCharges.FindFirst() then begin
                DocNo := HMSCharges."Invoice Number";
                returnValue :=
                    '{"status":"success","DocNo":"' + DocNo + '"}';
                exit(returnValue);
            end;
        end;

        ClearLastError();
        returnValue := '{"status":"fail", "msg":"' + GetLastErrorText() + '"}';

    end;

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

    procedure FnInsuranceInvoiceReport(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        staffNo: Code[30];
        VisitNo: Code[30];
        TbCharges: record "HMS Patient Charges";
        RpPatientInvoice: report "Final Patient Invoice";

        // Cloud Alternatives for Files & DotNet
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        OutStream: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        jResultObject: JsonObject;
        RecRef: RecordRef; // Added to handle the compiler error
    begin
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('EncounterNO', jToken);
        VisitNo := jToken.AsValue().AsCode();

        TbCharges.Reset();
        TbCharges.SetRange("Patient No.", documentNo);
        TbCharges.SetRange("Visit No", VisitNo);
        TbCharges.SetRange(Posted, true);

        if not TbCharges.FindSet() then
            Error('No charges found');

        // Filter report and print directly into memory stream
        RpPatientInvoice.SetTableView(TbCharges);
        TempBlob.CreateOutStream(OutStream);

        // FIX: Bind the filtered record to a RecordRef instance
        RecRef.GetTable(TbCharges);
        Report.SaveAs(Report::"Final Patient Invoice", '', ReportFormat::Pdf, OutStream, RecRef);

        // Convert memory stream to base64 text
        TempBlob.CreateInStream(InStream);

        jResultObject.Add('base64', Base64Convert.ToBase64(InStream));
        jResultObject.WriteTo(returnValue);
    end;

    procedure FnPatientInterimInvoice(jString: Text) returnValue: Text
    var
        jObject: JsonObject;
        jToken: JsonToken;
        documentNo: Code[30];
        visitNo: Code[30];
        staffNo: Code[30];
        TbPatieChar: Record "HMS Patient Charges";
        RpInterimInv: Report "HMS Patient Invoice";

        // Cloud Alternatives for Files & DotNet
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        OutStream: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        jResultObject: JsonObject;
        RecRef: RecordRef; // Added to handle the compiler error
    begin
        jObject.ReadFrom(jString);
        jObject.Get('patientNo', jToken);
        documentNo := jToken.AsValue().AsCode();
        jObject.Get('staffNo', jToken);
        staffNo := jToken.AsValue().AsCode();
        jObject.Get('visitNo', jToken);
        visitNo := jToken.AsValue().AsCode();

        TbPatieChar.Reset();
        TbPatieChar.SetRange("Patient No.", documentNo);
        TbPatieChar.SetRange("Visit No", visitNo);

        if not TbPatieChar.FindSet() then
            error('No patient charges found for patient %1 visit %2', documentNo, visitNo);

        // Filter report and print directly into memory stream
        RpInterimInv.SetTableView(TbPatieChar);
        TempBlob.CreateOutStream(OutStream);

        // FIX: Bind the filtered record to a RecordRef instance
        RecRef.GetTable(TbPatieChar);
        Report.SaveAs(Report::"HMS Patient Invoice", '', ReportFormat::Pdf, OutStream, RecRef);

        // Convert memory stream to base64 text
        TempBlob.CreateInStream(InStream);

        jResultObject.Add('base64', Base64Convert.ToBase64(InStream));
        jResultObject.WriteTo(returnValue);
    end;

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

    procedure FnSendEmail(subject: Text[150]; recipients: Text[200]; emailMessage: Text[1000]; ccRecipients: Text[100]) returnValue: Boolean
    var
        CuEmailMessage: Codeunit "Email Message";
        CuEmail: Codeunit Email;
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
                        returnValue := '{"status":"success","AdmissionNo":"' +
                        Format(TbAdm."Treatment No.") +
                        '"}';
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
                Error('Error Saving Admission Details.');
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
                returnValue := '{"status":"success","admissionNo":"' + TbAdm."Admission No." + '"}'
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
                returnValue := '{"status":"success","admissionNo":"' + TbAdm."Admission No." + '"}'
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
                returnValue := '{"status":"success","admissionNo":"' + TbAdm."Admission No." + '"}'
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
                Error('Error Fetching Admission Details.');

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
                Error('Error initiating Bed Transfer process.');
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
    //     Convert: DotNet Convert;
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

    // [ServiceEnabled]
    // procedure FnUploadAttachedFile(jString: Text) return_value: Boolean
    // var
    //     TableFound: Boolean;
    //     FromRecRef: RecordRef;
    //     Bytes: DotNet Array;
    //     Convert: DotNet Convert;
    //     MemoryStream: DotNet MemoryStream;
    //     Ostream: OutStream;
    //     CuFileManagement: Codeunit "File Management";
    //     DocNo1: Code[50];
    //     DocNo2: Code[50];
    //     DocNos: array[20] of Code[50];
    //     myPos: Integer;
    //     myText: Dotnet String;
    //     mySeparator: Dotnet String;
    //     myArray: DotNet Array;
    //     lineNo: Integer;
    //     ObjUsers: Record User;
    //     TbDocumentAttachment: Record "Document Attachment";
    //     jObject: JsonObject;
    //     jToken: JsonToken;
    //     tableId: Integer;
    //     fileName: Text;
    //     attachment: Text;
    //     myUserId: Code[30];
    //     TbRadiologyLine: Record "HMS Radiology Form Line";
    // begin
    //     TableFound := FALSE;
    //     return_value := FALSE;
    //     //
    //     jObject.ReadFrom(jString);
    //     jObject.Get('tableId', jToken);
    //     tableId := jToken.AsValue().AsInteger();
    //     jObject.Get('docNo', jToken);
    //     DocNo := jToken.AsValue().AsText();
    //     jObject.Get('fileName', jToken);
    //     fileName := jToken.AsValue().AsText();
    //     jObject.Get('fileBase64', jToken);
    //     attachment := jToken.AsValue().AsText();
    //     jObject.Get('myUserId', jToken);
    //     myUserId := jToken.AsValue().AsText();
    //     case TableID of
    //         Database::"HMS Radiology Form Line":
    //             begin
    //                 jObject.Get('docNo2', jToken);
    //                 DocNo2 := jToken.AsValue().AsText();
    //                 TbRadiologyLine.RESET;
    //                 TbRadiologyLine.SetRange(TbRadiologyLine."Radiology no.", DocNo);
    //                 TbRadiologyLine.SetRange(TbRadiologyLine."Radiology Type Code", DocNo2);
    //                 if TbRadiologyLine.FIND('-') then begin
    //                     FromRecRef.GETTABLE(TbRadiologyLine);
    //                 end;
    //                 TableFound := true;
    //             end;
    //     end;
    //     //save the file
    //     if tableFound = true then begin
    //         if fileName <> '' then begin
    //             CLEAR(TbDocumentAttachment);
    //             TbDocumentAttachment.INIT();
    //             TbDocumentAttachment.VALIDATE("File Extension", CuFileManagement.GetExtension(fileName));
    //             TbDocumentAttachment.VALIDATE("File Name", COPYSTR(CuFileManagement.GetFileNameWithoutExtension(fileName), 1, MAXSTRLEN(fileName)));
    //             // TbDocumentAttachment.VALIDATE("Table ID", FromRecRef.NUMBER);
    //             TbDocumentAttachment.VALIDATE("No.", docNo);
    //             TbDocumentAttachment."Table ID" := TableID;
    //             if lineNo <> 0 then
    //                 TbDocumentAttachment.VALIDATE(TbDocumentAttachment."Line No.", lineNo);
    //             if DocNos[2] <> '' then
    //                 TbDocumentAttachment.VALIDATE(TbDocumentAttachment."No. 2", DocNos[2]);
    //             Bytes := Convert.FromBase64String(Attachment);
    //             MemoryStream := MemoryStream.MemoryStream(Bytes);
    //             TbDocumentAttachment."Document Reference ID".IMPORTSTREAM(MemoryStream, '', fileName);
    //             ObjUsers.Reset();
    //             ObjUsers.SetRange("User Name", myUserId);
    //             if ObjUsers.Find('-') then
    //                 TbDocumentAttachment."Attached By" := ObjUsers."User Security ID";
    //             TbDocumentAttachment.VALIDATE("Attached Date", CURRENTDATETIME);
    //             TbDocumentAttachment.INSERT();
    //             return_value := true;
    //             if CuFileManagement.DeleteServerFile(fileName) then;
    //         end else
    //             ERROR('File name cannot be blank');
    //     end else begin
    //         ERROR('Related table or record for attached file was not found');
    //     end;
    // end;

    //procedure FnGetDocumentAttachmentBase64(docNo: Code[100]; attachmentID: Integer; tableID: Integer) BaseImage: Text;


    // procedure FnGetDocumentAttachmentBase64(jString: Text) BaseImage: Text;
    // var
    //     FromRecRef: RecordRef;
    //     CuFileManagement: Codeunit "File Management";
    //     Bytes: DotNet Array;
    //     Convert: DotNet Convert;
    //     MemoryStream: DotNet MemoryStream;
    //     Ostream: OutStream;
    //     isTableFound: Boolean;
    //     tableFound: Boolean;
    //     imageID: GUID;
    //     Istream: InStream;
    //     TbDocumentAttachment: record "Document Attachment";
    //     TbTenantMedia: Record "Tenant Media";
    //     jObject: JsonObject;
    //     jToken: JsonToken;
    //     tableID: Integer;
    //     attachmentID: Integer;
    //     docNo: Code[30];
    // begin
    //     jObject.ReadFrom(jString);
    //     jObject.Get('tableId', jToken);
    //     tableId := jToken.AsValue().AsInteger();
    //     jObject.Get('attachmentID', jToken);
    //     attachmentID := jToken.AsValue().AsInteger();
    //     jObject.Get('docNo', jToken);
    //     docNo := jToken.AsValue().AsCode();
    //     TbDocumentAttachment.RESET();
    //     TbDocumentAttachment.SETRANGE("Table ID", tableID);
    //     TbDocumentAttachment.SETRANGE("No.", docNo);
    //     TbDocumentAttachment.SETRANGE(ID, attachmentID);
    //     if TbDocumentAttachment.FINDFIRST() then begin
    //         if TbDocumentAttachment."Document Reference ID".HASVALUE then begin
    //             imageID := TbDocumentAttachment."Document Reference ID".MEDIAID;
    //             if TbTenantMedia.GET(imageID) then begin
    //                 TbTenantMedia.CALCFIELDS(Content);
    //                 TbTenantMedia.Content.CREATEINSTREAM(Istream);
    //                 MemoryStream := MemoryStream.MemoryStream();
    //                 COPYSTREAM(MemoryStream, Istream);
    //                 Bytes := MemoryStream.GetBuffer();
    //                 BaseImage := Convert.ToBase64String(Bytes);
    //             end;
    //         end;
    //     end;
    // end;

    var
        JsObject: JsonObject;
        NextNo: Code[30];
        DocNo: Code[30];
        ErrorSthWrong: Label '{"status":"failed","msg":"Something went wrong. Please try again."}';


        TbEmployee: Record "HR-Employee";
        HMSPatientTbl: record "HMS Patient";
        TbUserSetup: record "User Setup";
        TbHMSSetup: record "HMS Setup";
        TbAppointment: Record "HMS Appointment Form Header";
        CuNoSeries: Codeunit "No. Series";
        CuHMSProcesses: Codeunit "HMS Processes";
        FILESPATH: Label 'C:\inetpub\wwwroot\PortalFiles';

}
