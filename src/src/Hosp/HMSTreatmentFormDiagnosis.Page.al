Page 52202879 "HMS Treatment Form Diagnosis"
{
    PageType = ListPart;
    SourceTable = "HMS Treatment Form Diagnosis";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(DiagnosisType;Rec."Diagnosis Type")
                {
                    ToolTip = 'Specifies the value of the Diagnosis Type field.';
                }
                field(DiagnosisNo; Rec."Diagnosis No.")
                {
                    ToolTip = 'Specifies the value of the Diagnosis No. field.';
                }
                field(DiagnosisCode; Rec."Diagnosis Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Diagnosis Code field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Confirmed; Rec.Confirmed)
                {
                    ToolTip = 'Specifies the value of the Confirmed field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {
    }
}
