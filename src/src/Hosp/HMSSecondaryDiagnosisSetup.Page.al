namespace PTL.HMIS;

page 52203182 "HMS Secondary Diagnosis Setup"
{
    ApplicationArea = All;
    Caption = 'HMS Secondary Diagnosis Setup';
    PageType = List;
    SourceTable = "HMS Secondary Diagnosis Setup";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Diagnosis Code"; Rec."Diagnosis Code")
                {
                    ToolTip = 'Specifies the value of the Diagnosis Code field.', Comment = '%';
                }
                field(Diagnosis; Rec.Diagnosis)
                {
                    ToolTip = 'Specifies the value of the Diagnosis field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("MOH Code"; Rec."MOH Code")
                {
                    ToolTip = 'Specifies the value of the MOH Code field.', Comment = '%';
                }
                field("MOH Description"; Rec."MOH Description")
                {
                    ToolTip = 'Specifies the value of the MOH Description field.', Comment = '%';
                }
            }
        }
    }
}
