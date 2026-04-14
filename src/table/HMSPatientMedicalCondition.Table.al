Table 85216 "HMS Patient Medical Condition"
{
    fields
    {
        field(50000; "Patient No."; Code[20])
        {
        }
        field(50001; "Medical Condition"; Code[20])
        {
            TableRelation = "Medical Condition".Code;
        }
        field(50002; "Medical Condition Name"; Text[100])
        {
            CalcFormula = lookup("Medical Condition".Description where(Code = field("Medical Condition")));
            FieldClass = FlowField;
        }
        field(50003; "Date From"; Date)
        {
        }
        field(50004; "Date To"; Date)
        {
        }
        field(50005; Yes; Boolean)
        {
        }
        field(50006; Details; Text[200])
        {
        }
        field(50007; Surname; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50008; "Middle Name"; Text[30])
        {
            CalcFormula = lookup("HMS Patient"."Middle Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50009; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50010; "ID Number"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."ID Number" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50011; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Correspondence Address 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50012; "Telephone No. 1"; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50013; Email; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Email where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50014; "Patient Ref. No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Patient Ref. No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Patient No.", "Medical Condition")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
