Table 85381 "Disciplinary Cases"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[200])
        {
        }
        field(50002; Rating; Code[50])
        {
            TableRelation = "Disciplinary Case Ratings".Code;
        }
        field(50003; Comments; Text[200])
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
