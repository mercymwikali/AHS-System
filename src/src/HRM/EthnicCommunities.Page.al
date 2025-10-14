Page 52203087 "Ethnic Communities"
{
    PageType = ListPart;
    SourceTable = "HR Hiring Criteria";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(ApplicationCode; Rec."Application Code")
                {
                    ToolTip = 'Specifies the value of the Application Code field.';
                }
                field(HiringCriteria; Rec."Hiring Criteria")
                {
                    ToolTip = 'Specifies the value of the Hiring Criteria field.';
                }
            }
        }
    }

    actions
    {
    }
}
