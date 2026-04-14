Table 85355 "Academic Qua Grades"
{
    fields
    {
        field(50000; "Qualification Level"; Code[20])
        {
            //  TableRelation = "Payment Schedule Line".No;
        }
        field(50001; "Grade Code"; Code[20])
        {
        }
        field(50002; Description; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Qualification Level", "Grade Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
