Table 85224 "HMS Physiotheraphy TYpes"
{
    DrillDownPageID = "HR Training Providers Card";
    LookupPageID = "HR Training Providers Card";

    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Description; Text[100])
        {
        }
        field(50002; Amount; Decimal)
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
