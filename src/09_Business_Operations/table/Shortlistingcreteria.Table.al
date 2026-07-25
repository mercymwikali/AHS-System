Table 85468 "Shortlisting creteria"
{
    fields
    {
        field(50000; "Requitment Stage"; Code[20])
        {
            NotBlank = false;
            TableRelation = "Recruitment Stages";
        }
        field(50001; "Job ID"; Code[20])
        {
            NotBlank = true;
        }
        field(50002; Requirements; Code[20])
        {
            NotBlank = true;
            //  TableRelation = Qualification.Code where (Field50000=field("Qualification Type"));

            trigger OnValidate()
            begin
                JobRq.Get(Requirements);
                Description := JobRq.Description;
            end;
        }
        field(50003; Description; Text[100])
        {
        }
        field(50004; Score; Code[20])
        {
            TableRelation = "Score Setup";
        }
        field(50005; "Desired Score"; Decimal)
        {
        }
        field(50006; "Qualification Type"; Option)
        {
            OptionMembers = " ",Academic,Professional,Technical,Experience;
        }
    }

    keys
    {
        key(Key1; "Job ID", "Requitment Stage", Requirements, "Qualification Type")
        {
            Clustered = true;
            SumIndexFields = "Desired Score";
        }
        key(Key2; "Job ID", Requirements)
        {
            SumIndexFields = "Desired Score";
        }
        key(Key3; "Job ID", "Qualification Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        JobRq: Record Qualification;
}
