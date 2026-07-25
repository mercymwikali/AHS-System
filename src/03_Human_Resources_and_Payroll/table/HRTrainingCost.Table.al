Table 85439 "HR Training Cost"
{
    DrillDownPageID = "HR Training Cost";
    LookupPageID = "HR Training Cost";

    fields
    {
        field(50000; "Training Id"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HR Training Applications"."Application No";
        }
        field(50001; "Training Cost Item"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Training Cost Items"));
        }
        field(50002; Cost; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Training Id", "Training Cost Item")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
