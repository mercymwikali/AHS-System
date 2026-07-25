Table 85127 "Procurement Plan Period"
{
    DrillDownPageID = "Procurement Plan Period";
    LookupPageID = "Procurement Plan Period";

    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; "Period Name"; Text[30])
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
