Table 85296 Immunization
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            Description = 'Stores the code of immunization in the database';
        }
        field(50001; Description; Text[30])
        {
            Description = 'Stores the description of the medical condition in the database';
        }
        field(50002; Mandatory; Boolean)
        {
            Description = 'Stores the state of the immunization in the database';
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
