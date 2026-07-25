Table 85421 "HR Language Preference"
{
    // DrillDownPageID = UnknownPage39005608;
    // LookupPageID = UnknownPage39005608;

    fields
    {
        field(50000; "Code"; Code[10])
        {
        }
        field(50001; "Language Preference"; Text[30])
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
