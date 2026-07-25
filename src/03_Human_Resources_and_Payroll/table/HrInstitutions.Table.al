Table 85419 "Hr Institutions"
{
    fields
    {
        field(50000; "Institution Code"; Code[30])
        {
        }
        field(50001; "Institution Name"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Institution Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
