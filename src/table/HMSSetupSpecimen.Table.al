Table 85320 "HMS Setup Specimen"
{
    LookupPageID = "HMS Setup Specimen List";

    fields
    {
        field(50000; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Description; Text[30])
        {
            NotBlank = true;
        }
        field(50002; "Normal Ranges"; Text[100])
        {
        }
        field(50003; Units; Code[20])
        {
        }
        field(50004; "Desirable level"; Text[200])
        {
        }
        field(50005; "High Risk"; Text[200])
        {
        }
        field(50006; "Min Range"; Decimal)
        {
        }
        field(50007; "Max Range"; Decimal)
        {
        }
        field(50008; "Result Type"; Enum "Lab Result Types")
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
