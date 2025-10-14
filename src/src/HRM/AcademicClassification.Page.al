namespace PTL.HRMIS;

page 52202640 "Academic Classification"
{
    ApplicationArea = All;
    PageType = list;
    SourceTable = "Academic Classification";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Qualification; Rec.Qualification)
                {
                    ToolTip = 'Specifies the value of the Qualification field.';
                }
                field(Classification; Rec.Classification)
                {
                    ToolTip = 'Specifies the value of the Classification field.';
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ToolTip = 'Executes the ActionName action.';
                trigger OnAction()
                begin
                end;
            }
        }
    }
}