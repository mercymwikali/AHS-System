Page 52202920 "HMS Patient Medical Condition"
{
    PageType = ListPart;
    SourceTable = "HMS Patient Medical Condition";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(MedicalCondition; Rec."Medical Condition")
                {
                    ToolTip = 'Specifies the value of the Medical Condition field.';
                }
                field(MedicalConditionName; Rec."Medical Condition Name")
                {
                    ToolTip = 'Specifies the value of the Medical Condition Name field.';
                }
                field(DateFrom; Rec."Date From")
                {
                    ToolTip = 'Specifies the value of the Date From field.';
                }
                field(DateTo; Rec."Date To")
                {
                    ToolTip = 'Specifies the value of the Date To field.';
                }
                field(Yes; Rec.Yes)
                {
                    ToolTip = 'Specifies the value of the Yes field.';
                }
                field(Details; Rec.Details)
                {
                    ToolTip = 'Specifies the value of the Details field.';
                }
            }
        }
    }

    actions
    {
    }
}
