Table 85528 "PrLoan Balances"
{
    fields
    {
        field(50000; "Emp. No"; Code[20])
        {
        }
        field(50001; "Trans Code"; Code[20])
        {
        }
        field(50002; "Trans Name"; Text[100])
        {
        }
        field(50003; "Period Month"; Integer)
        {
        }
        field(50004; "Period Year"; Integer)
        {
        }
        field(50005; Balance; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Emp. No", "Trans Code", "Period Year", "Period Month", Balance)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
