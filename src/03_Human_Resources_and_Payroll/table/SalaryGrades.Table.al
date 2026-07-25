Table 85553 "Salary Grades"
{
    DrillDownPageID = "Salary Grades List";
    LookupPageID = "Salary Grades List";

    fields
    {
        field(50000; "Salary Grade"; Code[20])
        {
        }
        field(50001; "Salary Amount"; Decimal)
        {
        }
        field(50002; Description; Text[100])
        {
        }
        field(50003; "House Allowance"; Decimal)
        {
        }
        field(50004; "Leave Allowance"; Decimal)
        {
        }
        field(50005; Ceiling_salary; Decimal)
        {
        }
        field(50006; Basic_salary; Decimal)
        {
        }
        field(50007; "Travel Allowance"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Salary Grade")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
