Page 52202592 "Appraisal Part List"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal Objectives";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DocumentNo; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field(Objective; Rec.Objective)
                {
                    ToolTip = 'Specifies the value of the Objective field.';
                }
                field(KeyPerformanceIndicator; Rec."Key Performance Indicator")
                {
                    ToolTip = 'Specifies the value of the Key Performance Indicator field.';
                }
                field(Targets; Rec.Targets)
                {
                    ToolTip = 'Specifies the value of the Targets field.';
                }
                field(MaxWeight; Rec."Max Weight")
                {
                    ToolTip = 'Specifies the value of the Max Weight field.';
                }
                field(Achievements; Rec.Achievements)
                {
                    ToolTip = 'Specifies the value of the Achievements field.';
                }
                field(Ratings; Rec.Ratings)
                {
                    ToolTip = 'Specifies the value of the Ratings field.';
                }
                field(NotesByAppraisee; Rec."Notes By Appraisee")
                {
                    ToolTip = 'Specifies the value of the Notes By Appraisee field.';
                }
                field(NotesByAppraiser; Rec."Notes By Appraiser")
                {
                    ToolTip = 'Specifies the value of the Notes By Appraiser field.';
                }
                field(NotesByHOD; Rec."Notes By HOD")
                {
                    ToolTip = 'Specifies the value of the Notes By HOD field.';
                }
                field(ApprovalCommentLine; Rec."Approval Comment Line")
                {
                    ToolTip = 'Specifies the value of the Approval Comment Line field.';
                }
                field(SupervisorRating; Rec."Supervisor Rating")
                {
                    ToolTip = 'Specifies the value of the Supervisor Rating field.';
                }
                field(HODRating; Rec."HOD Rating")
                {
                    ToolTip = 'Specifies the value of the HOD Rating field.';
                }
            }
        }
    }

    actions
    {
    }
}
