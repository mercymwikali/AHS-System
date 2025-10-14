table 52202543 "Doctors Tax Entry"
{
    fields
    {
        field(1; "Doctor ID"; Code[20])
        {
        }
        field(2; "Batch No"; Code[20])
        {
        }
        field(3; "Insurance No"; Code[20])
        {
        }
        field(4; "Tax Type"; Option)
        {
            OptionCaption = '" ,WHT,HDF"';
            OptionMembers = " ",WHT,HDF;
        }
        field(5; Amount; Decimal)
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
