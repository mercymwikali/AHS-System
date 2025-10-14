namespace PTL.HMIS;

page 52203165 "Suicidal Precaution Form"
{
    ApplicationArea = All;
    Caption = 'Suicidal Precaution Form';
    PageType = ListPart;
    SourceTable = "Suicidal Precaution Form";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Admission No."; Rec."Admission No.")
                {
                    ToolTip = 'Specifies the value of the Admission No field.', Comment = '%';
                    Visible = false;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Time"; Rec."Time")
                {
                    ToolTip = 'Specifies the value of the Time field.', Comment = '%';
                }
                field("Handing Over"; Rec."Handing Over")
                {
                    ToolTip = 'Specifies the value of the Handing Over field.', Comment = '%';
                }
                field("Taking Over"; Rec."Taking Over")
                {
                    ToolTip = 'Specifies the value of the Taking Over field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';

                }
            }
        }
    }
}
