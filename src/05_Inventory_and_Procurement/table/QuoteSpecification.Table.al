Table 85040 "Quote Specification"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Description; Text[60])
        {
        }
        field(50002; "Value/Weight"; Decimal)
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
