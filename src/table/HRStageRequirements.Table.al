Table 85438 "HR Stage Requirements"
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
            TableRelation = "HR Qualifications"."Qualification Type";

            trigger OnValidate()
            begin
                if "Qualification Category" = 'GENDER' then
                    "Qualification Code" := "Qualification Type";

                if "Qualification Category" = 'ETHNICITY' then
                    "Qualification Code" := "Qualification Type";

                if "Qualification Category" = 'PUBLICATIONS' then
                    "Qualification Code" := "Qualification Type";
            end;
        }
        field(50002; "Qualification Code"; Code[30])
        {
            Editable = true;
            NotBlank = true;
            TableRelation = "HR Recruitment Courses"."Course Code";

            trigger OnValidate()
            begin
                if "Qualification Category" = 'ACADEMIC' then begin
                    HRRecruitmentCourses.Reset();
                    HRRecruitmentCourses.SetRange("Course Code", "Qualification Code");
                    if HRRecruitmentCourses.Find('-') then
                        "Qualification Description" := HRRecruitmentCourses."Course Description";
                end;
                if "Qualification Category" = 'PUBLICATIONS' then
                    "Qualification Type" := "Qualification Code";
            end;
        }
        field(50003; Priority; Option)
        {
            OptionMembers = " ",High,Medium,Low;
        }
        field(50004; Score; Decimal)
        {
        }
        field(50005; "Need code"; Code[10])
        {
            trigger OnValidate()
            begin
                HREmployeeRequisitions.Reset();
                HREmployeeRequisitions.SetRange("Requisition No.", "Need code");
                if HREmployeeRequisitions.Find('-') then
                    "Job Id" := HREmployeeRequisitions."Job ID";
            end;
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
        field(50011; "Grade Attained"; Code[30])
        {
            TableRelation = "Academic Classification".Classification where(Qualification = field("Qualification Type"));

            trigger OnValidate()
            begin
                if "Qualification Category" = 'ACADEMIC' then begin
                    AcademicClassification.Reset();
                    AcademicClassification.SetRange(Qualification, "Qualification Type");
                    AcademicClassification.SetRange(Classification, "Grade Attained");
                    if AcademicClassification.Find('-') then
                        "Desired Score" := AcademicClassification.Score;
                end;
            end;
        }
        field(50012; "Qualification Category"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Qualification category"));

            trigger OnValidate()
            begin
                if "Qualification Category" = 'EXPERIENCE' then begin
                    "Qualification Code" := 'EXPERIENCE';
                    "Qualification Type" := 'EXPERIENCE';
                end;
            end;
        }
        field(50013; "Field of Reasearch"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "No. Of Authors"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Complete; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Need code", "Job Id", "Qualification Type", "Qualification Code", "Qualification Category")
        {
            Clustered = true;
            SumIndexFields = Score;
        }
    }

    fieldgroups
    {
    }

    var
        AcademicClassification: Record "Academic Classification";
        HREmployeeRequisitions: Record "HR Employee Requisitions";
        HRRecruitmentCourses: Record "HR Recruitment Courses";
}
