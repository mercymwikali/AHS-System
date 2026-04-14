Table 85369 "Appraisal Ratings"
{
    DrillDownPageID = "Appraisal Ratings";
    LookupPageID = "Appraisal Ratings";

    fields
    {
        field(50000; Rating; Decimal)
        {
        }
        field(50001; Description; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; Rating)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
