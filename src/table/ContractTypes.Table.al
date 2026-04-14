Table 85377 "Contract Types"
{
    DrillDownPageID = "Contract Types";
    LookupPageID = "Contract Types";

    fields
    {
        field(50000; Contract; Code[50])
        {
            NotBlank = true;
        }
        field(50001; Remarks; Text[200])
        {
        }
        field(50002; "Pays Provident"; Boolean)
        {
        }
        field(50003; "Pays Pension"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Contract)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
