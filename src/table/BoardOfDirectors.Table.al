Table 85372 "Board Of Directors"
{
    //  LookupPageID = UnknownPage39005785;

    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; SurName; Text[100])
        {
        }
        field(50002; "Other Names"; Text[150])
        {
        }
        field(50003; Remarks; Text[200])
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
