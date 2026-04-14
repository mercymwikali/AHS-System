Table 85195 "HMS ICU Line Process"
{
    fields
    {
        field(50000; "No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Process No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS ICU Process".Code;
        }
        field(50002; "Process Name"; Text[30])
        {
            FieldClass = Normal;
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
        field(50007; Test; Text[30])
        {
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
