Table 52202554 "Application Setup County"
{
    DrillDownPageId = "Application Setup County";
    LookupPageId = "Application Setup County";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Description = 'Stores the code of the district in the database';
        }
        field(2; Description; Text[30])
        {
            Description = 'Stores the district''s description in the database';
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
