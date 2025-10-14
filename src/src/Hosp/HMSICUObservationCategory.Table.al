Table 52202493 "HMS ICU Observation Category"
{
    fields
    {
        field(1; "code"; Code[30])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; "Line No"; Integer)
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
