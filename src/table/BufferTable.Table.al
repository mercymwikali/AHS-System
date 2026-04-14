Table 85078 "Buffer Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; No; Code[20])
        {
        }
        field(50001; "New Code"; Code[20])
        {
        }
        field(50002; Balance; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; No, "New Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
