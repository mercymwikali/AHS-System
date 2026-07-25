Table 85416 "HR Hiring Criteria"
{
    fields
    {
        field(50000; "Application Code"; Code[50])
        {
        }
        field(50001; "Hiring Criteria"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Application Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
