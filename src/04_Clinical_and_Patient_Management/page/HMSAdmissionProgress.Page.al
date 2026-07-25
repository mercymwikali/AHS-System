page 85307 "HMS Admission Progress"
{
    InsertAllowed = false;
    PageType = Document;
    SourceTable = "HMS Admission Form Header";
    SourceTableView = where(Status = const(Admitted));
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
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Date field.';
                }
                field("Admission Time"; Rec."Admission Time")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Time field.';
                }
                field("Admission Area"; Rec."Admission Area")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Area field.';
                }
                field(Ward; Rec.Ward)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Ward field.';
                }
                field("Ward Room"; Rec."Ward Room")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Ward Room field.';
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
                field("Admission Reason"; Rec."Admission Reason")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Reason field.';
                }
                field("Final Diagnosis"; Rec."Final Diagnosis")
                {
                    ToolTip = 'Specifies the value of the Final Diagnosis field.';
                }
                field("Final Diagnosis Name"; Rec."Final Diagnosis Name")
                {
                    ToolTip = 'Specifies the value of the Final Diagnosis Name field.', Comment = '%';
                }                
                field("Next Appointment Date"; Rec."Next Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Next Appointment Date field.';
                }
                field("Next Apointment Slot"; Rec."Next Apointment Slot")
                {
                    ToolTip = 'Specifies the value of the Next Apointment Slot field.';
                    Visible = false;
                }
                field("Next Appointment Time"; Rec."Next Appointment Time")
                {
                    ToolTip = 'Specifies the value of the Next Appointment Time field.';
                    Visible = false;
                }
            }
            group("Daily Processes/Procedures")
            { // TODO Replace with Doctors Ward Rounds Notes.
                Caption = 'Daily Processes/Procedures';
                part(Control1102760006; "Doctor Notes List")
                {
                    SubPageLink = "Admission No." = field("Admission No.");
                }
            }
            group("Nurse Notes")
            {
                Caption = 'Nurse Notes';
                part(Control1102760007; "HMS Admission Nurse Notes")
                {
                    SubPageLink = "Admission No." = field("Admission No.");
                }
            }
            group(Prescription)
            {
                Caption = 'Prescription';
                part(Control1102760008; "HMS Admission Form Drug")
                {
                    SubPageLink = "Admission No." = field("Admission No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Initiate Discharge")
            {
                Caption = '&Initiate Discharge';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Initiate Discharge action.';
                trigger OnAction()
                var
                    CuHMSProcess: Codeunit "HMS Processes";
                begin
                    if Confirm('Do you wish to initiate Patient discharge?', false) = false then
                        exit;
                    if CuHMSProcess.FnInpatientInitiateDischarge(Rec) then
                        Message('Patient Admission Discharge Process Initiated');
                end;
            }
        }
    }

    var
        DischargeHeader: Record "HMS Admission Discharge Header";
        DischargeLine: Record "HMS Admission Discharge Line";
        Patient: Record "HMS Patient";
        DischargeProcesses: Record "HMS Setup Discharge Processes";
        PatientName: Text[100];
}
