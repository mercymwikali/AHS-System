Table 85536 "prPayslip Messages"
{
    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
        }
        field(50001; "Period Message"; Text[200])
        {
        }
        field(50002; Recurring; Boolean)
        {
        }
        field(50003; "Period Month"; Integer)
        {
        }
        field(50004; "Period Year"; Integer)
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
