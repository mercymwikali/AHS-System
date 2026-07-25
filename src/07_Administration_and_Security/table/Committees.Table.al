Table 85374 Committees
{
    // LookupPageID = UnknownPage39005784;

    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[200])
        {
            NotBlank = true;
        }
        field(50002; Comments; Text[200])
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
