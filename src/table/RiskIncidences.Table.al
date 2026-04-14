Table 85568 "Risk Incidences"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; "Risk Code"; Code[20])
        {
        }
        field(50002; "Incidence Desc 1"; Text[250])
        {
        }
        field(50003; "Incidence Desc 2"; Text[250])
        {
        }
        field(50004; "Incidence Desc 3"; Text[250])
        {
        }
        field(50005; "Incidence Desc 4"; Text[250])
        {
        }
        field(50006; "Date Created"; Date)
        {
        }
        field(50007; "Created By"; Code[20])
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
