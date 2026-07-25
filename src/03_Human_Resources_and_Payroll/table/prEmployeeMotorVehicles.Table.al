Table 85511 "prEmployee Motor Vehicles"
{
    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
        }
        field(50001; "Vehicle Category"; Code[20])
        {
        }
        field(50002; "Vehicle Value"; Decimal)
        {
        }
        field(50003; "Is Leased"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
