Table 52202736 "HR Applicant Referees"
{
    fields
    {
        field(2; Names; Text[200])
        {
        }
        field(3; Designation; Text[100])
        {
        }
        field(4; Institution; Text[100])
        {
        }
        field(5; Address; Text[200])
        {
        }
        field(6; "Telephone No"; Text[100])
        {
        }
        field(7; "E-Mail"; Text[100])
        {
        }
        field(8; "Employee No"; Code[30])
        {
        }
        field(9; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(10; "Applicant Username"; Code[50])
        {
        }
        field(11; "Applicant Email Address"; Code[50])
        {
        }
        field(12; "Applicant Postal Address"; Code[50])
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
