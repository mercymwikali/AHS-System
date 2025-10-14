Table 52202933 "QMS Archive"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Title; Text[250])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; "Date Created"; Date)
        {
        }
        field(5; "Created By"; Text[100])
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
