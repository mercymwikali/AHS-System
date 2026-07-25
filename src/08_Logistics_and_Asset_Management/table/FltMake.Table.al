Table 85009 "Flt Make"
{
    DrillDownPageID = "Flt Make List";
    LookupPageID = "Flt Make List";

    fields
    {
        field(50000; "Code"; Code[10])
        {
        }
        field(50001; Description; Text[30])
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
