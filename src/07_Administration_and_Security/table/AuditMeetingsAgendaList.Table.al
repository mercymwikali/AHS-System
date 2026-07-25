Table 85559 "Audit Meetings Agenda List"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; "Meeting Code"; Code[20])
        {
        }
        field(50002; "Agenda Desc 1"; Text[250])
        {
        }
        field(50003; "Agenda Desc 2"; Text[250])
        {
        }
        field(50004; "Discussed?"; Boolean)
        {
        }
        field(50005; "Date Created"; Date)
        {
        }
        field(50006; "Created By"; Code[30])
        {
        }
        field(50007; "Date Edited"; Date)
        {
        }
        field(50008; "Edited By"; Code[30])
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
