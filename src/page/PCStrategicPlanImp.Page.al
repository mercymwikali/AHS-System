page 85723 "PC Strategic Plan Imp."
{
    ApplicationArea = All;
    CardPageId = "PC Strategic Plan Imp. Card";
    PageType = List;
    SourceTable = "PC Strategic Plan Imp";
    UsageCategory = Administration;
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
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Objectives; Rec.Objectives)
                {
                    ToolTip = 'Specifies the value of the Objectives field.';
                }
                field(Strategies; Rec.Strategies)
                {
                    ToolTip = 'Specifies the value of the Strategies field.';
                }
                field(Activities; Rec.Activities)
                {
                    ToolTip = 'Specifies the value of the Activities field.';
                }
                field("Expected Outputs"; Rec."Expected Outputs")
                {
                    ToolTip = 'Specifies the value of the Expected Outputs field.';
                }
                field("Performance Indicators"; Rec."Performance Indicators")
                {
                    ToolTip = 'Specifies the value of the Performance Indicators field.';
                }
                field("Baseline Value"; Rec."Baseline Value")
                {
                    ToolTip = 'Specifies the value of the Baseline Value field.';
                }
                field("Overall Target"; Rec."Overall Target")
                {
                    ToolTip = 'Specifies the value of the Overall Target field.';
                }
                field("Annual Targets"; Rec."Annual Targets")
                {
                    ToolTip = 'Specifies the value of the Annual Targets field.';
                }
                field("Time – Line"; Rec."Time – Line")
                {
                    ToolTip = 'Specifies the value of the Time – Line field.';
                }
                field("Annual Budgets"; Rec."Annual Budgets")
                {
                    ToolTip = 'Specifies the value of the Annual Budgets field.';
                }
                field("Overall Budget"; Rec."Overall Budget")
                {
                    ToolTip = 'Specifies the value of the Overall Budget field.';
                }
                field("Action By"; Rec."Action By")
                {
                    ToolTip = 'Specifies the value of the Action By field.';
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