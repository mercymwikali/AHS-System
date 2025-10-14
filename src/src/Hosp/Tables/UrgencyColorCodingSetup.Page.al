namespace PTL.HMIS;

page 52203183 "Urgency Color Coding Setup"
{
    ApplicationArea = All;
    Caption = 'Urgency Color Coding Setup';
    PageType = List;
    SourceTable = "Urgency Color Coding Setup";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Urgency Status"; Rec."Urgency Status")
                {
                    ToolTip = 'Specifies the value of the Urgency Status field.', Comment = '%';
                }
                field("Color Code"; Rec."Color HexCode")
                {
                    ToolTip = 'Specifies the value of the Color Code field.', Comment = '%';
                }
                field(StyleExpr; Rec.StyleExpr)
                {
                    ToolTip = 'Specifies the value of the StyleExpr field.', Comment = '%';
                }
            }
        }
    }
}
