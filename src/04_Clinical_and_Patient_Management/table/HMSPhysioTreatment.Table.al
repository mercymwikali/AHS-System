Table 85226 "HMS Physio Treatment"
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
        }
        field(50002; "Process Name"; Text[30])
        {
        }
        field(50003; "Process Mandatory"; Boolean)
        {
        }
        field(50004; "Process Remarks"; Text[250])
        {
        }
        field(50005; "Process Result"; Text[30])
        {
        }
        field(50006; Diagnosis; Text[250])
        {
        }
        field(50007; Treatment; Text[250])
        {
        }
        field(50008; "Frequency Per week"; Decimal)
        {
        }
        field(50009; Duration; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
