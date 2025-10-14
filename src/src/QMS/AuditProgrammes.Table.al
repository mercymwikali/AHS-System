Table 52202473 "Audit Programmes"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[30])
        {
        }
        field(2; Title; Text[200])
        {
        }
        field(3; "Date Created"; Date)
        {
        }
        field(4; "Description/Comment"; Text[200])
        {
        }
        field(5; "Created By"; Text[100])
        {
        }
        field(6; "Last Edited By"; Text[100])
        {
        }
        field(7; "Date Edited"; Date)
        {
        }
        field(8; Status; Option)
        {
            OptionMembers = ,"Pending Approval",Approved,Rejected;
        }
        field(9; "Approval Comments"; Text[250])
        {
        }
        field(10; "Notification Sent?"; Boolean)
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
