Table 52202505 "Child Growth Monitoring"
{
    fields
    {
        field(1; "Patient No"; Code[20])
        {
        }
        field(2; Gender; Option)
        {
            OptionMembers = ,Male,Female;
        }
        field(3; Height; Decimal)
        {
        }
        field(4; Weight; Decimal)
        {
        }
        field(5; "Date Taken"; Date)
        {
        }
        field(6; "User ID"; Code[30])
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
