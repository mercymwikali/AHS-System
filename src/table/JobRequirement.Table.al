Table 85443 "Job Requirement"
{
    fields
    {
        field(50000; "Job Id"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Company Jobs"."Job ID";
        }
        field(50001; "Qualification Type"; Option)
        {
            NotBlank = false;
            OptionMembers = " ",Academic,Professional,Technical,Experience,"Personal Attributes";
        }
        field(50002; "Qualification Code"; Code[10])
        {
            Editable = true;
            NotBlank = true;

            trigger OnValidate()
            begin
                QualificationSetUp.Reset();
                QualificationSetUp.SetRange(QualificationSetUp.Code, "Qualification Code");
                if QualificationSetUp.Find('-') then
                    Qualification := QualificationSetUp.Description;
            end;
        }
        field(50003; Qualification; Text[200])
        {
            NotBlank = false;
        }
        field(50004; "Job Requirements"; Text[250])
        {
            NotBlank = true;
        }
        field(50005; Priority; Option)
        {
            OptionMembers = " ",High,Medium,Low;
        }
        field(50006; "Job Specification"; Option)
        {
            OptionMembers = " ",Academic,Professional,Technical,Experience;
        }
        field(50007; "Score ID"; Decimal)
        {
            TableRelation = "Score Setup"."Score ID";
        }
    }

    keys
    {
        key(Key1; "Job Id", "Qualification Type", "Qualification Code")
        {
            Clustered = true;
            SumIndexFields = "Score ID";
        }
    }

    fieldgroups
    {
    }

    var
        QualificationSetUp: Record Qualification;
}
