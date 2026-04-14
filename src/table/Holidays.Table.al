Table 85387 Holidays
{
    LookupPageID = Holidays;

    fields
    {
        field(50000; Date; Date)
        {
            NotBlank = true;
        }
        field(50001; Description; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
