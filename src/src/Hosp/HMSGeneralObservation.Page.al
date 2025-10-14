Page 52202697 "HMS General Observation"
{
    PageType = List;
    SourceTable = "HMS General Observation";
    SourceTableView = where(ICU = filter(false));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Category; Rec.Category)
                {
                    ToolTip = 'Specifies the value of the Category field.';
                }
                field(CategoryValue; Rec."Category Value")
                {
                    ToolTip = 'Specifies the value of the Category Value field.';
                }
                field(Timing; Rec.Timing)
                {
                    ToolTip = 'Specifies the value of the Timing field.';
                }
            }
        }
    }

    actions
    {
    }
}
