Table 85395 "HR Appraisal Evaluation Areas"
{
    // LookupPageID = "Posted Interbank Transfers UP";

    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Description; Text[200])
        {
        }
        field(50002; "Include in Evaluation Form"; Boolean)
        {
        }
        field(50003; "Objective Type"; Option)
        {
            OptionMembers = Quantitative,Qualitative;
        }
        field(50004; "Categorize As"; Option)
        {
            OptionMembers = "JOB SPECIFIC EVALUATION AREA","EMPLOYEE PERFORMANCE FACTOR";
        }
        field(50005; "Assign To"; Code[20])
        {
            TableRelation = "HR Jobs"."Job ID";
        }
        field(50006; "Sub Category"; Code[50])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Appraisal Sub Category"));
        }
        field(50007; Group; Code[40])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Appraisal Group Item"));
        }
        field(50008; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Line No", "Categorize As", "Code", "Sub Category", Group)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
