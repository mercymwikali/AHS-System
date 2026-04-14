namespace PTL.Hospital;

page 85002 "Vital Monitoring Chart Range"
{
    ApplicationArea = All;
    Caption = 'Vital Monitoring Chart Range';
    PageType = List;
    SourceTable = "Vital Scale";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Upper Limit field.', Comment = '%';
                }
                field(Tier; Rec.Tier)
                {
                    ToolTip = 'Specifies the value of the Tier field.', Comment = '%';
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ToolTip = 'Specifies the value of the Lower Limit field.', Comment = '%';
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ToolTip = 'Specifies the value of the Upper Limit field.', Comment = '%';
                }
                field("Vital Type"; Rec."Vital Type")
                {
                    ToolTip = 'Specifies the value of the Vital Type field.', Comment = '%';
                }            
            }
        }
    }
}
