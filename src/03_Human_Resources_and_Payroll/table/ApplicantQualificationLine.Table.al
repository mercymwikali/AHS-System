Table 85358 "Applicant Qualification Line"
{
    //  Job ID,Requirements

    fields
    {
        field(50000; "Entry No"; Integer)
        {
        }
        field(50001; "Applicant ID"; Code[20])
        {
        }
        field(50002; "Qualification code"; Code[20])
        {
            TableRelation = "HR Qualifications".Code where("Qualification Type" = field("Qualification Type"));

            trigger OnValidate()
            begin
                /*JobRq.SETRANGE(JobRq."Job Specification","Qualification code");
                JobRq.SETRANGE(JobRq."Qualification Type","Job ID");
                IF JobRq.FIND('-') THEN
                "Qualification Description":=JobRq."Qualification Code";
                Creteria.SETCURRENTKEY("Job ID",Requirements);
                Creteria.SETRANGE("Job ID","Job ID");
                Creteria.SETRANGE(Creteria.Requirements,"Qualification code");
                IF Creteria.FIND('-') THEN
                 IF Desiredscore.GET(Creteria.Score) THEN
                 "Desired Score" :=Desiredscore.Score;
               */
                if HRQualifications.Get("Qualification Type", "Qualification code") then
                    "Qualification Description" := HRQualifications.Description;
            end;
        }
        field(50003; "Qualification Description"; Text[250])
        {
        }
        field(50004; "Job ID"; Code[20])
        {
            TableRelation = "Company Jobs";

            trigger OnValidate()
            begin
                if Qualification.Get("Qualification code") then
                    "Qualification Description" := Qualification.Description;
            end;
        }
        field(50005; Qualified; Boolean)
        {
        }
        field(50006; "From Date"; Date)
        {
        }
        field(50007; "To Date"; Date)
        {
        }
        field(50008; Institution; Text[200])
        {
        }
        field(50009; "Qualification Type"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter("Qualification Type"));
        }
        field(50010; "No of Years"; Decimal)
        {
        }
        field(50011; "Actual Score"; Code[20])
        {
            // TableRelation = "Score Setup"."Score ID";

            trigger OnValidate()
            begin
                if Desiredscore.Get("Actual Score") then
                    ;
            end;
        }
        field(50012; "Desired Score"; Integer)
        {
        }
        field(50013; ActualScore; Decimal)
        {
        }
        field(50014; "Recruitment Stage"; Integer)
        {
            TableRelation = "Recruitment Stages";
        }
        field(50015; "User ID"; Code[20])
        {
        }
        field(50016; "Membership No"; Text[30])
        {
        }
        field(50017; "Membership Status"; Option)
        {
            OptionMembers = ,Active,Inactive;
        }
        field(50018; "Publication/Research Descripti"; Text[250])
        {
        }
        field(50019; Grade; Code[20])
        {
            TableRelation = "Academic Qua Grades"."Grade Code";
        }
    }

    keys
    {
        key(Key1; "Applicant ID", "Entry No", "Qualification Type", "Qualification code")
        {
            Clustered = true;
            SumIndexFields = ActualScore;
        }
        key(Key2; "User ID")
        {
            SumIndexFields = ActualScore;
        }
    }

    fieldgroups
    {
    }

    var
        HRQualifications: Record "HR Qualifications";
        Qualification: Record Qualification;
        Desiredscore: Record "Score Setup";
}
