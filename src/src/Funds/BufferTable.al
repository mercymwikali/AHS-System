Table 52202496 "Buffer Table"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "New Code"; Code[20])
        {
        }
        field(3; Balance; Decimal)
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
