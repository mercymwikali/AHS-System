Table 85433 "HR Recruitment Stages"
{
    LookupPageID = "Budgetary Control Setup";

    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Description; Text[30])
        {
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
