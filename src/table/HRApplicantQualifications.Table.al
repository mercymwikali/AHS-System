table 85391 "HR Applicant Qualifications"
{
    Caption = 'HR Applicant Qualifications';
    DataCaptionFields = "Employee No.";

    fields
    {
        field(50000; "Application No"; Code[30])
        {
            Caption = 'Application No';
            TableRelation = applicants."Application No";
        }
        field(50001; "Employee No."; Code[30])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "HR-Employee"."No.";
        }
        field(50002; "Qualification Description"; Code[100])
        {
            Caption = 'Qualification Description';
            NotBlank = true;

            trigger OnValidate()
            begin

                HRRecruitmentCourses.Reset();
                HRRecruitmentCourses.SetRange(HRRecruitmentCourses."Course Code", Qualification);
                if HRRecruitmentCourses.Find('-') then
                    "Qualification Description" := HRRecruitmentCourses."Course Description";
            end;
        }
        field(50003; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(50004; "To Date"; Date)
        {
            Caption = 'To Date';

            trigger OnValidate()
            begin
                // IF ("To Date"<>0D) AND ("From Date"<>0D) THEN BEGIN
                //  Experience:=ROUND (("To Date"-"From Date")/365);
                // END;
            end;
        }
        field(50005; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(50006; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(50007; "Institution/Company"; Text[100])
        {
            Caption = 'Institution/Company';
        }
        field(50008; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(50009; "Course Grade"; Text[100])
        {
            Caption = 'Course Grade';
        }
        field(50010; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(50011; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(50012; "Qualification Code"; Text[200])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                // IF HRQualifications.GET("Qualification Type","Qualification Code") THEN
                // "Qualification Description":=HRQualifications.Description;
                // IF JobReq.GET(JobReq."Qualification Type",JobReq."Qualification Code")   THEN
                // "Score ID":=JobReq."Desired Score";
            end;
        }
        field(50013; "Score ID"; Decimal)
        {
            Caption = 'Score';
        }
        field(50014; "Desired Score"; Decimal)
        {
        }
        field(50015; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50016; "User Name"; Code[30])
        {
        }
        field(50017; "Email Address"; text[30])
        {
        }
        field(50018; Experience; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; Qualification; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".code where(Type = filter("Qualification Type"));
        }
        field(50020; "Course Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Qualifications".code where("Qualification Type" = field(Qualification));
        }
        field(50021; Classification; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Academic Classification".Classification where(Qualification = field(Qualification));
            trigger OnValidate()
            begin
                AcademicClassification.Reset();
                AcademicClassification.SetRange(Qualification, Qualification);
                AcademicClassification.SetRange(Classification, Classification);
                if AcademicClassification.Find('-') then
                    "Score ID" := AcademicClassification.Score;
            end;
        }
        field(50022; "Document Link"; Text[200])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
        field(50023; "Membership No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; QualificationType; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Academic,Professional,Training';
            OptionMembers = " ",Academic,Professional,Training;
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        AcademicClassification: Record "Academic Classification";
        HRRecruitmentCourses: Record "HR Recruitment Courses";
}
