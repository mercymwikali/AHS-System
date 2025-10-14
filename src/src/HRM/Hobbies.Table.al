Table 52202787 Hobbies
{
    fields
    {
        field(1; No; Code[20])
        {
            TableRelation = Applicants."Application No";
        }
        field(2; Hobbies; Text[200])
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
