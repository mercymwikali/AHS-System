Page 85701 "HR Training Cost"
{
    PageType = List;
    SourceTable = "HR Training Cost";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TrainingId; Rec."Training Id")
                {
                    ToolTip = 'Specifies the value of the Training Id field.';
                }
                field(TrainingCostItem; Rec."Training Cost Item")
                {
                    ToolTip = 'Specifies the value of the Training Cost Item field.';
                }
                field(Cost; Rec.Cost)
                {
                    ToolTip = 'Specifies the value of the Cost field.';
                }
            }
        }
    }

    actions
    {
    }
}
