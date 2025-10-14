Page 52202908 "HMS Treatment SubForm"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "HMS Treatment Form Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                Editable = false;
                field(TreatmentNo; Rec."Treatment No.")
                {
                    ToolTip = 'Specifies the value of the Treatment No. field.';
                }
                field(TreatmentDate; Rec."Treatment Date")
                {
                    ToolTip = 'Specifies the value of the Treatment Date field.';
                }
                field(TreatmentTime; Rec."Treatment Time")
                {
                    ToolTip = 'Specifies the value of the Treatment Time field.';
                }
                field(DoctorID; Rec."Doctor ID")
                {
                    ToolTip = 'Specifies the value of the Doctor ID field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
    }
}
