Table 85233 "HMS Radiology Sections"
{
    //  DrillDownPageID = UnknownPage70135295;
    //  LookupPageID = UnknownPage70135295;

    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Description; Text[100])
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
