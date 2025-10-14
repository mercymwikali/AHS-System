table 52202734 "HR Applicant Qualifications"
{
    Caption = 'HR Applicant Qualifications';
    DataCaptionFields = "Employee No.";

    fields
    {
        field(1; "Application No"; Code[30])
        {
            Caption = 'Application No';
            TableRelation = applicants."Application No";
        }
        field(2; "Employee No."; Code[30])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = "HR-Employee"."No.";
        }
        field(3; "Qualification Description"; Code[100])
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
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';

            trigger OnValidate()
            begin
                // IF ("To Date"<>0D) AND ("From Date"<>0D) THEN BEGIN
                //  Experience:=ROUND (("To Date"-"From Date")/365);
                // END;
            end;
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ",Internal,External,"Previous Position";
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Institution/Company"; Text[100])
        {
            Caption = 'Institution/Company';
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
        }
        field(10; "Course Grade"; Text[100])
        {
            Caption = 'Course Grade';
        }
        field(11; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        field(15; "Qualification Code"; Text[200])
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
        field(16; "Score ID"; Decimal)
        {
            Caption = 'Score';
        }
        field(17; "Desired Score"; Decimal)
        {
        }
        field(18; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(19; "User Name"; Code[30])
        {
        }
        field(20; "Email Address"; text[30])
        {
        }
        field(21; Experience; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Qualification; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Lookup Values".code where(Type = filter("Qualification Type"));
        }
        field(23; "Course Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Qualifications".code where("Qualification Type" = field(Qualification));
        }
        field(24; Classification; Text[50])
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
        field(25; "Document Link"; Text[200])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
        field(26; "Membership No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(27; QualificationType; Option)
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
