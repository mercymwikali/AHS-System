Table 85508 "prCurrency Denominations"
{
    fields
    {
        field(50000; "Currency Code"; Code[10])
        {
        }
        field(50001; "Denomination Value"; Decimal)
        {
        }
        field(50002; "Denomination Name"; Text[30])
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
