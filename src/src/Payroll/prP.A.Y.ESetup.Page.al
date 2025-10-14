Page 52202795 "prP.A.Y.E Setup"
{
    PageType = List;
    SourceTable = prPAYE;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(TierCode; Rec."Tier Code")
                {
                    ToolTip = 'Specifies the value of the Tier Code field.';
                }
                field(PAYETier; Rec."PAYE Tier")
                {
                    ToolTip = 'Specifies the value of the PAYE Tier field.';
                }
                field(Rate; Rec.Rate)
                {
                    ToolTip = 'Specifies the value of the Rate field.';
                }
            }
        }
    }

    actions
    {
    }
}
