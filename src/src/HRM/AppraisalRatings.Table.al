Table 52202799 "Appraisal Ratings"
{
    DrillDownPageID = "Appraisal Ratings";
    LookupPageID = "Appraisal Ratings";

    fields
    {
        field(1; Rating; Decimal)
        {
        }
        field(2; Description; Text[150])
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
