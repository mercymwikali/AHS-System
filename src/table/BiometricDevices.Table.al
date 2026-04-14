Table 85571 "Biometric Devices"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Device Name"; Code[50])
        {
        }
        field(50002; "IP Address"; Code[50])
        {
        }
        field(50003; Active; Boolean)
        {
        }
        field(50004; "Last Modified"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "IP Address")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Last Modified" := CurrentDatetime;
        Modify();
    end;

    trigger OnModify()
    begin
        "Last Modified" := CurrentDatetime;
        Modify();
    end;

    trigger OnRename()
    begin
        "Last Modified" := CurrentDatetime;
        Modify();
    end;
}
