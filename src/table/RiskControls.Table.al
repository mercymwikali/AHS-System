Table 85567 "Risk Controls"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(50000; "Code"; Code[20])
        {
        }
        field(50001; "Risk Code"; Text[250])
        {
        }
        field(50002; "Control Desc 1"; Text[250])
        {
        }
        field(50003; "Control Desc 2"; Text[250])
        {
        }
        field(50004; "Control Desc 3"; Text[250])
        {
        }
        field(50005; "Control Desc 4"; Text[250])
        {
        }
        field(50006; "Date Created"; Date)
        {
        }
        field(50007; "Created By"; Code[20])
        {
        }
        field(50008; "Date Edited"; Date)
        {
        }
        field(50009; "Edited By"; Code[20])
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
