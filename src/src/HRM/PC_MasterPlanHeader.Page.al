page 52202609 "MasterPlan Header"
{
    ApplicationArea = All;
    PageType = Card;
    SourceTable = "PC MasterPlan Header";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
            group(Lines)
            {
                part(MasterPlanLines; "MasterPlan Lines")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "MasterPlan Code" = field(Code);
                }
            }
        }
    }
}