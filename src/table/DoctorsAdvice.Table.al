Table 85162 "Doctors Advice"
{
    // LookupPageID = UnknownPage39006158;

    fields
    {
        field(50000; Advice; Text[250])
        {
        }
        field(50001; "Short Name"; Text[200])
        {
        }
        field(50002; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; Advice)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
