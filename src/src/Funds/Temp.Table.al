Table 52202495 Temp
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Transcation Code"; Code[20])
        {
        }
        field(3; Balance; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; No, "Transcation Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
