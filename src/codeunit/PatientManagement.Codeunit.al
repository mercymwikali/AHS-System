namespace PTL.HMIS;
using Microsoft.Sales.Customer;
using Microsoft.Sales.History;
using PTL.HMISBC;

codeunit 52202463 "Patient Management"
{
    var
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
        InsuranceCustomer: Record Customer;
        HMSSetupDoctor: Record "HMS Setup Doctor";
        DoctorDailyClinicalReport: Record "Doctor Daily Clinical Report";

    procedure GenerateBriefMSEForm(EncounterNo: Code[30]) returnValue: Boolean
    var
        FormItems: Record "Form Items";
        FormCategory: Record "Form Category";
        BriefMSEForm: Record "Brief MSE Form";
        FormSections: Record "Form Sections";
        lineNo: Integer;
    begin
        returnValue := false;
        lineNo := 0;
        BriefMSEForm.Reset();
        BriefMSEForm.SetCurrentKey("Line No.");
        if BriefMSEForm.FindLast() then
            lineNo := BriefMSEForm."Line No.";

        HMSAdmissionFormHeader.Reset();
        HMSAdmissionFormHeader.SetRange(HMSAdmissionFormHeader."Admission No.", EncounterNo);
        if HMSAdmissionFormHeader.FindFirst() then begin
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
                                    BriefMSEForm.Reset();
                                    BriefMSEForm.SetRange("Encounter No", HMSAdmissionFormHeader."Admission No.");
                                    BriefMSEForm.SetRange("Item ID", FormItems."Item ID");
                                    if BriefMSEForm.IsEmpty then begin
                                        lineNo := lineNo + 1;
                                        BriefMSEForm.Init();
                                        BriefMSEForm."Line No." := lineNo;
                                        BriefMSEForm."Encounter No" := HMSAdmissionFormHeader."Admission No.";
                                        BriefMSEForm."Patient No" := HMSAdmissionFormHeader."Patient No.";
                                        BriefMSEForm."Date Taken" := HMSAdmissionFormHeader."Admission Date";
                                        BriefMSEForm."Category ID" := FormItems."Category ID";
                                        BriefMSEForm."Section ID" := FormSections."Section ID";
                                        BriefMSEForm."Item ID" := FormItems."Item ID";
                                        BriefMSEForm.Insert();
                                    end;
                                until FormItems.Next() = 0;
                        until FormCategory.Next() = 0;
                until FormSections.Next() = 0;
            returnValue := true;
        end;
    end;

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
                FormItems.Reset();
                FormItems.SetRange("Category ID", FormCategory."Category ID");
                FormItems.SetFilter("Form Type", '<>%1', FormItems."Form Type"::"Brief MSE");
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
                returnValue := true;
            end;
        end;
    end;

    procedure CalcClinicalDayStats(ClinicalReportDate: Date)
    var
        DailyClinicalReportsHeader: Record "Daily Clinical Reports Header";
        HMSPatientCharges: Record "HMS Patient Charges";
        TotalActiveIP: Integer;
        TotalAdmissions: Integer;
        TotalRehab: Integer;
        TotalMAKL: Integer;
        TotalMAKLPerc: Decimal;
        TotalByCP: Integer;
        TotalOPCP: Integer;
        TotalOPVisits: Integer;
        TotalOPPerc: Decimal;
        TotalByCpPerc: Decimal;
        TotalSHA: Integer;
        TotalSHAPerc: Decimal;
        PrevDate: Date;
    begin
        TotalActiveIP := 0;
        TotalAdmissions := 0;
        TotalMAKL := 0;
        TotalRehab := 0;
        TotalByCP := 0;
        TotalSHA := 0;
        TotalByCpPerc := 0;
        TotalMAKLPerc := 0;
        TotalSHAPerc := 0;
        TotalOPCP := 0;
        TotalOPVisits := 0;
        TotalOPPerc := 0;
        // TotalRecs := 0;
        DailyClinicalReportsHeader.Reset();
        DailyClinicalReportsHeader.SetRange(Date, ClinicalReportDate);
        if DailyClinicalReportsHeader.IsEmpty() then begin
            DailyClinicalReportsHeader.Init();
            DailyClinicalReportsHeader.Date := ClinicalReportDate;
            DailyClinicalReportsHeader.Insert();
        end;

        DailyClinicalReportsHeader.Reset();
        DailyClinicalReportsHeader.SetRange(Date, ClinicalReportDate);
        DailyClinicalReportsHeader.SetAutoCalcFields("Total Admissions", "Total Bed Occupancy", "Total MAKL Occupancy", "Total SHA Occupancy", "Total OP Visits");
        if DailyClinicalReportsHeader.FindFirst() then begin
            TotalActiveIP := DailyClinicalReportsHeader."Total Bed Occupancy";
            TotalMAKL := DailyClinicalReportsHeader."Total MAKL Occupancy";
            TotalSHA := DailyClinicalReportsHeader."Total SHA Occupancy";
            TotalOPVisits := DailyClinicalReportsHeader."Total OP Visits";
            Message(Format(DailyClinicalReportsHeader.Date));

            // Calc total Admissions by CP
            HMSPatientCharges.Reset();
            HMSPatientCharges.SetRange(Date, DailyClinicalReportsHeader.Date);
            HMSPatientCharges.SetRange("Transaction Type", 'BED');
            HMSPatientCharges.SetAutoCalcFields("Admitting Doctor");
            if HMSPatientCharges.FindSet() then //  These are all active Admissions on the date
                repeat
                    if isAdmissionByCP(HMSPatientCharges."Admitting Doctor") then
                        TotalByCP += 1;

                // Get their Respective admission Nos
                until HMSPatientCharges.Next() = 0;


            if TotalActiveIP > 0 then begin
                // Calc Percentages
                TotalByCpPerc := Round((TotalByCP / TotalActiveIP), 0.01, '=') * 100;
                TotalMAKLPerc := Round((TotalMAKL / TotalActiveIP), 0.01, '=') * 100;
                TotalSHAPerc := Round((TotalSHA / TotalActiveIP), 0.01, '=') * 100;
            end;

            // Calc total OP charges With Doctor ID
            HMSPatientCharges.Reset();
            HMSPatientCharges.SetRange(Date, DailyClinicalReportsHeader.Date);
            HMSPatientCharges.SetRange("Shortcut Dimension 3 Code", 'OP');
            HMSPatientCharges.SetRange(Posted, true);
            // HMSPatientCharges.SetFilter("Doctor ID", '<>%1', '');
            if HMSPatientCharges.FindSet() then
                repeat
                    if HMSPatientCharges."Doctor ID" <> '' then
                        if isAdmissionByCP(HMSPatientCharges."Doctor ID") then begin
                            TotalOPCP += 1;
                        end;

                // Get their Respective admission Nos
                until HMSPatientCharges.Next() = 0;

            if TotalOPVisits > 0 then
                TotalOPPerc := Round((TotalOPCP / TotalOPVisits), 0.01, '=') * 100;


            Message(Format(TotalOPCP));

            // TODO: Get Pharmacy ones from pharmacy header. area (reception/doctor)

            DailyClinicalReportsHeader."Total SHA %" := TotalSHAPerc;
            DailyClinicalReportsHeader."Total IP C.P %" := TotalByCpPerc;
            DailyClinicalReportsHeader."Total MAKL %" := TotalMAKLPerc;
            DailyClinicalReportsHeader."Total IP C.P" := TotalByCP;
            DailyClinicalReportsHeader."Total OP C.P" := TotalOPCP;
            DailyClinicalReportsHeader."Total OP C.P %" := TotalOPPerc;
            if DailyClinicalReportsHeader.Modify() then Message('done');
        end;
    end;

    local procedure isBedRehab(WardNo: Code[30]) ReturnValue: Boolean
    var
        HMSWardSetup: Record "HMS Ward Setup";
    begin
        ReturnValue := true;
        HMSWardSetup.Reset();
        HMSWardSetup.SetRange("Ward Code", WardNo);
        HMSWardSetup.SetRange(isRehab, true);
        if HMSWardSetup.IsEmpty() then
            ReturnValue := false;

        exit(ReturnValue);
    end;

    local procedure isAdmissionByCP(DoctorID: Code[30]) returnValue: Boolean
    begin
        returnValue := true;
        HMSSetupDoctor.Reset();
        HMSSetupDoctor.SetRange("Doctor ID", DoctorID);
        HMSSetupDoctor.SetRange(Resident, true);
        if HMSSetupDoctor.IsEmpty() then
            returnValue := false;

        exit(returnValue);

    end;

    procedure FnBookPatientAppointment(PatientNo: Code[20]; VisitNo: Code[30]; TCADate: Date; TCATime: Time; DoctorID: Code[30]; Remarks: Text[100]) ReturnValue: Boolean
    var
        HMSPatient: Record "HMS Patient";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
        HMSAdmissionDischargeHeader: Record "HMS Admission Discharge Header";
        HMSPatientAppointmntBookng: Record "HMS Patient Appointmnt Bookng";
        SMSSenderCodeunit: Codeunit "SMS Integration Management";
        smsMsg: text;
    begin
        ReturnValue := false;
        if HMSPatient.Get(PatientNo) then begin
            HMSPatient.TestField(Activated, true);
            HMSPatientAppointmntBookng.Reset();
            HMSPatientAppointmntBookng.SetRange("Patient No", PatientNo);
            HMSPatientAppointmntBookng.SetRange("Appointment Date", TCADate);
            HMSPatientAppointmntBookng.SetRange("Source No", VisitNo);
            if HMSPatientAppointmntBookng.IsEmpty() then begin
                // Insert an AppointmentBooking Record
                HMSPatientAppointmntBookng.Init();
                HMSPatientAppointmntBookng."Appointment Date" := TCADate;
                HMSPatientAppointmntBookng."Appointment Time" := TCATime;
                HMSPatientAppointmntBookng."Patient No" := PatientNo;
                HMSPatientAppointmntBookng.Validate("Patient No");
                HMSPatientAppointmntBookng.Branch := HMSPatient."Global Dimension 1 Code";
                HMSPatientAppointmntBookng."Source No" := VisitNo;
                HMSPatientAppointmntBookng."Doctor ID" := DoctorID;
                HMSPatientAppointmntBookng.Validate("Doctor ID");
                HMSPatientAppointmntBookng."Appointment Reason" := Remarks;
                HMSPatientAppointmntBookng.Status := HMSPatientAppointmntBookng.Status::Booked;
                if HMSPatientAppointmntBookng.Insert(true) then
                    ReturnValue := true;



                // smsMsg := 'Hello ' + HMSPatient.Surname + ', You have an appointment booked on ' + Format(HMSPatientAppointmntBookng."Appointment Date") + ' at ' + Format(HMSPatientAppointmntBookng."Appointment Time");
                // if HMSPatient."Telephone No. 1" <> '' then
                //     SMSSenderCodeunit.SendSMS(HMSPatient."Telephone No. 1", smsMsg);

            end else
                ReturnValue := true;

            if ReturnValue then
                if HMSPatient.Inpatient then begin
                    HMSAdmissionFormHeader.Reset();
                    HMSAdmissionFormHeader.SetRange("Admission No.", VisitNo);
                    if HMSAdmissionFormHeader.FindFirst() then begin
                        HMSAdmissionFormHeader."Next Appointment Date" := TCADate;
                        HMSAdmissionFormHeader."Next Appointment Time" := TCATime;
                        HMSAdmissionFormHeader."Next Appointment Comments" := Remarks;
                        HMSAdmissionFormHeader.Modify();
                    end;
                    HMSAdmissionDischargeHeader.Reset();
                    HMSAdmissionDischargeHeader.SetRange("Admission No.", VisitNo);
                    HMSAdmissionDischargeHeader.SetRange(Status, HMSAdmissionDischargeHeader.Status::New);
                    if HMSAdmissionDischargeHeader.FindFirst() then begin
                        HMSAdmissionDischargeHeader."Next Appointment Date" := TCADate;
                        HMSAdmissionDischargeHeader."Next Appointment Time" := TCATime;
                        HMSAdmissionDischargeHeader."Next Appointment Comments" := Remarks;
                        HMSAdmissionDischargeHeader.Modify();
                    end;
                end else begin
                    HMSTreatmentFormHeader.Reset();
                    HMSTreatmentFormHeader.SetRange("Treatment No.", VisitNo);
                    if HMSTreatmentFormHeader.FindFirst() then begin
                        HMSTreatmentFormHeader."Next Appointment Date" := TCADate;
                        HMSTreatmentFormHeader."Next Appointment Time" := TCATime;
                        HMSTreatmentFormHeader."Next Appointment Comments" := Remarks;
                        HMSTreatmentFormHeader.Modify();
                    end;
                end;
        end;
    end;

    procedure FnSendDailyClinicalReport(ClinicalReportDate: Date)
    var
        DailyClinicalReportsHeader: Record "Daily Clinical Reports Header";
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
        HMSPatientCharges: Record "HMS Patient Charges";
        SMSTemplatesTable: Record "SMS Templates Table";
        ClinicalReportRecepients: Record "Clinical Report Recepients";
        SMSIntegrationManagement: Codeunit "SMS Integration Management";
        SMSRenderCodeunit: Codeunit SMSRenderCodeunit;
        DocCount: Integer;
        Blocks: Dictionary of [Text, List of [Dictionary of [Text, Text]]];
        OPDoctorList: List of [Dictionary of [Text, Text]];
        IPDoctorList: List of [Dictionary of [Text, Text]];
        OPPsychologistsList: List of [Dictionary of [Text, Text]];
        AdmissionsList: List of [Dictionary of [Text, Text]];
        GeneratedText: Text;
        MainVars: Dictionary of [Text, Text];
        Msg: Text;
        OneOPDoctor: Dictionary of [Text, Text];
        OneIPDoctor: Dictionary of [Text, Text];
        OneOPPsychologist: Dictionary of [Text, Text];
        OneAdmittingDoctor: Dictionary of [Text, Text];
        AdmissionCounter: Integer;
    begin
        DailyClinicalReportsHeader.Reset();
        DailyClinicalReportsHeader.SetRange(Date, ClinicalReportDate);
        if DailyClinicalReportsHeader.IsEmpty() then
            CalcClinicalDayStats(ClinicalReportDate);

        Commit();

        DailyClinicalReportsHeader.Reset();
        DailyClinicalReportsHeader.SetRange(Date, ClinicalReportDate);
        DailyClinicalReportsHeader.CalcFields("Total Bed Occupancy", "Total OP Visits");
        GeneratedText := '';
        Msg := '';
        // Message(DailyClinicalReportsHeader.Remarks);
        SMSTemplatesTable.Reset();
        SMSTemplatesTable.SetRange(Active, true);
        if SMSTemplatesTable.FindFirst() then
            Msg := SMSTemplatesTable."Template Text";

        // Fill Template Variables -- Predefined Values 
        // Use Dictionary Key:Value Pairs to store variables
        // 1. Main Variables

        MainVars.Add('ReportDate', Format(DailyClinicalReportsHeader.Date, 0, '<Day,2>-<Month Text>-<Year4>'));
        MainVars.Add('TotalInPatients', Format(DailyClinicalReportsHeader."Total Bed Occupancy"));
        MainVars.Add('TotalMAKL', Format(DailyClinicalReportsHeader."Total MAKL Occupancy"));
        MainVars.Add('TotalMAKLHold', Format(DailyClinicalReportsHeader."Total MAKL %"));
        MainVars.Add('TotalSHA', Format(DailyClinicalReportsHeader."Total SHA Occupancy"));
        MainVars.Add('TotalSHAHold', Format(DailyClinicalReportsHeader."Total SHA %"));
        MainVars.Add('TotalAccuteOccupancy', Format(DailyClinicalReportsHeader."Total Acute"));
        MainVars.Add('TotalInPatientsByCP', Format(DailyClinicalReportsHeader."Total IP C.P"));
        MainVars.Add('TotalInpatientsByCPPercentage', Format(DailyClinicalReportsHeader."Total IP C.P %"));
        MainVars.Add('TotalOutPatientsByCP', Format(DailyClinicalReportsHeader."Total IP C.P"));
        MainVars.Add('TotalOutPatientsByCPPercentage', Format(DailyClinicalReportsHeader."Total OP C.P %"));
        MainVars.Add('TotalOPByCHGPsychologists', '');
        MainVars.Add('TotalOPByCHGPsychologistsPercentage', '');
        MainVars.Add('TotalByExternalPsychiatrists', '');
        MainVars.Add('TotalByExternalPsychologists', '');
        MainVars.Add('TotalWalkinLabVisits', '');
        MainVars.Add('TotalWalkinPharmacyVisits', '');
        MainVars.Add('TotalAdmissions', Format(DailyClinicalReportsHeader."Total Admissions"));
        MainVars.Add('TotalOPVisits', Format(DailyClinicalReportsHeader."Total OP Visits"));

        HMSSetupDoctor.Reset();
        HMSSetupDoctor.SetRange(Resident, true);
        HMSSetupDoctor.SetFilter("Date Filter", '=%1', DailyClinicalReportsHeader.Date);
        HMSSetupDoctor.SetAutoCalcFields("Total OP", "Total IP");
        if HMSSetupDoctor.FindSet() then
            repeat

                // 2. Clear Blocks for repeating variables
                Clear(OneOPDoctor);
                Clear(OneIPDoctor);
                Clear(OneOPPsychologist);
                Clear(AdmissionsList);

                DocCount := 0;

                // Get Admissions on the report Date
                HMSPatientCharges.Reset();
                HMSPatientCharges.SetRange(HMSPatientCharges.Code, 'ADMISSION FEE');
                HMSPatientCharges.SetRange(Date, DailyClinicalReportsHeader.Date);
                if HMSPatientCharges.FindSet() then
                    repeat
                        HMSAdmissionFormHeader.Reset();
                        HMSAdmissionFormHeader.SetRange("Admission No.", HMSPatientCharges."Visit No");
                        HMSAdmissionFormHeader.SetRange(Doctor, HMSSetupDoctor."Doctor ID");
                        if not HMSAdmissionFormHeader.IsEmpty() then begin
                            OneAdmittingDoctor.add('AdmittingDoctorName', HMSSetupDoctor."Doctors Name");
                            if HMSPatientCharges."Insurance Name" <> '' then
                                OneAdmittingDoctor.add('InsuranceName', HMSPatientCharges."Insurance Name")
                            else
                                OneAdmittingDoctor.add('InsuranceName', 'CASH');
                            AdmissionsList.Add(OneAdmittingDoctor);
                        end;
                    until HMSPatientCharges.Next() = 0;

                // Get Active Admissions on that Date
                HMSPatientCharges.Reset();
                HMSPatientCharges.SetRange(HMSPatientCharges."Transaction Type", 'BED');
                HMSPatientCharges.SetRange(Date, DailyClinicalReportsHeader.Date);
                HMSPatientCharges.SetAutoCalcFields("Insurance Name");
                if HMSPatientCharges.FindSet() then
                    repeat
                        HMSAdmissionFormHeader.Reset();
                        HMSAdmissionFormHeader.SetRange("Admission No.", HMSPatientCharges."Visit No");
                        HMSAdmissionFormHeader.SetRange(Doctor, HMSSetupDoctor."Doctor ID");
                        if not HMSAdmissionFormHeader.IsEmpty() then
                            DocCount += 1;

                    until HMSPatientCharges.Next() = 0;

                // Add The List of Corporate Psychologists and Phsychiatrists
                if HMSSetupDoctor.Specialization = 'PSYCHOLOGIST' then begin
                    OneOPPsychologist.Add('PsychologistsName', HMSSetupDoctor."Doctors Name");
                    OneOPPsychologist.Add('PsychologistsOPCount', Format(HMSSetupDoctor."Total OP"));
                    // Add the Single Doctor to the Doctors List
                    OPDoctorList.Add(OneOPDoctor);

                end else
                    if HMSSetupDoctor.Specialization = 'PSYCHIATRIST' then begin
                        OneOPDoctor.Add('OPDoctorName', HMSSetupDoctor."Doctors Name");
                        OneOPDoctor.Add('OPDoctorsCount', Format(HMSSetupDoctor."Total OP"));
                        OneIPDoctor.Add('IPDoctorName', HMSSetupDoctor."Doctors Name");
                        OneIPDoctor.Add('IPDoctorsCount', Format(DocCount));
                        // Add the Single Doctor to the Doctors List
                        OPDoctorList.Add(OneOPDoctor);
                        IPDoctorList.Add(OneIPDoctor);
                    end;
            until HMSSetupDoctor.Next() = 0;

        // 3. Individual Variables for each block
        Blocks.Add('IPDoctors', IPDoctorList);
        Blocks.Add('OPDoctors', OPDoctorList);
        Blocks.Add('OPPsychologists', OPPsychologistsList);
        Blocks.Add('IPDoctorsAdmission', AdmissionsList);

        // 4. Render the SMS Message
        GeneratedText := SMSRenderCodeunit.RenderSMSMessage(Msg, MainVars, Blocks);

        // 5. Send the SMS Message.
        // TODO: Store the message in a buffer table
        if ClinicalReportRecepients.FindSet() then
            repeat
                SMSIntegrationManagement.SendSMS(ClinicalReportRecepients."Phone No", Msg)
            until ClinicalReportRecepients.Next() = 0;

    end;
}
