Table 85196 "HMS ICU Observation Category"
{
    fields
    {
        field(50000; "code"; Code[30])
        {
        }
        field(50001; Description; Text[250])
        {
        }
        field(50002; "Line No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
