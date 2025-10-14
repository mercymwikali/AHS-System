table 52202441 "Temp Delete"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Doc No"; code[20])
        {
        }
        field(2; "Description"; text[200])
        {
        }
        field(3; "Amount"; Decimal)
        {
        }
        field(4; "Posted"; Boolean)
        {
        }
        field(5; "Entries Count"; Integer)
        {
            CalcFormula = count("G/L Entry" where("Document No." = field("Doc No"), "Posting Date" = field("Posting Date")));
            FieldClass = FlowField;
        }
        field(6; "Posting Date"; date)
        {
        }
    }

    keys
    {
        key(Key1; "Doc No")
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