table 85111 "Estate Houses"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Estate Houses";
    LookupPageId = "Estate Houses";
    fields
    {
        field(50000; Code; code[20])
        {
        }
        field(50001; Description; text[100])
        {
        }
        field(50002; "Occupant Employee No"; code[20])
        {
        }
        field(50003; "Outsider Name"; text[100])
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