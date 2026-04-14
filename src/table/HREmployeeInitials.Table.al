table 85411 "HR Employee Initials"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "HR Employee Initials";
    LookupPageId = "HR Employee Initials";

    fields
    {
        field(50000; Code; code[20])
        {
        }
        field(50001; Description; text[30])
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