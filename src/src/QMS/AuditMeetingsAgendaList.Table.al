Table 52202926 "Audit Meetings Agenda List"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Meeting Code"; Code[20])
        {
        }
        field(3; "Agenda Desc 1"; Text[250])
        {
        }
        field(4; "Agenda Desc 2"; Text[250])
        {
        }
        field(5; "Discussed?"; Boolean)
        {
        }
        field(6; "Date Created"; Date)
        {
        }
        field(7; "Created By"; Code[30])
        {
        }
        field(8; "Date Edited"; Date)
        {
        }
        field(9; "Edited By"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Meeting Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := Database.UserId;
        "Date Created" := today;
    end;

    trigger OnModify()
    begin
        "Edited By" := Database.UserId;
        "Date Edited" := today;
    end;
}
