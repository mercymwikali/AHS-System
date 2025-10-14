Table 52202571 "Empl. Loan Balances"
{
    fields
    {
        field(1; "Emp. Code"; Code[20])
        {
        }
        field(2; "Trans Code"; Code[20])
        {
        }
        field(3; "Total Balance"; Decimal)
        {
        }
        field(4; "Deduction Amount"; Decimal)
        {
        }
        field(12; "Reference No"; Text[100])
        {
        }
        field(13; "trans Name"; Text[150])
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
