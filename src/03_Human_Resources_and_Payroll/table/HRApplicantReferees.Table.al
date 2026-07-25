Table 85392 "HR Applicant Referees"
{
    fields
    {
        field(50000; Names; Text[200])
        {
        }
        field(50001; Designation; Text[100])
        {
        }
        field(50002; Institution; Text[100])
        {
        }
        field(50003; Address; Text[200])
        {
        }
        field(50004; "Telephone No"; Text[100])
        {
        }
        field(50005; "E-Mail"; Text[100])
        {
        }
        field(50006; "Employee No"; Code[30])
        {
        }
        field(50007; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50008; "Applicant Username"; Code[50])
        {
        }
        field(50009; "Applicant Email Address"; Code[50])
        {
        }
        field(50010; "Applicant Postal Address"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No", Names)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
