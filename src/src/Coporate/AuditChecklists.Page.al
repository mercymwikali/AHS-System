Page 52202630 "Audit Checklists"
{
    PageType = List;
    SourceTable = "Audit Checklists";
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
                field(AuditCode; Rec."Audit Code")
                {
                    ToolTip = 'Specifies the value of the Audit Code field.';
                }
                field(CheckpointDesc1; Rec."Checkpoint Desc 1")
                {
                    ToolTip = 'Specifies the value of the Checkpoint Desc 1 field.';
                }
                field(CheckpointDesc2; Rec."Checkpoint Desc 2")
                {
                    ToolTip = 'Specifies the value of the Checkpoint Desc 2 field.';
                }
                field(ClauseofCriteriaDocument; Rec."Clause of Criteria Document")
                {
                    ToolTip = 'Specifies the value of the Clause of Criteria Document field.';
                }
                field(CheckpointDesc3; Rec."Checkpoint Desc 3")
                {
                    ToolTip = 'Specifies the value of the Checkpoint Desc 3 field.';
                }
                field(CheckpointDesc4; Rec."Checkpoint Desc 4")
                {
                    ToolTip = 'Specifies the value of the Checkpoint Desc 4 field.';
                }
                field(DateCreated; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field(CreatedBy; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field(FindingDesc1; Rec."Finding Desc 1")
                {
                    ToolTip = 'Specifies the value of the Finding Desc 1 field.';
                }
                field(FindingDesc2; Rec."Finding Desc 2")
                {
                    ToolTip = 'Specifies the value of the Finding Desc 2 field.';
                }
                field(FindingDesc3; Rec."Finding Desc 3")
                {
                    ToolTip = 'Specifies the value of the Finding Desc 3 field.';
                }
                field(FindingCitation1; Rec."Finding Citation 1")
                {
                    ToolTip = 'Specifies the value of the Finding Citation 1 field.';
                }
                field(FindingCitation2; Rec."Finding Citation 2")
                {
                    ToolTip = 'Specifies the value of the Finding Citation 2 field.';
                }
                field(FindingDesc4; Rec."Finding Desc 4")
                {
                    ToolTip = 'Specifies the value of the Finding Desc 4 field.';
                }
                field(FindingStatus; Rec."Finding Status")
                {
                    ToolTip = 'Specifies the value of the Finding Status field.';
                }
                field(RejectedCount; Rec."Rejected Count")
                {
                    ToolTip = 'Specifies the value of the Rejected Count field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(Classification; Rec.Classification)
                {
                    ToolTip = 'Specifies the value of the Classification field.';
                }
                field(ApprovalComments; Rec."Approval Comments")
                {
                    ToolTip = 'Specifies the value of the Approval Comments field.';
                }
                field(AuditProgramme; Rec."Audit Programme")
                {
                    ToolTip = 'Specifies the value of the Audit Programme field.';
                }
                field(AuditNo; Rec."Audit No")
                {
                    ToolTip = 'Specifies the value of the Audit No field.';
                }
            }
        }
    }

    actions
    {
    }
}
