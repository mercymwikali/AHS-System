Table 85364 "Applicants Medical Info."
{
    fields
    {
        field(50000; "Applicant No"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[150])
        {
            NotBlank = true;
            TableRelation = "Medical Information".Description;
        }
        field(50002; Results; Text[200])
        {
        }
        field(50003; Date; Date)
        {
        }
        field(50004; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Applicant No", Description)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
