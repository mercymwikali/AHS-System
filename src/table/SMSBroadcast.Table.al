Table 85342 "SMS Broadcast"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Date; Date)
        {
        }
        field(50002; "SMS Message"; Text[150])
        {
        }
        field(50003; "Posted By"; Code[20])
        {
        }
        field(50004; Posted; Boolean)
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
