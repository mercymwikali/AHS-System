Table 85207 "HMS Operational Notes"
{
    DrillDownPageID = "HMS Operation nurse Notes";
    LookupPageID = "HMS Operation nurse Notes";

    fields
    {
        field(50000; "Theatre No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Nurse ID"; Code[20])
        {
        }
        field(50002; "Notes Date"; Date)
        {
        }
        field(50003; "Notes Time"; Time)
        {
        }
        field(50004; Notes; Text[250])
        {
        }
        field(50005; notesType; Option)
        {
            OptionCaption = 'Nurse Notes,Surgeon Notes,Operation Notes,Complications,Biopsy Specimen,Anaesthesist Notes';
            OptionMembers = "Nurse Notes","Surgeon Notes","Operation Notes",Complications,"Biopsy Specimen","Anaesthesist Notes";
        }
        field(50006; "Line no"; Integer)
        {
            AutoIncrement = true;
        }
        field(50007; "Treatment No"; Code[20])
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
