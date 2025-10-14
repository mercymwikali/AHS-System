Table 52202721 "HMS Radiology Sections"
{
    //  DrillDownPageID = UnknownPage70135295;
    //  LookupPageID = UnknownPage70135295;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[100])
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
