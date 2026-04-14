Table 85170 "HMS Admission Discharge Line"
{
    fields
    {
        field(50000; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Process Code"; Code[20])
        {
            TableRelation = "HMS Setup Discharge Processes".Code;
        }
        field(50002; Description; Text[100])
        {
            CalcFormula = lookup("HMS Setup Discharge Processes".Description where(Code = field("Process Code")));
            FieldClass = FlowField;
        }
        field(50003; Mandatory; Boolean)
        {
            CalcFormula = lookup("HMS Setup Discharge Processes".Mandatory where(Code = field("Process Code")));
            FieldClass = FlowField;
        }
        field(50004; Done; Boolean)
        {
        }
        field(50005; Date; Date)
        {
        }
        field(50006; Time; Time)
        {
        }
        field(50007; "User ID"; Code[20])
        {
            TableRelation = User."User Name";
        }
        field(50008; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Admission No.", "Process Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
