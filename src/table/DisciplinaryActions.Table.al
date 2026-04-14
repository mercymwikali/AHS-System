Table 85379 "Disciplinary Actions"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[200])
        {
        }
        field(50002; Terminate; Boolean)
        {
        }
        field(50003; Document; Text[100])
        {
        }
        field(50004; Comments; Text[200])
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
