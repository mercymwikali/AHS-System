Table 85250 "HMS Setup Injection"
{
    //  LookupPageID = UnknownPage70135123;

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
        field(50002; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(50003; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(50004; Amount; Decimal)
        {
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
