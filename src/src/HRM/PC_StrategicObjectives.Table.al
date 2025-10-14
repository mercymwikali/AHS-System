table 52202437 "PC Strategic Objectives"
{
    DataClassification = ToBeClassified;
    LookupPageId = "PC Strategic Objectives";
    fields
    {
        field(1; Code; code[20])
        {
        }
        field(2; Description; text[2000])
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