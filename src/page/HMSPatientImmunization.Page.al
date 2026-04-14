Page 85379 "HMS Patient Immunization"
{ //TODO: Remove This Table. Redundant to CHG
    PageType = ListPart;
    SourceTable = "HMS Patient Immunization";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(ImmunizationCode; Rec."Immunization Code")
                {
                    ToolTip = 'Specifies the value of the Immunization Code field.';
                }
                field(ImmunizationName; Rec."Immunization Name")
                {
                    ToolTip = 'Specifies the value of the Immunization Name field.';
                }
                field(Yes; Rec.Yes)
                {
                    ToolTip = 'Specifies the value of the Yes field.';
                }
                field(ImmunizationDate; Rec."Immunization Date")
                {
                    ToolTip = 'Specifies the value of the Immunization Date field.';
                }
            }
        }
    }

    actions
    {
    }
}
