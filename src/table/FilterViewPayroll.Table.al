Table 85488 "Filter View Payroll"
{
    fields
    {
        field(50000; "User ID"; Code[50])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50001; "View Payroll"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
