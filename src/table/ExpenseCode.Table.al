Table 85051 "Expense Code"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(50001; Name; Text[30])
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
