Table 85366 "Appraisal Criteria"
{
    fields
    {
        field(50000; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; Criteria; Code[20])
        {
        }
        field(50002; Description; Text[100])
        {
        }
        field(50003; "Appraisal Year"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No", Criteria, "Appraisal Year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Description; Description)
        {
        }
    }
}
