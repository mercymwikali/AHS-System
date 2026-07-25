page 85310 "HMS Admission Verication Card"
{
    PageType = Document;
    SourceTable = "HMS Admission Form Header";
    SourceTableView = WHERE(Status = CONST(New));
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
                field("Admission Type"; Rec."Admission Type")
                {
                    ToolTip = 'Specifies the value of the Admission Type field.';
                }
                field(Ward; Rec.Ward)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Ward field.';
                }
                field(Bed; Rec.Bed)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Bed field.';
                }
                field(Doctor; Rec.Doctor)
                {
                    ToolTip = 'Specifies the value of the Doctor field.';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Patient No. field.';
                }
                field(PatientName; PatientName)
                {
                    Editable = false;
                    ShowCaption = false;
                }
                field(Branch; Rec.Branch)
                {
                    // Editable = false;
                    ToolTip = 'Specifies the value of the Branch field.';
                }
                field("Admission Reason"; Rec."Admission Reason")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Reason field.';
                }
            }
            part(Control1102760002; "HMS Admission Form Lines")
            {
                SubPageLink = Status = CONST(Admitted);
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
                ToolTip = 'Executes the &Verify Patient Admission action.';
                trigger OnAction()
                var
                    HMSProcesses: Codeunit "HMS Processes";
                begin
                    if Confirm('Verify Patient?', true) = false then
                        exit;
                    HMSProcesses.FnVerifyAdmissionRequest(Rec);

                    Message('Patient Verified');
                end;
            }

            action("&Cancel Admission")
            {
                Caption = '&Cancel Admission';
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the &Cancel Admission action.';
                trigger OnAction()
                var
                    HMSProcesses: Codeunit "HMS Processes";
                begin
                    if Confirm('Cancel the Admission Request?', false) = false then
                        exit;

                    HMSProcesses.FnCancelAdmissionRequest(Rec);

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
