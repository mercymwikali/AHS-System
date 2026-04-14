Table 85546 prTimeSheets
{
    fields
    {
        field(50000; "Schedule Code"; Text[30])
        {
        }
        field(50001; "Primary File Path"; Text[150])
        {
        }
        field(50002; "Secondary File Path"; Text[150])
        {
        }
        field(50003; "Delete After Import"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Schedule Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
