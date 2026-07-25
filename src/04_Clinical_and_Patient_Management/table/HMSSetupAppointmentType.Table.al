Table 85242 "HMS Setup Appointment Type"
{
    DrillDownPageId = "HMS Setup Appointment Type";
    LookupPageID = "HMS Setup Appointment Type";

    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[30])
        {
            NotBlank = true;
        }
        field(50002; "Bill Consultancy Fee"; Boolean)
        {
        }
        field(50003; isReview; Boolean)
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
