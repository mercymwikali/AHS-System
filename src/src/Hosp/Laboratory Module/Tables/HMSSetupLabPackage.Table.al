Table 52202632 "HMS Setup Lab Package"
{
    // LookupPageID = UnknownPage70135111;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            NotBlank = true;
        }
        field(3; "Lab Tests"; Integer)
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
