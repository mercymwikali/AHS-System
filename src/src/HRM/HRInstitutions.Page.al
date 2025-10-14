Page 52202472 "HR Institutions"
{
    PageType = Card;
    SourceTable = "Hr Institutions";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(InstitutionCode; Rec."Institution Code")
                {
                    ToolTip = 'Specifies the value of the Institution Code field.';
                }
                field(InstitutionName; Rec."Institution Name")
                {
                    ToolTip = 'Specifies the value of the Institution Name field.';
                }
            }
        }
    }

    actions
    {
    }
}
