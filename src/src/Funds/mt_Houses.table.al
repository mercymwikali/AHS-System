table 52202524 "Estate Houses"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Estate Houses";
    LookupPageId = "Estate Houses";
    fields
    {
        field(1; Code; code[20])
        {
        }
        field(2; Description; text[100])
        {
        }
        field(3; "Occupant Employee No"; code[20])
        {
        }
        field(4; "Outsider Name"; text[100])
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