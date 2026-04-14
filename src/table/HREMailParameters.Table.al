Table 85408 "HR E-Mail Parameters"
{
    fields
    {
        field(50000; "Associate With"; Option)
        {
            Caption = 'Associate With';
            OptionMembers = "Vacancy Advertisements","Interview Invitations",General,"HR Jobs","Regret Notification"," Aptitude Test Invitation","Aptitude Regret Notification","Assesment Test Invitation","Assesment Regret Notification";
        }
        field(50001; "Sender Name"; Text[30])
        {
        }
        field(50002; "Sender Address"; Text[30])
        {
        }
        field(50003; Recipients; Text[30])
        {
        }
        field(50004; Subject; Text[100])
        {
        }
        field(50005; Body; Text[100])
        {
        }
        field(50006; "Body 2"; Text[250])
        {
        }
        field(50007; HTMLFormatted; Boolean)
        {
        }
        field(50008; "Body 3"; Text[250])
        {
        }
        field(50009; "Body 4"; Text[250])
        {
        }
        field(50010; "Body 5"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Associate With")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
