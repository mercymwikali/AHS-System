Table 52202903 "Vendor Category"
{
    DrillDownPageId = "Vendor Category";
    LookupPageId = "Vendor Category";
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[150])
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
