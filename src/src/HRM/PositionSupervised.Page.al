Page 52203115 "Position Supervised"
{
    PageType = ListPart;
    SourceTable = "Position Supervised";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(JobID; Rec."Position Supervised")
                {
                    Caption = 'Job ID';
                    ToolTip = 'Specifies the value of the Job ID field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
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
