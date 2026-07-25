Table 85275 "HMS Triage Test Setup"
{
    fields
    {
        field(50000; "Test Code"; Code[30])
        {
        }
        field(50001; "Test Description"; Text[250])
        {
        }
        field(50002; Compulsory; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Test Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
