Table 52202761 Holidays
{
    LookupPageID = Holidays;

    fields
    {
        field(1; Date; Date)
        {
            NotBlank = true;
        }
        field(2; Description; Text[150])
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
