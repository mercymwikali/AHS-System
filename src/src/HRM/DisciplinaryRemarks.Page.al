Page 52203105 "Disciplinary Remarks"
{
    PageType = ListPart;
    SourceTable = "Disciplinary Remarks";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Remark; Rec.Remark)
                {
                    ToolTip = 'Specifies the value of the Remark field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
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
