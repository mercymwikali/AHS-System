Table 52202570 "Security Setups"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Visitors Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(3; "Students Sec. Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(4; "Employee Sec Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50001; "Legal Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50002; "Corporate No."; Code[20])
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
