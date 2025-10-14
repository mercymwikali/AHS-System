Table 52202511 "HMS Setup Flags"
{
    // DrillDownPageID = "HMS Observation Form Dressing";
    //LookupPageID = "HMS Observation Form Dressing";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
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
