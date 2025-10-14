Table 52202638 "HMS Setup Appointment Type"
{
    DrillDownPageId = "HMS Setup Appointment Type";
    LookupPageID = "HMS Setup Appointment Type";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            NotBlank = true;
        }
        field(3; "Bill Consultancy Fee"; Boolean)
        {
        }
        field(4; isReview; Boolean)
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
