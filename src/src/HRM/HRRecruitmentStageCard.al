page 52202467 "HR Recruitment  Stage Card"
{
    PageType = Card;
    SourceTable = "HR Recruitment Stages";
    ApplicationArea = basic;

    layout
    {
        area(content)
        {
            group(General)
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
        area(navigation)
        {
            group(Job)
            {
                action(Requirements)
                {
                    Caption = 'Requirements';
                    Image = Card;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "HR Stage Requirement Lines";
                    RunPageLink = "Stage Code" = FIELD(Code);
                    ToolTip = 'Executes the Requirements action.';
                }
            }
        }
    }
}
