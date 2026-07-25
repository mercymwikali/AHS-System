Table 85187 "HMS Doctors Payment Batch"
{
    fields
    {
        field(50000; No; Code[20])
        {
        }
        field(50001; Date; Date)
        {
        }
        field(50002; Time; Time)
        {
        }
        field(50003; "Posted By"; Code[50])
        {
        }
        field(50004; "Payment Vourcher No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
