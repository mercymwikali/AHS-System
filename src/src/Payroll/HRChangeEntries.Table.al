Table 52202723 "HR Change Entries"
{
    fields
    {
        field(1; "Integer"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "employee No"; Code[50])
        {
        }
        field(3; "Change Date"; Date)
        {
        }
        field(4; "Change Description"; Text[250])
        {
        }
        field(5; "Old Value"; Text[250])
        {
        }
        field(6; "New Value"; Text[250])
        {
        }
        field(7; UserID; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Integer")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
