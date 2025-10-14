Table 52202490 "HMS Operational Notes"
{
    DrillDownPageID = "HMS Operation nurse Notes";
    LookupPageID = "HMS Operation nurse Notes";

    fields
    {
        field(1; "Theatre No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Nurse ID"; Code[20])
        {
        }
        field(3; "Notes Date"; Date)
        {
        }
        field(4; "Notes Time"; Time)
        {
        }
        field(5; Notes; Text[250])
        {
        }
        field(6; notesType; Option)
        {
            OptionCaption = 'Nurse Notes,Surgeon Notes,Operation Notes,Complications,Biopsy Specimen,Anaesthesist Notes';
            OptionMembers = "Nurse Notes","Surgeon Notes","Operation Notes",Complications,"Biopsy Specimen","Anaesthesist Notes";
        }
        field(7; "Line no"; Integer)
        {
            AutoIncrement = true;
        }
        field(8; "Treatment No"; Code[20])
        {
            CalcFormula = lookup("HMS Theatre Form Header"."Link No." where("No." = field("Theatre No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Theatre No.", "Nurse ID", "Notes Date", "Notes Time", "Line no")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Nurse ID" := UserId;
        "Notes Date" := Today;
        "Notes Time" := "Notes Time";
    end;
}
