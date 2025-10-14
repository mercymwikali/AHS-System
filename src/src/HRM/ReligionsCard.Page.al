Page 52202780 "Religions Card"
{
    PageType = Card;
    SourceTable = Religions;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Religion; Rec.Religion)
                {
                    ToolTip = 'Specifies the value of the Religion field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
    }
}
