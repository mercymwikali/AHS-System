Table 85157 "Child Growth Monitoring"
{
    fields
    {
        field(50000; "Patient No"; Code[20])
        {
        }
        field(50001; Gender; Option)
        {
            OptionMembers = ,Male,Female;
        }
        field(50002; Height; Decimal)
        {
        }
        field(50003; Weight; Decimal)
        {
        }
        field(50004; "Date Taken"; Date)
        {
        }
        field(50005; "User ID"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Patient No", "Date Taken", Height, Weight)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
