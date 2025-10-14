namespace PTL.HMIS;

page 52203191 "Nursing Care Plan Card"
{
    ApplicationArea = All;
    Caption = 'Nursing Care Plan Card';
    PageType = Card;
    SourceTable = "Nursing Care Plan";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Specifies the value of the Patient No. field.', Comment = '%';
                }
                field("Admission No."; Rec."Admission No.")
                {
                    ToolTip = 'Specifies the value of the Admission No. field.', Comment = '%';
                }
                field("Date"; Rec."Date Taken")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Time"; Rec."Time Taken")
                {
                    ToolTip = 'Specifies the value of the Time field.', Comment = '%';
                }
            }
            field("Physical Assesmet(MSA)"; Rec."Physical Assessmet(MSA)")
            {
                ToolTip = 'Specifies the value of the Physical Assesmet(MSA) field.', Comment = '%';
                MultiLine = true;
            }
            field("Nursing Diagnosis"; Rec."Nursing Diagnosis")
            {
                ToolTip = 'Specifies the value of the Nursing Diagnosis field.', Comment = '%';
                Caption = 'Nursing Diagnosis';
                MultiLine = true;
            }
            field(Plan; Rec.Plan)
            {
                ToolTip = 'Specifies the value of the Plan field.', Comment = '%';
            }

            field(Implementation; Rec.Implementation)
            {
                Caption = 'Implementation';
                ToolTip = 'Specifies the value of the Implementation field.', Comment = '%';
                MultiLine = true;
            }
            field(Rationale; Rec.Rationale)
            {
                ToolTip = 'Specifies the value of the Rationale field.', Comment = '%';
                Caption = 'Rationale';

                MultiLine = true;
            }

            field(Evaluation; Rec.Evaluation)
            {
                ToolTip = 'Specifies the value of the Evaluation field.', Comment = '%';
                Caption = 'Evaluation';
                MultiLine = true;
            }
        }
    }
}
