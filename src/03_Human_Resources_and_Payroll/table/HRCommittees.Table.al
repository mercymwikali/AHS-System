Table 85402 "HR Committees"
{
    //LookupPageID = UnknownPage70135016;

    fields
    {
        field(50000; "Code"; Code[70])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[200])
        {
            NotBlank = true;
        }
        field(50002; Roles; Text[200])
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
