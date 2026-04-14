Table 85198 "HMS Immunization"
{
    fields
    {
        field(50000; "No."; Integer)
        {
            AutoIncrement = true;
            NotBlank = false;
        }
        field(50001; "Immunization Date"; Date)
        {
            NotBlank = true;
        }
        field(50002; "Immunization Time"; Time)
        {
            NotBlank = true;
        }
        field(50003; "Patient No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Patient"."Patient No." where("Patient Type" = field("Patient Type"));
        }
        field(50004; "Patient Type"; Option)
        {
            NotBlank = true;
            OptionMembers = Others,Student,Employee,Relative;
        }
        field(50005; "Patient Name"; Text[150])
        {
            FieldClass = Normal;
        }
        field(50006; "Immunization No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Immunization.Code;
        }
        field(50007; "Immunization Name"; Text[100])
        {
            CalcFormula = lookup(Immunization.Description where(Code = field("Immunization No.")));
            FieldClass = FlowField;
        }
        field(50008; Given; Boolean)
        {
        }
        field(50009; Remarks; Text[200])
        {
        }
        field(50010; Posted; Boolean)
        {
        }
        field(50011; Select; Boolean)
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
