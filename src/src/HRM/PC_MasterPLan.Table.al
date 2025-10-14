table 52202470 "PC MasterPlan Header"
{
    DataClassification = ToBeClassified;
    LookupPageId = "MasterPlan List";

    fields
    {
        field(1; Code; code[20])
        {
        }
        field(2; Description; text[200])
        {
        }
        field(3; "Start Date"; date)
        {
        }
        field(4; "End Date"; date)
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