Table 85446 "Leave Family Employees"
{
    fields
    {
        field(50000; Family; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HR-Employee"."No.";
        }
        field(50002; Remarks; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; Family, "Employee No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
