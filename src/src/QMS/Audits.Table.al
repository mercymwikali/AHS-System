Table 52202472 Audits
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; "Audit Programme"; Code[30])
        {
            TableRelation = "Audit Programmes".Code;
        }
        field(3; "Audit No."; Option)
        {
            OptionCaption = ',1st Internal Audit,1st Surveillance Audit,6th Internal Audit,3rd Surveillance Audit,7th Internal Audit,4th Surveillance Audit';
            OptionMembers = ,"1st Internal Audit","1st Surveillance Audit","6th Internal Audit","3rd Surveillance Audit","7th Internal Audit","4th Surveillance Audit";
        }
        field(4; "Audit From Date"; Date)
        {
        }
        field(5; "Audit To Date"; Date)
        {
        }
        field(6; "Leaders Appointment Date"; Date)
        {
        }
        field(7; "Members Appointment Date"; Date)
        {
        }
        field(8; "Follow Up To Date"; Date)
        {
        }
        field(9; "Review To Date"; Date)
        {
        }
        field(10; "Follow Up From Date"; Date)
        {
        }
        field(11; "Review From Date"; Date)
        {
        }
        field(12; Status; Option)
        {
            OptionMembers = ,Open,Closed;
        }
        field(13; "Date Created"; Date)
        {
        }
        field(14; Sequence; Integer)
        {
        }
        field(15; Description; Text[250])
        {
        }
        field(16; "Created By"; Code[20])
        {
        }
        field(17; Name; Text[250])
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
