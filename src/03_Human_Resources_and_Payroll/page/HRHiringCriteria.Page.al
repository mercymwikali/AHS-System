Page 85656 "HR Hiring Criteria"
{
    PageType = List;
    SourceTable = "HR Hiring Criteria";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
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
