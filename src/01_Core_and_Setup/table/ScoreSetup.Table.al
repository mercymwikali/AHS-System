Table 85467 "Score Setup"
{
    fields
    {
        field(50000; "Score ID"; Decimal)
        {
        }
        field(50001; Score; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Score ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
