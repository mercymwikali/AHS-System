Table 85004 "FLT-Flt Model"
{
    DrillDownPageID = "Flt Model List";
    LookupPageID = "Flt Model List";

    fields
    {
        field(50000; "Code"; Code[10])
        {
        }
        field(50001; Description; Text[30])
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
