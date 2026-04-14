Table 85246 "HMS Setup Discharge Processes"
{
    // LookupPageID = "WF Student Other Incident SF";

    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[100])
        {
            NotBlank = true;
        }
        field(50002; Mandatory; Boolean)
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
