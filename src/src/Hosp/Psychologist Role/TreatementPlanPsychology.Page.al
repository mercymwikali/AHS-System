namespace PTL.HMIS;

page 52203176 "Treatement Plan(Psychology)"
{
    ApplicationArea = All;
    Caption = 'Treatement Plan(Psychology)';
    PageType = ListPart;
    SourceTable = "Treatment Plan(Psychology)";
    CardPageId = "Treatment Plan Card(Psych)";
    UsageCategory = None;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Plan No."; Rec."Plan No.")
                {
                    ToolTip = 'Specifies the value of the Plan No. field.', Comment = '%';
                    Editable = false;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.', Comment = '%';
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.', Comment = '%';
                    Editable = false;
                }
                field("Doctor No."; Rec."Doctor No.")
                {
                    ToolTip = 'Specifies the value of the Doctor No. field.', Comment = '%';
                }
                field("Doctor Name"; Rec."Doctor Name")
                {
                    ToolTip = 'Specifies the value of the Doctor Name field.', Comment = '%';
                    Editable = false;
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
        }
    }
}
