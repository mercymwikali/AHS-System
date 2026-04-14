Table 85564 Audits
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[30])
        {
        }
        field(50001; "Audit Programme"; Code[30])
        {
            TableRelation = "Audit Programmes".Code;
        }
        field(50002; "Audit No."; Option)
        {
            OptionCaption = ',1st Internal Audit,1st Surveillance Audit,6th Internal Audit,3rd Surveillance Audit,7th Internal Audit,4th Surveillance Audit';
            OptionMembers = ,"1st Internal Audit","1st Surveillance Audit","6th Internal Audit","3rd Surveillance Audit","7th Internal Audit","4th Surveillance Audit";
        }
        field(50003; "Audit From Date"; Date)
        {
        }
        field(50004; "Audit To Date"; Date)
        {
        }
        field(50005; "Leaders Appointment Date"; Date)
        {
        }
        field(50006; "Members Appointment Date"; Date)
        {
        }
        field(50007; "Follow Up To Date"; Date)
        {
        }
        field(50008; "Review To Date"; Date)
        {
        }
        field(50009; "Follow Up From Date"; Date)
        {
        }
        field(50010; "Review From Date"; Date)
        {
        }
        field(50011; Status; Option)
        {
            OptionMembers = ,Open,Closed;
        }
        field(50012; "Date Created"; Date)
        {
        }
        field(50013; Sequence; Integer)
        {
        }
        field(50014; Description; Text[250])
        {
        }
        field(50015; "Created By"; Code[20])
        {
        }
        field(50016; Name; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; "Audit Programme")
        {
        }
    }

    fieldgroups
    {
    }
}
