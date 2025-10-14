Page 52202637 "Audit Findings Actions"
{
    PageType = List;
    SourceTable = "Audit Findings Actions";
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
                field(FindingCode; Rec."Finding Code")
                {
                    ToolTip = 'Specifies the value of the Finding Code field.';
                }
                field(ActionClassification; Rec."Action Classification")
                {
                    ToolTip = 'Specifies the value of the Action Classification field.';
                }
                field(ReviewArea; Rec."Review Area")
                {
                    ToolTip = 'Specifies the value of the Review Area field.';
                }
                field(RequirementDesc1; Rec."Requirement Desc 1")
                {
                    ToolTip = 'Specifies the value of the Requirement Desc 1 field.';
                }
                field(RequirementDesc2; Rec."Requirement Desc 2")
                {
                    ToolTip = 'Specifies the value of the Requirement Desc 2 field.';
                }
                field(EvidenceDesc1; Rec."Evidence Desc 1")
                {
                    ToolTip = 'Specifies the value of the Evidence Desc 1 field.';
                }
                field(EvidenceDesc2; Rec."Evidence Desc 2")
                {
                    ToolTip = 'Specifies the value of the Evidence Desc 2 field.';
                }
                field(EvidenceDesc3; Rec."Evidence Desc 3")
                {
                    ToolTip = 'Specifies the value of the Evidence Desc 3 field.';
                }
                field(RootCause; Rec."Root Cause")
                {
                    ToolTip = 'Specifies the value of the Root Cause field.';
                }
                field(CorrectionDesc1; Rec."Correction Desc 1")
                {
                    ToolTip = 'Specifies the value of the Correction Desc 1 field.';
                }
                field(CorrectionDesc2; Rec."Correction Desc 2")
                {
                    ToolTip = 'Specifies the value of the Correction Desc 2 field.';
                }
                field(CorrectionDesc3; Rec."Correction Desc 3")
                {
                    ToolTip = 'Specifies the value of the Correction Desc 3 field.';
                }
                field(CorrectionDesc4; Rec."Correction Desc 4")
                {
                    ToolTip = 'Specifies the value of the Correction Desc 4 field.';
                }
                field(Recurrenceaction1; Rec."Recurrence action 1")
                {
                    ToolTip = 'Specifies the value of the Recurrence action 1 field.';
                }
                field(Recurrenceaction2; Rec."Recurrence action 2")
                {
                    ToolTip = 'Specifies the value of the Recurrence action 2 field.';
                }
                field(CompletionDate; Rec."Completion Date")
                {
                    ToolTip = 'Specifies the value of the Completion Date field.';
                }
                field(ActionAppropriate; Rec."Action Appropriate?")
                {
                    ToolTip = 'Specifies the value of the Action Appropriate? field.';
                }
                field(FollowUpAction; Rec."Follow Up Action")
                {
                    ToolTip = 'Specifies the value of the Follow Up Action field.';
                }
                field(FollowUpStatus; Rec."Follow Up Status")
                {
                    ToolTip = 'Specifies the value of the Follow Up Status field.';
                }
                field(ActionEffective; Rec."Action Effective?")
                {
                    ToolTip = 'Specifies the value of the Action Effective? field.';
                }
                field(EffectivenessDesc; Rec."Effectiveness Desc")
                {
                    ToolTip = 'Specifies the value of the Effectiveness Desc field.';
                }
                field(EffectivenessStatus; Rec."Effectiveness Status")
                {
                    ToolTip = 'Specifies the value of the Effectiveness Status field.';
                }
                field(FindingClassification; Rec."Finding Classification")
                {
                    ToolTip = 'Specifies the value of the Finding Classification field.';
                }
            }
        }
    }

    actions
    {
    }
}
