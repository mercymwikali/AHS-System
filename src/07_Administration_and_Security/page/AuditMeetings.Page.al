page 85799 "Audit Meetings"
{
    ApplicationArea = All;
    CardPageId = "Audit Meetings Card";
    PageType = List;
    SourceTable = "Audit Meetings";
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Audit Code"; Rec."Audit Code")
                {
                    ToolTip = 'Specifies the value of the Audit Code field.';
                }
                field("Audit No."; Rec."Audit No.")
                {
                    ToolTip = 'Specifies the value of the Audit No. field.';
                }
                field("Audit Programme"; Rec."Audit Programme")
                {
                    ToolTip = 'Specifies the value of the Audit Programme field.';
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