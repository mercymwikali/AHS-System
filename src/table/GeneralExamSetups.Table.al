Table 85168 "General Exam Setups"
{
    fields
    {
        field(50000; "Code"; Code[30])
        {
        }
        field(50001; Description; Text[100])
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
