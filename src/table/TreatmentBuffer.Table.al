Table 85352 "Treatment Buffer"
{
    fields
    {
        field(50000; "Treatment No"; Code[20])
        {
        }
        field(50001; Category; Code[50])
        {
        }
        field(50002; "Code"; Code[50])
        {
        }
        field(50003; Description; Text[200])
        {
        }
        field(50004; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50005; Remarks; Text[200])
        {
        }
        field(50006; "Sort Order"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Treatment No", "Line No", Category)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
