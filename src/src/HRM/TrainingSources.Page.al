Page 52203116 "Training Sources"
{
    PageType = ListPart;
    SourceTable = "Training Source";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Source; Rec.Source)
                {
                    ToolTip = 'Specifies the value of the Source field.';
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
