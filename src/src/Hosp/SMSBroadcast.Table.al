Table 52202492 "SMS Broadcast"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; "SMS Message"; Text[150])
        {
        }
        field(4; "Posted By"; Code[20])
        {
        }
        field(5; Posted; Boolean)
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
