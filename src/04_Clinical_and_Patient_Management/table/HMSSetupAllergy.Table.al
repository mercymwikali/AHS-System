Table 85241 "HMS Setup Allergy"
{
    //  LookupPageID = UnknownPage39005976;

    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[30])
        {
            NotBlank = true;
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
