Table 85091 "Financial Periods"
{
    fields
    {
        field(50000; "Period Code"; Code[20])
        {
        }
        field(50001; "Period Name"; Text[30])
        {
        }
        field(50002; "Current Period"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Period Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
