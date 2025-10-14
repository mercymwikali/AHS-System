Table 52202517 "Ethnic Community"
{
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Ethnic Community"; Text[100])
        {
        }
        field(50000; "No. of Students"; Integer)
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
