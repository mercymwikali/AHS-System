Table 85569 "Risk Mitigations"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Risk Code"; Text[250])
        {
            FieldClass = Normal;
            TableRelation = Risks.Code where(Code = field("Risk Code"));
        }
        field(50002; "Mitigation Desc 1"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Mitigation Desc 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Mitigation Desc 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Mitigation Desc 4"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Date Edited"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Edited By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Risk Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
