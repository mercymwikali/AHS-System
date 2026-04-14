Table 85563 "Audit Programmes"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[30])
        {
        }
        field(50001; Title; Text[200])
        {
        }
        field(50002; "Date Created"; Date)
        {
        }
        field(50003; "Description/Comment"; Text[200])
        {
        }
        field(50004; "Created By"; Text[100])
        {
        }
        field(50005; "Last Edited By"; Text[100])
        {
        }
        field(50006; "Date Edited"; Date)
        {
        }
        field(50007; Status; Option)
        {
            OptionMembers = ,"Pending Approval",Approved,Rejected;
        }
        field(50008; "Approval Comments"; Text[250])
        {
        }
        field(50009; "Notification Sent?"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
        key(Key2; Title)
        {
        }
    }

    fieldgroups
    {
    }
}
