Table 85248 "HMS Setup Flags"
{
    // DrillDownPageID = "HMS Observation Form Dressing";
    //LookupPageID = "HMS Observation Form Dressing";

    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[30])
        {
            NotBlank = true;
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
