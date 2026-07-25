Table 85544 "prStatutory Exemptions"
{
    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
        }
        field(50001; NSSF; Boolean)
        {
            Description = 'Is staff exempted from NSSF?';
        }
        field(50002; NHIF; Boolean)
        {
            Description = 'Is staff exempted from NHIF?';
        }
        field(50003; PAYE; Boolean)
        {
            Description = 'Is staff exempted from PAYE?';
        }
        field(50004; Recurring; Boolean)
        {
            Description = 'Is exemption carried to next period?';
        }
        field(50005; "Period Month"; Integer)
        {
        }
        field(50006; "Period Year"; Integer)
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
