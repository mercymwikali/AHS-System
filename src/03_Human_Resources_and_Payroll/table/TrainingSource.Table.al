Table 85470 "Training Source"
{
    // LookupPageID = UnknownPage39005843;

    fields
    {
        field(50000; Source; Code[50])
        {
            NotBlank = true;
        }
        field(50001; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Source)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
