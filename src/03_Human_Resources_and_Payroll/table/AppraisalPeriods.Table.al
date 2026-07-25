Table 85368 "Appraisal Periods"
{
    // DrillDownPageID = UnknownPage39005787;
    // LookupPageID = UnknownPage39005787;

    fields
    {
        field(50000; Period; Code[30])
        {
        }
        field(50001; Comments; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Period)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
