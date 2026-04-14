Table 85361 "Applicants Comments/Views"
{
    fields
    {
        field(50000; "Applicant No"; Code[20])
        {
        }
        field(50001; Date; Date)
        {
        }
        field(50002; "Views/Comments"; Text[150])
        {
        }
    }

    keys
    {
        key(Key1; "Applicant No", Date, "Views/Comments")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
