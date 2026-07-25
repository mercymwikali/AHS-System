Page 85306 "HMS Admission Nurse Notes"
{
    PageType = ListPart;
    SourceTable = "HMS Admission Form Nurse";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102760000)
            {
                field(NurseID; Rec."Nurse ID")
                {
                    Editable = true;
                    ToolTip = 'Specifies the value of the Nurse ID field.';
                }
                field(NotesDate; Rec."Notes Date")
                {
                    ToolTip = 'Specifies the value of the Notes Date field.';
                }
                field(NotesTime; Rec."Notes Time")
                {
                    ToolTip = 'Specifies the value of the Notes Time field.';
                }
                field(Notes; Rec.Notes)
                {
                    ToolTip = 'Specifies the value of the Notes field.';
                }
            }
        }
    }

    actions
    {
    }
}
