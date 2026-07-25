Table 85524 "prJournal Analyzers"
{
    fields
    {
        field(50000; "Analysis Code"; Code[20])
        {
        }
        field(50001; Description; Text[30])
        {
        }
        field(50002; "Is Used"; Boolean)
        {
        }
        field(50003; Mandatory; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Analysis Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
