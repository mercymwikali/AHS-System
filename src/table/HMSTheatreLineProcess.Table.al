Table 85257 "HMS Theatre Line Process"
{
    fields
    {
        field(50000; "No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Process No."; Code[30])
        {
            NotBlank = true;
            TableRelation = "HMS Theatre Types".Code;
        }
        field(50002; "Process Name"; Text[250])
        {
        }
        field(50003; "Process Mandatory"; Boolean)
        {
            FieldClass = Normal;
        }
        field(50004; "Process Remarks"; Text[250])
        {
        }
        field(50005; "Process Result"; Text[30])
        {
        }
        field(50006; "Date Taken"; Date)
        {
        }
        field(50007; "Line No"; Integer)
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
