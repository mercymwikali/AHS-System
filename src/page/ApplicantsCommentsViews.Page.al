Page 85581 "Applicants Comments/Views"
{
    PageType = ListPart;
    SourceTable = "Applicants Comments/Views";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(ViewsComments; Rec."Views/Comments")
                {
                    ToolTip = 'Specifies the value of the Views/Comments field.';
                }
            }
        }
    }

    actions
    {
    }
}
