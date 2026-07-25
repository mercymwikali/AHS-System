Page 85698 "HR Stage Requirement Lines"
{
    PageType = List;
    SourceTable = "HR shortList Requirements";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(StageCode; Rec."Stage Code")
                {
                    ToolTip = 'Specifies the value of the Stage Code field.';
                }
                field("ShortList Type"; Rec."ShortList Type")
                {
                    ToolTip = 'Specifies the value of the ShortList Type field.';
                }
                field("ShortList Code"; Rec."ShortList Code")
                {
                    ToolTip = 'Specifies the value of the ShortList Code field.';
                }
                field(QualificationDescription; Rec."Qualification Description")
                {
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Qualification Description field.';
                }
                field(GradeAttained; Rec."Grade Attained")
                {
                    ToolTip = 'Specifies the value of the Grade Attained field.';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.';
                }
                field(DesiredScore; Rec."Desired Score")
                {
                    ToolTip = 'Specifies the value of the Desired Score field.';
                }
                field(TotalStageDesiredScore; Rec."Total (Stage)Desired Score")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Total (Stage)Desired Score field.';
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ToolTip = 'Specifies the value of the Mandatory field.';
                }
            }
        }
    }

    actions
    {
    }
}
