Table 85460 "Position Supervised"
{
    fields
    {
        field(50000; "Job ID"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Company Jobs"."Job ID";
        }
        field(50001; "Position Supervised"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Company Jobs"."Job ID";

            trigger OnValidate()
            begin
                if Jobs.Get("Position Supervised") then
                    Description := Jobs."Job Description";
            end;
        }
        field(50002; Description; Text[250])
        {
        }
        field(50003; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Job ID", "Position Supervised")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Jobs: Record "Company Jobs";
}
