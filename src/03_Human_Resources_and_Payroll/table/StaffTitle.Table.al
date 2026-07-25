Table 85469 "Staff Title"
{
    LookupPageID = "Staff Tiltles";

    fields
    {
        field(50000; "Code"; Code[50])
        {
        }
        field(50001; Description; Text[100])
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
