Table 85249 "HMS Setup Immunization"
{
    // LookupPageID = UnknownPage52506;

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
        field(50002; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50003; Amount; Decimal)
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
