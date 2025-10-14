Page 52202559 "Casual Tiers"
{
    PageType = List;
    SourceTable = "Casual Tiers";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(OccupationCode; Rec."Occupation Code")
                {
                    ToolTip = 'Specifies the value of the Occupation Code field.';
                }
                field(OccupationDescription; Rec."Occupation Description")
                {
                    ToolTip = 'Specifies the value of the Occupation Description field.';
                }
                field(RatePerMonth; Rec."Rate Per Month")
                {
                    ToolTip = 'Specifies the value of the Rate Per Month field.';
                }
                field(RateperDay; Rec."Rate per Day")
                {
                    ToolTip = 'Specifies the value of the Rate per Day field.';
                }
            }
        }
    }

    actions
    {
    }
}
