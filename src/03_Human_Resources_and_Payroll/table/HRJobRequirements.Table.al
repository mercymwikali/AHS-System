Table 85294 "HR Job Requirements"
{
    fields
    {
        field(50000; "Job Id"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HR Jobs"."Job ID";
        }
        field(50001; "Qualification Type"; Code[20])
        {
            NotBlank = false;
            TableRelation = "HR Lookup Values".Code where(Type = filter("Qualification Type"));
        }
        field(50002; "Qualification Code"; Code[30])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "HR Qualifications".Code where("Qualification Type" = field("Qualification Type"));

            trigger OnValidate()
            begin
                /*.SETFILTER(Requirments."Qualification Type","Qualification Type");
                Requirments.SETFILTER(Requirments.Code,"Qualification Code");
                IF Requirments.FIND('-') THEN
                 Qualification := Requirments.Description; */

                if HRQualifications.Get("Qualification Type", "Qualification Code") then
                    "Qualification Description" := HRQualifications.Description;
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
        }
        field(50012; "Qualification Category"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Qualification category"));

            trigger OnValidate()
            begin
                if HRQualifications.Get("Qualification Type", "Qualification Code") then
                    "Qualification Description" := HRQualifications.Description;
            end;
        }
    }

    keys
    {
        key(Key1; "Job Id", "Qualification Type", "Qualification Code", "Qualification Category")
        {
            Clustered = true;
            SumIndexFields = "Score ID";
        }
    }

    fieldgroups
    {
    }

    var
        HRQualifications: Record "HR Employee Qualifications";
}
