Table 85502 "Monthly Reconcilliation"
{
    fields
    {
        field(50000; Employee; Code[20])
        {
        }
        field(50001; TransCode; Code[20])
        {
        }
        field(50002; Description; Text[50])
        {
        }
        field(50003; CurrAmount; Decimal)
        {
        }
        field(50004; PrevAmount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Employee, TransCode)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
