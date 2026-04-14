Page 85589 "Appraisal Indicators"
{
    PageType = List;
    SourceTable = "HR Appraisal indicators";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(PerformanceIndicator; Rec."Performance Indicator")
                {
                    ToolTip = 'Specifies the value of the Performance Indicator field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {
    }
}
