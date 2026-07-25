Table 85398 "HR Appraisal Objectives"
{
    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Document No"; Code[30])
        {
        }
        field(50002; Objective; Text[250])
        {
        }
        field(50003; "Key Performance Indicator"; Text[250])
        {
        }
        field(50004; Targets; Text[250])
        {
        }
        field(50005; "Max Weight"; Decimal)
        {
        }
        field(50006; Achievements; Text[200])
        {
        }
        field(50007; Ratings; Decimal)
        {
        }
        field(50008; "Appraisal Period"; Code[30])
        {
        }
        field(50009; Section; Option)
        {
            OptionCaption = ',Strategic Objectives,Performance Improvement Plan,Learning and Development,Notes and Validation,Mid Year,Core Values,End Year,Quarter2';
            OptionMembers = ,"Strategic Objectives","Performance Improvement Plan","Learning and Development","Notes and Validation","Mid Year","Core Values","End Year",Quarter2;
        }
        field(50010; "Staff No"; Code[30])
        {
        }
        field(50011; "User ID"; Code[50])
        {
        }
        field(50012; "Last Modified By"; Code[30])
        {
        }
        field(50013; Deliverables; Text[200])
        {
        }
        field(50014; "Time Lines"; Option)
        {
            OptionCaption = ',Q1,Q2,Q3,Q4';
            OptionMembers = ,Q1,Q2,Q3,Q4;
        }
        field(50015; "Notes By Appraisee"; Text[250])
        {
        }
        field(50016; "Notes By Appraiser"; Text[250])
        {
        }
        field(50017; "Notes By HOD"; Text[250])
        {
        }
        field(50018; "Approval Comment Line"; Text[250])
        {
        }
        field(50019; "Supervisor Rating"; Decimal)
        {
        }
        field(50020; "HOD Rating"; Decimal)
        {
        }
        field(50021; "Is stratigic objective"; Boolean)
        {
        }
        field(50022; "Objective Number"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Document No", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
