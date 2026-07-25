Table 85519 "prExchange Rates"
{
    fields
    {
        field(50000; "Currency Code"; Code[10])
        {
        }
        field(50001; "Exchange Rate"; Decimal)
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
        key(Key1; "Currency Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
