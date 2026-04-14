Table 85080 "Cashier Link q"
{
    fields
    {
        field(50000; UserID; Code[20])
        {
            NotBlank = true;
            TableRelation = User."User Name";
        }
        field(50001; "Bank Account No"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50002; "Branch Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCHES'));
        }
    }

    keys
    {
        key(Key1; UserID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
