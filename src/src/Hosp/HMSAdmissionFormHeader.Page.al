page 52202894 "HMS Admission Form Header"
{
    PageType = Document;
    SourceTable = "HMS Admission Form Header";
    SourceTableView = WHERE(Status = filter(Verified | New));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("Admission No."; Rec."Admission No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission No. field.';
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Admission Date field.';
                }
                field("Admission Time"; Rec."Admission Time")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Admission Time field.';
                }
                field("Admission Area"; Rec."Admission Area")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Area field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Branch field.';
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
                field(PatientName; PatientName)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field("Admission Reason"; Rec."Admission Reason")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Reason field.';
                }
                field("Diagnosis Code"; Rec."Diagnosis Code")
                {
                    Caption = 'Primary Diagnosis Code';
                    ToolTip = 'Specifies the value of the Diagnosis Code';
                }
                field("Expected Date of Discharge"; Rec."Expected Date of Discharge")
                {
                    ToolTip = 'Specifies the value of the Expected Date of discharge field';
                    Editable = false;
                }
                field("Psychiatric Coding"; Rec."Psychiatric Coding")
                {
                    ToolTip = 'Specifies the value of the Psychiatric Coding field';
                }
                field("Code Reason"; Rec."Code Reason")
                {
                    ToolTip = 'Specifies the value of the Coding Reason field';
                }
            }
            part(Control1102760002; "HMS Admission Form Lines")
            {
                SubPageLink = Status = CONST(Admitted), "Patient No." = field("Patient No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Verify Admission")
            {
                Caption = '&Verify Patient Admission';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                // Visible = false;
                ToolTip = 'Executes the &Verify Patient Admission action.';
                trigger OnAction()
                var
                    HMSSetup: Record "HMS Setup";
                begin
                    if Confirm('Verify Patient?', true) = false then
                        exit;
                    Patient.get(Rec."Patient No.");
                    HMSSetup.get();

                    Rec.Status := Rec.Status::Verified;
                    Rec.Modify();
                    Message('Patient Verified');
                end;
            }
            action("&Admit Patient")
            {
                Caption = '&Admit Patient';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Admit Patient action.';
                trigger OnAction()
                var
                    HMSProcesses: Codeunit "HMS Processes";
                begin
                    Rec.TESTFIELD(Ward);
                    Rec.TESTFIELD(Bed);

                    if CONFIRM('Admit Patient?', true) = false then
                        exit;

                    HMSProcesses.FnAdmitPatient(Rec);
                    MESSAGE('Patient Admitted');
                end;
            }
            action("&Cancel Admission")
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
                    Status := Status::Cancelled;
                    Rec.Modify();
                    Message('Admission Request Cancelled');
                end;
            }
        }
    }

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

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.", PatientName);
    end;
}
