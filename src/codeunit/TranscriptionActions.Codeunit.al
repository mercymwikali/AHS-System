codeunit 85016 "Transcription Actions"
{
    Subtype = Normal;

    var
        HMSAdmissionFormHeader: Record "HMS Admission Form Header";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";
        HMSSetup: Record "HMS Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        jObject: JsonObject;
        jToken: JsonToken;
        Action: Text;
        EncounterType: Text;
        PatientNo: Code[20];
        Clinic: Code[20];
        AdmissionDate: Date;
        DischargeDate: Date;
        OldFileNumber: Code[30];
        EncounterNo: Code[20];
        User: Code[50];
        Response: Text;

    [ServiceEnabled]
    procedure FnManageTranscriptions(jString: Text): Text
    begin
        Clear(Response);
        Clear(jObject);
        jObject.ReadFrom(jString);

        // Parse JSON values safely
        if jObject.Get('myAction', jToken) then
            Action := LowerCase(jToken.AsValue().AsText());
        if jObject.Get('encounterType', jToken) then
            EncounterType := LowerCase(jToken.AsValue().AsText());
        if jObject.Get('patientNo', jToken) then
            PatientNo := jToken.AsValue().AsCode();
        if jObject.Get('clinic', jToken) then
            Clinic := jToken.AsValue().AsCode();
        if jObject.Get('oldFileNumber', jToken) then
            OldFileNumber := jToken.AsValue().AsCode();
        if jObject.Get('user', jToken) then
            User := jToken.AsValue().AsCode();
        if jObject.Get('encounterNo', jToken) then
            EncounterNo := jToken.AsValue().AsCode();
        if jObject.Get('admissionDate', jToken) then
            Evaluate(AdmissionDate, jToken.AsValue().AsText());
        if jObject.Get('dischargeDate', jToken) then
            Evaluate(DischargeDate, jToken.AsValue().AsText());

        // Validate required inputs
        if PatientNo = '' then
            exit('{"status":"error","message":"Patient number is required."}');

        if (Action in ['edit', 'delete']) and (EncounterNo = '') then
            exit('{"status":"error","message":"Encounter number required for edit/delete."}');

        case Action of
            'create', 'create#save':
                CreateEncounter();
            'edit', 'edit#save':
                EditEncounter();
            'delete':
                DeleteEncounter();
            else
                exit('{"status":"error","message":"Invalid action."}');
        end;

        exit(Response);
    end;

    local procedure CreateEncounter()
    begin
        HMSSetup.Get();
        HMSSetup.TestField("Transcription Nos");
        EncounterNo := NoSeriesMgt.GetNextNo(HMSSetup."Transcription Nos", 0D, true);

        case EncounterType of
            'inpatient':
                begin
                    HMSAdmissionFormHeader.Init();
                    HMSAdmissionFormHeader."Admission No." := EncounterNo;
                    HMSAdmissionFormHeader."Patient No." := PatientNo;
                    HMSAdmissionFormHeader."Admission Date" := AdmissionDate;
                    HMSAdmissionFormHeader."Discharged Date" := DischargeDate;
                    HMSAdmissionFormHeader."Transcribed File No" := OldFileNumber;
                    HMSAdmissionFormHeader."Created By" := User;
                    HMSAdmissionFormHeader."Clinic Visited" := Clinic;
                    HMSAdmissionFormHeader.Insert(true);
                end;
            'outpatient':
                begin
                    HMSTreatmentFormHeader.Init();
                    HMSTreatmentFormHeader."Treatment No." := EncounterNo;
                    HMSTreatmentFormHeader."Patient No." := PatientNo;
                    HMSTreatmentFormHeader."Treatment Date" := AdmissionDate;
                    HMSTreatmentFormHeader."Transcribed File No" := OldFileNumber;
                    HMSTreatmentFormHeader."Clinic Visited" := Clinic;
                    HMSTreatmentFormHeader."Created By" := User;
                    HMSTreatmentFormHeader.Insert(true);
                end;
            else
                Error('Invalid encounter type.');
        end;

        Response := '{"status":"success","encounterNo":"' + Format(EncounterNo) + '"}';
    end;

    local procedure EditEncounter()
    begin
        case EncounterType of
            'inpatient':
                if HMSAdmissionFormHeader.Get(EncounterNo) then begin
                    if AdmissionDate <> 0D then
                        HMSAdmissionFormHeader."Admission Date" := AdmissionDate;
                    if DischargeDate <> 0D then
                        HMSAdmissionFormHeader."Discharged Date" := DischargeDate;
                    if OldFileNumber <> '' then
                        HMSAdmissionFormHeader."Transcribed File No" := OldFileNumber;
                    if Clinic <> '' then
                        HMSAdmissionFormHeader."Clinic Visited" := Clinic;
                    HMSAdmissionFormHeader."Modified By" := User;
                    HMSAdmissionFormHeader.Modify(true);
                end else
                    Error('Inpatient encounter %1 not found.', EncounterNo);

            'outpatient':
                if HMSTreatmentFormHeader.Get(EncounterNo) then begin
                    if AdmissionDate <> 0D then
                        HMSTreatmentFormHeader."Treatment Date" := AdmissionDate;
                    if OldFileNumber <> '' then
                        HMSTreatmentFormHeader."Transcribed File No" := OldFileNumber;
                    if Clinic <> '' then
                        HMSTreatmentFormHeader."Clinic Visited" := Clinic;
                    HMSTreatmentFormHeader."Modified By" := User;
                    HMSTreatmentFormHeader.Modify(true);
                end else
                    Error('Outpatient encounter %1 not found.', EncounterNo);
        end;

        Response := '{"status":"success"}';
    end;

    local procedure DeleteEncounter()
    begin
        case EncounterType of
            'inpatient':
                if HMSAdmissionFormHeader.Get(EncounterNo) then begin
                    HMSAdmissionFormHeader.Delete(true);
                    Response := '{"status":"success"}';
                end else
                    Error('Inpatient encounter %1 not found.', EncounterNo);
            'outpatient':
                if HMSTreatmentFormHeader.Get(EncounterNo) then begin
                    HMSTreatmentFormHeader.Delete(true);
                    Response := '{"status":"success"}';
                end else
                    Error('Outpatient encounter %1 not found.', EncounterNo);
        end;
    end;
}
