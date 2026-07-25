Page 85781 "prNHIF SetUp"
{
    PageType = List;
    SourceTable = prNHIF;
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
                field(LowerLimit; Rec."Lower Limit")
                {
                    ToolTip = 'Specifies the value of the Lower Limit field.';
                }
                field(UpperLimit; Rec."Upper Limit")
                {
                    ToolTip = 'Specifies the value of the Upper Limit field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }

    actions
    {
    }
}
