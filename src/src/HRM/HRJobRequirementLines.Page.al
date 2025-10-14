Page 52202947 "HR Job Requirement Lines"
{
    PageType = List;
    SourceTable = "HR Stage Requirements";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(QualificationCategory; Rec."Qualification Category")
                {
                    ToolTip = 'Specifies the value of the Qualification Category field.';
                }
                field(QualificationType; Rec."Qualification Type")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Qualification Type field.';
                }
                field(QualificationCode; Rec."Qualification Code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the value of the Qualification Code field.';
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
                field(DesiredScore; Rec."Desired Score")
                {
                    ToolTip = 'Specifies the value of the Desired Score field.';
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
