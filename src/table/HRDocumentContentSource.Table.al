Table 85406 "HR Document Content Source"
{
    //  DrillDownPageID = UnknownPage39003971;
    //  LookupPageID = UnknownPage39003971;

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
        field(50007; "Objective Type"; Option)
        {
            OptionMembers = Quantitative,Qualitative;
        }
    }

    keys
    {
        key(Key1; "Objective Type", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
