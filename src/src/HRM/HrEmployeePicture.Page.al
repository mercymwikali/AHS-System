Page 52202451 "Hr Employee Picture"
{
    Caption = 'Employee Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SourceTable = "HR-Employee";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ToolTip = 'Specifies the value of the Picture field.';
            }
        }
    }

    actions
    {
    }
}
