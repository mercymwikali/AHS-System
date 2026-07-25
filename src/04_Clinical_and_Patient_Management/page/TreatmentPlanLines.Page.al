namespace PTL.HMIS;

page 85565 "Treatment Plan Lines"
{
    ApplicationArea = All;
    Caption = 'Treatment Plan Lines';
    PageType = ListPart;
    SourceTable = "Treatment Plan Lines(Psych)";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Plan No."; Rec."Plan No.")
                {
                    ToolTip = 'Specifies the value of the Plan No. field.', Comment = '%';
                }
                field("Session No"; Rec."Session No")
                {
                    ToolTip = 'Specifies the value of the Session No field.', Comment = '%';
                }
                field("Aim/Plan"; Rec."Aim/Plan")
                {
                    ToolTip = 'Specifies the value of the Aim/Plan field.', Comment = '%';
                }
                field("Date Done"; Rec."Date Done")
                {
                    ToolTip = 'Specifies the value of the Date Done field.', Comment = '%';
                }
                field("Treatment No"; Rec."Treatment No")
                {
                    ToolTip = 'Specifies the value of the Treatment No field.', Comment = '%';
                }
                field("Therapy Session No"; Rec."Therapy Session No")
                {
                    ToolTip = 'Specifies the value of the Therapy Session No field.', Comment = '%';
                }
            }
        }
    }
}
