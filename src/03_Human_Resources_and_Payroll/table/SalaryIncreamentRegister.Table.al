Table 85465 "Salary Increament Register"
{
    fields
    {
        field(50000; "Employee No."; Code[20])
        {
        }
        field(50001; "Increament Month"; Code[20])
        {
        }
        field(50002; "Increament Year"; Integer)
        {
        }
        field(50003; "User ID"; Code[20])
        {
        }
        field(50004; "Prev. Salary"; Decimal)
        {
        }
        field(50005; "Current Salary"; Decimal)
        {
        }
        field(50006; "Job Grade"; Code[20])
        {
        }
        field(50007; "Job Category"; Code[50])
        {
        }
        field(50008; Posted; Boolean)
        {
        }
        field(50009; Reversed; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
