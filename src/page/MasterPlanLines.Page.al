page 85717 "MasterPlan Lines"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "PC MasterPlan Lines";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Five Year Target"; Rec."Five Year Target")
                {
                    ToolTip = 'Specifies the value of the Five Year Target field.';
                }
                field(Achievements; Rec.Achievements)
                {
                    ToolTip = 'Specifies the value of the Achievements field.';
                }
                field(Shortfalls; Rec.Shortfalls)
                {
                    ToolTip = 'Specifies the value of the Shortfalls field.';
                }
                field(Variance; Rec.Variance)
                {
                    ToolTip = 'Specifies the value of the Variance field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Risk Mitigation Factors"; Rec."Risk Mitigation Factors")
                {
                    ToolTip = 'Specifies the value of the Risk Mitigation Factors field.';
                }
                field(Alterations; Rec.Alterations)
                {
                    ToolTip = 'Specifies the value of the Alterations field.';
                }
            }
        }
    }
}
