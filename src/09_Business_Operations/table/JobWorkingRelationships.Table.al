Table 85444 "Job Working Relationships"
{
    fields
    {
        field(50000; "Job ID"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR Jobs"."Job ID";
        }
        field(50001; Type; Option)
        {
            NotBlank = false;
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(50002; Relationship; Text[200])
        {
            NotBlank = true;
        }
        field(50003; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Job ID", Type, Relationship)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
