Table 85501 "Lecturers Category"
{
    DrillDownPageId = "Lecturer Category";
    LookupPageId = "Lecturer Category";
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Description; Text[100])
        {
        }
        field(50002; "Max. Fulltime Units"; Integer)
        {
        }
        field(50003; "Max. Parttime Units"; Integer)
        {
        }
        field(50004; "Max. Units"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
