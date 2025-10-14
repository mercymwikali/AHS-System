Table 52202722 "HR Stage Requirements"
{
    fields
    {
        field(1; "Job Id"; Code[50])
        {
            NotBlank = true;
            TableRelation = "HR Jobs"."Job ID";
        }
        field(2; "Qualification Type"; Code[20])
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
        field(3; "Qualification Code"; Code[30])
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
        field(6; Priority; Option)
        {
            OptionMembers = " ",High,Medium,Low;
        }
        field(8; Score; Decimal)
        {
        }
        field(9; "Need code"; Code[10])
        {
            trigger OnValidate()
            begin
                HREmployeeRequisitions.Reset();
                HREmployeeRequisitions.SetRange("Requisition No.", "Need code");
                if HREmployeeRequisitions.Find('-') then
                    "Job Id" := HREmployeeRequisitions."Job ID";
            end;
        }
        field(10; "Stage Code"; Code[10])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const(Scores));
        }
        field(11; Mandatory; Boolean)
        {
        }
        field(12; "Desired Score"; Decimal)
        {
        }
        field(13; "Total (Stage)Desired Score"; Decimal)
        {
        }
        field(14; "Qualification Description"; Text[100])
        {
        }
        field(15; "Grade Attained"; Code[30])
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
        field(16; "Qualification Category"; Code[30])
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
        field(17; "Field of Reasearch"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "No. Of Authors"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Complete; Boolean)
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
