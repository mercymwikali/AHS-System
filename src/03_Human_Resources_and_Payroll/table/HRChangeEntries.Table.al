Table 85490 "HR Change Entries"
{
    fields
    {
        field(50000; "Integer"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "employee No"; Code[50])
        {
        }
        field(50002; "Change Date"; Date)
        {
        }
        field(50003; "Change Description"; Text[250])
        {
        }
        field(50004; "Old Value"; Text[250])
        {
        }
        field(50005; "New Value"; Text[250])
        {
        }
        field(50006; UserID; Code[50])
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
