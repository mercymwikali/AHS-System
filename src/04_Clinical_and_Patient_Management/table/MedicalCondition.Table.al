Table 85325 "Medical Condition"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            Description = 'Stores the code of the medical condition in the database';
        }
        field(50001; Description; Text[30])
        {
            Description = 'Stores the name of the medical condition in the database';
        }
        field(50002; Mandatory; Boolean)
        {
            Description = 'Stores the state of the medical condition';
        }
        field(50003; Family; Boolean)
        {
            Description = 'Stores the state of the medical condition whether it is also based on family in the database';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
