page 52202601 "PC Targets"
{
    ApplicationArea = All;
    PageType = list;
    SourceTable = "PC Targets";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Quarterly Target"; Rec."Quarterly Target")
                {
                    ToolTip = 'Specifies the value of the Quarterly Target field.';
                }
                field("Actual achieved"; Rec."Actual achieved")
                {
                    ToolTip = 'Specifies the value of the Actual achieved field.';
                }
                field("Cumulative Target"; Rec."Cumulative Target")
                {
                    ToolTip = 'Specifies the value of the Cumulative Target field.';
                }
                field("Cumulative Actual"; Rec."Cumulative Actual")
                {
                    ToolTip = 'Specifies the value of the Cumulative Actual field.';
                }
                field(Variance; Rec.Variance)
                {
                    ToolTip = 'Specifies the value of the Variance field.';
                }
                field("Comments on variance"; Rec."Comments on variance")
                {
                    ToolTip = 'Specifies the value of the Comments on variance field.';
                }
                field("action taken"; Rec."action taken")
                {
                    ToolTip = 'Specifies the value of the action taken field.';
                }
                field("Risk Mitigation"; Rec."Risk Mitigation")
                {
                    ToolTip = 'Specifies the value of the Risk Mitigation field.';
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