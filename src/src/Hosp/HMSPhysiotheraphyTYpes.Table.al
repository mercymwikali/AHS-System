Table 52202509 "HMS Physiotheraphy TYpes"
{
    DrillDownPageID = "HR Training Providers Card";
    LookupPageID = "HR Training Providers Card";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
