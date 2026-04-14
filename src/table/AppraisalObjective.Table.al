Table 85367 "Appraisal Objective"
{
    fields
    {
        field(50000; "No Series"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Appraisal Code"; Code[50])
        {
        }
        field(50002; "HOD  Comments"; Text[250])
        {
        }
        field(50003; "Appraisee Comments"; Text[250])
        {
        }
        field(50004; Ratings; Decimal)
        {
            TableRelation = "Appraisal Ratings".Rating;

            trigger OnValidate()
            begin
                AppRating.SetRange(AppRating.Rating, Ratings);
                if AppRating.Find('-') then
                    "Rating Description" := AppRating.Description;
            end;
        }
        field(50005; Objectives; Text[250])
        {
        }
        field(50006; "Performance Indicator Code"; Code[10])
        {
            TableRelation = "HR Appraisal indicators".Code where(Criteria = field("Criteria Code"));

            trigger OnValidate()
            begin
                Indctrs.SetRange(Indctrs."Performance Indicator", "Performance Indicator Code");
                if Indctrs.Find('-') then
                    "Performance Indicator Descript" := Indctrs."Performance Indicator";
            end;
        }
        field(50007; "Criteria Code"; Code[10])
        {
            TableRelation = "Appraisal Criteria".Criteria;

            trigger OnValidate()
            begin

                Crteria.SetRange(Crteria.Criteria, "Criteria Code");
                if Crteria.Find('-') then
                    "Criteria Description" := Crteria.Description;
            end;
        }
        field(50008; "Performance Indicator Descript"; Text[250])
        {
        }
        field(50009; "Agreed Rating Point"; Decimal)
        {
        }
        field(50010; "Employee Rating Percentage"; Decimal)
        {
        }
        field(50011; "Agreed rating Percentage"; Decimal)
        {
        }
        field(50012; "Staff No"; Code[20])
        {
            TableRelation = "HR-Employee"."No.";

            trigger OnValidate()
            begin
                //HrEmp.SETRANGE(HrEmp."No.","Staff No");
                //IF HrEmp.FIND('-') THEN
                //"Staff Name":=HrEmp."First Name"+'  ' +HrEmp."Middle Name"+'  '+ HrEmp."Last Name";
            end;
        }
        field(50013; "Criteria Description"; Text[250])
        {
        }
        field(50014; "Weak Areas Discussed"; Text[250])
        {
        }
        field(50015; "Rating Description"; Text[100])
        {
        }
        field(50016; "HOD Asssement Summary"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "No Series", "Appraisal Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Crteria: Record "Appraisal Criteria";
        AppRating: Record "Appraisal Ratings";
        Indctrs: Record "HR Appraisal indicators";
}
