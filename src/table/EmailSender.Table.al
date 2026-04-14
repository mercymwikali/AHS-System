Table 85090 "Email Sender"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Subject; Text[250])
        {
        }
        field(50002; "Receiver Email"; Text[100])
        {
        }
        field(50003; "Message Desc 1"; Text[250])
        {
        }
        field(50004; "Message Desc 2"; Text[250])
        {
        }
        field(50005; "Message Desc 3"; Text[250])
        {
        }
        field(50006; "Message Desc 4"; Text[250])
        {
        }
        field(50007; "Sent?"; Boolean)
        {
        }
        field(50008; Category; Option)
        {
            OptionCaption = ',Online Application,Enquiry,QMS,Password Reset,Audit Notification';
            OptionMembers = ,"Online Application",Enquiry,QMS,"Password Reset","Audit Notification";
        }
        field(50009; "Date Created"; DateTime)
        {
        }
        field(50010; Sender; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
