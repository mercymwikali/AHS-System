Table 52202715 "HMS Doctors Payment Batch"
{
    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; Time; Time)
        {
        }
        field(4; "Posted By"; Code[50])
        {
        }
        field(5; "Payment Vourcher No"; Code[20])
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
