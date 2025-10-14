Page 52203109 "Emp Disciplinary Cases"
{
    PageType = ListPart;
    SourceTable = "Employee Disciplinary Cases";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(RefferenceNo; Rec."Refference No")
                {
                    ToolTip = 'Specifies the value of the Refference No field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(DisciplinaryCase; Rec."Disciplinary Case")
                {
                    ToolTip = 'Specifies the value of the Disciplinary Case field.';
                }
                field(CasesDiscusion; Rec."Cases Discusion")
                {
                    ToolTip = 'Specifies the value of the Cases Discusion field.';
                }
                field(RecommendedAction; Rec."Recommended Action")
                {
                    ToolTip = 'Specifies the value of the Recommended Action field.';
                }
                field(CaseDescription; Rec."Case Description")
                {
                    ToolTip = 'Specifies the value of the Case Description field.';
                }
                field(AccusedDefence; Rec."Accused Defence")
                {
                    ToolTip = 'Specifies the value of the Accused Defence field.';
                }
                field(Witness1; Rec."Witness #1")
                {
                    ToolTip = 'Specifies the value of the Witness #1 field.';
                }
                field(Witness2; Rec."Witness #2")
                {
                    ToolTip = 'Specifies the value of the Witness #2 field.';
                }
                field(ActionTaken; Rec."Action Taken")
                {
                    ToolTip = 'Specifies the value of the Action Taken field.';
                }
                field(DateTaken; Rec."Date Taken")
                {
                    ToolTip = 'Specifies the value of the Date Taken field.';
                }
                field(DocumentLink; Rec."Document Link")
                {
                    ToolTip = 'Specifies the value of the Document Link field.';
                }
                field(DisciplinaryRemarks; Rec."Disciplinary Remarks")
                {
                    ToolTip = 'Specifies the value of the Disciplinary Remarks field.';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field.';
                }
            }
        }
    }

    actions
    {
    }
}
