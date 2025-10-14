namespace PTL.HMIS;

page 52203181 "HMS Doctors Notes Card"
{
    ApplicationArea = All;
    Caption = 'HMS Doctors Notes Card';
    PageType = Card;
    SourceTable = "HMS Notes";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
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
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies the value of the Created Date field.', Comment = '%';
                }
                field(Clinic; Rec.Clinic)
                {
                    ToolTip = 'Specifies the value of the Clinic field.', Comment = '%';
                }
                field("Creation Time"; Rec."Creation Time")
                {
                    ToolTip = 'Specifies the value of the Creation Time field.', Comment = '%';
                }
            }
            group(DocNotes)
            {
                Caption = 'Notes';
                
                field(Notes; Rec.Notes)
                {
                    Caption = 'Doctors Notes';
                    ToolTip = 'Specifies the value of the Notes field.', Comment = '%';
                    MultiLine = true;
                }
            }
        }
    }
}
