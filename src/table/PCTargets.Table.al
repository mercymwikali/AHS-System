table 85458 "PC Targets"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Quarterly Target"; Text[200])
        {
        }
        field(50002; "Actual achieved"; Text[200])
        {
        }
        field(50003; "Cumulative Target"; Text[200])
        {
        }
        field(50004; "Cumulative Actual"; Text[200])
        {
        }
        field(50005; "Variance"; Text[200])
        {
        }
        field(50006; "Comments on variance"; Text[200])
        {
        }
        field(50007; "action taken"; Text[200])
        {
        }
        field(50008; "Risk Mitigation"; Text[200])
        {
        }
        field(50009; "Strategic Plan No."; code[20])
        {
        }
    }

    keys
    {
        key(PK; "Entry No", "Strategic Plan No.")
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