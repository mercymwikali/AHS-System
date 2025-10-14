Table 52202766 "HR Job Applicants - Appt. Res"
{
    fields
    {
        field(2; "Applicant No"; Code[20])
        {
            Description = 'Stores the admission number of the record in the database';
            TableRelation = "HR Job Applicants - Appt. Line"."Applicants Code";
        }
        field(3; "Interview Code"; Code[80])
        {
            Description = 'Stores the code of the medical condition in the database';
            TableRelation = "HR Stage Requirements"."Qualification Code" where("Stage Code" = field(Stage));

            trigger OnValidate()
            begin
                Intdetails.SetRange(Intdetails."Qualification Code", "Interview Code");
                if Intdetails.Find('-') then
                    "Interview Description" := Intdetails."Qualification Description";
            end;
        }
        field(4; "Interview Description"; Text[250])
        {
            Description = 'Stores the name of the medical condition';

            trigger OnValidate()
            begin

                CalcFields("Interview Description");
            end;
        }
        field(6; Score; Decimal)
        {
            Description = 'Stores when the user was diagnosed';
            MaxValue = 5;
        }
        field(8; "Total Score"; Decimal)
        {
            CalcFormula = sum("HR Job Applicants - Appt. Res".Score where("Applicant No" = field("Applicant No")));
            Editable = false;
            FieldClass = FlowField;
            MaxValue = 19;

            trigger OnValidate()
            begin
                //Cust.CALCFIELDS("Total Score");
                if Cust."Total Score" > 5 then
                    Error('The allowable unaccounted balance of %1 has been exceeded');
            end;
        }
        field(10; Category; Option)
        {
            OptionMembers = "JOB SPECIFIC EVALUATION AREA","EMPLOYEE PERFORMANCE FACTOR";
        }
        field(11; "Sub Category"; Code[100])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Checklist Item"));
        }
        field(12; Group; Code[80])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Appraisal Sub Category"));
        }
        field(14; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(15; comments; Text[250])
        {
        }
        field(16; Interviwer; Code[50])
        {
            TableRelation = "HMS ICU Process";

            trigger OnValidate()
            begin
                Employee.Reset();
                Employee.SetRange(Employee."No.", Interviwer);
                if Employee.Find('-') then
                    "Interviewer Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(17; "Interviewer Name"; Text[100])
        {
        }
        field(18; Stage; Code[10])
        {
            TableRelation = "HR Recruitment Stages".Code;
        }
    }

    keys
    {
        key(Key1; "Applicant No", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "HR-Employee";
        Cust: Record "HR Job Interview";
        Intdetails: Record "HR Stage Requirements";
}
