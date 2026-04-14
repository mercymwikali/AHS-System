Table 85400 "HR Appraisal skills comp Score"
{
    fields
    {
        field(50000; "Appraisal No"; Code[30])
        {
        }
        field(50001; "Appraisal Period"; Code[30])
        {
        }
        field(50002; Competence; Text[250])
        {
        }
        field(50003; Score; Decimal)
        {
        }
        field(50004; "Question Number"; Integer)
        {
        }
        field(50005; "Line No"; Integer)
        {
            AutoIncrement = true;
            MinValue = 1;
        }
    }

    keys
    {
        key(Key1; "Appraisal No", "Question Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
