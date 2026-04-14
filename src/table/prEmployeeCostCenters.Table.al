Table 85510 "prEmployee Cost Centers"
{
    fields
    {
        field(50000; "Employee Code"; Code[10])
        {
        }
        field(50001; "Center Code"; Code[20])
        {
        }
        field(50002; Percentage; Decimal)
        {
        }
        field(50003; Analysis0; Text[20])
        {
        }
        field(50004; Analysis1; Text[20])
        {
        }
        field(50005; Analysis2; Text[20])
        {
        }
        field(50006; Analysis3; Text[20])
        {
        }
        field(50007; Analysis4; Text[20])
        {
        }
        field(50008; Analysis5; Text[20])
        {
        }
    }

    keys
    {
        key(Key1; "Employee Code", "Center Code", Analysis0, Analysis1, Analysis3, Analysis4, Analysis5)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
