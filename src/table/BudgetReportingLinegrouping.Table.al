Table 85077 "Budget Reporting Line grouping"
{
    fields
    {
        field(50000; "Budget Line Grouping"; Code[50])
        {
        }
        field(50001; Description; Text[200])
        {
        }
        field(50002; Currency; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Budget Line Grouping")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
