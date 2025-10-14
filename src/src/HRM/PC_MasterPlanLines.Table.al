table 52202471 "PC MasterPlan Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Five Year Target"; Text[200])
        {
        }
        field(3; "Achievements"; Text[200])
        {
        }
        field(4; "Shortfalls"; Text[200])
        {
        }
        field(5; "Variance"; Text[200])
        {
        }
        field(6; "Remarks"; Text[200])
        {
        }
        field(7; "Risk Mitigation Factors"; Text[200])
        {
        }
        field(8; "Alterations"; Text[200])
        {
        }
        field(9; "MasterPlan Code"; code[20])
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