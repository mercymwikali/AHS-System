Page 85308 "HMS Admission Progress List"
{
    CardPageID = "HMS Admission Progress";
    InsertAllowed = false;
    PageType = List;
    SourceTable = "HMS Admission Form Header";
    SourceTableView = where(Status = const(Admitted));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(AdmissionNo; Rec."Admission No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission No. field.';
                }
                field(AdmissionDate; Rec."Admission Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Date field.';
                }
                field(AdmissionTime; Rec."Admission Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Time field.';
                }
                field(AdmissionArea; Rec."Admission Area")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Area field.';
                }
                field(Ward; Rec.Ward)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Ward field.';
                }
                field(Bed; Rec.Bed)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Bed field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Doctor field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    Caption = 'Names';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Names field.';
                }
                field(AdmissionReason; Rec."Admission Reason")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Reason field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(InitiateDischarge)
            {
                Caption = '&Initiate Discharge';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Initiate Discharge action.';

                trigger OnAction()
                begin
                    if Confirm('Do you wish to initiate Patient discharge?', false) = false then
                        exit;

                    DischargeHeader.Reset();
                    DischargeHeader.SetRange(DischargeHeader."Admission No.", Rec."Admission No.");
                    if DischargeHeader.Find('-') then
                        DischargeHeader.DeleteAll();
                    DischargeHeader.Reset();
                    DischargeHeader.Init();
                    DischargeHeader."Admission No." := Rec."Admission No.";
                    DischargeHeader."Patient No." := Rec."Patient No.";
                    DischargeHeader."Ward No." := Rec.Ward;
                    DischargeHeader."Bed No." := Rec.Bed;
                    DischargeHeader."Date of Admission" := Rec."Admission Date";
                    DischargeHeader."Time Of Admission" := Rec."Admission Time";
                    DischargeHeader.Insert();

                    DischargeLine.Reset();
                    DischargeLine.SetRange(DischargeLine."Admission No.", Rec."Admission No.");
                    if DischargeLine.Find('-') then
                        DischargeLine.DeleteAll();
                    DischargeProcesses.Reset();
                    if DischargeProcesses.Find('-') then
                        repeat
                            DischargeLine.Init();
                            DischargeLine."Admission No." := Rec."Admission No.";
                            DischargeLine."Process Code" := DischargeProcesses.Code;
                            DischargeLine.Validate(DischargeLine."Process Code");
                            DischargeLine.Insert();
                        until DischargeProcesses.Next() = 0;
                    /*
                      IF Patient.GET("Patient No.") THEN BEGIN
                      Patient.Inpatient :=FALSE;
                      Patient.MODIFY;
                      END;
                  */
                    Rec.Status := Rec.Status::Discharged;
                    Rec.Modify();
                    Message('Patient Admission Discharge Process Initiated');
                end;
            }
            action(RefreshNames)
            {
                Caption = '&Refresh Names';
                Image = Refresh;
                Promoted = true;
                ToolTip = 'Executes the &Refresh Names action.';

                trigger OnAction()

                var
                    DisHeader: Record "HMS Admission Form Header";
                    Patients: Record "HMS Patient";
                begin
                    DisHeader.Reset();
                    DisHeader.SetFilter(DisHeader."Search Name", '%1', '');
                    if DisHeader.Find('-') then
                        repeat
                            if Patients.get(DisHeader."Patient No.") then begin
                                DisHeader."Search Name" := Patients."Search Name";
                                DisHeader.modify();
                            end;
                        until DisHeader.next() = 0;
                    message('Completed');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if patient.get(Rec."Patient No.") then
            PatientName := Patient."Search Name";
    end;

    trigger OnOpenPage()
    var
        DisHeader: Record "HMS Admission Form Header";
        Patients: Record "HMS Patient";
        UserRec: Record "User Setup";
    begin
        if UserRec.get(Database.UserId) then
            if userrec."Branch Code" <> '' then
                Rec.setfilter("Global Dimension1", UserRec."Branch Code");
        DisHeader.Reset();
        DisHeader.SetFilter(DisHeader."Search Name", '%1', '');
        if DisHeader.Find('-') then
            repeat
                if Patients.get(DisHeader."Patient No.") then begin
                    DisHeader."Search Name" := Patients."Search Name";
                    DisHeader.modify();
                end;
            until DisHeader.next() = 0;
    end;

    var
        DischargeHeader: Record "HMS Admission Discharge Header";
        DischargeLine: Record "HMS Admission Discharge Line";
        Patient: Record "HMS Patient";
        DischargeProcesses: Record "HMS Setup Discharge Processes";
        PatientName: Text[100];

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.Reset();
        PatientName := '';
        if Patient.Get(PatientNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
    end;
}
