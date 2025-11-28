namespace HMISBC.HMISBC;
using System.Email;
using System.Security.User;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.NoSeries;

codeunit 52202424 NewHMISPortal
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

        // Create email message body
        mailMessage :=
            '<br> Dear ' + TbEmployee."First Name" + ' ' + TbEmployee."Middle Name" +
            ', your request for password reset was received successfully. Kindly use the One Time Password below to access your employee self service account ' +
            '<br><strong>' + RandomValue + '</strong>' +
            '<br><br><strong>[This is an automated message - Kindly do not reply]</strong>';

        // Try sending email
        if not FnSendEmail('Staff Portal Reset Password Code', TbEmployee."Company E-Mail", mailMessage, '') then
            Error('An error occurred when sending the email. Kindly ask the administrator to check out email configurations.');

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
        CuNoSeries: Codeunit NoSeriesManagement;
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
                returnValue := '{"status":"success","treatmentNo":"' + DocNo + '"}'
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
        CuNoSeries: Codeunit NoSeriesManagement;
        CuHMSProcesses: Codeunit "HMS Processes";

}
