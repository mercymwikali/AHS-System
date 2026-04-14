Table 85041 "Security Setups"
{
    fields
    {
        field(50000; "Primary Key"; Code[10])
        {
        }
        field(50001; "Visitors Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50002; "Students Sec. Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50003; "Employee Sec Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50004; "Legal Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50005; "Corporate No."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
