Table 85370 "Appraisal Types"
{
    // DrillDownPageID = UnknownPage39005882;
    //   LookupPageID = UnknownPage39005882;

    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[150])
        {
            NotBlank = true;
        }
        field(50002; "Use Template"; Boolean)
        {
        }
        field(50003; "Template Link"; Text[200])
        {
        }
        field(50004; Remarks; Text[250])
        {
        }
        field(50005; "Max. Weighting"; Decimal)
        {
        }
        field(50006; "Max. Score"; Decimal)
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
