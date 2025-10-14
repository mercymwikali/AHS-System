Table 52202598 "prCurrency Denominations"
{
    fields
    {
        field(1; "Currency Code"; Code[10])
        {
        }
        field(2; "Denomination Value"; Decimal)
        {
        }
        field(3; "Denomination Name"; Text[30])
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
