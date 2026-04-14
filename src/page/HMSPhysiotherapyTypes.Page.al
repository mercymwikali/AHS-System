Page 85411 "HMS Physiotherapy Types"
{
    PageType = List;
    SourceTable = "HMS PhysioTypes";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(pfno; Rec.pfno)
                {
                    ToolTip = 'Specifies the value of the pfno field.';
                }
                field("code"; Rec.code)
                {
                    ToolTip = 'Specifies the value of the code field.';
                }
                field(Amounttt; Rec.Amounttt)
                {
                    ToolTip = 'Specifies the value of the Amounttt field.';
                }
            }
        }
    }

    actions
    {
    }
}
