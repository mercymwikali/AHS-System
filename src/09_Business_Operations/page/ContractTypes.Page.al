Page 85602 "Contract Types"
{
    PageType = Card;
    SourceTable = "Contract Types";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Contract; Rec.Contract)
                {
                    ToolTip = 'Specifies the value of the Contract field.';
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
