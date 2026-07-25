Table 85403 "HR Company Pay Periods"
{
    fields
    {
        field(50000; Weekly; Integer)
        {
        }
        field(50001; "2 Weekly"; Integer)
        {
        }
        field(50002; "4 Weekly"; Integer)
        {
        }
        field(50003; "Working Days Per Year"; Integer)
        {
        }
        field(50004; "Working Hours Per Week"; Integer)
        {
        }
        field(50005; "Working Hours Per Day"; Integer)
        {
        }
        field(50006; "VAT%"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Weekly)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
