Page 85322 "HMS Blood Group Donation Card"
{
    PageType = Card;
    SourceTable = "HMS Setup Blood Donation";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(Donor; Rec.Donor)
                {
                    ToolTip = 'Specifies the value of the Donor field.';
                }
                field(Recipient; Rec.Recipient)
                {
                    ToolTip = 'Specifies the value of the Recipient field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {
    }
}
