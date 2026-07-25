Table 85471 "Un-affected Salary Increaments"
{
    fields
    {
        field(50000; "Increament Month"; Code[20])
        {
        }
        field(50001; "Increament Year"; Integer)
        {
        }
        field(50002; "Employee No."; Code[20])
        {
        }
        field(50003; "Employee Category"; Code[20])
        {
        }
        field(50004; "Employee Grade"; Code[20])
        {
        }
        field(50005; Reason; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Increament Month")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
