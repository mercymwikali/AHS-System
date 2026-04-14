Table 85255 "HMS Systems"
{
    //  DrillDownPageID = UnknownPage70135144;
    //  LookupPageID = UnknownPage70135144;

    fields
    {
        field(50000; "Code"; Code[20])
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
