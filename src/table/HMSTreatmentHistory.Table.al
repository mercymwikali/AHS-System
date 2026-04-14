Table 85272 "HMS Treatment History"
{
    fields
    {
        field(50000; "Treatment No."; Code[20])
        {
        }
        field(50001; "History Code"; Code[20])
        {
            // TableRelation = "HMS Patient History"."History Code";
        }
        field(50002; "History Value"; Code[250])
        {
        }
        field(50003; "History Name"; Text[250])
        {
            // CalcFormula = lookup("HMS Patient History"."History Name" where("History Code" = field("History Code")));
            // FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Treatment No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
