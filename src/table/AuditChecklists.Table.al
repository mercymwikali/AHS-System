Table 85556 "Audit Checklists"
{
    fields
    {
        field(50000; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Audit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Audits.Code;
        }
        field(50002; "Checkpoint Desc 1"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Checkpoint Desc 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Clause of Criteria Document"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Checkpoint Desc 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Checkpoint Desc 4"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Created By"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Finding Desc 1"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Finding Desc 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Finding Desc 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Finding Citation 1"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Finding Citation 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Finding Desc 4"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Finding Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Not Created,Pending submission,Pending Acceptance,Accepted,Rejected';
            OptionMembers = "Not Created","Pending submission","Pending Acceptance",Accepted,Rejected;
        }
        field(50016; "Rejected Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; Department; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('DEPARTMENT'));
        }
        field(50018; Classification; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Compliance,Observation,Minor Non-conformity,Major Non-conformity';
            OptionMembers = ,"Compliance/Positive",Observation,"Minor Non-conformity","Major Non-conformity";
        }
        field(50019; "Approval Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Audit Programme"; Code[20])
        {
            CalcFormula = lookup(Audits."Audit Programme" where(Code = field("Audit Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; "Audit No"; Option)
        {
            CalcFormula = lookup(Audits."Audit No." where(Code = field("Audit Code")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ',1st Internal Audit,1st Surveillance Audit,6th Internal Audit,3rd Surveillance Audit,7th Internal Audit,4th Surveillance Audit';
            OptionMembers = ,"1st Internal Audit","1st Surveillance Audit","6th Internal Audit","3rd Surveillance Audit","7th Internal Audit","4th Surveillance Audit";
        }
    }

    keys
    {
        key(Key1; "Code", "Audit Code")
        {
            Clustered = true;
        }
        key(Key2; "Audit Code")
        {
        }
    }

    fieldgroups
    {
    }
}
