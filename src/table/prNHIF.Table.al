Table 85532 prNHIF
{
    fields
    {
        field(50000; "Tier Code"; Code[10])
        {
            SQLDataType = Integer;
        }
        field(50001; "NHIF Tier"; Decimal)
        {
        }
        field(50002; Amount; Decimal)
        {
        }
        field(50003; "Lower Limit"; Decimal)
        {
        }
        field(50004; "Upper Limit"; Decimal)
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
