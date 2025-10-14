namespace PTL.HMIS;

page 52203187 "Nursing Care Plan"
{
    ApplicationArea = All;
    Caption = 'Nursing Care Plan';
    PageType = List;
    CardPageId = "Nursing Care Plan Card";
    SourceTable = "Nursing Care Plan";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Patient No."; Rec."Patient No.")
                {
                    ToolTip = 'Spoecifies the value of the Patient No. field.', Comment = '%';
                }
                field("Admission No."; Rec."Admission No.")
                {
                    ToolTip = 'Specifies the value of the Admission No. field.', Comment = '%';
                    Editable = false;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ToolTip = 'Specifies the value of the Patient Name field.', Comment = '%';
                }
                field(Date; Rec."Date Taken")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field(Time; Rec."Time Taken")
                {
                    ToolTip = 'Specifies the value of the Time field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Physical Assessmet(MSA)"; Rec."Physical Assessmet(MSA)")
                {
                    ToolTip = 'Specifies the value of the Physical Assesmet(MSA) field.', Comment = '%';
                    Visible = false;
                }
                field("Nursing Diagnosis"; Rec."Nursing Diagnosis")
                {
                    ToolTip = 'Specifies the value of the Nursing Diagnosis field.', Comment = '%';
                    Visible = false;
                }
                field(Plan; Rec.Plan)
                {
                    ToolTip = 'Specifies the value of the Plan field.', Comment = '%';
                }
                field(Implementation; Rec.Implementation)
                {
                    ToolTip = 'Specifies the value of the Implementation field.', Comment = '%';
                    Visible = false;
                }
                field(Rationale; Rec.Rationale)
                {
                    ToolTip = 'Specifies the value of the Rationale field.', Comment = '%';
                    Visible = false;
                }
                field(Evaluation; Rec.Evaluation)
                {
                    ToolTip = 'Specifies the value of the Evaluation field.', Comment = '%';
                    Visible = false;
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                    Visible = false;
                }
                field(StaffName; Rec.StaffName)
                {
                    ToolTip = 'Specifies the value of the StaffName field.';
                }
            }
        }
    }
}
