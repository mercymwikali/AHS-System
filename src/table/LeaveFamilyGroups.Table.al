Table 85447 "Leave Family Groups"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[100])
        {
        }
        field(50002; Remarks; Text[200])
        {
        }
        field(50003; "Leave Days"; Decimal)
        {
            DecimalPlaces = 1 : 1;
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
