Table 85570 Risks
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; Department; Code[20])
        {
        }
        field(50002; "Risk Desc 1"; Text[250])
        {
        }
        field(50003; "Risk Desc 2"; Text[250])
        {
        }
        field(50004; "Risk Desc 3"; Text[250])
        {
        }
        field(50005; "Risk Desc 4"; Text[250])
        {
        }
        field(50006; "Indicator Desc 1"; Text[250])
        {
        }
        field(50007; "Indicator Desc 2"; Text[250])
        {
        }
        field(50008; Environment; Option)
        {
            OptionCaption = ',Economic';
            OptionMembers = ,Economic;
        }
        field(50009; Impact; Integer)
        {
        }
        field(50010; Likelihood; Integer)
        {
        }
        field(50011; Level; Integer)
        {
        }
        field(50012; "Date Created"; Date)
        {
        }
        field(50013; "Created By"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
