Table 85580 "Vendor Category"
{
    DrillDownPageId = "Vendor Category";
    LookupPageId = "Vendor Category";
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Description; Text[150])
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
