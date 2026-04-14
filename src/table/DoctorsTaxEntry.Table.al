table 85348 "Doctors Tax Entry"
{
    fields
    {
        field(50000; "Doctor ID"; Code[20])
        {
        }
        field(50001; "Batch No"; Code[20])
        {
        }
        field(50002; "Insurance No"; Code[20])
        {
        }
        field(50003; "Tax Type"; Option)
        {
            OptionCaption = '" ,WHT,HDF"';
            OptionMembers = " ",WHT,HDF;
        }
        field(50004; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Doctor ID", "Batch No", "Insurance No", "Tax Type")
        {
        }
    }

    fieldgroups
    {
    }
}
