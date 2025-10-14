Table 52202547 "Biometric Devices"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Device Name"; Code[50])
        {
        }
        field(3; "IP Address"; Code[50])
        {
        }
        field(4; Active; Boolean)
        {
        }
        field(5; "Last Modified"; DateTime)
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
