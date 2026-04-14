Table 85548 "prUnused Relief"
{
    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
        }
        field(50001; "Unused Relief"; Decimal)
        {
        }
        field(50002; "Period Month"; Integer)
        {
        }
        field(50003; "Period Year"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
