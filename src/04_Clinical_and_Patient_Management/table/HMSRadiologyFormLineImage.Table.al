Table 85232 "HMS Radiology Form Line Image"
{
    fields
    {
        field(50000; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; "Radiology No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Radiology Form Header"."Radiology No.";
        }
        field(50002; "Radiology Type Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Radiology Type".Code;
        }
        field(50003; "Radiology Type Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Radiology Type".Description where(Code = field("Radiology Type Code")));
            FieldClass = FlowField;
        }
        field(50004; Image; Blob)
        {
        }
        field(50005; Remarks; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "Radiology No.", "Radiology Type Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
