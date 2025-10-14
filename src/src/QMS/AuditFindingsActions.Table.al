Table 52202475 "Audit Findings Actions"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[80])
        {
        }
        field(2; "Finding Code"; Code[50])
        {
        }
        field(3; "Action Classification"; Option)
        {
            OptionCaption = ',Preventive Action,Corrective Action';
            OptionMembers = ,"Preventive Action","Corrective Action";
        }
        field(4; "Review Area"; Text[250])
        {
        }
        field(5; "Requirement Desc 1"; Text[250])
        {
        }
        field(6; "Requirement Desc 2"; Text[250])
        {
        }
        field(9; "Evidence Desc 1"; Text[250])
        {
        }
        field(10; "Evidence Desc 2"; Text[250])
        {
        }
        field(11; "Evidence Desc 3"; Text[250])
        {
        }
        field(13; "Root Cause"; Text[250])
        {
        }
        field(14; "Correction Desc 1"; Text[250])
        {
        }
        field(15; "Correction Desc 2"; Text[250])
        {
        }
        field(16; "Correction Desc 3"; Text[250])
        {
        }
        field(17; "Correction Desc 4"; Text[250])
        {
        }
        field(18; "Recurrence action 1"; Text[250])
        {
        }
        field(19; "Recurrence action 2"; Text[250])
        {
        }
        field(22; "Completion Date"; Date)
        {
        }
        field(23; "Action Appropriate?"; Boolean)
        {
        }
        field(24; "Follow Up Action"; Text[250])
        {
        }
        field(25; "Follow Up Status"; Option)
        {
            OptionCaption = ',Open,Closed';
            OptionMembers = ,Open,Closed;
        }
        field(26; "Action Effective?"; Boolean)
        {
        }
        field(27; "Effectiveness Desc"; Text[250])
        {
        }
        field(28; "Effectiveness Status"; Boolean)
        {
        }
        field(29; "Finding Classification"; Option)
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
