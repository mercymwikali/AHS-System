table 85144 "Temp Delete"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Doc No"; code[20])
        {
        }
        field(50001; "Description"; text[200])
        {
        }
        field(50002; "Amount"; Decimal)
        {
        }
        field(50003; "Posted"; Boolean)
        {
        }
        field(50004; "Entries Count"; Integer)
        {
            CalcFormula = count("G/L Entry" where("Document No." = field("Doc No"), "Posting Date" = field("Posting Date")));
            FieldClass = FlowField;
        }
        field(50005; "Posting Date"; date)
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