Page 52202848 "HMS Setup Lab Test Specimen SF"
{
    PageType = List;
    SourceTable = "HMS Setup Test Specimen";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Specimen; Rec.Specimen)
                {
                    ToolTip = 'Specifies the value of the Specimen field.';
                }
                field(SpecimenName; Rec."Specimen Name")
                {
                    ToolTip = 'Specifies the value of the Specimen Name field.';
                }
                field(MeasuringUnit; Rec."Measuring Unit")
                {
                    ToolTip = 'Specifies the value of the Measuring Unit field.';
                }
                field(MinimumValue; Rec."Minimum Value")
                {
                    ToolTip = 'Specifies the value of the Minimum Value field.';
                }
                field(MaximumValue; Rec."Maximum Value")
                {
                    ToolTip = 'Specifies the value of the Maximum Value field.';
                }
            }
        }
    }

    actions
    {
    }
}
