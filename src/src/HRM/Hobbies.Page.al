Page 52203122 Hobbies
{
    PageType = ListPart;
    SourceTable = Hobbies;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Hobbies; Rec.Hobbies)
                {
                    ToolTip = 'Specifies the value of the Hobbies field.';
                }
            }
        }
    }

    actions
    {
    }
}
