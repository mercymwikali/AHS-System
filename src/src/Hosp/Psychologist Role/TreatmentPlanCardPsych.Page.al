namespace PTL.HMIS;

page 52203177 "Treatment Plan Card(Psych)"
{
    ApplicationArea = All;
    Caption = 'Treatment Plan Card(Psych)';
    PageType = Card;
    SourceTable = "Treatment Plan(Psychology)";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Plan No."; Rec."Plan No.")
                {
                    ToolTip = 'Specifies the value of the Plan No. field.', Comment = '%';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.', Comment = '%';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.', Comment = '%';
                }
                field("Doctor No."; Rec."Doctor No.")
                {
                    ToolTip = 'Specifies the value of the Doctor No. field.', Comment = '%';
                }
                field("Doctor Name"; Rec."Doctor Name")
                {
                    ToolTip = 'Specifies the value of the Doctor Name field.', Comment = '%';
                }
                field(Diagnosis; Rec.Diagnosis)
                {
                    ToolTip = 'Specifies the value of the Diagnosis field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
            part("Treatment Plan Lines"; "Treatment Plan Lines")
            {
                SubPageLink = "Plan No." = field("Plan No.");
            }
        }
    }
}
