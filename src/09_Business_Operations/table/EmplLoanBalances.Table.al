Table 85484 "Empl. Loan Balances"
{
    fields
    {
        field(50000; "Emp. Code"; Code[20])
        {
        }
        field(50001; "Trans Code"; Code[20])
        {
        }
        field(50002; "Total Balance"; Decimal)
        {
        }
        field(50003; "Deduction Amount"; Decimal)
        {
        }
        field(50004; "Reference No"; Text[100])
        {
        }
        field(50005; "trans Name"; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Emp. Code", "Trans Code", "Reference No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
