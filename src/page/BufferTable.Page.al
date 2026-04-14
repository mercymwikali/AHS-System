page 85104 "Buffer Table"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Buffer Table";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("New Code"; Rec."New Code")
                {
                    ToolTip = 'Specifies the value of the New Code field.';
                }
            }
        }
        area(Factboxes)
        {
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