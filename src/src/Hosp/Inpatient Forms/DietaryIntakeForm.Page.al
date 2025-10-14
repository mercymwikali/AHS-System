namespace PTL.HMIS;

page 52203171 "Dietary Intake Form"
{
    ApplicationArea = All;
    Caption = 'Dietary Intake Form';
    PageType = Card;
    SourceTable = "Dietary Intake Form Header";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Admission No."; Rec."Admission No.")
                {
                    ToolTip = 'Specifies the value of the Admission No. field.', Comment = '%';
                }
                field(Height; Rec.Height)
                {
                    ToolTip = 'Specifies the value of the Height field.', Comment = '%';
                }
                field(Weight; Rec.Weight)
                {
                    ToolTip = 'Specifies the value of the Weight field.', Comment = '%';
                }
                field(RM; Rec.RM)
                {
                    ToolTip = 'Specifies the value of the RM field.', Comment = '%';
                }
                field("Preferences (Meals)"; Rec."Preferences (Meals)")
                {
                    ToolTip = 'Specifies the value of the Preferences (Meals) field.', Comment = '%';
                }
                field("Preferences (Beverages)"; Rec."Preferences (Beverages)")
                {
                    ToolTip = 'Specifies the value of the Preferences (Beverages) field.', Comment = '%';
                }
            }
            part("Form Lines"; "Dietary Intake Form Lines")
            {
                Caption = 'Dietary Intake Form';
                SubPageLink = "Admission No." = field("Admission No.");
            }
        }
    }
}
