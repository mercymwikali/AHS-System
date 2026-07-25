Table 85533 prPAYE
{
    fields
    {
        field(50000; "Tier Code"; Code[10])
        {
        }
        field(50001; "PAYE Tier"; Decimal)
        {
        }
        field(50002; Rate; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Tier Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
