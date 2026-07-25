Table 85499 "Job_Salary grade/steps"
{
    DrillDownPageId = "Job_Salary grade/steps";
    LookupPageId = "Job_Salary grade/steps";

    fields
    {
        field(50000; Grade; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Employee Category"; Code[30])
        {
            TableRelation = "Employee Categories".Code;
        }
        field(50002; "Salary Grade code"; Code[30])
        {
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(50003; "Grade Level"; Integer)
        {
        }
        field(50004; "House Allowance"; Decimal)
        {
        }
        field(50005; "Leave Allowance"; Decimal)
        {
        }
        field(50006; "Medical Ceilling"; Decimal)
        {
        }
        field(50007; "Annual Leave Days"; Decimal)
        {
        }
        field(50008; "Grade Description"; Text[100])
        {
            CalcFormula = lookup("Salary Grades".Description where("Salary Grade" = field("Salary Grade code")));
            FieldClass = FlowField;
        }
        field(50009; "Basic Salary"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee Category", "Salary Grade code", "Grade Level")
        {
            Clustered = true;
        }
        key(Key2; "Grade Level")
        {
        }
    }

    fieldgroups
    {
    }
}
