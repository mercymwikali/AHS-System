page 85341 "HMS Drug Interaction Header"
{
    PageType = Document;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the item.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies a description of the item.';
                }
            }
            part(Control1102760000; "HMS Drug Interaction Line")
            {
                SubPageLink = "Drug No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}
