Table 52202487 "HMS Doctors Payment Temp"
{
    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Ins No"; Code[20])
        {
        }
        field(3; WHT; Decimal)
        {
        }
        field(4; HDF; Decimal)
        {
        }
        field(5; "Gross Amount"; Decimal)
        {
        }
        field(6; "Net Amount"; Decimal)
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
