Table 85205 "HMS Observation Signs"
{
    fields
    {
        field(50000; "Treatment No."; Code[20])
        {
            TableRelation = "HMS Treatment Form Header"."Treatment No.";
        }
        field(50001; "Sign Code"; Code[20])
        {
            TableRelation = "HMS Signs Setup"."Sign Code" where(System = field(System));
        }
        field(50002; "Sign Description"; Text[250])
        {
        }
        field(50003; System; Code[30])
        {
            TableRelation = "HMS Systems".Code;
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Sign Code", System)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
