table 85113 "Material Usage"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; MyField; Integer)
        {
        }
    }

    keys
    {
        key(PK; MyField)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;
}