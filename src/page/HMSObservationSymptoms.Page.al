Page 85369 "HMS Observation Symptoms"
{
    PageType = ListPart;
    SourceTable = "HMS Observation Symptoms";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(System; Rec.System)
                {
                    ToolTip = 'Specifies the value of the System field.';
                }
                field(SymptomCode; Rec."Symptom Code")
                {
                    ToolTip = 'Specifies the value of the Symptom Code field.';
                }
                field(SymptomDescription; Rec."Symptom Description")
                {
                    ToolTip = 'Specifies the value of the Symptom Description field.';
                }
                field(Duration; Rec.Duration)
                {
                    ToolTip = 'Specifies the value of the Duration field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Characteristics; Rec.Characteristics)
                {
                    ToolTip = 'Specifies the value of the Characteristics field.';
                }
            }
        }
    }

    actions
    {
    }
}
