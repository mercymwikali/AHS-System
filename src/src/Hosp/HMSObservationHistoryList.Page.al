Page 52202830 "HMS Observation History List"
{
    CardPageID = "HMS Observation Form Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HMS Observation Form Header";
    SourceTableView = where(Closed = const(true));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ObservationNo; Rec."Observation No.")
                {
                    ToolTip = 'Specifies the value of the Observation No. field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(ObservationType; Rec."Observation Type")
                {
                    ToolTip = 'Specifies the value of the Observation Type field.';
                }
                field(LinkNo; Rec."Link No.")
                {
                    ToolTip = 'Specifies the value of the Link No. field.';

                    trigger OnValidate()
                    begin
                        if Rec."Observation Type" = Rec."observation type"::Appointment then
                            GetAppointmentDetails();
                    end;
                }
                field(ObservationDate; Rec."Observation Date")
                {
                    ToolTip = 'Specifies the value of the Observation Date field.';
                }
                field(ObservationTime; Rec."Observation Time")
                {
                    ToolTip = 'Specifies the value of the Observation Time field.';
                }
                field(ObservationUserID; Rec."Observation User ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Observation User ID field.';
                }
                field(ObservationUserIDName; ObservationUserIDName)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the ObservationUserIDName field.';
                }
                field(ObservationRemarks; Rec."Observation Remarks")
                {
                    ToolTip = 'Specifies the value of the Observation Remarks field.';
                }
                field(Closed; Rec.Closed)
                {
                    Caption = 'Released';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Released field.';
                }
                field(StudentNo; Rec."Student No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field(RelativeNo; Rec."Relative No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Relative No. field.';
                }
                field(PatientName; PatientName)
                {
                    Caption = 'Patient Name';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient Name field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //OnAfterGetCurrRecord;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
        Appointment: Record "HMS Appointment Form Header";
        Patient: Record "HMS Patient";
        User: Record User;
        ObservationUserIDName: Text[30];
        PatientName: Text[100];

    procedure GetAppointmentDetails()
    begin
        /*Get the appointment details from the database*/
        Appointment.Reset();
        if Appointment.Get(Rec."Link No.") then begin
            Rec."Patient No." := Appointment."Patient No.";
            Rec."Student No." := Appointment."Student No.";
            Rec."Employee No." := Appointment."Employee No.";
            Rec."Relative No." := Appointment."Relative No.";
            Rec."Link Type" := 'Appointment';
            GetPatientName(Rec."Patient No.", PatientName);
        end;
    end;

    procedure GetVisitDetails()
    begin
    end;

    procedure GetAdmissionDetails()
    begin
    end;

    procedure GetPatientName(var PatientNo: Code[20]; var PatientName: Text[100])
    begin
        Patient.Reset();
        PatientName := '';
        if Patient.Get(PatientNo) then
            PatientName := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
    end;

    procedure GetUserName()
    begin
        User.Reset();
        if User.Get(Rec."Observation User ID") then
            ObservationUserIDName := User."User Name";
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        //VALIDATE("Patient No.");
        GetPatientName(Rec."Patient No.", PatientName);
        GetUserName();
    end;
}
