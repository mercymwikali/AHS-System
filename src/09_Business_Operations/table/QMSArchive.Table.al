Table 85565 "QMS Archive"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Title; Text[250])
        {
        }
        field(50002; Description; Text[250])
        {
        }
        field(50003; "Date Created"; Date)
        {
        }
        field(50004; "Created By"; Text[100])
        {
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
