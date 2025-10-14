Page 52203088 "Recruitment stages"
{
    PageType = ListPart;
    SourceTable = "Recruitment Stages";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(RecruitementStage; Rec."Recruitement Stage")
                {
                    ToolTip = 'Specifies the value of the Recruitement Stage field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(FailedResponseTemplates; Rec."Failed Response Templates")
                {
                    ToolTip = 'Specifies the value of the Failed Response Templates field.';
                }
                field(PassedResponseTemplates; Rec."Passed Response Templates")
                {
                    ToolTip = 'Specifies the value of the Passed Response Templates field.';
                }
            }
        }
    }

    actions
    {
    }
}
