Table 85521 "prHousing Scheme"
{
    fields
    {
        field(50000; "Scheme Code"; Code[10])
        {
        }
        field(50001; "Scheme Name"; Text[50])
        {
        }
        field(50002; "Market Value"; Decimal)
        {
        }
        field(50003; "Rental Value"; Decimal)
        {
        }
        field(50004; "Employer Owned"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Scheme Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
