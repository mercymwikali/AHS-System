Table 85143 Temp
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; No; Code[20])
        {
        }
        field(50001; "Transcation Code"; Code[20])
        {
        }
        field(50002; Balance; Decimal)
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
