Table 85495 "HR Lookup Values"
{
    DrillDownPageID = "HR Lookup Values List";
    LookupPageID = "HR Lookup Values List";

    fields
    {
        field(50000; Type; Option)
        {
            OptionCaption = 'Religion,Language,Medical Scheme,Location,Contract Type,Qualification Type,Stages,Scores,Institution,Appraisal Type,Appraisal Period,Urgency,Succession,Security,Disciplinary Case Rating,Disciplinary Case,Disciplinary Action,Next of Kin,County,Grade,Checklist Item,Appraisal Sub Category,Appraisal Group Item,Transport Type,Training Cost Items,Training Category,Dependant,CompetenceValues,ShortListing Criteria,Qualification category,Sub Tribe,Appointments,Course,EXPERIENCE';
            OptionMembers = Religion,Language,"Medical Scheme",Location,"Contract Type","Qualification Type",Stages,Scores,Institution,"Appraisal Type","Appraisal Period",Urgency,Succession,Security,"Disciplinary Case Rating","Disciplinary Case","Disciplinary Action","Next of Kin",County,Grade,"Checklist Item","Appraisal Sub Category","Appraisal Group Item","Transport Type","Training Cost Items","Training Category",Dependant,CompetenceValues,"ShortListing Criteria","Qualification category","Sub Tribe",Appointments,Course,EXPERIENCE;
        }
        field(50001; "Code"; Code[70])
        {
            trigger OnValidate()
            begin
                if Type = Type::"Qualification Type" then
                    category := code;
                if Type = Type::"Qualification category" then
                    "Sub Category" := code;
            end;
        }
        field(50002; Description; Text[50])
        {
        }
        field(50003; Remarks; Text[250])
        {
        }
        field(50004; "Notice Period"; Date)
        {
        }
        field(50005; Closed; Boolean)
        {
        }
        field(50006; "Contract Length"; Integer)
        {
        }
        field(50007; "Current Appraisal Period"; Boolean)
        {
        }
        field(50008; "Disciplinary Case Rating"; Text[30])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Disciplinary Case Rating"));
        }
        field(50009; "Disciplinary Action"; Code[20])
        {
            TableRelation = "HR Lookup Values".Code where(Type = const("Disciplinary Action"));
        }
        field(50010; From; Date)
        {
        }
        field(50011; "To"; Date)
        {
        }
        field(50012; Score; Decimal)
        {
        }
        field(50013; "Basic Salary"; Decimal)
        {
        }
        field(50014; "To be cleared by"; Code[20])
        {
            TableRelation = "HR Jobs"."Job ID";
        }
        field(50015; "Weight Scores"; Decimal)
        {
        }
        field(50016; "Job Scale"; Code[20])
        {
        }
        field(50017; "Next Period"; Boolean)
        {
        }
        field(50018; "Previous Job Position"; Boolean)
        {
        }
        field(50019; "Previous Job Position Order"; Integer)
        {
        }
        field(50020; "Category"; Code[70])
        {
        }
        field(50021; "Sub Category"; Code[70])
        {
        }
    }

    keys
    {
        key(Key1; Type, "Code", Category, "Sub Category")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
    }
}
