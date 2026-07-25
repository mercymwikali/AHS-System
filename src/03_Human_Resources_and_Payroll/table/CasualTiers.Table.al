Table 85482 "Casual Tiers"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Occupation Code"; Code[50])
        {
            Description = 'Casual bukua';
        }
        field(50001; "Occupation Description"; Text[100])
        {
            Description = 'casual Bukura';
        }
        field(50002; "Rate Per Month"; Decimal)
        {
            Description = 'casual Bukura';
        }
        field(50003; "Rate per Day"; Decimal)
        {
            Description = 'casual Bukura';
        }
    }

    keys
    {
        key(Key1; "Occupation Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
