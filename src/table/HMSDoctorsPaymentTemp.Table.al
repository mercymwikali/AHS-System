Table 85188 "HMS Doctors Payment Temp"
{
    fields
    {
        field(50000; No; Code[20])
        {
        }
        field(50001; "Ins No"; Code[20])
        {
        }
        field(50002; WHT; Decimal)
        {
        }
        field(50003; HDF; Decimal)
        {
        }
        field(50004; "Gross Amount"; Decimal)
        {
        }
        field(50005; "Net Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; No, "Ins No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
