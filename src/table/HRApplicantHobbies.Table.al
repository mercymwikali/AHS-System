Table 85390 "HR Applicant Hobbies"
{
    fields
    {
        field(50000; "Job Application No"; Code[20])
        {
            TableRelation = Applicants."Application No";
        }
        field(50001; Hobby; Text[200])
        {
        }
        field(50002; "Applicant No"; Integer)
        {
        }
        field(50003; Interests; Text[200])
        {
        }
        field(50004; "Community Services"; Text[100])
        {
        }
        field(50005; "Major Achievements"; Text[100])
        {
        }
        field(50006; "User Name"; Code[30])
        {
        }
        field(50007; "Email Address"; Code[30])
        {
        }
        field(50008; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50009; "Religious Affiliation"; Option)
        {
            OptionCaption = 'Default,Christian,Muslim,Hindu,Other';
            OptionMembers = Default,Christian,Muslim,Hindu,Other;
        }
        field(50010; "Attending Church"; Option)
        {
            OptionCaption = 'Default,Yes,No';
            OptionMembers = Default,Yes,No;
        }
        field(50011; "Church Address"; Text[150])
        {
        }
        field(50012; "Pastors Name"; Text[100])
        {
        }
        field(50013; "Church Activities"; Text[200])
        {
        }
        field(50014; "Accept Christ"; Text[200])
        {
        }
        field(50015; "Personal Ministry"; Text[200])
        {
        }
        field(50016; "Applicant Names"; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
