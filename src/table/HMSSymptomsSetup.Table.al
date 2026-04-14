Table 85254 "HMS Symptoms Setup"
{
    // LookupPageID = "ELECT Election Result Line";

    fields
    {
        field(50000; "Syptom Code"; Code[20])
        {
        }
        field(50001; "Symptom Name"; Text[100])
        {
        }
        field(50002; "Treatment no"; Code[20])
        {
            TableRelation = "HMS Treatment Form Header"."Treatment No.";
        }
    }

    keys
    {
        key(Key1; "Syptom Code", "Treatment no")
        {
            Clustered = true;
        }
        key(Key2; "Symptom Name")
        {
        }
    }

    fieldgroups
    {
    }
}
