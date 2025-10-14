Table 52202442 "Casual Tiers"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Occupation Code"; Code[50])
        {
            Description = 'Casual bukua';
        }
        field(2; "Occupation Description"; Text[100])
        {
            Description = 'casual Bukura';
        }
        field(3; "Rate Per Month"; Decimal)
        {
            Description = 'casual Bukura';
        }
        field(4; "Rate per Day"; Decimal)
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
