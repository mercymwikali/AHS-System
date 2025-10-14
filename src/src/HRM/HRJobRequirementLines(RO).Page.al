Page 52202445 "HR Job Requirement Lines(RO)"
{
    Caption = 'HR Job Requirements';
    PageType = List;
    SourceTable = "HR Job Requirements";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(QualificationType; Rec."Qualification Type")
                {
                    ToolTip = 'Specifies the value of the Qualification Type field.';
                }
                field(QualificationCode; Rec."Qualification Code")
                {
                    ToolTip = 'Specifies the value of the Qualification Code field.';
                }
                field(QualificationDescription; Rec."Qualification Description")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Qualification Description field.';
                }
                field(NeedCode; Rec."Need Code")
                {
                    ToolTip = 'Specifies the value of the Need code field.';
                }
                field(GradeAttained; Rec."Grade Attained")
                {
                    ToolTip = 'Specifies the value of the Grade Attained field.';
                }
                field(Control1102755017; Rec."Qualification Description")
                {
                    ToolTip = 'Specifies the value of the Qualification Description field.';
                }
            }
        }
    }

    actions
    {
    }
}
