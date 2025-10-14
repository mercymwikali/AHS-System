Page 52202853 "HMS Setup Injection Card"
{
    PageType = Card;
    SourceTable = "HMS Setup Injection";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(ItemNo; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
            }
        }
    }

    actions
    {
    }
}
