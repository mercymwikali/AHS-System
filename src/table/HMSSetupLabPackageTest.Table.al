table 85317 "HMS Setup Lab Package Test"
{
    fields
    {
        field(50000; "Lab Package"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Lab Package".Code;
        }
        field(50001; "Package Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Lab Package".Description where(Code = field("Lab Package")));
            FieldClass = FlowField;
        }
        field(50002; Test; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Lab Test".Code;
        }
        field(50003; "Test Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field(Test)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Lab Package", Test)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
