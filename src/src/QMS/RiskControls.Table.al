Table 52202929 "Risk Controls"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Risk Code"; Text[250])
        {
        }
        field(3; "Control Desc 1"; Text[250])
        {
        }
        field(4; "Control Desc 2"; Text[250])
        {
        }
        field(5; "Control Desc 3"; Text[250])
        {
        }
        field(6; "Control Desc 4"; Text[250])
        {
        }
        field(7; "Date Created"; Date)
        {
        }
        field(8; "Created By"; Code[20])
        {
        }
        field(9; "Date Edited"; Date)
        {
        }
        field(10; "Edited By"; Code[20])
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
