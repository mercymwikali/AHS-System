Page 52202961 "HMS Admission Form Header List"
{
    CardPageID = "HMS Admission Verication Card";
    PageType = List;
    SourceTable = "HMS Admission Form Header";
    SourceTableView = where(Status = const(New));
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
                    Editable = true;
                    ToolTip = 'Specifies the value of the Admission Date field.';
                }
                field(AdmissionTime; Rec."Admission Time")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Admission Time field.';
                }
                field(AdmissionArea; Rec."Admission Area")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Area field.';
                }
                field(Ward; Rec.Ward)
                {
                    ToolTip = 'Specifies the value of the Ward field.';
                }
                field("Ward Room"; Rec."Ward Room")
                {
                    ToolTip = 'Specifies the value of the Ward Room field.';
                }
                field(Bed; Rec.Bed)
                {
                    ToolTip = 'Specifies the value of the Bed field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ToolTip = 'Specifies the value of the Doctor field.';
                }
                field(PatientNo; Rec."Patient No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(PatientName; PatientName)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the PatientName field.';
                }
                field(EmployeeNoRelativeNo; Rec."Employee No.")
                {
                    Caption = 'Employee No./Relative No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Employee No./Relative No. field.';
                }
                field(RelativeNo; Rec."Relative No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Relative No. field.';
                }
                field(StudentNo; Rec."Student No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field(AdmissionReason; Rec."Admission Reason")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Reason field.';
                }
                field("Psychiatric Coding"; Rec."Psychiatric Coding")
                {
                    ToolTip = 'Specifies the value of the Psychiatric Coding field';
                }
                field("Code Reason"; Rec."Code Reason")
                {
                    ToolTip = 'Specifies the value of the Coding Reason field';
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
            action(AdmitPatient)
            {
                Caption = '&Admit Patient';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Admit Patient action.';

                trigger OnAction()
                begin
                    if Confirm('Admit Patient?', true) = false then
                        exit;
                    Rec.Status := Rec.Status::Admitted;
                    Rec.Modify();
                    Message('Patient Admitted');
                end;
            }
            action(CancelAdmission)
            {
                Caption = '&Cancel Admission';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Cancel Admission action.';

                trigger OnAction()
                begin
                    if Confirm('Cancel the Admission Request?', false) = false then
                        exit;
                    //Status:=Status::Cancelled;
                    Rec.Modify();
                    Message('Admission Request Cancelled');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
        Patient: Record "HMS Patient";
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
