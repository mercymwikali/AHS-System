Table 85176 "HMS Admission Injection"
{
    fields
    {
        field(50000; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Injection Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Injection".Code;
        }
        field(50002; "Injection Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Injection".Description where(Code = field("Injection Code")));
            FieldClass = FlowField;
        }
        field(50003; Date; Date)
        {
        }
        field(50004; Time; Time)
        {
        }
        field(50005; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Admission No.", "Injection Code", Date, Time)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Date := Today;
        Time := Time;
    end;
}
