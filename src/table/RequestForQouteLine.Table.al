Table 85137 "Request For Qoute Line"
{
    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Quote No"; Code[10])
        {
        }
        field(50002; "Item No"; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(50003; Description; Text[50])
        {
        }
        field(50004; Units; Code[20])
        {
        }
        field(50005; Qty; Decimal)
        {
        }
        field(50006; "Unit Cost"; Decimal)
        {
        }
        field(50007; "Line Amount"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
        key(Key2; "Quote No")
        {
            SumIndexFields = "Line Amount";
        }
    }

    fieldgroups
    {
    }
}
