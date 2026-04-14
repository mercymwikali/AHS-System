Table 85562 Auditors
{
    fields
    {
        field(50000; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Role; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Member,Leader';
            OptionMembers = ,Member,Leader;
        }
        field(50002; "Audit Programme"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Programmes".Code;
        }
        field(50003; "Audit No."; Option)
        {
            Editable = false;
            FieldClass = Normal;
            OptionCaption = ',1st Internal Audit,1st Surveillance Audit,6th Internal Audit,3rd Surveillance Audit,7th Internal Audit,4th Surveillance Audit';
            OptionMembers = ,"1st Internal Audit","1st Surveillance Audit","6th Internal Audit","3rd Surveillance Audit","7th Internal Audit","4th Surveillance Audit";
        }
        field(50004; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Department; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Audit Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Pending Approval,Accepted,Rejected';
            OptionMembers = ,"Pending Approval",Accepted,Rejected;
        }
        field(50009; "Approval Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Audit Programme", Department, "User ID", "Audit Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
