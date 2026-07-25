Table 85462 "Recruitment Stages"
{
    fields
    {
        field(50000; "Recruitement Stage"; Code[50])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[200])
        {
        }
        field(50002; "Failed Response Templates"; Code[10])
        {
            TableRelation = "Interaction Template".Code;
        }
        field(50003; "Passed Response Templates"; Code[10])
        {
            TableRelation = "Interaction Template".Code;
        }
    }

    keys
    {
        key(Key1; "Recruitement Stage")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
