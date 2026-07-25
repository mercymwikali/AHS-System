Table 85557 "Audit Findings Actions"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[80])
        {
        }
        field(50001; "Finding Code"; Code[50])
        {
        }
        field(50002; "Action Classification"; Option)
        {
            OptionCaption = ',Preventive Action,Corrective Action';
            OptionMembers = ,"Preventive Action","Corrective Action";
        }
        field(50003; "Review Area"; Text[250])
        {
        }
        field(50004; "Requirement Desc 1"; Text[250])
        {
        }
        field(50005; "Requirement Desc 2"; Text[250])
        {
        }
        field(50006; "Evidence Desc 1"; Text[250])
        {
        }
        field(50007; "Evidence Desc 2"; Text[250])
        {
        }
        field(50008; "Evidence Desc 3"; Text[250])
        {
        }
        field(50009; "Root Cause"; Text[250])
        {
        }
        field(50010; "Correction Desc 1"; Text[250])
        {
        }
        field(50011; "Correction Desc 2"; Text[250])
        {
        }
        field(50012; "Correction Desc 3"; Text[250])
        {
        }
        field(50013; "Correction Desc 4"; Text[250])
        {
        }
        field(50014; "Recurrence action 1"; Text[250])
        {
        }
        field(50015; "Recurrence action 2"; Text[250])
        {
        }
        field(50016; "Completion Date"; Date)
        {
        }
        field(50017; "Action Appropriate?"; Boolean)
        {
        }
        field(50018; "Follow Up Action"; Text[250])
        {
        }
        field(50019; "Follow Up Status"; Option)
        {
            OptionCaption = ',Open,Closed';
            OptionMembers = ,Open,Closed;
        }
        field(50020; "Action Effective?"; Boolean)
        {
        }
        field(50021; "Effectiveness Desc"; Text[250])
        {
        }
        field(50022; "Effectiveness Status"; Boolean)
        {
        }
        field(50023; "Finding Classification"; Option)
        {
            OptionMembers = ,New;
        }
    }

    keys
    {
        key(Key1; "Code", "Finding Code")
        {
            Clustered = true;
        }
        key(Key2; "Finding Code")
        {
        }
    }

    fieldgroups
    {
    }
}
