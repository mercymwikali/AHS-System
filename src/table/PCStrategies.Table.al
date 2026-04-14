table 85457 "PC Strategies"
{
    DataClassification = ToBeClassified;
    LookupPageId = "PC Strategies";
    fields
    {
        field(50000; Code; code[20])
        {
        }
        field(50001; Description; text[2000])
        {
        }
    }

    keys
    {
        key(PK; code)
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