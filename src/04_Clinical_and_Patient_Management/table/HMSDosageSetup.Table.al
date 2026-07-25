Table 85189 "HMS Dosage Setup"
{
    LookupPageID = "HR Job Requirement Lines";

    fields
    {
        field(50000; "Dose Code"; Code[20])
        {
        }
        field(50001; Description; Text[100])
        {
        }
        field(50002; "Calculate Dosage"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Dose Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
