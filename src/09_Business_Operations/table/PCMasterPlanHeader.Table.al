table 85451 "PC MasterPlan Header"
{
    DataClassification = ToBeClassified;
    LookupPageId = "MasterPlan List";

    fields
    {
        field(50000; Code; code[20])
        {
        }
        field(50001; Description; text[200])
        {
        }
        field(50002; "Start Date"; date)
        {
        }
        field(50003; "End Date"; date)
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