namespace PTL.HMIS;

page 52203180 "HMS Doctors Notes"
{
    ApplicationArea = All;
    Caption = 'HMS Doctors Notes';
    CardPageId = "HMS Doctors Notes Card";
    PageType = List;
    Editable = false;
    SourceTable = "HMS Notes";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(TreatmentNo; Rec.TreatmentNo)
                {
                    ToolTip = 'Specifies the value of the TreatmentNo field.', Comment = '%';
                }
                field(PatientNo; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the PatientNo field.', Comment = '%';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.', Comment = '%';
                }
                field("Treatment Date"; Rec."Treatment Date")
                {
                    ToolTip = 'Specifies the value of the Treatment Date field.', Comment = '%';
                }
                field("Treatment Time"; Rec."Treatment Time")
                {
                    ToolTip = 'Specifies the value of the Treatment Time field.', Comment = '%';
                }
                field("Notes Type"; Rec."Notes Type")
                {
                    ToolTip = 'Specifies the value of the Notes Type field.', Comment = '%';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.', Comment = '%';
                }
                field(Clinic; Rec.Clinic)
                {
                    ToolTip = 'Specifies the value of the Clinic field.', Comment = '%';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field.', Comment = '%';
                }
                field("Creation Time"; Rec."Creation Time")
                {
                    ToolTip = 'Specifies the value of the Creation Time field.', Comment = '%';
                }
                field(Notes; Rec.Notes)
                {
                    ToolTip = 'Specifies the value of the Notes field.', Comment = '%';
                }
                field("Notes Section ID"; Rec."Notes Section ID")
                {
                    ToolTip = 'Specifies the value of the Notes Section ID field.', Comment = '%';
                }
                field("Notes Section Name"; Rec."Notes Section Name")
                {
                    ToolTip = 'Specifies the value of the Notes Section Name field.', Comment = '%';
                }

                field("Admission No."; Rec."Admission No.")
                {
                    ToolTip = 'Specifies the value of the Admission No. field.', Comment = '%';
                }
                field("Creation DateTime"; Rec."Creation DateTime")
                {
                    ToolTip = 'Specifies the value of the Creation DateTime field.', Comment = '%';
                }


                field(SystemId; SystemId)
                {
                    Visible = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // if not GuiAllowed then begin
        //     Rec.CalcFields(Notes);
        //     if Rec.Notes.HasValue then begin
        //         rec.Notes.CreateInStream(iStream);
        //         iStream.Read(NotesTxt);
        //     end;
        // end;
    end;
}
