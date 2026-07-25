Page 85340 "HMS Dosage Setup"
{
    PageType = List;
    SourceTable = "HMS Dosage Setup";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DoseCode; Rec."Dose Code")
                {
                    ToolTip = 'Specifies the value of the Dose Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(CalculateDosage; Rec."Calculate Dosage")
                {
                    ToolTip = 'Specifies the value of the Calculate Dosage field.';
                }
            }
        }
    }

    actions
    {
    }
}
