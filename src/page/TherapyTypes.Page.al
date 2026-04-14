namespace PTL.Hospital;

page 85824 "Therapy Types"
{
    ApplicationArea = All;
    Caption = 'Therapy Types';
    PageType = List;
    SourceTable = "Therapy Types";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Therapy Code"; Rec."Therapy Code")
                {
                    ToolTip = 'Specifies the value of the Therapy Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
