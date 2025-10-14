Table 52202488 "HMS Theatre Line Process"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Process No."; Code[30])
        {
            NotBlank = true;
            TableRelation = "HMS Theatre Types".Code;
        }
        field(3; "Process Name"; Text[250])
        {
        }
        field(4; "Process Mandatory"; Boolean)
        {
            FieldClass = Normal;
        }
        field(5; "Process Remarks"; Text[250])
        {
        }
        field(6; "Process Result"; Text[30])
        {
        }
        field(7; "Date Taken"; Date)
        {
        }
        field(8; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.", "Process No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
