Table 85522 "prInstitutional Membership"
{
    fields
    {
        field(50000; "Group No"; Code[20])
        {
            TableRelation = "prMembership Groups"."Group No";
        }
        field(50001; "Institution No"; Code[20])
        {
        }
        field(50002; Description; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Group No", "Institution No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
