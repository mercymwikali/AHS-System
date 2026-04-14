Table 85579 "Value Posting"
{
    fields
    {
        field(50000; UserID; Code[20])
        {
            TableRelation = User."User Name";
        }
        field(50001; "Value Posting"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
