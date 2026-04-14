Table 85380 "Disciplinary Case Ratings"
{
    fields
    {
        field(50000; "Code"; Code[50])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[100])
        {
        }
        field(50002; Comments; Text[200])
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
