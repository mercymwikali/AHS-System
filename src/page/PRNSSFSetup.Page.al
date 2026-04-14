page 85763 "PR NSSF Setup"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "PR NSSF";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Tier; Rec.Tier)
                {
                    ToolTip = 'Specifies the value of the Tier field.';
                }
                field(Earnings; Rec.Earnings)
                {
                    ToolTip = 'Specifies the value of the Earnings field.';
                }
                field("Pensionable Earnings"; Rec."Pensionable Earnings")
                {
                    ToolTip = 'Specifies the value of the Pensionable Earnings field.';
                }
                field("Tier 1 earnings"; Rec."Tier 1 earnings")
                {
                    ToolTip = 'Specifies the value of the Tier 1 earnings field.';
                }
                field("Tier 1 Employee Deduction"; Rec."Tier 1 Employee Deduction")
                {
                    ToolTip = 'Specifies the value of the Tier 1 Employee Deduction field.';
                }
                field("Tier 1 Employer Contribution"; Rec."Tier 1 Employer Contribution")
                {
                    ToolTip = 'Specifies the value of the Tier 1 Employer Contribution field.';
                }
                field("Tier 2 earnings"; Rec."Tier 2 earnings")
                {
                    ToolTip = 'Specifies the value of the Tier 2 earnings field.';
                }
                field("Tier 2 Employee Deduction"; Rec."Tier 2 Employee Deduction")
                {
                    ToolTip = 'Specifies the value of the Tier 2 Employee Deduction field.';
                }
                field("Tier 2 Employer Contribution"; Rec."Tier 2 Employer Contribution")
                {
                    ToolTip = 'Specifies the value of the Tier 2 Employer Contribution field.';
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ToolTip = 'Specifies the value of the Lower Limit field.';
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ToolTip = 'Specifies the value of the Upper Limit field.';
                }
            }
        }
    }
}
