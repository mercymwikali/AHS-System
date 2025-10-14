Table 52202521 "Referral Labs"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Lab Test"; Code[100])
        {
        }
        field(3; "Referral Lab"; Text[250])
        {
        }
        field(4; TAT; Text[100])
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
