namespace PTL.HMIS;

page 85493 "Dietary Intake Form Lines"
{
    ApplicationArea = All;
    Caption = 'Dietary Intake Form Lines';
    PageType = ListPart;
    SourceTable = "Dietary Intake Form Lines";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Admission No."; Rec."Admission No.")
                {
                    ToolTip = 'Specifies the value of the Admission No. field.', Comment = '%';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field.', Comment = '%';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.', Comment = '%';
                }
            }
        }
    }
}
