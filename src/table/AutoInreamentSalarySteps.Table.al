Table 85371 "Auto. Inreament Salary Steps"
{
    fields
    {
        field(50000; "Employee Category"; Code[50])
        {
            NotBlank = true;
            TableRelation = "Employee Categories".Code;
        }
        field(50001; "Salary Grade"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(50002; Step; Integer)
        {
            NotBlank = true;
        }
        field(50003; "Basic Salary"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Category", "Salary Grade", Step)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
