Table 85503 "Non-Pensionable Items"
{
    fields
    {
        field(50000; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[60])
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
