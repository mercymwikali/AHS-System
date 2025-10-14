namespace PTL.HMIS;

page 52203173 "Jackson Visual Form"
{
    ApplicationArea = All;
    Caption = 'Jackson Visual Form';
    PageType = List;
    SourceTable = "Jackson Visual Form";
    UsageCategory = None;
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Admission No"; Rec."Admission No")
                {
                    ToolTip = 'Specifies the value of the Admission No field.', Comment = '%';
                    Editable = false;
                }
                field("Date "; Rec."Date ")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field.', Comment = '%';
                }
                field("IV Line "; Rec."IV Line ")
                {
                    ToolTip = 'Specifies the value of the IV Line field.', Comment = '%';
                }
                field(Nurse; Rec.Nurse)
                {
                    ToolTip = 'Specifies the value of the Nurse field.', Comment = '%';
                }
            }
        }
    }
}
