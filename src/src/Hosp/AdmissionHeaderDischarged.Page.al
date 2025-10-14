namespace PTL.Hospital;

page 52203220 "Admission Header Discharged"
{
    ApplicationArea = All;
    Caption = 'Admission Header Discharged';
    PageType = Card;
    SourceTable = "HMS Admission Form Header";

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
                field("Admission Type"; Rec."Admission Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Admission Type field.';
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
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Bed; Rec.Bed)
                {
                    // Editable = false;
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
                group(EDD)
                {
                    field("Expected Date of Discharge"; Rec."Expected Date of Discharge")
                    {
                        ToolTip = 'Specifies the value of the Expected Date of Discharge field.';
                    }
                }
                field("Psychiatric Coding"; Rec."Psychiatric Coding")
                {
                    ToolTip = 'Specifies the value of the Psychiatric Coding field';
                }
                field("Code Reason"; Rec."Code Reason")
                {
                    ToolTip = 'Specifies the value of the Coding Reason field';
                }
                field(SystemId; SystemId)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field("Link Type"; Rec."Link Type")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Link Type field.';
                }
                field("Link No."; Rec."Link No.")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Link No. field.';
                }

                field("Off Duty"; Rec."Off Duty")
                {
                    ToolTip = 'Specifies the value of the Off Duty field.', Comment = '%';
                    Visible = false;
                }
                field("Off Duty Days"; Rec."Off Duty Days")
                {
                    ToolTip = 'Specifies the value of the Off Duty Days field.', Comment = '%';
                    Visible = false;
                }
                field("Off Duty Comments"; Rec."Off Duty Comments")
                {
                    ToolTip = 'Specifies the value of the Off Duty Comments field.', Comment = '%';
                    Visible = false;
                }
                field("Sick Off End Date"; Rec."Sick Off End Date")
                {
                    ToolTip = 'Specifies the value of the Sick Off End Date field.', Comment = '%';
                    Visible = false;
                }
                field("Sick Off Start Date"; Rec."Sick Off Start Date")
                {
                    ToolTip = 'Specifies the value of the Sick Off Start Date field.', Comment = '%';
                    Visible = false;
                }

            }
            part(Control1102760002; "HMS Admission Form Lines")
            {
                SubPageLink = Status = CONST(Admitted);
            }

        }
    }
    var
        Patient: Record "HMS Patient";
        PatientName: Text[250];

    procedure GetPatientName(PatientNo: Code[30])
    begin
        Patient.Reset();
        PatientName := '';
        if Patient.Get(PatientNo) then
            PatientName := Patient."Search Name";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        GetPatientName(Rec."Patient No.");
    end;
}
