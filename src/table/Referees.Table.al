Table 85340 Referees
{
    fields
    {
        field(50000; No; Code[20])
        {
            // TableRelation = Applicants."No.";
        }
        field(50001; Names; Text[200])
        {
        }
        field(50002; Designation; Text[100])
        {
        }
        field(50003; Company; Text[100])
        {
        }
        field(50004; Address; Text[200])
        {
        }
        field(50005; "Telephone No"; Text[100])
        {
        }
        field(50006; "E-Mail"; Text[100])
        {
        }
        field(50007; "Entry No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; No, Names)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
