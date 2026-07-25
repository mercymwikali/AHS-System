Table 85386 Hobbies
{
    fields
    {
        field(50000; No; Code[20])
        {
            TableRelation = Applicants."Application No";
        }
        field(50001; Hobbies; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; No, Hobbies)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
