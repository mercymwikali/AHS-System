Table 85341 "Referral Labs"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Lab Test"; Code[100])
        {
        }
        field(50002; "Referral Lab"; Text[250])
        {
        }
        field(50003; TAT; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
