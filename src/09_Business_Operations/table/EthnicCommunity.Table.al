Table 85385 "Ethnic Community"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; "Ethnic Community"; Text[100])
        {
        }
        field(50002; "No. of Students"; Integer)
        {
            CalcFormula = count(Customer where(Tribe = field(Code)));
            FieldClass = FlowField;
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
