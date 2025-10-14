Table 52202927 "Audit Notifications"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; Sender; Code[30])
        {
        }
        field(3; Receiver; Code[30])
        {
        }
        field(4; "Message 1"; Text[250])
        {
        }
        field(5; "Message 2"; Text[250])
        {
        }
        field(6; "Read?"; Boolean)
        {
        }
        field(7; "Date Created"; Date)
        {
        }
        field(8; Subject; Text[250])
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
