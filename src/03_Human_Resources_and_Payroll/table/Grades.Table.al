Table 85489 Grades
{
    fields
    {
        field(50000; Grade; Code[50])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[250])
        {
        }
        field(50002; "Annual Leave Days"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; Grade)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
