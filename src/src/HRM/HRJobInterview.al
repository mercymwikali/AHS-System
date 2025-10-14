page 52202447 "HR Job Interview"
{
    PageType = List;
    SourceTable = "HR Job Interview";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Interview Code"; Rec."Interview Code")
                {
                    ToolTip = 'Specifies the value of the Interview Code field.';
                }
                field("Interview Description"; Rec."Interview Description")
                {
                    ToolTip = 'Specifies the value of the Interview Description field.';
                }
                field(Score; Rec.Score)
                {
                    ToolTip = 'Specifies the value of the Score field.';
                }
                field("Total Score"; Rec."Total Score")
                {
                    ToolTip = 'Specifies the value of the Total Score field.';
                }
                field(comments; Rec.comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field(Interviewer; Rec.Interviewer)
                {
                    ToolTip = 'Specifies the value of the Interviewer field.';
                }
                field("Interviewer Name"; Rec."Interviewer Name")
                {
                    ToolTip = 'Specifies the value of the Interviewer Name field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicants)
            {
                Caption = 'Applicants';
                action("Hiring Criteria")
                {
                    Caption = 'Hiring Criteria';
                    Image = Agreement;
                    Promoted = true;
                    RunObject = Page "HR Hiring Criteria";
                    RunPageLink = "Application Code" = FIELD("Interview Code");
                    ToolTip = 'Executes the Hiring Criteria action.';
                }
            }
        }
    }
}
