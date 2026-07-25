namespace HMISBC.HMISBC;
using Microsoft.Foundation.NoSeries;
using PTL.HMIS;
using PTL.Hospital;
using System;
using System.Security.User;
using Microsoft.Sales.Customer;
using PTL.HMISBC;

// TODO: Separate Billing Process to its own Proceedure

codeunit 85031 "HMS Processes"
{
    var
        TbHMSSetup: Record "HMS Setup";
        CuNoSeries: Codeunit "No. Series";

    procedure FnDispatchToTriage(RecApp: record "HMS Appointment Form Header") returnValue: Code[30]
    var
        HMSSetup: Record "HMS Setup";
        HMSTreatmentFormHeader: record "HMS Treatment Form Header";
        ObservHeader: record "HMS Observation Form Header";
        recInsurance: record Customer;
        NoSeriesMgt: Codeunit "No. Series";
        SMSSenderCodeunit: Codeunit "SMS Integration Management";
        NewObservationNo: Code[20];
        TreatmentNo: Code[20];
        smsMsg: text;
    begin
        returnValue := '';

        if RecApp."Appointment Type" <> 'REVIEW' then begin
            if ((Today - RecApp."Appointment Date") > 2) then
                Error('This is already an old appointment. Kindly queue the patient for today');

            if GuiAllowed then
                if Confirm('Dispatch selected Appointment to Observation?', false) = false then
                    exit;

            RecApp.TestField("Settlement Type");
            RecApp.TestField("Appointment Date");
            RecApp.TestField("Appointment Time");
            RecApp.TestField("Patient Type");
            // RecApp.TestField(Doctor);
            RecApp.TestField("Patient No.");
            RecApp.TestField("Appointment Type");

            HMSSetup.Reset();
            HMSSetup.Get();
            HMSSetup.TestField("Visit Nos");
            HMSSetup.TestField("Observation Nos");

            // Check if Observation Header Exists
            ObservHeader.Reset();
            ObservHeader.SetRange(ObservHeader."Link No.", RecApp."Appointment No.");
            ObservHeader.SetRange(ObservHeader.Doctor, RecApp.Doctor);
            ObservHeader.SetRange(ObservHeader."Patient No.", RecApp."Patient No.");
            ObservHeader.SetRange(ObservHeader."Observation Date", RecApp."Appointment Date");
            if ObservHeader.FindFirst() then
                NewObservationNo := ObservHeader."Observation No."
            else
                NewObservationNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);
            // Error('You have already dispatched this Patient to Triage');

            HMSTreatmentFormHeader.Reset();
            HMSTreatmentFormHeader.SetRange("Treatment Date", RecApp."Appointment Date");
            HMSTreatmentFormHeader.SetRange("Doctor ID", RecApp.Doctor);
            HMSTreatmentFormHeader.SetRange("Patient No.", RecApp."Patient No.");
            if HMSTreatmentFormHeader.FindFirst() then
                TreatmentNo := HMSTreatmentFormHeader."Treatment No."
            else
                TreatmentNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);

            // Get Next Treatment No and Observation No
            // TODO: Add Patient Charges if the Appointment type Should bill a consultancy fee
            // AddAppointmentConsultancyFee(RecApp, recInsurance, NewObservationNo);
            // Insert Observation Form Header and Treatment Form Header
            if RecApp."Settlement Type" = RecApp."Settlement Type"::Insurance then begin
                RecApp.TestField("Insurance Member No");

                recInsurance.Get(RecApp."Insurance No");
                if recInsurance.Minet = true then
                    if RecApp."MVC No." = '' then Error('Minet MVC No. is required');

                //Insert Observation Header

                InsertObservationHeader(RecApp, NewObservationNo, TreatmentNo);
                // Treatment Header
                InsertTreatmentHeader(RecApp, NewObservationNo, TreatmentNo);
            end else
                if RecApp."Settlement Type" = RecApp."Settlement Type"::Cash then begin
                    //Insert Observation Header
                    InsertObservationHeader(RecApp, NewObservationNo, TreatmentNo);
                    // Treatment Header
                    InsertTreatmentHeader(RecApp, NewObservationNo, TreatmentNo);
                end;


            ModifyAppointmentHeader(RecApp, NewObservationNo, TreatmentNo);

            // if "Settlement Type" = "Settlement Type"::Cash then
            //     CreateReceipt("Patient No.", Patient."Active Visit No")
            // else
            if GuiAllowed then
                Message('Selected Appointment has been dispatched to the Observation Room.');
            returnValue := NewObservationNo;
            if GuiAllowed then
                Message(Format(Today) + Format(RecApp.Time));
        end else begin //Appointment type = Review or Revisit

            if ((Today - RecApp."Appointment Date") > 2) then
                Error('This is already an old appointment. Kindly queue the patient for today');
            if GuiAllowed then
                if Confirm('Dispatch selected Appointment to Observation?', false) = false then
                    exit;

            begin
                RecApp.TestField("Settlement Type");
                RecApp.TestField("Appointment Date");
                RecApp.TestField("Appointment Time");
                RecApp.TestField("Patient Type");
                RecApp.TestField(Doctor);
                RecApp.TestField("Patient No.");
                RecApp.TestField("Appointment Type");
                RecApp.TestField("Special Clinics");

                HMSSetup.Reset();
                HMSSetup.Get();
                HMSSetup.TestField("Visit Nos");
                HMSSetup.TestField("Observation Nos");
                // Check if Observation Header Exists
                ObservHeader.Reset();
                ObservHeader.SetRange(ObservHeader."Link No.", RecApp."Appointment No.");
                ObservHeader.SetRange(ObservHeader.Doctor, RecApp.Doctor);
                ObservHeader.SetRange(ObservHeader."Patient No.", RecApp."Patient No.");
                ObservHeader.SetRange(ObservHeader."Observation Date", RecApp."Appointment Date");
                if ObservHeader.IsEmpty() then
                    NewObservationNo := NoSeriesMgt.GetNextNo(HMSSetup."Observation Nos", 0D, true);
                // Error('You have already dispatched this Patient to Triage');

                HMSTreatmentFormHeader.Reset();
                HMSTreatmentFormHeader.SetRange("Treatment Date", RecApp."Appointment Date");
                HMSTreatmentFormHeader.SetRange("Doctor ID", RecApp.Doctor);
                HMSTreatmentFormHeader.SetRange("Patient No.", RecApp."Patient No.");
                if HMSTreatmentFormHeader.IsEmpty() then
                    TreatmentNo := NoSeriesMgt.GetNextNo(HMSSetup."Visit Nos", 0D, true);

                // TODO: Add Patient Charges if the Appointment type Should bill a consultancy fee  
                // AddAppointmentConsultancyFee(RecApp, recInsurance, NewObservationNo);
                // Insert Observation Form Header and Treatment Form Header
                if RecApp."Settlement Type" = RecApp."Settlement Type"::Insurance then begin
                    RecApp.TestField("Insurance Member No");

                    recInsurance.Get(RecApp."Insurance No");
                    if recInsurance.Minet = true then
                        if RecApp."MVC No." = '' then Error('Minet MVC No. is required');

                    //Insert Observation Header
                    InsertObservationHeader(RecApp, NewObservationNo, TreatmentNo);
                    // Insert Treatment Header
                    InsertTreatmentHeader(RecApp, NewObservationNo, TreatmentNo);
                    //*************** for review cash to create and no need to send to cashier
                end else
                    if RecApp."Settlement Type" = RecApp."Settlement Type"::Cash then begin
                        //Insert Observation Header
                        InsertObservationHeader(RecApp, NewObservationNo, TreatmentNo);
                        // Treatment Header
                        InsertTreatmentHeader(RecApp, NewObservationNo, TreatmentNo);
                    end
            end;
            //***************

            ModifyAppointmentHeader(RecApp, NewObservationNo, TreatmentNo);

            // if "Settlement Type" = "Settlement Type"::Cash then
            //     CreateReceipt("Patient No.", Patient."Active Visit No")
            // else
            if GuiAllowed then
                Message('Selected Appointment has been dispatched to ' + RecApp."Special Clinics");
        end;
        if GuiAllowed then
            Message(Format(Today) + Format(RecApp.Time));
        returnValue := NewObservationNo;
    end;

    procedure FnDispatchWalkinPatient(RecApp: record "HMS Appointment Form Header") returnValue: Code[30]
    begin
        // Just Update the Appointment Form Header with time and make sure waiting at is pharmacy.
        // Update notifications from this end point
        returnValue := '';

        RecApp."Dispatch Date" := Today;
        RecApp."Dispatch Time" := DT2TIME(System.CurrentDateTime);
        RecApp.Status := RecApp.Status::Dispatched;
        RecApp.Modify();

        returnValue := RecApp."Appointment No.";
    end;

    procedure FnCheckifPatientIDExists(IDNumber: Text): Boolean
    var
        HMSPatient: Record "HMS Patient";
    begin
        // Check
        HMSPatient.Reset();
        HMSPatient.SetRange("ID Number", IDNumber);
        if HMSPatient.IsEmpty then
            exit(false)
        else
            exit(true);
    end;
    /// <summary>
    /// function Convert visit entry to patient
    /// </summary>
    /// <param name="VisitNo">Accepts Visit number</param>
    /// <returns>Patient number of the New or Existing Patient</returns>
    procedure FnConvertVisitorToPatient(VisitNo: Text) returnValue: Code[30]
    var
        HMSPatient: Record "HMS Patient";
        SecVisitorMgt: Record "Sec-Visitor Management";
        NoSeriesManagement: Codeunit "No. Series";
        Delimiter: Text;
        NameParts: List of [Text];
    begin
        SecVisitorMgt.Reset();
        if SecVisitorMgt.Get(VisitNo) then
            // First Check if the ID number Exists
            if not FnCheckifPatientIDExists(SecVisitorMgt."ID Number") then begin
                TbHMSSetup.Get();

                HMSPatient.Init();
                HMSPatient."Patient No." := NoSeriesManagement.GetNextNo(TbHMSSetup."Patient Nos", 0D, true);

                HMSPatient.Surname := SecVisitorMgt."First Name";
                HMSPatient."Middle Name" := SecVisitorMgt."Middle Name";
                HMSPatient."Global Dimension 1 Code" := SecVisitorMgt."Global Dimension 1 Code";
                HMSPatient."Last Name" := SecVisitorMgt."Last Name";
                HMSPatient."Search Name" := SecVisitorMgt."Visitor Name";
                HMSPatient."ID Number" := SecVisitorMgt."ID Number";

                HMSPatient."Telephone No. 1" := SecVisitorMgt."Phone Number";
                if HMSPatient.Insert() then begin
                    SecVisitorMgt."Patient No." := HMSPatient."Patient No.";
                    SecVisitorMgt.Status := SecVisitorMgt.Status::"Converted to Patient";
                    SecVisitorMgt.Modify();

                    returnValue := HMSPatient."Patient No.";
                end;
            end else begin
                HMSPatient.Reset();
                HMSPatient.SetRange("ID Number", SecVisitorMgt."ID Number");
                if HMSPatient.FindFirst() then begin
                    if GuiAllowed then Message('Patient Aleady Exists. Patient Number: %1', HMSPatient."Patient No.");
                    returnValue := HMSPatient."Patient No.";
                end;
            end;

    end;

    procedure FnDispatchToDoctor(Recc: record "HMS Observation Form Header") returnValue: Boolean
    var
        HMSClinicsSetup: Record "HMS Clinics Setup";
        HMSPatient: Record "HMS Patient";
        HMSSetup: record "HMS Setup";
        HMSTreatmentFormHeader: record "HMS Treatment Form Header";
        ObsLine: Record "HMS Observation Form Line Proc"; // TODO: Return this implementation to maintain history
        TreatmentLine: Record "HMS Treatment Form Process";
        SMSSenderCodeunit: Codeunit "SMS Integration Management";
        NewTreatmentNo: Code[20];
        smsMsg: text;
    begin
        returnValue := false;
        // Treatment Header Was Already Created. At This Point we only need ot update the Waiting at field and notify the doctor.
        HMSSetup.RESET();
        HMSSetup.GET();
        HMSTreatmentFormHeader.Reset();
        HMSTreatmentFormHeader.SetRange("Treatment No.", Recc."Treatment No");
        if HMSTreatmentFormHeader.FindFirst() then begin
            if HMSClinicsSetup.Get(HMSTreatmentFormHeader.Clinic) then
                if HMSClinicsSetup."Clinic Type" = HMSClinicsSetup."Clinic Type"::Psychology then
                    HMSTreatmentFormHeader.isTherapy := true; //filter special clinics


            HMSTreatmentFormHeader.Status := HMSTreatmentFormHeader.Status::New;
            HMSTreatmentFormHeader."Waiting At" := Recc."Special Clinics";
            HMSTreatmentFormHeader."Urgency Status" := Recc."Urgency Status";
            HMSTreatmentFormHeader.Modify();
        end;
        HMSPatient.Get(Recc."Patient No.");


        // send message to patient
        smsMsg := 'Dear ' + Recc."Patient Name" + ', Your appointment has been dispatched to Doctor ' + Recc."Doctor Name" + '. Please proceed to the ' + Recc."Special Clinics" + ' room for your consultation.';

        // if HMSPatient."Telephone No. 1" <> '' then
        //     SMSSenderCodeunit.SendSMS(HMSPatient."Telephone No. 1", smsMsg);

        /*
        if Appointment.GET("Link No.") then begin
            if Appointment."Appointment Type" <> 'REVIEW' then begin
                PatientCharges.INIT;
                PatientCharges."Line No" := 1;
                PatientCharges."Patient No." := "Patient No.";
                PatientCharges."Link No" := NewTreatmentNo;
                PatientCharges."Treatment No." := NewTreatmentNo;
                PatientCharges.Code := 'CONSULTATION_1';
                if Appointment."Patient Type" = Appointment."Patient Type"::Corporate then
                    PatientCharges.Code := 'CONSULTATION_2';
                PatientCharges.VALIDATE(Code);
                //  PatientCharges.Description:=
                //  PatientCharges.Amount:=
                PatientCharges."Appointment No." := Appointment."Appointment No.";
                PatientCharges.Date := TODAY;
                PatientCharges.INSERT;
            end;
    end;
    */
        Recc.Completed := true;
        Recc.Status := Recc.Status::Closed;
        Recc.Closed := true;
        Recc.MODIFY();

        if GuiAllowed then
            MESSAGE('Success.', smsMsg);
        returnValue := true;
        // end;
        exit(returnValue);
    end;

    procedure RequestLaboratoryTests(Recc: Record "HMS Treatment Form Laboratory") returnV: Code[30]
    var
        DocLabRequestLines: Record "HMS Treatment Form Laboratory";
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
        LaboratoryFormHeader: record "HMS Laboratory Form Header";
        LabHeader: Record "HMS Laboratory Form Header";
        LabTestLines: Record "HMS Laboratory Test Line";
        TreatmentHeader: Record "HMS Treatment Form Header";
        DoctorID: Code[30];
        LaboratoryHeaderNo: Code[20];
        LinkNo: Code[20];
        LinkType: Code[20];
        NewNo: Code[20];
        PatientNumber: Code[20];
        inPatient: Boolean;
    begin
        returnV := '';
        if GuiAllowed then
            if Confirm('Send Laboratory Test Request Now?', false) = false then exit;

        HMSAdmissionFormHeader.Reset();
        if HMSAdmissionFormHeader.Get(recc."Treatment No.") then begin
            PatientNumber := HMSAdmissionFormHeader."Patient No.";
            LinkNo := HMSAdmissionFormHeader."Admission No.";
            DoctorID := HMSAdmissionFormHeader.Doctor;
            LinkType := 'Admission';
            inPatient := true;
        end
        else begin
            TreatmentHeader.Reset();
            if TreatmentHeader.Get(Recc."Treatment No.") then begin
                PatientNumber := TreatmentHeader."Patient No.";
                LinkNo := TreatmentHeader."Treatment No.";
                DoctorID := TreatmentHeader."Doctor ID";
                LinkType := 'Treatment';
                inPatient := false;
            end;
        end;
        LaboratoryHeaderNo := '';

        // Insert/Update Header
        LaboratoryFormHeader.Reset();
        LaboratoryFormHeader.SetRange(LaboratoryFormHeader."Link No.", LinkNo);
        LaboratoryFormHeader.SetRange(Status, LaboratoryFormHeader.Status::New);
        LaboratoryFormHeader.SetRange("Laboratory Date", Recc."Date Due");
        if LaboratoryFormHeader.FindFirst() then begin
            LaboratoryFormHeader."Patient No." := PatientNumber;
            LaboratoryFormHeader."Request Area" := LaboratoryFormHeader."request area"::Doctor;
            LaboratoryFormHeader.Branch := HMSAdmissionFormHeader.Branch;
            LaboratoryFormHeader."Laboratory Date" := Today;
            LaboratoryFormHeader."Laboratory Time" := Recc.Time;
            LaboratoryFormHeader."Link Type" := LinkType;
            LaboratoryFormHeader."Link No." := LinkNo;
            LaboratoryFormHeader."Doctor ID" := DoctorID;
            LaboratoryFormHeader.Inpatient := inPatient;
            LaboratoryFormHeader.Modify();

            LaboratoryHeaderNo := LaboratoryFormHeader."Laboratory No.";
        end
        else begin
            TbHMSSetup.Reset();
            TbHMSSetup.Get();
            NewNo := CuNoSeries.GetNextNo(TbHMSSetup."Lab Test Request Nos", 0D, true);

            LabHeader.Reset();
            LabHeader.Init();
            LabHeader."Laboratory No." := NewNo;
            LabHeader."Laboratory Date" := Today;
            LabHeader."Laboratory Time" := Recc.Time;
            LabHeader."Patient No." := PatientNumber;
            LabHeader."Request Area" := LabHeader."request area"::Doctor;
            LabHeader."Link Type" := LinkType;
            LaboratoryFormHeader.Branch := HMSAdmissionFormHeader.Branch;
            LabHeader."Link No." := LinkNo;
            LabHeader."Doctor ID" := DoctorID;
            LabHeader.Inpatient := inPatient;
            LabHeader.Insert();

            LaboratoryHeaderNo := LabHeader."Laboratory No.";
        end;

        // Insert Lines
        DocLabRequestLines.Reset();
        DocLabRequestLines.SetRange(DocLabRequestLines."Treatment No.", Recc."Treatment No.");
        DocLabRequestLines.SetRange(DocLabRequestLines.Status, DocLabRequestLines.Status::New);
        if DocLabRequestLines.FindSet() then
            repeat
                DocLabRequestLines."Lab No" := LaboratoryHeaderNo;
                DocLabRequestLines.Status := DocLabRequestLines.Status::Forwarded;
                DocLabRequestLines.Modify();

                LabTestLines.Init();
                LabTestLines."Laboratory No." := LaboratoryHeaderNo;
                LabTestLines."Laboratory Test Code" := DocLabRequestLines."Laboratory Test Package Code";
                LabTestLines.Validate("Laboratory Test Code");
                LabTestLines."Lab Request Date" := DocLabRequestLines."Date Due";
                LabTestLines."Lab Request Time" := DocLabRequestLines.Time;
                LabTestLines.Insert();

            until DocLabRequestLines.Next() = 0;

        returnV := NewNo;
    end;
    //
    procedure FnRequestRadiologyTests(Recc: Record "HMS Treatment Form Radiology") returnV: Code[30]
    var
        RadiologyHeader: Record "HMS Radiology Form Header";
        RadiologyLine: Record "HMS Radiology Form Line";
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Radiology";
        NewNo: Code[30];
    begin
        returnV := '';
        if GuiAllowed then
            if Confirm('Send Radiology Request?', false) = false then exit;
        TbHMSSetup.Reset();
        TbHMSSetup.Get();
        NewNo := CuNoSeries.GetNextNo(TbHMSSetup."Radiology Nos", 0D, true);
        TreatmentHeader.Reset();
        if TreatmentHeader.Get(Recc."Treatment No.") then begin
            RadiologyHeader.Reset();
            RadiologyHeader.Init();
            RadiologyHeader."Radiology No." := NewNo;
            RadiologyHeader."Radiology Date" := Today;
            RadiologyHeader."Radiology Time" := Time;
            RadiologyHeader."Radiology Area" := RadiologyHeader."radiology area"::Doctor;
            RadiologyHeader."Patient No." := TreatmentHeader."Patient No.";
            RadiologyHeader."Student No." := TreatmentHeader."Student No.";
            RadiologyHeader."Employee No." := TreatmentHeader."Employee No.";
            RadiologyHeader."Relative No." := TreatmentHeader."Relative No.";
            RadiologyHeader."Link No." := TreatmentHeader."Treatment No.";
            RadiologyHeader."Link Type" := 'Doctor';
            RadiologyHeader.Insert();

            /*Insert the lines*/
            TreatmentLine.Reset();
            TreatmentLine.SetRange(TreatmentLine."Treatment No.", Recc."Treatment No.");
            if TreatmentLine.Find('-') then
                repeat
                    RadiologyLine.Reset();
                    RadiologyLine.Init();
                    RadiologyLine."Radiology no." := NewNo;
                    RadiologyLine."Radiology Type Code" := TreatmentLine."Radiology Type Code";
                    RadiologyLine.Insert();

                    TreatmentLine.Status := TreatmentLine.Status::Forwarded;
                    TreatmentLine.Modify();
                until TreatmentLine.Next() = 0;
        end;

        /* if GuiAllowed then begin
            Report.Run(70135209, true, true, TreatmentHeader);
            Message('Radiology Test Request Forwarded');
        end
        else begin
            Report.Run(70135209, false, true, TreatmentHeader);
        end; */
        returnV := NewNo;
    end;
    // Procedure Request
    procedure FnRequestProcedureTest(Recc: Record "HMS Procedure Requests") returnValue: Boolean
    var
        HMSQue: Record "HMS Doctor Queue";
        Patient: Record "HMS Patient";
    begin
        returnValue := false;
        Recc.Status := Recc.Status::"Request Sent";
        Recc.Modify();
        // Update Queue
        Patient.Get(Recc."Patient No");
        HMSQue.Init();
        HMSQue."Patient No" := Recc."Patient No";
        HMSQue."Visit No" := Patient."Active Visit No";
        HMSQue."Document No" := Recc."Link No";
        HMSQue.Type := Format(Recc."Procedure Type");
        HMSQue."Doctor ID" := Recc."Doctor ID";
        HMSQue.Date := Today;
        HMSQue.Time := Time;
        HMSQue.Insert();
        returnValue := true;
    end;
    // Procedure Request Done
    procedure FnCompleteRequestProcedureTest(Recc: Record "HMS Procedure Requests") returnValue: Boolean
    var
        HMSCharges: Record "HMS Charges";
        HMSPatientCharges: Record "HMS Patient Charges";
        HMSQue: Record "HMS Doctor Queue";
        HMSTransType: Record "HMS Transactions code";
        Patient: Record "HMS Patient";
    begin
        returnValue := false;

        Patient.Get(Recc."Patient No");

        //TODO: Add Billing Implementation Here
        // REFACTOR: If Patient Is Cash They will Need to Pay before The ECT is Done

        // 1. Check if Charges Already Exist
        HMSPatientCharges.Reset();
        HMSPatientCharges.SetRange("Patient No.", Recc."Patient No");
        HMSPatientCharges.SetRange("Visit No", Patient."Active Visit No");
        HMSPatientCharges.SetRange(Date, Recc."Procedure Date");
        HMSPatientCharges.SetRange(Code, Recc."Charge Code");
        if HMSPatientCharges.IsEmpty() then begin
            HMSCharges.get(Recc."Charge Code");
            HMSTransType.get(HMSCharges."Transaction Type");

            HMSPatientCharges.Init();
            HMSPatientCharges."Patient No." := Patient."Patient No.";
            HMSPatientCharges."Link No" := Patient."Active Visit No";
            HMSPatientCharges."Treatment No." := Format(Recc."Procedure Type");
            HMSPatientCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
            HMSPatientCharges."Shortcut Dimension 2 Code" := HMSTransType."Department Code";
            HMSPatientCharges."Transaction Type" := HMSCharges."Transaction Type";
            HMSPatientCharges.Validate("Transaction Type");
            HMSPatientCharges.Code := Format(Recc."Procedure Type");
            HMSPatientCharges.Validate(code);
            HMSPatientCharges.Validate(Amount);
            HMSPatientCharges.Date := Today;
            HMSPatientCharges."User ID" := UserId; // REFACTOR: Pass the Correct User When billing
            HMSPatientCharges."Creation Time" := DT2Time(System.CurrentDateTime);
            HMSPatientCharges."Creation Date" := Today;
            HMSPatientCharges."Admission No" := Patient."Current Adm No";
            HMSPatientCharges."Visit No" := Patient."Active Visit No";
            HMSPatientCharges.Insert();
        end;
        // Error('Patient Already Charged for this Procedure');

        // Update Queue
        HMSQue.Init();
        HMSQue."Patient No" := Recc."Patient No";
        HMSQue."Visit No" := Patient."Active Visit No";
        HMSQue."Document No" := Recc."Link No";
        HMSQue.Type := Format(Recc."Procedure Type");
        HMSQue."Doctor ID" := Recc."Doctor ID";
        HMSQue.Status := HMSQue.Status::Open;
        HMSQue."Queue Type" := 'Procedure Results';
        HMSQue.Date := Today;
        HMSQue.Time := Time;
        HMSQue.Insert();

        // Modify the Record
        Recc.TestField("Procedure Notes");
        Recc.Status := Recc.Status::Done;
        Recc.Modify();


        returnValue := true;
    end;
    //
    procedure FnPostInjectionItemsUsage(Recc: Record "HMS Treatment Form Injection") returnV: Code[30]
    var
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Injection";
        NewNo: Code[30];
    begin
        returnV := '';
        if GuiAllowed then
            if Confirm('Alert Pharmacy About Prescription?') = false then
                exit;
        TbHMSSetup.Reset();
        TbHMSSetup.Get();
        NewNo := CuNoSeries.GetNextNo(TbHMSSetup."Pharmacy Nos", 0D, true);
        //
        /*Get the treatment from the database*/
        TreatmentHeader.Reset();
        if TreatmentHeader.Get(Recc."Treatment No.") then begin
            PharmHeader.Reset();
            PharmHeader.Init();
            PharmHeader."Pharmacy No." := NewNo;
            PharmHeader."Pharmacy Date" := Today;
            PharmHeader."Pharmacy Time" := Time;
            PharmHeader."Request Area" := PharmHeader."request area"::Doctor;
            PharmHeader."Patient No." := TreatmentHeader."Patient No.";
            PharmHeader."Student No." := TreatmentHeader."Student No.";
            PharmHeader."Employee No." := TreatmentHeader."Employee No.";
            PharmHeader."Relative No." := TreatmentHeader."Relative No.";
            PharmHeader."Link Type" := 'Doctor';
            PharmHeader."Link No." := Recc."Treatment No.";
            PharmHeader.Insert();

            TreatmentLine.Reset();
            TreatmentLine.SetRange(TreatmentLine."Treatment No.", Recc."Treatment No.");
            if TreatmentLine.Find('-') then
                repeat
                    PharmLine.Init();
                    PharmLine."Pharmacy No." := NewNo;
                    PharmLine."No." := Recc."Item No.";
                    PharmLine.Quantity := Recc."Injection Quantity";
                    PharmLine.Validate(PharmLine.Quantity);
                    PharmLine."Measuring Unit" := Recc."Injection Unit of Measure";
                    PharmLine.Validate(PharmLine.Quantity);
                    PharmLine.Dosage := Recc.Duration;
                    PharmLine.Pharmacy := Recc."Injection No.";//TODO: Should be a location
                    PharmLine."Link Code" := TreatmentHeader."Link No.";
                    PharmLine.Insert();
                until TreatmentLine.Next() = 0;
            if GuiAllowed then
                Message('The Prescription has been sent to the Pharmacy for Issuance. Issue No:' + NewNo);
            returnV := NewNo;
        end;
    end;
    //
    procedure FnPrescribeDrugs(Recc: Record "HMS Treatment Form Drug") returnV: Code[30]
    var
        HMSPatient: Record "HMS Patient";
        PharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        TreatmentHeader: Record "HMS Treatment Form Header";
        TreatmentLine: Record "HMS Treatment Form Drug";
        NewNo: Code[30];
    begin
        returnV := '';
        if GuiAllowed then
            if Confirm('Alert Pharmacy About Prescription?') = false then
                exit;


        /*Get the treatment from the database*/
        TreatmentHeader.Reset();
        if TreatmentHeader.Get(Recc."Treatment No.") then begin
            TbHMSSetup.Reset();
            TbHMSSetup.Get();
            NewNo := CuNoSeries.GetNextNo(TbHMSSetup."Pharmacy Nos", 0D, true);

            HMSPatient.Reset();
            HMSPatient.Get(TreatmentHeader."Patient No.");

            PharmHeader.Reset();
            PharmHeader.Init();
            PharmHeader."Pharmacy No." := NewNo;
            PharmHeader."Pharmacy Date" := Today;
            PharmHeader."Pharmacy Time" := Time;
            PharmHeader."Request Area" := PharmHeader."request area"::Doctor;
            PharmHeader."Patient No." := TreatmentHeader."Patient No.";
            PharmHeader.InPatient := false;
            PharmHeader."Pharmacy Type" := PharmHeader."Pharmacy Type"::Outpatient;
            PharmHeader."Student No." := TreatmentHeader."Student No.";
            PharmHeader."Employee No." := TreatmentHeader."Employee No.";
            PharmHeader."Relative No." := TreatmentHeader."Relative No.";
            PharmHeader."Doctor ID" := TreatmentHeader."Doctor ID";
            PharmHeader."Global Dimension 1 Code" := HMSPatient."Global Dimension 1 Code"; //REFACTOR: Change this to be 1. Setup Based, or Come from API.
         //   PharmHeader.Validate("Global Dimension 1 Code");
            PharmHeader."Transaction Type" := 'PHARMACY';
            PharmHeader."Link Type" := 'Doctor';
            PharmHeader."Link No." := Recc."Treatment No.";
            PharmHeader.Insert(true);

            TreatmentLine.Reset();
            TreatmentLine.SetRange(TreatmentLine."Treatment No.", Recc."Treatment No.");
            TreatmentLine.SetRange(TreatmentLine.Status, TreatmentLine.Status::New);
            if TreatmentLine.Find('-') then
                repeat
                    PharmLine.Init();
                    PharmLine."Pharmacy No." := NewNo;
                    PharmLine."No." := TreatmentLine."Drug No.";
                  //  PharmLine.Validate("No.");
                    PharmLine.Quantity := TreatmentLine.Quantity;
               //     PharmLine.Validate(PharmLine.Quantity);
                    PharmLine."Measuring Unit" := TreatmentLine."Unit Of Measure";
                  //  PharmLine.Validate(PharmLine.Quantity);
                    PharmLine.Dosage := TreatmentLine.Dosage;
                    PharmLine.Frequency := TreatmentLine.Frequency;
                    PharmLine.Location := PharmHeader."Issuing Location";
                    PharmLine."Prescription Dose" := TreatmentLine."Prescription Dose";
                    PharmLine.Pharmacy := PharmHeader."Issuing Location";
                    PharmLine."Link Code" := TreatmentHeader."Link No.";
                    PharmLine.Insert();

                    TreatmentLine.Status := TreatmentLine.Status::Forwarded;
                    TreatmentLine.Modify();

                until TreatmentLine.Next() = 0;
            if GuiAllowed then
                Message('The Prescription has been sent to the Pharmacy for Issuance');

            returnV := NewNo;
        end;
    end;

    procedure FnRequestPatientAdmission(Recc: Record "HMS Treatment Admission") returnV: Code[30]
    var
        AdmissionHeader: Record "HMS Admission Form Header";
        HMSTreatmentFormDiagnosis: Record "HMS Treatment Form Diagnosis";
        Patient: Record "HMS Patient";
        TreatmentHeader: Record "HMS Treatment Form Header";
        PatientCU: Codeunit "HMS Patient-integration";
        NewNo: Code[20];
    begin
        returnV := '';
        /*Ask for user confirmation*/
        AdmissionHeader.Reset();
        AdmissionHeader.SetRange(AdmissionHeader."Link No.", Recc."Treatment No.");
        AdmissionHeader.SetFilter(Status, '<>%1|%2', AdmissionHeader.Status::Cancelled, AdmissionHeader.Status::Discharged);
        if AdmissionHeader.FindFirst() then
            exit(returnV);

        TbHMSSetup.Reset();
        TbHMSSetup.Get();
        NewNo := CuNoSeries.GetNextNo(TbHMSSetup."Admission Request Nos", 0D, true);
        if GuiAllowed then
            if Confirm('Send the admission request?', false) = false then
                exit;
        TreatmentHeader.Reset();
        if TreatmentHeader.Get(Recc."Treatment No.") then begin
            Patient.Reset();
            Patient.SetRange(Patient."Patient No.", TreatmentHeader."Patient No.");
            Patient.SetRange(Patient.Inpatient, true);
            if not Patient.IsEmpty() then
                Error('The patient is in Admission already');

            AdmissionHeader.Reset();
            AdmissionHeader.Init();
            AdmissionHeader."Admission No." := NewNo;
            AdmissionHeader."Admission Date" := Today;
            AdmissionHeader."Admission Time" := Time;
            AdmissionHeader."Admission Area" := AdmissionHeader."admission area"::Doctor;
            AdmissionHeader."Patient No." := TreatmentHeader."Patient No.";
            AdmissionHeader."Employee No." := TreatmentHeader."Treatment No.";
            AdmissionHeader."Relative No." := TreatmentHeader."Relative No.";
            AdmissionHeader.Ward := Recc."Ward No.";
            AdmissionHeader.Bed := Recc."Bed No.";
            AdmissionHeader.Doctor := TreatmentHeader."Doctor ID";
            AdmissionHeader.Validate(Doctor);
            AdmissionHeader."Global Dimension1" := TreatmentHeader.Branch;
            // Get Diagnosis
            HMSTreatmentFormDiagnosis.Reset();
            HMSTreatmentFormDiagnosis.SetRange(HMSTreatmentFormDiagnosis."Treatment No.", TreatmentHeader."Treatment No.");
            HMSTreatmentFormDiagnosis.SetRange("Diagnosis Type", HMSTreatmentFormDiagnosis."Diagnosis Type"::"Primary Diagnosis");
            if HMSTreatmentFormDiagnosis.FindFirst() then begin
                AdmissionHeader."Diagnosis Code" := HMSTreatmentFormDiagnosis."Diagnosis Code";
                AdmissionHeader.Validate("Diagnosis Code");
            end;

            AdmissionHeader.Branch := TreatmentHeader.Branch;
            AdmissionHeader.Remarks := Recc."Admission Remarks";
            AdmissionHeader."Admission Reason" := Recc."Admission Reason";
            AdmissionHeader."Student No." := TreatmentHeader."Student No.";
            AdmissionHeader."Link Type" := 'Doctor';
            AdmissionHeader."Link No." := TreatmentHeader."Treatment No.";
            AdmissionHeader.Status := AdmissionHeader.Status::New;
            AdmissionHeader.Insert();



            PatientCU.AssignCurrentAdmNo(TreatmentHeader."Patient No.", NewNo);
            if GuiAllowed then
                Message('The Admission Request has been sent');
        end;
        returnV := NewNo;
    end;
    //
    procedure FnRegisterReferral(Recc: Record "HMS Treatment Referral") returnV: Code[30]
    var
        Referral: Record "HMS Referral Header";
        TreatmentHeader: Record "HMS Treatment Form Header";
        NewNo: Code[30];
    begin
        returnV := '';
        if GuiAllowed then
            if Confirm('Register Referral?', false) = false then
                exit;

        TreatmentHeader.Reset();
        if TreatmentHeader.Get(Recc."Treatment No.") then begin
            Referral.Init();
            Referral."Treatment no." := Recc."Treatment No.";
            Referral."Hospital No." := Recc."Hospital No.";
            Referral."Patient No." := TreatmentHeader."Patient No.";
            Referral."Date Referred" := Recc."Date Referred";
            Referral."Referral Reason" := Recc."Referral Reason";
            Referral."Referral Remarks" := Recc."Referral Remarks";
            Referral.Insert();
            returnV := Recc."Treatment No.";
        end;
    end;

    procedure FnGateAdmitVisitor(Recc: Record "Sec-Visitor Management") returnV: Boolean
    var
        NewNo: Code[30];
    begin
        returnV := false;
        Recc.TestField("Visitor Name");
        Recc.TestField("ID Number");
        Recc.TestField("Phone Number");
        Recc.TestField("Person To See");
        Recc.TestField("Purpose of Visit");
        Recc.TestField(Department);
        Recc.TestField("Visitor Pass No.");
        if GuiAllowed then
            if Confirm('Mark visitor as admitted?', true) = false then
                Error('Cancelled by user: %1', UserId);

        Recc."Initiated By" := Format(UserId);
        Recc."Initiated By Time" := Time;
        Recc."Initiated Date" := Today;
        Recc.Status := Recc.Status::Entered;
        Recc.Modify();
        if GuiAllowed then
            Message('Admitted!');
        returnV := true;
    end;

    procedure FnGateClearVisitor(Recc: Record "Sec-Visitor Management") returnV: Boolean
    var
        NewNo: Code[30];
    begin
        returnV := false;
        Recc.TestField("Visitor Name");
        Recc.TestField("ID Number");
        Recc.TestField("Phone Number");
        Recc.TestField("Person To See");
        Recc.TestField("Purpose of Visit");
        Recc.TestField(Department);
        Recc.TestField("Visitor Pass No.");
        if GuiAllowed then
            if Confirm('Mark visitor as cleared?', true) = false then
                Error('Cancelled by user: %1', UserId);

        Recc."Cleared By" := Format(UserId);
        Recc."Cleared By Time" := Time;
        Recc."Cleared Date" := Today;
        Recc.Status := Recc.Status::Cleared;
        Recc.Modify();
        if GuiAllowed then
            Message('cleared!');
        returnV := true;
    end;

    procedure FnReceptionConvertVisitorToPatient(Recc: Record "Sec-Visitor Management") returnV: Code[30]
    var
        HMSPatient: Record "HMS Patient";
        NewNo: Code[30];
        PatientNo: Code[30];
    begin
        returnV := '';
        ///Recc.TestField(Status, Recc.Status::Entered);
        PatientNo := FnConvertVisitorToPatient(Recc.No);
        HMSPatient.Reset();
        returnV := PatientNo;
    end;
    //
    procedure FnConsultationMarkAsCompleted(RecTreatment: record "HMS Treatment Form Header") returnValue: Boolean
    var
        TbObsrHeader: record "HMS Observation Form Header";
    begin
        returnValue := false;
        /*Ask for confirmation*/
        if GuiAllowed then
            if CONFIRM('Mark the Treatment as Completed?', false) = false then
                exit;
        RecTreatment.TESTFIELD("Treatment Date");
        RecTreatment.Status := RecTreatment.Status::Completed;
        RecTreatment.MODIFY();

        TbObsrHeader.RESET();
        TbObsrHeader.SETRANGE(TbObsrHeader."Patient No.", RecTreatment."Patient No.");
        TbObsrHeader.SETRANGE(TbObsrHeader."Observation No.", RecTreatment."Link No.");
        if TbObsrHeader.FIND('-') then begin
            TbObsrHeader.Status := TbObsrHeader.Status::Closed;
            TbObsrHeader.MODIFY();
        end;
        if GuiAllowed then
            MESSAGE('Treatment Marked as Completed');
        returnValue := true;
    end;

    procedure FnConsultationRoomCheckin(RecTreatment: record "HMS Treatment Form Header") returnValue: Boolean
    var
        PatientManagement: Codeunit "Patient Management";

    begin
        returnValue := false;
        if GuiAllowed then
            if CONFIRM('Mark the Consultation as Active?', false) = false then
                exit;
        RecTreatment.Status := RecTreatment.Status::Active;
        RecTreatment.MODIFY();
        // Generate Forms
        PatientManagement.FnGeneratePatientNotesForm(RecTreatment."Treatment No.", false);
        returnValue := true;
    end;

    procedure FnConsultationRoomSendToTriage(RecTreatment: record "HMS Treatment Form Header") returnValue: Boolean
    var
        TbObsrHeader: record "HMS Observation Form Header";
    begin
        returnValue := false;
        if GuiAllowed then
            if CONFIRM('Send to Triage?', false) = false then
                exit;

        TbObsrHeader.RESET();
        TbObsrHeader.SETRANGE(TbObsrHeader."Patient No.", RecTreatment."Patient No.");
        TbObsrHeader.SETRANGE(TbObsrHeader."Observation No.", RecTreatment."Observation No");
        if TbObsrHeader.FIND('-') then begin
            TbObsrHeader.Status := TbObsrHeader.Status::Pending;
            TbObsrHeader.MODIFY();
        end;

        RecTreatment."Waiting At" := 'Triage';
        RecTreatment.MODIFY();
        if GuiAllowed then
            MESSAGE('Sent to Triage');
        returnValue := true;
    end;
    // Doctor Inpatient Activities
    procedure FnVerifyAdmissionRequest(AdmissionHeader: Record "HMS Admission Form Header") returnValue: Boolean
    begin
        // TODO : Implement Pre-Auth before Admission Verificaiton
        AdmissionHeader.Status := AdmissionHeader.Status::Verified;
        AdmissionHeader.Modify();

        returnValue := true;
    end;

    procedure FnCancelAdmissionRequest(AdmissionHeader: Record "HMS Admission Form Header") returnValue: Boolean
    var
        HMSPatient: Record "HMS Patient";
    begin
        HMSPatient.get(AdmissionHeader."Patient No.");
        if HMSPatient."Current Adm No" = AdmissionHeader."Admission No." then begin
            HMSPatient."Current Adm No" := '';
            HMSPatient.Inpatient := false;
            // TODO : Disable Activated when cancelling an admisison?
            HMSPatient.Modify();
        end;

        AdmissionHeader.Status := AdmissionHeader.Status::Cancelled;
        AdmissionHeader.Modify();
        returnValue := true;
    end;

    procedure FnAdmitPatient(VerifiedAdmission: Record "HMS Admission Form Header") returnValue: Boolean
    var
        BedRec: Record "HMS Beds";
        Charges: Record "HMS Charges";
        HMSPatientCharges: Record "HMS Patient Charges";
        PatientManagement: Codeunit "Patient Management";
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
        HMSSetup: Record "HMS Setup";
        Patient: Record "HMS Patient";
        WardCharges: Record "HMS Ward Charges";
        WardRec: Record "HMS Ward Setup";
    begin
        returnValue := false;


        Patient.get(VerifiedAdmission."Patient No.");
        Patient."Active Visit No" := VerifiedAdmission."Admission No.";
        patient.Modify();
        Commit();

        HMSSetup.get();

        // if Admission Header already has bed selected, they can be allocated
        if VerifiedAdmission.Bed <> '' then
            FnBedAllocation(VerifiedAdmission);

        // Insert Admission Fee
        HMSSetup.TestField("Admission Fee");
        HMSSetup.TestField("Nursing Fee Code");
        Charges.get(HMSSetup."Admission Fee");

        // Admission Fee
        HMSPatientCharges.Init();
        HMSPatientCharges."Patient No." := VerifiedAdmission."Patient No.";
        HMSPatientCharges.Validate("Patient No.");
        HMSPatientCharges."Transaction Type" := Charges."Transaction Type";
        HMSPatientCharges.Validate("Transaction Type");
        HMSPatientCharges."Link No" := VerifiedAdmission."Admission No.";
        HMSPatientCharges."Treatment No." := VerifiedAdmission."Admission No.";
        HMSPatientCharges."Appointment No." := VerifiedAdmission."Appointment No.";
        HMSPatientCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
        HMSPatientCharges.Code := HMSSetup."Admission Fee";
        HMSPatientCharges.validate(Code);
        HMSPatientCharges.Amount := Charges.Amount;
        HMSPatientCharges.Validate(Amount);
        HMSPatientCharges.Date := VerifiedAdmission."Admission Date";
        HMSPatientCharges."Shortcut Dimension 2 Code" := Charges."Shortcut Dimension 2 Code";
        HMSPatientCharges."Shortcut Dimension 3 Code" := 'IP';// TODO : Refactor to setup based
        if Patient."Patient Type" = Patient."Patient Type"::Cash then
            HMSPatientCharges."Shortcut Dimension 4 Code" := 'Cash';
        if Patient."Patient Type" = Patient."Patient Type"::Corporate then
            HMSPatientCharges."Shortcut Dimension 4 Code" := 'Corporate';
        HMSPatientCharges."Bill Section" := HMSPatientCharges."Bill Section"::Admissions;
        HMSPatientCharges."User ID" := Format(UserId);
        HMSPatientCharges."Creation Date" := Today;
        HMSPatientCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
        HMSPatientCharges."Admission No" := VerifiedAdmission."Admission No.";
        HMSPatientCharges."Visit No" := Patient."Active Visit No";
        HMSPatientCharges.InPatient := true;
        HMSPatientCharges.Insert();


        // TODO:Insert Nursing      
        Charges.Reset();
        Charges.get(HMSSetup."Nursing Fee Code");

        HMSPatientCharges.Init();
        HMSPatientCharges."Patient No." := VerifiedAdmission."Patient No.";
        HMSPatientCharges.Validate("Patient No.");
        HMSPatientCharges."Transaction Type" := Charges."Transaction Type";
        HMSPatientCharges.Validate("Transaction Type");
        HMSPatientCharges."Link No" := VerifiedAdmission."Admission No.";
        HMSPatientCharges."Treatment No." := VerifiedAdmission."Admission No.";
        HMSPatientCharges."Appointment No." := VerifiedAdmission."Appointment No.";
        HMSPatientCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
        HMSPatientCharges.Code := HMSSetup."Nursing Fee Code";
        HMSPatientCharges.validate(Code);
        HMSPatientCharges.Amount := Charges.Amount;
        HMSPatientCharges.Validate(Amount);
        HMSPatientCharges.Date := VerifiedAdmission."Admission Date";
        HMSPatientCharges."Shortcut Dimension 2 Code" := Charges."Shortcut Dimension 2 Code";
        HMSPatientCharges."Shortcut Dimension 3 Code" := 'IP';// TODO : Refactor to setup based
        if Patient."Patient Type" = Patient."Patient Type"::Cash then
            HMSPatientCharges."Shortcut Dimension 4 Code" := 'Cash';
        if Patient."Patient Type" = Patient."Patient Type"::Corporate then
            HMSPatientCharges."Shortcut Dimension 4 Code" := 'Corporate';
        HMSPatientCharges."Bill Section" := HMSPatientCharges."Bill Section"::Admissions;
        HMSPatientCharges."Billing Type" := HMSPatientCharges."Billing Type"::Reccuring;
        HMSPatientCharges."Reccuring Type" := HMSPatientCharges."Reccuring Type"::Daily;
        HMSPatientCharges."System Created" := false;
        HMSPatientCharges."Billing Start Date" := VerifiedAdmission."Admission Date";
        HMSPatientCharges."User ID" := Format(UserId);
        HMSPatientCharges."Creation Date" := Today;
        HMSPatientCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
        HMSPatientCharges."Admission No" := VerifiedAdmission."Admission No.";
        HMSPatientCharges."Visit No" := Patient."Active Visit No";
        HMSPatientCharges.InPatient := true;
        HMSPatientCharges.Insert();


        Patient.GET(VerifiedAdmission."Patient No.");
        Patient.Inpatient := true;
        Patient.Activated := true;
        Patient."Admissions Date" := VerifiedAdmission."Admission Date";
        Patient."Adm No." := VerifiedAdmission."Admission No.";
        Patient."Current Adm No" := VerifiedAdmission."Admission No.";
        patient."Last Billing Date" := VerifiedAdmission."Admission Date";
        Patient.MODIFY();
        VerifiedAdmission.Status := VerifiedAdmission.Status::Admitted;
        VerifiedAdmission.MODIFY();

  

        if GuiAllowed then
            MESSAGE('Patient Admitted');
        returnValue := true;
    end;

    procedure FnBedAllocation(AdmittedAdmission: Record "HMS Admission Form Header") returnValue: Boolean
    var
        BedRec: Record "HMS Beds";
        Charges: Record "HMS Charges";
        HMSChargesPrices: Record "HMS Charges Prices";
        HMSPatientCharges: Record "HMS Patient Charges";
        Patient: Record "HMS Patient";
        WardRec: Record "HMS Ward Setup";
    begin
        returnValue := false;
        // Insert Ward Charge
        // Error('Bed No: %1 is already occupied, %2', AdmittedAdmission.Bed, AdmittedAdmission."Ward Room");
        WardRec.get(AdmittedAdmission.Ward);
        WardRec.TestField("Charges Code");
        Charges.get(WardRec."Charges Code");

        Patient.Get(AdmittedAdmission."Patient No.");


        BedRec.RESET();
        BedRec.SETRANGE(BedRec."Room No", AdmittedAdmission."Ward Room");
        BedRec.SETRANGE(BedRec."Bed No", AdmittedAdmission.Bed);
        if BedRec.FindFirst() then begin
            // Error('in Bed %1 in room %2 occupancy %3', BedRec."Bed Name", BedRec."Room No", BedRec.Occupied);
            BedRec.Occupied := true;
            BedRec.Modify();
        end;
        // Error('Bed No: %1 is already occupied, %2', AdmittedAdmission.Bed, AdmittedAdmission."Ward Room");

        HMSPatientCharges.INIT();
        HMSPatientCharges."Patient No." := AdmittedAdmission."Patient No.";
        HMSPatientCharges.Validate("Patient No.");
        HMSPatientCharges."Link No" := AdmittedAdmission."Admission No.";
        HMSPatientCharges."Treatment No." := AdmittedAdmission."Link No.";
        HMSPatientCharges."Transaction Type" := Charges."Transaction Type";
        HMSPatientCharges.VALIDATE("Transaction Type");
        HMSPatientCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
        HMSPatientCharges.Code := WardRec."Charges Code";
        HMSPatientCharges.VALIDATE(Code);
        HMSPatientCharges.Description := AdmittedAdmission.Ward + ' ' + AdmittedAdmission.Bed;
        // HMSPatientCharges.VALIDATE(Amount); // TODO : Review OnValidate Trigger Pending Billing process
        HMSPatientCharges.Date := AdmittedAdmission."Admission Date";
        HMSPatientCharges."Bill Section" := HMSPatientCharges."Bill Section"::Admissions;
        HMSPatientCharges."Billing Type" := HMSPatientCharges."Billing Type"::Reccuring;
        HMSPatientCharges."Reccuring Type" := HMSPatientCharges."Reccuring Type"::Daily;
        HMSPatientCharges."Shortcut Dimension 2 Code" := Charges."Shortcut Dimension 2 Code";
        HMSPatientCharges."Shortcut Dimension 3 Code" := 'IP';

        HMSChargesPrices.Reset();
        HMSChargesPrices.SetRange("Charge Code", Charges.Code);
        HMSChargesPrices.SetRange("Branch Code", Patient."Global Dimension 1 Code");
        if HMSChargesPrices.FindFirst() then begin
            if Patient."Patient Type" = Patient."Patient Type"::Cash then begin
                HMSPatientCharges."Shortcut Dimension 4 Code" := 'Cash';
                HMSPatientCharges.Amount := HMSChargesPrices."Cash Amount";
                HMSPatientCharges.Validate(Amount);
            end;
            if Patient."Patient Type" = Patient."Patient Type"::Corporate then begin
                HMSPatientCharges."Shortcut Dimension 4 Code" := 'Corporate';
                HMSPatientCharges.Amount := HMSChargesPrices."Corporate Amount";
                HMSPatientCharges.Validate(Amount);
            end;
        end;

        HMSPatientCharges."Billing Start Date" := AdmittedAdmission."Admission Date";
        HMSPatientCharges."Admission No" := AdmittedAdmission."Admission No.";
        // HMSPatientCharges."Visit No" := Patient."Active Visit No";
        HMSPatientCharges.InPatient := true;
        HMSPatientCharges."System Created" := false;
        HMSPatientCharges.INSERT();

        // Refactor Add Ward charges if The ward has Multiple charges tied to them upon allocation.
        /* WardCharges.reset();
        WardCharges.SetRange("Ward No", AdmittedAdmission.Ward);
        if WardCharges.find('-') then
            repeat
                Charges.get(WardCharges."Charge Code");
                HMSPatientCharges.INIT();
                HMSPatientCharges."Patient No." := AdmittedAdmission."Patient No.";
                HMSPatientCharges."Link No" := AdmittedAdmission."Admission No.";
                HMSPatientCharges."Treatment No." := AdmittedAdmission."Link No.";
                HMSPatientCharges."Transaction Type" := Charges."Transaction Type";
                HMSPatientCharges.VALIDATE("Transaction Type");
                HMSPatientCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
                HMSPatientCharges.Code := Charges.code;
                HMSPatientCharges.VALIDATE(Code);
                HMSPatientCharges.Description := WardCharges."Charge Description";
                HMSPatientCharges.VALIDATE(Amount);
                HMSPatientCharges.Date := TODAY;
                HMSPatientCharges."Bill Section" := HMSPatientCharges."Bill Section"::Admissions;
                HMSPatientCharges."Billing Type" := HMSPatientCharges."Billing Type"::Reccuring;
                HMSPatientCharges."Reccuring Type" := HMSPatientCharges."Reccuring Type"::Daily;
                HMSPatientCharges."Shortcut Dimension 2 Code" := Charges."Shortcut Dimension 2 Code";
                HMSPatientCharges."Shortcut Dimension 3 Code" := 'IP';
                if Patient."Patient Type" = Patient."Patient Type"::Cash then
                    HMSPatientCharges."Shortcut Dimension 4 Code" := 'Cash';
                if Patient."Patient Type" = Patient."Patient Type"::Corporate then
                    HMSPatientCharges."Shortcut Dimension 4 Code" := 'Corporate';
                HMSPatientCharges."Billing Start Date" := TODAY;
                HMSPatientCharges."Admission No" := AdmittedAdmission."Admission No.";
                HMSPatientCharges."Visit No" := Patient."Active Visit No";
                HMSPatientCharges.InPatient := true;
                HMSPatientCharges."System Created" := false;
                HMSPatientCharges.INSERT();
            until WardCharges.next() = 0; */


        returnValue := true;

        exit(returnValue);
    end;

    procedure FnInpatientInitiateDischarge(RecAdmFoH: Record "HMS Admission Form Header") returnValue: Boolean
    var
        DischargeHeader: record "HMS Admission Discharge Header";
        DischargeLine: record "HMS Admission Discharge Line";
        DischargeProcesses: record "HMS Setup Discharge Processes";
    begin
        returnValue := false;
        DischargeHeader.Reset();
        DischargeHeader.SetRange(DischargeHeader."Admission No.", RecAdmFoH."Admission No.");
        if DischargeHeader.Find('-') then
            DischargeHeader.DeleteAll();
        DischargeHeader.Reset();
        DischargeHeader.Init();
        DischargeHeader."Discharge Date" := Today;
        DischargeHeader."Admission No." := RecAdmFoH."Admission No.";
        DischargeHeader."Patient No." := RecAdmFoH."Patient No.";
        DischargeHeader."Ward No." := RecAdmFoH.Ward;
        DischargeHeader."Bed No." := RecAdmFoH.Bed;
        DischargeHeader."Date of Admission" := RecAdmFoH."Admission Date";
        DischargeHeader."Time Of Admission" := RecAdmFoH."Admission Time";
        DischargeHeader."Next Appointment Date" := RecAdmFoH."Next Appointment Date";
        if RecAdmFoH."Next Apointment Slot" <> '' then
            DischargeHeader."Next Apointment Slot" := RecAdmFoH."Next Apointment Slot";
        // DischargeHeader.Validate("Next Apointment Slot");

        DischargeHeader.Insert();

        DischargeLine.Reset();
        DischargeLine.SetRange(DischargeLine."Admission No.", RecAdmFoH."Admission No.");
        if DischargeLine.Find('-') then
            DischargeLine.DeleteAll();
        DischargeProcesses.Reset();
        if DischargeProcesses.Find('-') then
            repeat
                DischargeLine.Init();
                DischargeLine."Admission No." := RecAdmFoH."Admission No.";
                DischargeLine."Process Code" := DischargeProcesses.Code;
                DischargeLine.Validate(DischargeLine."Process Code");
                DischargeLine.Insert();
            until DischargeProcesses.Next() = 0;

        RecAdmFoH.Status := RecAdmFoH.Status::"Discharge Pending";
        RecAdmFoH.Modify();
        returnValue := true;
    end;

    procedure FnInpatientCancelDischarge(RecAdmFoH: Record "HMS Admission Discharge Header") returnValue: Boolean
    var
        AdmH: Record "HMS Admission Form Header";
        PatRec: Record "HMS Patient";
    begin
        returnValue := false;
        if patrec.get(RecAdmFoH."Patient No.") then begin
            PatRec.Activated := true;
            PatRec.Inpatient := true;
            PatRec.modify();
        end;
        if AdmH.get(RecAdmFoH."Admission No.") then begin
            AdmH.Status := AdmH.Status::Admitted;
            AdmH.modify();
        end;
        RecAdmFoH.Delete();
        returnValue := true;
    end;

    procedure FnInpatientPostDischarge(RecDisc: Record "HMS Admission Discharge Header"; PostingUser: Code[30]) returnValue: Boolean
    var
        AdmissionFormHeader: Record "HMS Admission Form Header";
        HMSAdmissionDischargeHeader: Record "HMS Admission Discharge Header";
        HMSBeds: Record "HMS Beds";
        HMSPat: Record "HMS Patient";
        HMSSetup: record "HMS Setup";
        HMS: Codeunit "HMS Patient-integration";
        SecurityCode: code[30];
        mBillBal: Decimal;
    begin
        returnValue := false;
        if HMSPat.Get(RecDisc."Patient No.") then begin
            // HMSPat.SETFILTER(HMSPAT.
            HMSPat.CalcFields(HMSPat."Invoice Amount");
            HMSPat.CalcFields(HMSPat."Receipt Amount");
            HMSPat.CalcFields(HMSPat."Visit Invoice No");
            HMSPat.CalcFields(HMSPat."Bill Balance");
            HMSPat.CalcFields(HMSPat.Balance);
            mBillBal := HMSPat."Bill Balance";

            if (HMSPat."Visit Invoice No" = '') and (HMSPat."Patient Type" = HMSPat."patient type"::Corporate) and (mBillBal > 0) then
                Error('Please note that you can not clear a Patient with open bills, Either raise the invoice or clear the bill');

            if (mBillBal > 10) and (HMSPat."Patient Type" = HMSPat."patient type"::Cash) then
                Error('Please note that you can not clear a Patient with open bills, Either raise the invoice or clear the bill');
        end;
        RecDisc.TestField("Discharge Date");

        HMS.CloseBill(RecDisc."Patient No.");
        // Discharge Patient
        if HMSPat.Get(RecDisc."Patient No.") then begin
            HMSPat.Inpatient := false;
            HMSPat."Discharge Date" := RecDisc."Discharge Date";
            HMSPat."Discharged Type" := RecDisc."Discharge Type";
            HMSPat.Activated := false;
            HMSPat."Active Visit No" := '';
            HMSPat.Modify();
        end;
        // Free Bed
        HMSBeds.Reset();
        HMSBeds.SetRange("Ward No", RecDisc."Ward No.");
        HMSBeds.SetRange("Room No", RecDisc."Ward Room No.");
        HMSBeds.SetRange(HMSBeds."Bed No", RecDisc."Bed No.");
        if HMSBeds.FindFirst() then begin
            HMSBeds.Occupied := false;
            HMSBeds.Modify();
        end;

        AdmissionFormHeader.Reset();
        AdmissionFormHeader.SetRange(AdmissionFormHeader."Admission No.", RecDisc."Admission No.");
        if AdmissionFormHeader.Find('-') then begin
            AdmissionFormHeader.Status := AdmissionFormHeader.Status::Discharged;
            AdmissionFormHeader."Discharged Date" := RecDisc."Discharge Date";
            AdmissionFormHeader."Discharged By" := PostingUser;
            AdmissionFormHeader.Modify();
        end;

        HMSSetup.Get();
        SecurityCode := CuNoSeries.GetNextNo(HMSSetup."Security Nos", Today, true);

        RecDisc.Status := RecDisc.Status::Completed;
        RecDisc."Discharge Time" := Time;
        RecDisc."Security Code" := SecurityCode;
        RecDisc."Discharged By" := PostingUser;
        RecDisc.Modify();

        HMSAdmissionDischargeHeader.Reset();
        HMSAdmissionDischargeHeader.SetRange(HMSAdmissionDischargeHeader."Admission No.", RecDisc."Admission No.");
        HMSAdmissionDischargeHeader.SetRange(HMSAdmissionDischargeHeader."Security Code", SecurityCode);
        if HMSAdmissionDischargeHeader.Find('-') then
            if GuiAllowed then
                Report.Run(Report::"Discharge Slip", false, false, HMSAdmissionDischargeHeader);

        returnValue := true;
    end;

    procedure FnInpatientReleaseBed(RecDisc: Record "HMS Admission Discharge Header") returnValue: Boolean
    var
        HMSBeds: Record "HMS Beds";
        Patient: Record "HMS Patient";
    begin
        returnValue := false;
        HMSBeds.Reset();
        HMSBeds.SetRange(HMSBeds."Bed No", RecDisc."Bed No.");
        HMSBeds.SetRange("Ward No", RecDisc."Ward No.");
        if HMSBeds.Find('-') then begin
            HMSBeds.Occupied := false;
            HMSBeds.Modify();
            if Patient.Get(RecDisc."Patient No.") then begin
                Patient.Activated := false;
                Patient.Modify();
            end;
        end;
        returnValue := true;
    end;

    procedure FnRadiologyForwardRequest(RecTb: Record "HMS Radiology Form Header") returnValue: Boolean
    var
        HMSQue: Record "HMS Doctor Queue";
        Patient: Record "HMS Patient";
    begin
        returnValue := false;
        RecTb.Status := RecTb.Status::Forwarded;
        RecTb.Modify();
        // Update Queue
        Patient.Get(RecTb."Patient No.");
        HMSQue.Init();
        HMSQue."Patient No" := RecTb."Patient No.";
        HMSQue."Visit No" := Patient."Active Visit No";
        HMSQue."Document No" := RecTb."Radiology No.";
        HMSQue.Type := 'RADIOLOGY';
        HMSQue."Doctor ID" := RecTb."Doctor ID";
        HMSQue.Date := Today;
        HMSQue.Time := Time;
        HMSQue.Insert();
        returnValue := true;
    end;

    procedure FnPharmacyPostDrugIssuance(RecTb: Record "HMS Pharmacy Header") returnValue: Boolean
    var
        AppH: Record "HMS Appointment Form Header";
        HMSQue: Record "HMS Doctor Queue";
        Patient: Record "HMS Patient";
        PharmHeader: record "HMS Pharmacy Header";
        PTLFactory: Codeunit "PTL Factory";
    begin
        returnValue := false;
        RecTb.TestField("Transaction Type");
        // RecTb.TestField("Issuing Location");
        //TESTFIELD("Issued By");
        if RecTb."Issued By" = '' then
            RecTb."Issued By" := Format(UserId);

        if AppH.Get(RecTb."Link No.") then;

        Patient.Reset;
        Patient.SetRange(Patient."Patient No.", RecTb."Patient No.");
        Patient.SetRange(Patient.Inpatient, true);
        if Patient.Find('-') then begin
            RecTb."Cash Sale" := false;
        end;

        Patient.Reset;
        Patient.SetRange(Patient."Patient No.", RecTb."Patient No.");
        Patient.SetRange(Patient.Inpatient, false);
        if Patient.Find('-') then begin
            if AppH."Settlement Type" = AppH."Settlement Type"::Cash then
                RecTb."Cash Sale" := true;
            Patient.Activated := true;
            // Patient."Active Visit No":=AppH."Appointment No.";
            Patient.Modify;

        end;
        RecTb.CheckSuffientStock;
        RecTb.CheckLotSizeallocation();
        Patient.SetRange(Patient."Patient No.", RecTb."Patient No.");
        if Patient.Find('-') then
            Patient.CalcFields(Patient."Bill Balance");

        // if (RecTb."Cash Sale" = false) or (RecTb.Status = RecTb.Status::Paid) then
        RecTb.PostItems(RecTb."Pharmacy No.");
        //PTLFactory.PostPharmLine(RecTb."Pharmacy No.");


        RecTb.ChargePatient;
        // HMSCU.PostCharges("Patient No.", Patient."Active Visit No");


        AppH.SetRange(AppH."Appointment No.", RecTb."Link No.");
        if AppH.Find('-') then begin
            AppH."Pharmacy Time Out" := CurrentDateTime;
            AppH."Waiting At" := AppH."Waiting At";
            AppH.Modify;
        end;
        //  IF ("Cash Sale"=FALSE)  THEN BEGIN
        if (RecTb.Status = RecTb.Status::New) and (RecTb."Cash Sale" = false) then begin
            PharmHeader.Reset;
            PharmHeader.SetRange(PharmHeader."Pharmacy No.", RecTb."Pharmacy No.");
            if PharmHeader.Find('-') then begin
                if PharmHeader.Status = PharmHeader.Status::New then
                    PharmHeader.Status := PharmHeader.Status::Completed;
                PharmHeader.Charged := true;
                PharmHeader.Modify;
            end;
        end else begin
            PharmHeader.Reset;
            PharmHeader.SetRange(PharmHeader."Pharmacy No.", RecTb."Pharmacy No.");
            if PharmHeader.Find('-') then begin
                PharmHeader.Charged := true;
                PharmHeader.Modify;
            end;
        end;
        returnValue := true;
    end;

    procedure FnPharmacyArchivePrescription(RecTb: Record "HMS Pharmacy Header") returnValue: Boolean
    var
        HMSQue: Record "HMS Doctor Queue";
        PatCharges: Record "HMS Patient Charges";
    begin
        returnValue := false;
        PatCharges.reset;
        PatCharges.setrange("Patient No.", RecTb."Patient No.");
        PatCharges.setrange("Visit No", RecTb."Link No.");
        PatCharges.setrange("Transaction Type", 'PHARMACY');
        PatCharges.setrange(Posted, false);
        if PatCharges.find('-') then PatCharges.DeleteAll();
        RecTb.Status := RecTb.Status::Cancelled;
        RecTb."Issued By" := userid;
        if RecTb.modify then
            returnValue := true;
    end;

    procedure FnDirectDispatchLaboratory(PatientNumber: Code[20]) returnValue: Code[100]
    var
        HMSLaboratoryFormHeader: Record "HMS Laboratory Form Header";
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
        HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
        HMSPatient: Record "HMS Patient";
        LaboratoryHeaderNo: Code[20];
        DoctorID: Code[30];
        DoctorNames: Text[250];
        LinkNo: Code[20];
        LinkType: Code[20];
        NewNo: Code[20];
        RequestArea: Option Doctor,Admission,Walkin;
        Inpatient: Boolean;
        returnLbl: Label '{"status":"success", "LaboratoryNo":"%1","RequestType":"%2"}', comment = '%1 = LabHeader no %2 = Request Type';

        RequestType: Text[10];
    begin
        DoctorID := '';
        LinkNo := '';
        LinkType := '';
        NewNo := '';
        LaboratoryHeaderNo := '';
        returnValue := '';
        Inpatient := false;
        RequestType := '';

        HMSPatient.Get(PatientNumber);
        HMSPatient.TestField("Active Visit No");
        if HMSPatient.Inpatient then begin
            HMSAdmissionFormHeader.Reset();
            HMSAdmissionFormHeader.SetRange("Admission No.", HMSPatient."Active Visit No");
            if HMSAdmissionFormHeader.FindFirst() then begin
                HMSAdmissionFormHeader.CalcFields("Dr Name");
                DoctorID := HMSAdmissionFormHeader.Doctor;
                DoctorNames := HMSAdmissionFormHeader."Dr Name";
                LinkType := 'Admission';
                RequestArea := RequestArea::Admission;
                LinkNo := HMSAdmissionFormHeader."Admission No.";
                RequestType := '1';
                Inpatient := true;
            end;
        end else begin
            HMSAppointmentFormHeader.Reset();
            HMSAppointmentFormHeader.SetRange("Appointment No.", HMSPatient."Active Visit No");
            if HMSAppointmentFormHeader.FindFirst() then begin
                HMSAppointmentFormHeader.CalcFields("Doctor Name");
                DoctorID := HMSAppointmentFormHeader.Doctor;
                DoctorNames := HMSAppointmentFormHeader."Doctors Name";
                if HMSAppointmentFormHeader."Treatment No" <> '' then begin
                    LinkNo := HMSAppointmentFormHeader."Treatment No";
                    RequestArea := RequestArea::Doctor;
                    RequestType := '0';
                end else begin
                    LinkNo := HMSAppointmentFormHeader."Appointment No.";
                    RequestArea := RequestArea::Walkin;
                    RequestType := '2';
                end;
                Inpatient := false;
                LinkType := 'Treatment';
            end;
        end;

        HMSLaboratoryFormHeader.Reset();
        HMSLaboratoryFormHeader.SetRange(HMSLaboratoryFormHeader."Link No.", LinkNo);
        HMSLaboratoryFormHeader.SetRange("Laboratory Date", Today);
        HMSLaboratoryFormHeader.SetRange(Status, HMSLaboratoryFormHeader.Status::New);
        if HMSLaboratoryFormHeader.FindFirst() then begin
            HMSLaboratoryFormHeader."Patient No." := PatientNumber;
            HMSLaboratoryFormHeader."Request Area" := RequestArea;
            HMSLaboratoryFormHeader."Laboratory Date" := Today;
            HMSLaboratoryFormHeader."Laboratory Time" := Time;
            HMSLaboratoryFormHeader."Link Type" := LinkType;
            HMSLaboratoryFormHeader."Link No." := LinkNo;
            HMSLaboratoryFormHeader."Doctor ID" := DoctorID;
            HMSLaboratoryFormHeader."Request Area" := RequestArea;
            HMSLaboratoryFormHeader.Inpatient := Inpatient;
            HMSLaboratoryFormHeader.Branch := HMSPatient."Global Dimension 1 Code";
            HMSLaboratoryFormHeader.Modify();

            LaboratoryHeaderNo := HMSLaboratoryFormHeader."Laboratory No.";
        end else begin
            TbHMSSetup.Get();
            NewNo := CuNoSeries.GetNextNo(TbHMSSetup."Lab Test Request Nos", 0D, true);

            HMSLaboratoryFormHeader.Reset();
            HMSLaboratoryFormHeader.Init();
            HMSLaboratoryFormHeader."Laboratory No." := NewNo;
            HMSLaboratoryFormHeader."Laboratory Date" := Today;
            HMSLaboratoryFormHeader."Laboratory Time" := Time;
            HMSLaboratoryFormHeader."Patient No." := PatientNumber;
            HMSLaboratoryFormHeader."Link Type" := LinkType;
            HMSLaboratoryFormHeader."Link No." := LinkNo;
            HMSLaboratoryFormHeader."Doctor ID" := DoctorID;
            HMSLaboratoryFormHeader."Request Area" := RequestArea;
            HMSLaboratoryFormHeader.Inpatient := Inpatient;
            HMSLaboratoryFormHeader.Branch := HMSPatient."Global Dimension 1 Code";
            HMSLaboratoryFormHeader.Insert();

            LaboratoryHeaderNo := HMSLaboratoryFormHeader."Laboratory No.";
        end;

        returnValue := StrSubstNo(returnLbl, LaboratoryHeaderNo, RequestType);
    end;

    // This procedure changes Sample Submission Status in lab lines and prefills results template.
    procedure FnLaboratorySubmitSamples(LabNo: Code[50]; LabTestCode: Code[50]) returnValue: Boolean
    var
        HMSLaboratoryFormHeader: Record "HMS Laboratory Form Header";
        HMSLaboratoryResultsEntry: Record "HMS Laboratory Results Entry";
        HMSLaboratoryTestLine: Record "HMS Laboratory Test Line";
        HMSLabParameterssetup: Record "HMS Lab Parameters setup";
    begin
        if GuiAllowed then
            if Confirm('Kindly Ensure all samples have been received', false) then;

        // Go through each line
        HMSLaboratoryTestLine.Reset();
        HMSLaboratoryTestLine.SetRange("Laboratory No.", LabNo);
        HMSLaboratoryTestLine.SetRange("Laboratory Test Code", LabTestCode);
        if HMSLaboratoryTestLine.FindFirst() then begin
            // First Delete Results Entry of the test
            HMSLaboratoryResultsEntry.Reset();
            HMSLaboratoryResultsEntry.SetRange("Laboratory No.", HMSLaboratoryTestLine."Laboratory No.");
            HMSLaboratoryResultsEntry.SetRange("Laboratory Test Code", HMSLaboratoryTestLine."Laboratory Test Code");
            if HMSLaboratoryResultsEntry.FindSet() then HMSLaboratoryResultsEntry.DeleteAll();

            // Insert Results Lines
            HMSLabParameterssetup.Reset();
            HMSLabParameterssetup.SetRange("Laboratory Test Code", HMSLaboratoryTestLine."Laboratory Test Code");
            HMSLabParameterssetup.SetAutoCalcFields("Result Type");
            if HMSLabParameterssetup.FindSet() then
                repeat
                    HMSLaboratoryResultsEntry.Init();
                    HMSLaboratoryResultsEntry."Laboratory No." := HMSLaboratoryTestLine."Laboratory No.";
                    HMSLaboratoryResultsEntry."Laboratory Test Code" := HMSLaboratoryTestLine."Laboratory Test Code";
                    HMSLaboratoryResultsEntry."Specimen Code" := HMSLabParameterssetup."Specimen Code";
                    HMSLaboratoryResultsEntry."Assigned User ID" := HMSLaboratoryTestLine."Assigned User ID";
                    HMSLaboratoryResultsEntry."Staff No" := HMSLaboratoryTestLine."Staff No";
                    HMSLaboratoryResultsEntry.Validate("Staff No");
                    HMSLaboratoryResultsEntry."Sort Test" := HMSLabParameterssetup.Arrangement;
                    HMSLaboratoryResultsEntry."Test Normal Ranges" := HMSLabParameterssetup."Test Normal Ranges";
                    HMSLaboratoryResultsEntry."Normal Range" := HMSLabParameterssetup."Test Normal Ranges";
                    HMSLaboratoryResultsEntry."Collection Date" := Today;
                    HMSLaboratoryResultsEntry."Collection Time" := Time;
                    HMSLaboratoryResultsEntry."Measuring Unit Code" := HMSLabParameterssetup."Measuring Unit Code";
                    HMSLaboratoryResultsEntry."Result Type" := HMSLabParameterssetup."Result Type";
                    HMSLaboratoryResultsEntry.Insert();
                until HMSLabParameterssetup.Next() = 0;

            //Update Lines 
            HMSLaboratoryTestLine."Sample Collected" := true;
            HMSLaboratoryTestLine.Validate("Sample Collected");
            HMSLaboratoryTestLine.Modify();
        end;

        // After All Results templates have been populated, Update header
        HMSLaboratoryFormHeader.Get(LabNo);
        HMSLaboratoryFormHeader."Samples Collected" := true;
        HMSLaboratoryFormHeader.Modify();
    end;

    // This procedure Marks the lab request as Completed
    procedure FnMarkLabRequestasCompleted(RecTb: Record "HMS Laboratory Form Header") returnValue: Boolean
    var
        HMSLaboratoryTestLine: Record "HMS Laboratory Test Line";
    begin
        returnValue := false;

        // Ensure All Test Lines are Completed
        HMSLaboratoryTestLine.Reset();
        HMSLaboratoryTestLine.SetRange(HMSLaboratoryTestLine."Laboratory No.", RecTb."Laboratory No.");
        HMSLaboratoryTestLine.SetRange(Completed, false);
        if HMSLaboratoryTestLine.IsEmpty() then begin
            RecTb.Status := RecTb.Status::Completed;
            RecTb.Modify();
            if GuiAllowed then
                Message('Laboratory Test Marked as Completed');
            returnValue := true;
        end else begin
            returnValue := false;
            if GuiAllowed then
                Error('Please ensure that all the tests are marked as completed');
        end;

    end;

    procedure FnLaboratoryDispatchToDoctor(RecTb: Record "HMS Laboratory Form Header") returnValue: Boolean
    var
        docHeader: Record "HMS Treatment Form Header";
        HMSSetup: Record "HMS Setup";
        HSMApp: Record "HMS Appointment Form Header";
        LabLine: Record "HMS Laboratory Test Line";
        TreatmentFormLab: Record "HMS Treatment Form Laboratory";
        blnCompleted: Boolean;
        NewNo: Code[30];
    begin
        returnValue := false;

        /* 
            **doc side = TreatmentFormLab**
            **lab side = LabLine**
            - Check for completed results that are not forwarded to doc side. 
            - If the test is not in Doc Side and is completed on the lab lines then add.
            - Update the Doc side with completion status if lab side is completed
        */

        LabLine.Reset();
        LabLine.SetRange(LabLine."Laboratory No.", RecTb."Laboratory No.");
        LabLine.SetRange(Completed, true);
        if LabLine.FindSet() then
            repeat
                TreatmentFormLab.Reset();
                TreatmentFormLab.SetRange("Treatment No.", RecTb."Link No.");
                TreatmentFormLab.SetRange("Lab No", RecTb."Laboratory No.");
                TreatmentFormLab.SetRange("Laboratory Test Package Code", LabLine."Laboratory Test Code");
                if TreatmentFormLab.FindFirst() then begin
                    TreatmentFormLab.Results := LabLine.Remarks;
                    TreatmentFormLab.Status := TreatmentFormLab.Status::Completed;
                    TreatmentFormLab.Modify();
                end else begin
                    TreatmentFormLab.Init();
                    TreatmentFormLab."Lab No" := LabLine."Laboratory No.";
                    TreatmentFormLab."Treatment No." := RecTb."Link No.";
                    TreatmentFormLab."Laboratory Test Package Code" := LabLine."Laboratory Test Code";
                    TreatmentFormLab."Date Due" := Today;
                    TreatmentFormLab.Status := TreatmentFormLab.Status::Completed;
                    TreatmentFormLab.Results := LabLine.Remarks;
                    TreatmentFormLab.Insert();
                end;
            until LabLine.Next() = 0;

        /* TODO: After Changing those Completed, Lets update any other status from the lab side */

        LabLine.Reset();
        LabLine.SetRange(LabLine."Laboratory No.", RecTb."Laboratory No.");
        LabLine.SetRange(Completed, false);
        if LabLine.IsEmpty() then
            RecTb.Status := RecTb.Status::Completed;

        // RecTb
        RecTb.Modify();
        if GuiAllowed then
            Message('Laboratory Test Marked as Completed');
        returnValue := true;
    end;

    procedure FnInpatientPostDrugPrescriptions(AdmissionNumber: Code[20]; StaffUserID: Code[20]) returnValue: Boolean
    var
        AdmissionHeader: Record "HMS Admission Form Header";
        AdmissionLine: Record "HMS Admission Drug Prescribe";
        HMSSetup: Record "HMS Setup";
        PharmHeader: Record "HMS Pharmacy Header";
        InsPharmHeader: Record "HMS Pharmacy Header";
        PharmLine: Record "HMS Pharmacy Line";
        blnCompleted: Boolean;
        NewNo: Code[20];
        PharmHeaderNo: Code[20];
    begin
        returnValue := false;
        HMSSetup.Reset();
        HMSSetup.Get();

        /*Get the treatment from the database*/
        AdmissionHeader.Reset();
        if AdmissionHeader.Get(AdmissionNumber) then begin
            // First Check if there are open Unposted prescriptions
            PharmHeader.Reset();
            PharmHeader.SetRange("Link No.", AdmissionNumber);
            PharmHeader.SetRange(Status, PharmHeader.Status::New);
            if PharmHeader.FindFirst() then begin
                PharmHeader."Pharmacy Date" := Today;
                PharmHeader."Pharmacy Type" := PharmHeader."Pharmacy Type"::Inpatient;
                PharmHeader.InPatient := true;
                PharmHeader."Global Dimension 1 Code" := AdmissionHeader.Branch;
                PharmHeader.Validate("Global Dimension 1 Code");
                PharmHeader.Modify();
                PharmHeaderNo := PharmHeader."Pharmacy No.";
            end else begin
                NewNo := CuNoSeries.GetNextNo(HMSSetup."Pharmacy Nos", 0D, true);

                InsPharmHeader.Init();
                InsPharmHeader."Pharmacy No." := NewNo;
                InsPharmHeader."Pharmacy Date" := Today;
                InsPharmHeader."Pharmacy Time" := Time;
                InsPharmHeader."Request Area" := InsPharmHeader."request area"::Doctor;
                InsPharmHeader."Patient No." := AdmissionHeader."Patient No.";
                InsPharmHeader.InPatient := true;
                InsPharmHeader."Pharmacy Type" := InsPharmHeader."Pharmacy Type"::Inpatient;
                InsPharmHeader."Global Dimension 1 Code" := AdmissionHeader.Branch;
                InsPharmHeader.Validate("Global Dimension 1 Code");
                InsPharmHeader."Student No." := AdmissionHeader."Student No.";
                InsPharmHeader."Employee No." := AdmissionHeader."Employee No.";
                InsPharmHeader."Relative No." := AdmissionHeader."Relative No.";
                InsPharmHeader."Link Type" := 'Admission';
                InsPharmHeader."Link No." := AdmissionNumber;
                InsPharmHeader."Transaction Type" := 'PHARMACY'; // Set Default pharmacy 
                if InsPharmHeader.Insert() then
                    PharmHeaderNo := InsPharmHeader."Pharmacy No.";
            end;


            if PharmHeaderNo <> '' then begin
                AdmissionLine.Reset();
                AdmissionLine.SetRange(AdmissionLine."Admission No.", AdmissionNumber);
                AdmissionLine.SetRange(AdmissionLine.Posted, false);
                if AdmissionLine.Find('-') then
                    repeat
                        PharmLine.Init();
                        PharmLine."Pharmacy No." := PharmHeaderNo;
                        PharmLine.Validate("Pharmacy No.");
                        PharmLine."No." := AdmissionLine."Drug No.";
                        PharmLine.Validate("No.");
                        PharmLine.Quantity := AdmissionLine.Quantity;
                        PharmLine.Validate(PharmLine.Quantity);
                        PharmLine."Measuring Unit" := AdmissionLine."Unit Of Measure";
                        PharmLine.Validate(PharmLine.Quantity);
                        PharmLine.Dosage := AdmissionLine.Dosage;
                        PharmLine.Pharmacy := InsPharmHeader."Issuing Location";
                        PharmLine."Prescription Dose" := AdmissionLine."Prescription Dose";
                        PharmLine.Remarks := AdmissionLine.Remarks;
                        PharmLine.Insert();
                        AdmissionLine.Posted := true;
                        AdmissionLine."Posted By" := StaffUserID;
                        AdmissionLine."Posting Date" := Today;
                        AdmissionLine."Posted Date" := Today;
                        AdmissionLine.Modify();
                    until AdmissionLine.Next() = 0;

                if GuiAllowed then
                    if Confirm('The Prescription has been sent to the Pharmacy for Issuance, do you wish to  open and issue') then begin
                        InsPharmHeader.Reset();
                        InsPharmHeader.SetRange(InsPharmHeader."Pharmacy No.", PharmHeaderNo);
                        if InsPharmHeader.Find('-') then
                            Page.Run(Page::"HMS Pharmacy Header", InsPharmHeader);
                    end;
            end else
                Error('Error When Getting Pharmacy Header');
        end;
    end;

    procedure FnRequestDoctorReview(RecTb: Record "HMS Treatment Form Review") returnValue: Boolean
    var
        DoctorReviewRequest: Record "HMS Doctor Review Request";
        HMSQue: Record "HMS Doctor Queue";
        HMSTreatmentformHeader: Record "HMS Treatment Form Header";
        Patient: Record "HMS Patient";
        NewRequestNo: Code[20];
    begin
        returnValue := false;

        TbHMSSetup.Reset();
        TbHMSSetup.Get();
        NewRequestNo := CuNoSeries.GetNextNo(TbHMSSetup."Doctor Review Request Nos.", 0D, true);

        HMSTreatmentformHeader.Reset();
        HMSTreatmentformHeader.SetRange("Treatment No.", RecTb."Treatment No.");
        if HMSTreatmentformHeader.FindFirst() then begin
            DoctorReviewRequest.Init();
            DoctorReviewRequest."Review Request No." := NewRequestNo;
            DoctorReviewRequest."Treatement No." := HMSTreatmentformHeader."Treatment No.";
            DoctorReviewRequest.Clinic := RecTb.Clinic;
            DoctorReviewRequest."Global Dimension 1 Code" := RecTb."Global Dimension 1 Code";
            DoctorReviewRequest."Doctor ID" := RecTb."Doctor No.";
            DoctorReviewRequest.Validate("Doctor ID");
            DoctorReviewRequest."Patient No." := HMSTreatmentformHeader."Patient No.";
            DoctorReviewRequest.Validate("Patient No.");
            DoctorReviewRequest."Request Date" := RecTb."Request Date";
            DoctorReviewRequest."Requesting Doctor" := HMSTreatmentformHeader."Doctor ID";
            DoctorReviewRequest.Status := DoctorReviewRequest.Status::New;
            DoctorReviewRequest."Request Reason" := RecTb."Request Reason";
            DoctorReviewRequest.Insert();

            returnValue := true;
        end;

        // TODO : Update Queue and use it to show notifications in future
        /* HMSQue.Init();
        HMSQue."Patient No" := RecTb."Patient No.";
        HMSQue."Visit No" := Patient."Active Visit No";
        HMSQue."Document No" := RecTb."Treatment No.";
        HMSQue.Type := 'CONSULTATION';
        HMSQue."Doctor ID" := RecTb."Doctor ID";
        HMSQue.Date := Today;
        HMSQue.Time := Time;
        HMSQue.Insert(); */
    end;

    procedure FnAcceptDoctorReviewRequest(RecTb: Record "HMS Doctor Review Request") returnValue: Boolean
    var
        HMSTreatmentFormReview: Record "HMS Treatment Form Review";
    begin
        returnValue := false;
        HMSTreatmentFormReview.Reset();
        HMSTreatmentFormReview.SetRange("Treatment No.", RecTb."Treatement No.");
        if HMSTreatmentFormReview.FindFirst() then begin
            HMSTreatmentFormReview.Status := HMSTreatmentFormReview.Status::Accepted;
            HMSTreatmentFormReview.Modify();

            RecTb.Status := RecTb.Status::Accepted;
            RecTb.Modify();

            // TODO : Notify the requesting doctor

            returnValue := true;
        end;
    end;

    procedure FnCancelDoctorReviewRequest(RecTb: Record "HMS Doctor Review Request") returnValue: Boolean
    var
        HMSTreatmentFormReview: Record "HMS Treatment Form Review";
    begin
        returnValue := false;
        HMSTreatmentFormReview.Reset();
        HMSTreatmentFormReview.SetRange("Treatment No.", RecTb."Treatement No.");
        if HMSTreatmentFormReview.FindFirst() then begin
            HMSTreatmentFormReview.Status := HMSTreatmentFormReview.Status::Cancelled;
            HMSTreatmentFormReview.Modify();

            RecTb.Status := RecTb.Status::Cancelled;
            RecTb.Modify();

            // TODO : Notify the requesting doctor

            returnValue := true;
        end;
    end;
    // Appointment Booking Process
    procedure FnScheduleAppointment(RecTb: Record "HMS Appointment Form Header") returnValue: Boolean
    var
        AppH: Record "HMS Appointment Form Header";
        HMSQue: Record "HMS Doctor Queue";
        Patient: Record "HMS Patient";
    begin
        // Appointment Booking functionality
    end;

    procedure FnCancelAppointment(RecTb: Record "HMS Appointment Form Header") returnValue: Boolean
    begin
        // Cancel Appointment functionality

    end;

    procedure FnRescheduleAppointment(RecTb: Record "HMS Appointment Form Header") returnValue: Boolean
    begin

    end;

    procedure FnGenerateInsuranceInvoice(patientNo: Code[30]; StaffNo: Code[30]) returnValue: Boolean
    var
        HMSCharges: Record "HMS Patient Charges";
        HMSPat: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        HMSPatIntegration: Codeunit "HMS Patient-integration";
    begin
        returnValue := false;
        if HMSPat.Get(patientNo) then begin
            // if GuiAllowed then begin
            //     HMSPatientCharges.Reset();
            //     HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", patientNo);
            //     HMSPatientCharges.SetRange(HMSPatientCharges."Visit No", HMSPat."Active Visit No");
            //     if HMSPatientCharges.FindFirst() then
            //         Report.Run(Report::"HMS Generate Patient Invoice", true, true, HMSPatientCharges)
            // end else begin

            HMSCharges.Reset();
            HMSCharges.SetFilter(HMSCharges."Patient No.", HMSPat."Patient No.");
            if HMSCharges.FindFirst() then
                HMSPatIntegration.CalculateTotalCharges(HMSCharges."Patient No.");

            HMSPatIntegration.GenerateInvoice(HMSPat."Patient No.", HMSPat."Active Visit No", false, StaffNo);

            // HMSPatientCharges.Reset();
            // HMSPatientCharges.SetRange(HMSPatientCharges."Patient No.", patientNo);
            // HMSPatientCharges.SetRange(HMSPatientCharges."Visit No", HMSPat."Active Visit No");
            // HMSPatientCharges.SetRange(Closed, false);
            // HMSPatientCharges.SetFilter(Amount, '<>%1', 0);
            // if HMSPatientCharges.FindSet() then
            //     repeat
            //         InsertSmartInvoices(HMSPatientCharges."Patient No.", HMSPatientCharges."Visit No"); // REFACTOR: Update Smart Link
            //     until HMSPatientCharges.Next() = 0;
            // returnValue := true;
        end;
    end;

    // local procedure InsertSmartInvoices(PatientNo: Code[20]; InvoiceNo: Code[20])
    // var
    //     HMSPatCharges: Record "HMS Patient Charges";
    //     HmsSetup: Record "HMS Setup";
    //     SmartInvoices: Record "Smart Invoices";
    //     RESTWSManagement: Codeunit "REST WS Management";
    //     HttpResponseMessage: DotNet HttpResponseMessage;
    //     ReturnValue: Boolean;
    //     data: Text;
    //     encoding: DotNet Encoding;
    //     httpUtility: DotNet HttpUtility;
    //     stringContent: DotNet StringContent;
    // begin
    //     SmartInvoices.RESET();
    //     SmartInvoices.SETRANGE(SmartInvoices."Document No", InvoiceNo);
    //     SmartInvoices.SETRANGE(SmartInvoices."Patient No", PatientNo);
    //     SmartInvoices.SETRANGE(SmartInvoices.Posted, FALSE);
    //     IF SmartInvoices.FIND('-') THEN
    //         SmartInvoices.DELETEALL();
    //     HMSPatCharges.RESET();
    //     HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.", PatientNo);
    //     HMSPatCharges.SETRANGE(HMSPatCharges."Invoice Number", InvoiceNo);
    //     IF HMSPatCharges.FIND('-') THEN
    //         REPEAT
    //             SmartInvoices.INIT();
    //             SmartInvoices.EntryNo := HMSPatCharges."Line No";
    //             SmartInvoices."Document No" := InvoiceNo;
    //             SmartInvoices."Patient No" := PatientNo;
    //             SmartInvoices."Invoice Date" := HMSPatCharges.Date;
    //             SmartInvoices."Invoice Time" := TIME;
    //             IF HMSPatCharges.Quantity > 0 THEN
    //                 SmartInvoices.Quantity := HMSPatCharges.Quantity
    //             ELSE
    //                 SmartInvoices.Quantity := 1;
    //             SmartInvoices."Encounter Type" := HMSPatCharges."Transaction Type";
    //             SmartInvoices.Code := HMSPatCharges.Code;
    //             SmartInvoices."Code Description" := HMSPatCharges.Description;
    //             SmartInvoices."Line Amount" := HMSPatCharges.Amount;
    //             SmartInvoices.INSERT(TRUE);
    //         UNTIL HMSPatCharges.NEXT() = 0;
    //     data += 'patient=' + httpUtility.UrlEncode(PatientNo, encoding.GetEncoding('ISO-8859-1'));
    //     data += 'invoiceno=' + httpUtility.UrlEncode(InvoiceNo, encoding.GetEncoding('ISO-8859-1'));

    //     stringContent := stringContent.StringContent(data, encoding.UTF8, 'application/x-www-form-urlencoded');
    //     HmsSetup.Get();

    //     ReturnValue := RESTWSManagement.CallRESTWebService(HmsSetup."Smartlink Base URL",
    //                                                        '/invoice.php',
    //                                                        'POST',
    //                                                        stringContent,
    //                                                        HttpResponseMessage);
    //     /* HMSPatCharges.RESET;
    //       HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.", PatientNo);
    //       HMSPatCharges.SETRANGE(HMSPatCharges."Posted Invoice No.", InvoiceNo);
    //       IF HMSPatCharges.FIND('-') THEN
    //         SmartInvoices.RESET;
    //         SmartInvoices.SETRANGE(SmartInvoices."Document No", PatientNo);
    //         SmartInvoices.SETRANGE(SmartInvoices."Patient No", InvoiceNo);
    //         SmartInvoices.SETRANGE(SmartInvoices.Posted, FALSE);
    //         IF SmartInvoices.FIND('-') THEN SmartInvoices.DELETEALL;
    //         REPEAT
    //       //Insert into Smart Invoices table
    //         SmartInvoices.INIT;
    //         SmartInvoices.EntryNo:=LineNo;
    //         SmartInvoices."Document No":= InvoiceNo;
    //         SmartInvoices."Patient No":=PatientNo;
    //         SmartInvoices."Invoice Date":=HMSPatCharges.Date;
    //         SmartInvoices."Invoice Time":=TIME;
    //          IF HMSPatCharges.Quantity>0 THEN
    //           SmartInvoices.Quantity:=HMSPatCharges.Quantity
    //           ELSE
    //           SmartInvoices.Quantity:=1;
    //         SmartInvoices."Encounter Type":=HMSPatCharges."Transaction Type";
    //         SmartInvoices.Code:=HMSPatCharges.Code;
    //         SmartInvoices."Code Description":=HMSPatCharges.Description;
    //         SmartInvoices."Line Amount":=HMSPatCharges.Amount;
    //         SmartInvoices.INSERT(TRUE);
    //         LineNo:=LineNo+1;
    //         UNTIL HMSPatCharges.NEXT=0;
    //     data += 'patient='  + httpUtility.UrlEncode(PatientNo,encoding.GetEncoding('ISO-8859-1'));
    //     data += 'invoiceno='  + httpUtility.UrlEncode(InvoiceNo,encoding.GetEncoding('ISO-8859-1'));

    //     stringContent := stringContent.StringContent(data,encoding.UTF8,'application/x-www-form-urlencoded');

    //     ReturnValue := RESTWSManagement.CallRESTWebService('http://localhost/',
    //                                                        '/invoice.php',
    //                                                        'POST',
    //                                                        stringContent,
    //                                                        HttpResponseMessage);
    //                                                        */
    // end;

    procedure InsertTreatmentHeader(RecApp: record "HMS Appointment Form Header"; NewObservationNo: Code[20]; TreatmentNo: Code[20])
    var
        HMSTreatmentFormHeader2: Record "HMS Treatment Form Header";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
    begin
        HMSTreatmentFormHeader2.Reset();
        HMSTreatmentFormHeader2.SetRange("Treatment No.", TreatmentNo);
        if HMSTreatmentFormHeader2.IsEmpty() then begin
            HMSTreatmentFormHeader.Init();
            HMSTreatmentFormHeader."Treatment No." := TreatmentNo;
            HMSTreatmentFormHeader."Treatment Date" := Today;
            HMSTreatmentFormHeader."Treatment Time" := DT2TIME(System.CurrentDateTime);
            HMSTreatmentFormHeader."Doctor ID" := RecApp.Doctor;
            HMSTreatmentFormHeader.Validate("Doctor ID");
            HMSTreatmentFormHeader.Branch := RecApp."Global Dimension 1";
            HMSTreatmentFormHeader."Patient No." := RecApp."Patient No.";
            HMSTreatmentFormHeader.Direct := false;
            HMSTreatmentFormHeader."Link No." := NewObservationNo;
            HMSTreatmentFormHeader."Observation No" := NewObservationNo;
            HMSTreatmentFormHeader.Clinic := RecApp."Special Clinics";
            HMSTreatmentFormHeader."Waiting At" := 'Triage';
            HMSTreatmentFormHeader."Link Type" := 'Outpatient';
            HMSTreatmentFormHeader.Status := HMSTreatmentFormHeader.Status::New;
            HMSTreatmentFormHeader.Validate(Status);
            HMSTreatmentFormHeader.Insert();
        end;
    end;

    procedure InsertObservationHeader(RecApp: record "HMS Appointment Form Header"; NewObservationNo: Code[20]; TreatmentNo: Code[20])
    var
        HMSObservationFormHeader: Record "HMS Observation Form Header";
        ObservHeader: Record "HMS Observation Form Header";
    begin
        HMSObservationFormHeader.Reset();
        HMSObservationFormHeader.SetRange("Observation No.", NewObservationNo);
        if HMSObservationFormHeader.IsEmpty() then begin
            ObservHeader.Init();
            ObservHeader."Observation No." := NewObservationNo;
            ObservHeader."Patient No." := RecApp."Patient No.";
            ObservHeader."Observation Date" := Today;
            ObservHeader."Observation Time" := DT2TIME(System.CurrentDateTime);
            ObservHeader."Treatment No" := TreatmentNo;
            ObservHeader."Special Clinics" := RecApp."Special Clinics";
            ObservHeader."Link Type" := 'Observation';
            ObservHeader."Link No." := RecApp."Appointment No.";
            ObservHeader.Branch := RecApp.Branch;
            ObservHeader.Doctor := RecApp.Doctor;
            ObservHeader.Status := ObservHeader.Status::New;
            ObservHeader.Validate("Link No.");
            ObservHeader.Insert();
        end;
    end;

    local procedure AddAppointmentConsultancyFee(var RecApp: record "HMS Appointment Form Header"; var recInsurance: record Customer; var NewObservationNo: Code[20])
    var
        AppointmentTypeSetup: record "HMS Setup Appointment Type";
        DoctorsRecApp: record "HMS Setup Doctor";
        HMSCharges: Record "HMS Charges";
        HMSPatientsCharges: record "HMS Patient Charges";
        Patient: Record "HMS Patient";
        PatRec: record "HMS Patient";
    begin
        AppointmentTypeSetup.Reset();
        AppointmentTypeSetup.SetRange(AppointmentTypeSetup.Code, RecApp."Appointment Type");
        AppointmentTypeSetup.SetRange(AppointmentTypeSetup."Bill Consultancy Fee", true);
        if AppointmentTypeSetup.Find('-') then begin
            DoctorsRecApp.get(RecApp.Doctor);

            HMSPatientsCharges.Init();
            HMSPatientsCharges."Patient No." := RecApp."Patient No.";
            HMSPatientsCharges."Link No" := NewObservationNo;
            HMSPatientsCharges."Treatment No." := NewObservationNo;
            HMSPatientsCharges."Appointment No." := RecApp."Appointment No.";
            Patient.Get(RecApp."Patient No.");
            // Begin Charge differentiation between Cash and corporate Patient 
            if (RecApp."Patient Type" = RecApp."Patient Type"::Cash) then begin
                RecApp.calcfields("Doctor Appointment Count");
                if RecApp."Doctor Appointment Count" > 0 then begin
                    if RecApp."Doctor Appointment Count" < 8 then begin
                        RecApp."Appointment Type" := 'REVIEW';
                    end else begin
                        DoctorsRecApp.TestField("Consultation Code Cash");
                        HMSCharges.Get(DoctorsRecApp."Consultation Code Cash");
                        RecApp."Appointment Type" := 'REVISIT';
                    end;
                end else begin
                    DoctorsRecApp.TestField("Consultation Cash FirstTimer");
                    HMSCharges.Get(DoctorsRecApp."Consultation Cash FirstTimer");
                    RecApp."Appointment Type" := 'NORMAL';
                end;

                if RecApp."Appointment Type" = 'REVIEW' then begin
                    DoctorsRecApp.TestField("Consultation Cash Review");
                    HMSCharges.Get(DoctorsRecApp."Consultation Cash Review");
                    // Message('Review');
                end;
                if RecApp."Appointment Type" = 'REVISIT' then begin
                    DoctorsRecApp.TestField("Consultation Code Cash");
                    HMSCharges.Get(DoctorsRecApp."Consultation Code Cash");
                    // Message('Revisit');
                end;
                if RecApp."Appointment Type" = 'NORMAL' then begin
                    DoctorsRecApp.TestField("Consultation Cash FirstTimer");
                    HMSCharges.Get(DoctorsRecApp."Consultation Cash FirstTimer");
                    // Message('Normal');
                end;

                if (RecApp."Appointment Type" <> 'REVIEW') and (RecApp."Appointment Type" <> 'REVISIT') and (RecApp."Appointment Type" <> 'NORMAL') then
                    error('Invalid Appointment Type. The allowed options are; REVIEW,REVISIT or NORMAL');

                HMSCharges.TestField("Transaction Type");
                HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                HMSPatientsCharges.Validate("Transaction Type");
                HMSPatientsCharges.Code := HMSCharges.Code;
                HMSPatientsCharges.Validate(Code);
                // HMSPatientsCharges.Description := DoctorsRecApp."Consultation Code Cash" + ' - ' + DoctorsRecApp."Doctor ID";
                HMSPatientsCharges.Description := HMSCharges.Description;
                //  HMSPatientsCharges.Amount := HMSCharges.Amount;

            end else
                if (RecApp."Patient Type" = RecApp."Patient Type"::Corporate) then begin
                    RecApp."Appointment Type" := 'NORMAL';
                    Patient.TestField("Insurance No.");
                    if DoctorsRecApp."Consultation Code" = '' then begin
                        recInsurance.get(Patient."Insurance No.");
                        if DoctorsRecApp.Resident then begin // Insurance Consultation
                            recInsurance.TestField("Resident Consultation Code");
                            HMSCharges.Get(recInsurance."Resident Consultation Code");
                            HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                            HMSPatientsCharges.Validate("Transaction Type");
                            HMSPatientsCharges.Code := recInsurance."Resident Consultation Code";
                        end else begin
                            recInsurance.TestField("Consultant Consultation Code");
                            HMSCharges.Get(recInsurance."Consultant Consultation Code");
                            HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                            HMSPatientsCharges.Validate("Transaction Type");
                            HMSPatientsCharges.Code := recInsurance."Consultant Consultation Code";
                        end;
                    end else begin // Default Doctor Consultation
                        HMSCharges.Get(DoctorsRecApp."Consultation Code");
                        HMSPatientsCharges."Transaction Type" := HMSCharges."Transaction Type";
                        HMSPatientsCharges.Validate("Transaction Type");
                        HMSPatientsCharges.Code := DoctorsRecApp."Consultation Code";
                    end;

                    HMSPatientsCharges.Validate(Code);

                end;
            // End of Differentiation between Cash and Corporate Patient Charges

            // Continue with Patient charges
            Patient.Get(RecApp."Patient No.");
            HMSPatientsCharges.Validate(Amount);
            HMSPatientsCharges.Date := Today;
            HMSPatientsCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
            HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSCharges."Shortcut Dimension 2 Code";
            HMSPatientsCharges."Bill Section" := HMSPatientsCharges."Bill Section"::Appointment;
            HMSPatientsCharges."Doctor ID" := DoctorsRecApp."Doctor ID";
            HMSPatientsCharges.Validate("Doctor ID");
            HMSPatientsCharges."User ID" := Format(UserId);
            HMSPatientsCharges."Creation Date" := Today;
            HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
            if PatRec.Get(RecApp."Patient No.") then begin
                HMSPatientsCharges."Admission No" := PatRec."Adm No.";
                HMSPatientsCharges."Visit No" := PatRec."Active Visit No";
            end;
            if HMSPatientsCharges.Amount > 0 then
                HMSPatientsCharges.Insert();

        end;
    end;

    local procedure ModifyAppointmentHeader(var RecApp: record "HMS Appointment Form Header"; NewObservationNo: Code[20]; TreatmentNo: Code[20])
    begin
        RecApp."Dispatch To" := RecApp."Dispatch To";
        RecApp."Dispatch Date" := Today;
        RecApp."Dispatch Time" := DT2TIME(System.CurrentDateTime);
        RecApp.Status := RecApp.Status::Dispatched;
        RecApp."Triage Time In" := CurrentDateTime;
        RecApp."Waiting At" := RecApp."Waiting At";
        RecApp."Treatment No" := TreatmentNo;
        RecApp."Link No" := NewObservationNo;
        RecApp.Modify();
    end;

    procedure FnPatientChargeReversal(RecTb: record "HMS Patient Charges") returnValue: Boolean
    var
        HMSCharges: record "HMS Patient Charges";
        UserSetUp: record "User Setup";
        CuPaInt: Codeunit "HMS Patient-integration";
        MyUserId: Code[30];
    begin
        if RecTb."User ID" = '' then
            MyUserId := UserId;
        if UserSetUp.Get(UserId) then begin
            if UserSetUp."Can Delete Charges" then begin
                returnValue := false;
                HMSCharges.RESET();
                HMSCharges.SETRANGE(HMSCharges."Patient No.", RecTb."Patient No.");
                HMSCharges.SETRANGE(HMSCharges."Visit No", RecTb."Visit No");
                HMSCharges.SETRANGE(HMSCharges.Posted, TRUE);
                IF HMSCharges.FIND('-') THEN BEGIN
                    CuPaInt.Post_Reverse_Charge(HMSCharges."Posting Document No", RecTb."Patient No.");
                    HMSCharges."Posting Document No" := '';
                    HMSCharges.Posted := false;
                    HMSCharges.Closed := false;
                    HMSCharges.modify();
                    returnValue := true;
                END;
            end else
                error('You do not have rights to reverse posted charges');
        end else
            error('You do not have rights to reverse posted charges');
    end;

    procedure setDefaultPatientInsurance(var RecTb: Record "HMS Patient Insuarance"): Boolean
    var
        HMSPatient: Record "HMS Patient";
        HMSPatientInsurance: Record "HMS Patient Insuarance";
    begin
        // Remove Default from all other insurances
        HMSPatientInsurance.Reset();
        HMSPatientInsurance.SetRange("Patient No", RecTb."Patient No");
        HMSPatientInsurance.SetRange(Default, true);
        if HMSPatientInsurance.FindSet() then
            repeat
                HMSPatientInsurance.Default := false;
                HMSPatientInsurance.Modify();
            until HMSPatientInsurance.Next() = 0;
        // Update The Patients Default Insurance then validate to modify any existing active patient charges.
        HMSPatient.Reset();
        HMSPatient.SetRange("Patient No.", RecTb."Patient No");
        if HMSPatient.FindFirst() then begin
            HMSPatient."Insurance No." := RecTb."Insurance No";
            HMSPatient."Insurance Name" := RecTb."Insurance Name";
            HMSPatient."Membership No" := RecTb."Member No";
            HMSPatient."Scheme Name" := RecTb."Scheme Name";
            HMSPatient.Validate("Insurance No."); // Handles the patient charges.
            HMSPatient.Modify();
        end;

        // Finally Update the Selected record
        RecTb.Default := true;
        RecTb.Modify();
    end;
    //
    procedure FnPostBedTransferRequest(var RecTb: Record "HMS Beds Transfer") returnV: Boolean
    var
        "HMS Adm": Record "HMS Admission Form Header";
        AdmH: Record "HMS Admission Form Header";
        Charges: Record "HMS Charges";
        HMSPatient: Record "HMS Patient";
        HMSPatientCharges: Record "HMS Patient Charges";
        HMSPatientInsurance: Record "HMS Patient Insuarance";
        HMSSetup: Record "HMS Setup";
        Patient: Record "HMS Patient";
        WardRec: Record "HMS Ward Setup";
    begin
        returnV := false;
        // TestField(Posted, false);
        RecTb.TESTFIELD("New Ward");
        RecTb.TESTFIELD("New Bed No");

        WardRec.get(RecTb."New Ward");
        WardRec.TestField("Charges Code");
        if AdmH.get(RecTb."Admission No.") then
            Patient.get(AdmH."Patient No.");
        HMSSetup.get();
        if GuiAllowed then begin
            IF CONFIRM('Do you really want to effect the Patient Bed Transfer?', TRUE) = FALSE THEN
                EXIT;
        end;
        HMSPatientCharges.INIT();
        HMSPatientCharges."Patient No." := AdmH."Patient No.";
        HMSPatientCharges."Link No" := RecTb."Admission No.";
        HMSPatientCharges."Treatment No." := AdmH."Link No.";
        WardRec.GET(RecTb."New Ward");
        Charges.GET(WardRec."Charges Code");
        HMSPatientCharges."Transaction Type" := Charges."Transaction Type";
        HMSPatientCharges.VALIDATE("Transaction Type");
        HMSPatientCharges."Shortcut Dimension 1 Code" := Patient."Global Dimension 1 Code";
        HMSPatientCharges.Code := WardRec."Charges Code";
        HMSPatientCharges.VALIDATE(Code);
        HMSPatientCharges.Description := RecTb."New Ward" + ' ' + RecTb."New Bed No";
        HMSPatientCharges.VALIDATE(Amount);
        HMSPatientCharges.Date := TODAY;
        HMSPatientCharges."Bill Section" := HMSPatientCharges."Bill Section"::Admissions;
        HMSPatientCharges."Billing Type" := HMSPatientCharges."Billing Type"::Reccuring;
        HMSPatientCharges."Reccuring Type" := HMSPatientCharges."Reccuring Type"::Daily;
        HMSPatientCharges."Billing Start Date" := TODAY;
        HMSPatientCharges."Admission No" := RecTb."Admission No.";
        HMSPatientCharges."Visit No" := Patient."Active Visit No";
        HMSPatientCharges.INSERT();

        Charges.get(WardRec."Charges Code");
        HMSPatientCharges.reset();
        HMSPatientCharges.setrange("Patient No.", AdmH."Patient No.");
        HMSPatientCharges.setrange("Visit No", AdmH."Link No.");
        HMSPatientCharges.setrange(Code, RecTb."Current Ward");
        if HMSPatientCharges.find('-') then begin
            HMSPatientCharges."System Created" := true;
            HMSPatientCharges.Transfer := true;
            HMSPatientCharges.modify();
        end;

        if "HMS Adm".Get(RecTb."Admission No.") then begin
            "HMS Adm".Ward := RecTb."New Ward";
            "HMS Adm".Bed := RecTb."New Bed No";
            RecTb."Posted By" := UserId;
            RecTb."Posting Date" := Today;
            RecTb.Posted := true;
            RecTb.modify();
            "HMS Adm".Modify();
            returnV := true;
        end;
    end;

    procedure FnSHIFRebatesCalculation(HmsPatient: record "HMS Patient"; RebateAmount: Decimal; ChargeDate: Date; InsuaranceCode: Code[20]): Boolean
    var
        HMSPatCharges2: Record "HMS Patient Charges";
        HMSPatCharges: Record "HMS Patient Charges";
        HMSPatIns: Record "HMS Patient Insuarance";
        HMSSetup: Record "HMS Setup";
    begin
        HMSSetup.get();
        HMSSetup.TestField("Rebates Exp. Account");
        HMSPatCharges.Reset();
        HMSPatCharges.SetRange(HMSPatCharges."Patient No.", HmsPatient."Patient No.");
        HMSPatCharges.SetRange(HMSPatCharges."Visit No", HmsPatient."Active Visit No");
        HMSPatCharges.SetRange(HMSPatCharges.Code, 'Rebates');
        if HMSPatCharges.FindFirst() then
            Error('Rebates already Exist For the Selected Visit. First Delete the Existing one then recalculate');

        HMSPatCharges.Reset();
        HMSPatCharges.SetRange(HMSPatCharges."Patient No.", HmsPatient."Patient No.");
        //HMSPatCharges.SETRANGE(HMSPatCharges.Posted,false);
        if HMSPatCharges.FindFirst() then begin

            HMSPatCharges2.Init();
            HMSPatCharges2."Transaction Type" := 'zReceipt';
            HMSPatCharges2."Patient No." := HmsPatient."Patient No.";
            HMSPatCharges2."Link No" := HMSPatCharges."Link No";
            HMSPatCharges2."Treatment No." := HMSPatCharges."Treatment No.";
            HMSPatCharges2.Code := 'Rebates';
            HMSPatCharges2.Description := 'SHIF Rebates';
            HMSPatCharges2.Amount := RebateAmount * -1;
            HMSPatCharges2.Validate(Amount);
            HMSPatCharges2.Date := ChargeDate;
            HMSPatCharges2.Quantity := 1;
            HMSPatCharges2.Validate(Quantity);
            HMSPatCharges2."G/L Account" := HMSSetup."Rebates Exp. Account";
            HMSPatCharges2."G/L Account No" := HMSSetup."Rebates Exp. Account";
            HMSPatCharges2."Insurance No" := InsuaranceCode;
            HMSPatCharges2."Insurance Amount" := RebateAmount * -1;
            HMSPatCharges2.InPatient := HmsPatient.Inpatient;
            HMSPatCharges2."Shortcut Dimension 1 Code" := HmsPatient."Global Dimension 1 Code";
            if HmsPatient.Inpatient then
                HMSPatCharges2."Shortcut Dimension 3 Code" := 'IP'
            else
                HMSPatCharges2."Shortcut Dimension 3 Code" := 'OP';
            if HmsPatient."Patient Type" = HmsPatient."Patient Type"::Cash then
                HMSPatCharges2."Shortcut Dimension 4 Code" := 'Cash'
            else
                HMSPatCharges2."Shortcut Dimension 4 Code" := 'Corporate';
            HMSPatCharges2."Visit No" := HmsPatient."Active Visit No";
            HMSPatCharges2.Insert();

            HMSPatIns.Reset();
            HMSPatIns.SetRange("Patient No", HmsPatient."Patient No.");
            HMSPatIns.SetRange(HMSPatIns."Insurance No", InsuaranceCode);
            if not HMSPatIns.Find('-') then begin
                HMSPatIns.Init();
                HMSPatIns."Patient No" := HmsPatient."Patient No.";
                HMSPatIns."Insurance No" := InsuaranceCode;
                HMSPatIns.Insert();
            end;
        end;

        exit(true);
    end;

    procedure FnDiscountCalculation(HMSPatient: record "HMS Patient"; DiscountPercentage: decimal; DiscountAmount: decimal) returnValue: Boolean
    var
        HMSPatCharges2: Record "HMS Patient Charges";
        HMSPatCharges: Record "HMS Patient Charges";
        HMSSetup: Record "HMS Setup";
        InsuranceCode: Code[20];
        DiscAmount: Decimal;
        DiscPerc: Decimal;
    begin
        returnValue := false;

        HMSSetup.get();
        HMSSetup.Testfield("Discount Exp. Account");
        HMSPatient.CALCFIELDS("Open Insurance Amount");

        if DiscountAmount = 0 then
            DiscAmount := HMSPatient."Open Insurance Amount" * (DiscountPercentage / 100)
        else
            DiscAmount := DiscountAmount;
        //IF InsuranceCode='' THEN ERROR('Please Enter the prefered Insurance scheme to proceed');

        HMSPatCharges.RESET();
        HMSPatCharges.SETRANGE(HMSPatCharges."Patient No.", HMSPatient."Patient No.");
        HMSPatCharges.SETFILTER(HMSPatCharges."Visit No", HMSPatient."Active Visit No");
        HMSPatCharges.SETRANGE(HMSPatCharges.Posted, false);
        if not HMSPatCharges.IsEmpty() then begin
            HMSPatCharges2.INIT();
            HMSPatCharges2."Transaction Type" := 'ZDISCOUNT';
            HMSPatCharges2."Patient No." := HMSPatient."Patient No.";
            HMSPatCharges2."Link No" := HMSPatCharges."Link No";
            HMSPatCharges2."Treatment No." := HMSPatCharges."Treatment No.";
            HMSPatCharges2."Appointment No." := HMSPatCharges."Appointment No.";
            HMSPatCharges2.Code := 'Discount';
            HMSPatCharges2.Description := 'Discount Given';
            HMSPatCharges2.Amount := DiscAmount * -1;
            HMSPatCharges2."Total Amount" := DiscAmount * -1;
            HMSPatCharges2.Date := TODAY;
            HMSPatCharges2.Quantity := 1;
            HMSPatCharges2."Shortcut Dimension 1 Code" := HMSPatient."Global Dimension 1 Code";
            HMSPatCharges2."Shortcut Dimension 2 Code" := 'Accounts';
            HMSPatCharges2."G/L Account" := HMSSetup."Discount Exp. Account";
            HMSPatCharges2."G/L Account No" := HMSSetup."Discount Exp. Account";
            HMSPatCharges2."Insurance No" := HMSPatCharges."Invoice Number";
            HMSPatCharges2."Insurance Amount" := DiscAmount * -1;
            HMSPatCharges2."Visit No" := HMSPatCharges."Visit No";
            HMSPatCharges2."Invoice Number" := HMSPatCharges."Invoice Number";
            HMSPatCharges2.Posted := HMSPatCharges.Posted;
            if HMSPatCharges2.INSERT() then
                returnValue := true;
        end;


        exit(returnValue);
    end;
    // Implement Close Bill Procedure
    procedure FnCloseBill(var RecTb: record "HMS Patient") returnValue: Boolean
    var
        HMSPatCharges: Record "HMS Patient Charges";
        HMSAppointmentFormHeader: Record "HMS Appointment Form Header";
        HMSPatIntegration: Codeunit "HMS Patient-integration";
    begin
        returnValue := false;
        if RecTb.activated then begin
            if HMSPatIntegration.CloseBill(RecTb."Patient No.") then begin
                HMSAppointmentFormHeader.Reset();
                HMSAppointmentFormHeader.SetRange("Appointment No.", RecTb."Active Visit No");
                if HMSAppointmentFormHeader.FindFirst() then begin
                    HMSAppointmentFormHeader.Status := HMSAppointmentFormHeader.Status::Completed;
                    HMSAppointmentFormHeader.Modify();
                end;

                RecTb."Discharge Date" := Today;
                RecTb.Activated := false;
                RecTb."Active Visit No" := '';
                RecTb.Modify();



                returnValue := true;

            end;
        end else begin
            if GuiAllowed then
                Error('The patient is Inactive');

            returnValue := false;
        end;

        exit(returnValue);
    end;
    // Migrate to Patient Management CodeUnit.
    procedure FnGeneratePatientNotesForm(EncounterNo: Code[30]; inpatient: Boolean) returnValue: Boolean
    var
        ConsultationNotesFormIns: Record "Consultation Notes Form";
        FormItems: Record "Form Items";
        FormCategory: Record "Form Category";
        FormSections: Record "Form Sections";
        HmsAdmissionFormHeader: Record "HMS Admission Form Header";
        HmsTreatmentFormHeader: Record "HMS Treatment Form Header";
        lineNo: Integer;
    begin
        returnValue := false;
        lineNo := 0;
        ConsultationNotesFormIns.Reset();
        ConsultationNotesFormIns.SetCurrentKey("Entry No");
        if ConsultationNotesFormIns.FindLast() then
            lineNo := ConsultationNotesFormIns."Entry No";

        if inpatient then begin
            HmsAdmissionFormHeader.Reset();
            HmsAdmissionFormHeader.SetRange("Admission No.", EncounterNo);
            if HmsAdmissionFormHeader.FindFirst() then begin

                FormSections.Reset();
                FormSections.SetRange("Form Type", FormSections."Form Type"::"Brief MSE");
                if FormSections.FindSet() then
                    repeat
                        FormCategory.Reset();
                        FormCategory.SetRange("Section ID", FormSections."Section ID");
                        if FormCategory.FindSet() then
                            repeat
                                FormItems.Reset();
                                FormItems.SetRange("Category ID", FormCategory."Category ID");
                                if FormItems.FindSet() then
                                    repeat
                                        ConsultationNotesFormIns.Reset();
                                        ConsultationNotesFormIns.SetRange("Encounter No", HmsAdmissionFormHeader."Admission No.");
                                        ConsultationNotesFormIns.SetRange("Item ID", FormItems."Item ID");
                                        if ConsultationNotesFormIns.IsEmpty then begin
                                            ConsultationNotesFormIns.Init();
                                            ConsultationNotesFormIns."Entry No" := lineNo + 10;
                                            ConsultationNotesFormIns."Encounter No" := HmsAdmissionFormHeader."Admission No.";
                                            ConsultationNotesFormIns."Patient No" := HmsAdmissionFormHeader."Admission No.";
                                            ConsultationNotesFormIns."Date Taken" := Today;
                                            ConsultationNotesFormIns."Category ID" := FormItems."Category ID";
                                            ConsultationNotesFormIns."Item ID" := FormItems."Item ID";
                                            ConsultationNotesFormIns.Insert();
                                        end;
                                    until FormItems.Next() = 0;
                            until FormCategory.Next() = 0;
                    until FormSections.Next() = 0;
                returnValue := true;
            end;
        end else begin
            HmsTreatmentFormHeader.Reset();
            HmsTreatmentFormHeader.SetRange(HmsTreatmentFormHeader."Treatment No.", EncounterNo);
            if HmsTreatmentFormHeader.FindFirst() then begin
                FormSections.Reset();
                FormSections.SetRange("Form Type", FormSections."Form Type"::"Brief MSE");
                if FormSections.FindSet() then
                    repeat
                        FormCategory.Reset();
                        FormCategory.SetRange("Section ID", FormSections."Section ID");
                        if FormCategory.FindSet() then
                            repeat
                                FormItems.Reset();
                                FormItems.SetRange("Category ID", FormCategory."Category ID");
                                if FormItems.FindSet() then
                                    repeat
                                        ConsultationNotesFormIns.Reset();
                                        ConsultationNotesFormIns.SetRange("Encounter No", HmsTreatmentFormHeader."Treatment No.");
                                        ConsultationNotesFormIns.SetRange("Item ID", FormItems."Item ID");
                                        if ConsultationNotesFormIns.IsEmpty then begin
                                            ConsultationNotesFormIns.Init();
                                            ConsultationNotesFormIns."Entry No" := lineNo + 10;
                                            ConsultationNotesFormIns."Encounter No" := HmsTreatmentFormHeader."Treatment No.";
                                            ConsultationNotesFormIns."Patient No" := HmsTreatmentFormHeader."Patient No.";
                                            ConsultationNotesFormIns."Date Taken" := HmsTreatmentFormHeader."Treatment Date";
                                            ConsultationNotesFormIns."Category ID" := FormItems."Category ID";
                                            ConsultationNotesFormIns."Item ID" := FormItems."Item ID";
                                            ConsultationNotesFormIns."Input Type" := FormItems."Input Type";
                                            ConsultationNotesFormIns.Insert();
                                        end;
                                    until FormItems.Next() = 0;
                            until FormCategory.Next() = 0;
                    until FormSections.Next() = 0;
                returnValue := true;
            end;
        end;
    end;
}
