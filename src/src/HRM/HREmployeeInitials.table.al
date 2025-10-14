table 52202920 "HR Employee Initials"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "HR Employee Initials";
    LookupPageId = "HR Employee Initials";

    fields
    {
        field(1; Code; code[20])
        {
        }
        field(2; Description; text[30])
        {
        }
    }

    keys
    {
        key(PK; Code)
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