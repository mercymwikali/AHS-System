page 52202691 "HMS Treatment History"
{
    PageType = ListPart;
    SourceTable = "HMS Treatment History";

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                ShowCaption = false;
                field("History Code"; Rec."History Code")
                {
                    ToolTip = 'Specifies the value of the History Code field.';
                }
                field("History Name"; Rec."History Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the History Name field.';
                }
                field("History Value"; Rec."History Value")
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the History Value field.';
                }
            }
        }
    }

    actions
    {
    }
}
