Table 85316 "HMS Setup Lab Package"
{
    // LookupPageID = UnknownPage70135111;

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
        field(50002; "Lab Tests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HMS Setup Lab Test" );
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
