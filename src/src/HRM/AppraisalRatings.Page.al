Page 52203137 "Appraisal Ratings"
{
    PageType = List;
    SourceTable = "Appraisal Ratings";
    SourceTableView = sorting(Rating)
                      order(descending);
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Rating; Rec.Rating)
                {
                    ToolTip = 'Specifies the value of the Rating field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}
