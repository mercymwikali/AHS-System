Table 85067 "A-Vehicle Make"
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
