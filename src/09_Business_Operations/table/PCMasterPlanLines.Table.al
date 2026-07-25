table 85452 "PC MasterPlan Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Five Year Target"; Text[200])
        {
        }
        field(50002; "Achievements"; Text[200])
        {
        }
        field(50003; "Shortfalls"; Text[200])
        {
        }
        field(50004; "Variance"; Text[200])
        {
        }
        field(50005; "Remarks"; Text[200])
        {
        }
        field(50006; "Risk Mitigation Factors"; Text[200])
        {
        }
        field(50007; "Alterations"; Text[200])
        {
        }
        field(50008; "MasterPlan Code"; code[20])
        {
        }
    }

    keys
    {
        key(PK; "Line No", "MasterPlan Code")
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