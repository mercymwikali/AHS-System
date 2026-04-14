Table 85531 "prMembership Groups"
{
    fields
    {
        field(50000; "Group No"; Code[10])
        {
        }
        field(50001; Description; Text[100])
        {
        }
        field(50002; Comments; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Group No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
