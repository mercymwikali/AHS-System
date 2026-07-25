Table 85561 "Audit Notifications"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[30])
        {
        }
        field(50001; Sender; Code[30])
        {
        }
        field(50002; Receiver; Code[30])
        {
        }
        field(50003; "Message 1"; Text[250])
        {
        }
        field(50004; "Message 2"; Text[250])
        {
        }
        field(50005; "Read?"; Boolean)
        {
        }
        field(50006; "Date Created"; Date)
        {
        }
        field(50007; Subject; Text[250])
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
