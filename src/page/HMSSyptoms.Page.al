Page 85456 "HMS Syptoms"
{
    PageType = List;
    SourceTable = "HMS Symptoms Setup";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Treatmentno; Rec."Treatment no")
                {
                    ToolTip = 'Specifies the value of the Treatment no field.';
                }
                field(SyptomCode; Rec."Syptom Code")
                {
                    ToolTip = 'Specifies the value of the Syptom Code field.';
                }
                field(SymptomName; Rec."Symptom Name")
                {
                    ToolTip = 'Specifies the value of the Symptom Name field.';
                }
            }
        }
    }

    actions
    {
    }
}
