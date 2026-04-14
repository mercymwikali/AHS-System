page 85809 Risk
{
    ApplicationArea = All;
    CardPageId = "Risk Card";
    PageType = List;
    SourceTable = Risks;
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            Repeater(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Level; Rec.Level)
                {
                    ToolTip = 'Specifies the value of the Level field.';
                }
                field(Impact; Rec.Impact)
                {
                    ToolTip = 'Specifies the value of the Impact field.';
                }
                field("Risk Desc 1"; Rec."Risk Desc 1")
                {
                    ToolTip = 'Specifies the value of the Risk Desc 1 field.';
                }
                field("Risk Desc 2"; Rec."Risk Desc 2")
                {
                    ToolTip = 'Specifies the value of the Risk Desc 2 field.';
                }
                field("Risk Desc 3"; Rec."Risk Desc 3")
                {
                    ToolTip = 'Specifies the value of the Risk Desc 3 field.';
                }
                field("Risk Desc 4"; Rec."Risk Desc 4")
                {
                    ToolTip = 'Specifies the value of the Risk Desc 4 field.';
                }
                field("Indicator Desc 1"; Rec."Indicator Desc 1")
                {
                    ToolTip = 'Specifies the value of the Indicator Desc 1 field.';
                }
                field("Indicator Desc 2"; Rec."Indicator Desc 2")
                {
                    ToolTip = 'Specifies the value of the Indicator Desc 2 field.';
                }
                field(Likelihood; Rec.Likelihood)
                {
                    ToolTip = 'Specifies the value of the Likelihood field.';
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