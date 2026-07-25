Table 85321 "HMS Setup Test Specimen"
{
    // LookupPageID = "ELECT Candidate List";

    fields
    {
        field(50000; Test; Code[20])
        {
            FieldClass = Normal;
            NotBlank = true;
            TableRelation = "HMS Setup Lab Test".Code;
        }
        field(50001; "Test Name"; Text[30])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field(Test)));
            FieldClass = FlowField;
        }
        field(50002; Specimen; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Specimen".Code;
        }
        field(50003; "Specimen Name"; Text[30])
        {
            CalcFormula = lookup("HMS Setup Specimen".Description where(Code = field(Specimen)));
            FieldClass = FlowField;
        }
        field(50004; "Measuring Unit"; Code[20])
        {
            TableRelation = "HMS Setup Measuring Unit".Code;
        }
        field(50005; "Minimum Value"; Decimal)
        {
        }
        field(50006; "Maximum Value"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Test, Specimen)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
