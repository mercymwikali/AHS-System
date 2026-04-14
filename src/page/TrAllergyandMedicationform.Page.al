namespace PTL.HMIS;

page 85570 "Tr Allergy and Medication form"
{
    ApplicationArea = All;
    Caption = 'Tr Allergy and Medication form';
    PageType = ListPart;
    SourceTable = "Tr Allergy and Medication form";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Observation No."; Rec."Observation No.")
                {
                    ToolTip = 'Specifies the value of the Observation No. field.', Comment = '%';
                }

                field(Complaints; Rec.Complaints)
                {
                    ToolTip = 'Specifies the value of the Complaints field.', Comment = '%';
                }
                field("Reason for Revisit"; Rec."Reason for Revisit")
                {
                    ToolTip = 'Specifies the value of the Reason for Revisit field.', Comment = '%';
                }
                field("Food Allergy"; Rec."Food Allergy")
                {
                    ToolTip = 'Specifies the value of the Food Allergy field.', Comment = '%';
                }
                field("Drug Allergy"; Rec."Drug Allergy")
                {
                    ToolTip = 'Specifies the value of the Drug Allergy field.', Comment = '%';
                }
                 field("Chronic Illness"; Rec."Chronic Illness")
                {
                    ToolTip = 'Specifies the value of the Chronic illness field.', Comment = '%';
                }
                field("Assessed By"; Rec."Assessed By")
                {
                    ToolTip = 'Specifies the value of the Assessed By field.', Comment = '%';
                }
            }
        }
    }
}
