Table 85414 "HR Employee Vehicle"
{
    fields
    {
        field(50000; "Employee No"; Code[20])
        {
        }
        field(50001; "Vehicle Reg No"; Code[20])
        {
        }
        field(50002; "Vehicle Make"; Code[20])
        {
        }
        field(50003; "Vehicle Model"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Vehicle Reg No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
