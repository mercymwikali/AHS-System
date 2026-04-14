Table 85069 "A-Vehicle Types"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Description; Text[50])
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
