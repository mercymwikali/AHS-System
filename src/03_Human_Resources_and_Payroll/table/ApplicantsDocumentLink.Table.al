Table 85362 "Applicants Document Link"
{
    fields
    {
        field(50000; "Document Description"; Text[100])
        {
            NotBlank = true;
        }
        field(50001; "Document Link"; Text[200])
        {
            ExtendedDatatype = URL;
        }
        field(50002; "Applicant No"; Text[30])
        {
        }
        field(50003; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50004; "User Name"; Code[30])
        {
        }
        field(50005; "Email Address"; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Line No", "Document Description")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
