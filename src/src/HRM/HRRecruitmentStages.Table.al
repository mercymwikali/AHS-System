Table 52202814 "HR Recruitment Stages"
{
    LookupPageID = "Budgetary Control Setup";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[30])
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
