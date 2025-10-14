Table 52202932 "Risk Incidences"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Risk Code"; Code[20])
        {
        }
        field(3; "Incidence Desc 1"; Text[250])
        {
        }
        field(4; "Incidence Desc 2"; Text[250])
        {
        }
        field(5; "Incidence Desc 3"; Text[250])
        {
        }
        field(6; "Incidence Desc 4"; Text[250])
        {
        }
        field(7; "Date Created"; Date)
        {
        }
        field(8; "Created By"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Risk Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
