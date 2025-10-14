page 52202465 "HR Recruitment Stages List"
{
    CardPageID = "HR Recruitment  Stage Card";
    Editable = false;
    PageType = List;
    SourceTable = "HR Recruitment Stages";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }

    actions
    {
    }
}
