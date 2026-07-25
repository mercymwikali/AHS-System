Table 85549 "prVehicle Categories"
{
    fields
    {
        field(50000; "Category Code"; Code[10])
        {
        }
        field(50001; Description; Text[50])
        {
        }
        field(50002; "Vehicle Value"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Category Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
