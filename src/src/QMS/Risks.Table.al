Table 52202928 Risks
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Department; Code[20])
        {
        }
        field(3; "Risk Desc 1"; Text[250])
        {
        }
        field(4; "Risk Desc 2"; Text[250])
        {
        }
        field(5; "Risk Desc 3"; Text[250])
        {
        }
        field(6; "Risk Desc 4"; Text[250])
        {
        }
        field(7; "Indicator Desc 1"; Text[250])
        {
        }
        field(8; "Indicator Desc 2"; Text[250])
        {
        }
        field(9; Environment; Option)
        {
            OptionCaption = ',Economic';
            OptionMembers = ,Economic;
        }
        field(10; Impact; Integer)
        {
        }
        field(11; Likelihood; Integer)
        {
        }
        field(12; Level; Integer)
        {
        }
        field(13; "Date Created"; Date)
        {
        }
        field(14; "Created By"; Code[20])
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
