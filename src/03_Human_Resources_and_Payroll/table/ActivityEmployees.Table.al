Table 85357 "Activity Employees"
{
    fields
    {
        field(50000; "Activity Code"; Code[20])
        {
            TableRelation = "Company Activities".Code;
        }
        field(50001; "Employee No"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";
        }
        field(50002; "Full Names"; Text[100])
        {
        }
        field(50003; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Activity Code", "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
