Table 52202919 "Email Sender"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Subject; Text[250])
        {
        }
        field(3; "Receiver Email"; Text[100])
        {
        }
        field(4; "Message Desc 1"; Text[250])
        {
        }
        field(5; "Message Desc 2"; Text[250])
        {
        }
        field(6; "Message Desc 3"; Text[250])
        {
        }
        field(7; "Message Desc 4"; Text[250])
        {
        }
        field(8; "Sent?"; Boolean)
        {
        }
        field(9; Category; Option)
        {
            OptionCaption = ',Online Application,Enquiry,QMS,Password Reset,Audit Notification';
            OptionMembers = ,"Online Application",Enquiry,QMS,"Password Reset","Audit Notification";
        }
        field(10; "Date Created"; DateTime)
        {
        }
        field(11; Sender; Code[100])
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
