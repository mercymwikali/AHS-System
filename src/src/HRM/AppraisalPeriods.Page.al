Page 52203098 "Appraisal Periods"
{
    PageType = list;
    SourceTable = "Appraisal Periods";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field.';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
            }
        }
    }

    actions
    {
    }
}
