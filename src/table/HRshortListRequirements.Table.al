Table 85436 "HR shortList Requirements"
{
    fields
    {
        field(50000; "Job Id"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HR Jobs"."Job ID";
        }
        field(50001; "ShortList Type"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HR Lookup Values".Code where(Type = filter("ShortListing Criteria"));
        }
        field(50002; "ShortList Code"; Code[30])
        {
            TableRelation = "HR ShortListQualifications".Code where("ShortList Type" = field("ShortList Type"));

            trigger OnValidate()
            begin

                if HRShortQualifications.Get("ShortList Type", "ShortList Code") then
                    "Qualification Description" := HRShortQualifications.Description;
            end;
        }
        field(50003; Priority; Option)
        {
            OptionMembers = " ",High,Medium,Low;
        }
        field(50004; "Score ID"; Decimal)
        {
        }
        field(50005; "Need code"; Code[10])
        {
        }
        field(50006; "Stage Code"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const(Scores));
        }
        field(50007; Mandatory; Boolean)
        {
        }
        field(50008; "Desired Score"; Decimal)
        {
        }
        field(50009; "Total (Stage)Desired Score"; Decimal)
        {
        }
        field(50010; "Qualification Description"; Text[100])
        {
        }
        field(50011; "Grade Attained"; Code[20])
        {
            TableRelation = "HR Recruitment Courses";
        }
    }

    keys
    {
        key(Key1; "Job Id", "ShortList Type", "ShortList Code")
        {
            Clustered = true;
            SumIndexFields = "Score ID";
        }
    }

    fieldgroups
    {
    }

    var
        HRShortQualifications: Record "HR ShortListQualifications";
}
