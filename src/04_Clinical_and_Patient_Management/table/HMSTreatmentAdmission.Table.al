Table 85261 "HMS Treatment Admission"
{
    fields
    {
        field(50000; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Ward No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Ward Setup"."Ward Code";
        }
        field(50002; "Bed No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Beds"."Bed No" where("Ward No" = field("Ward No."), "Room No" = field("Ward Room"));
        }
        field(50003; "Date Of Admission"; Date)
        {
        }
        field(50004; "Admission Reason"; Code[250])
        {
        }
        field(50005; "Admission Remarks"; Text[250])
        {
        }
        field(50006; Status; Option)
        {
            CalcFormula = lookup("HMS Admission Form Header".Status where("Link Type" = const('DOCTOR'),
                                                                           "Link No." = field("Treatment No.")));
            FieldClass = FlowField;
            OptionMembers = New,Admitted,Discharged,Cancelled,"Discharge Pending";
        }
        field(50007; "Past Medical History"; Text[250])
        {
        }
        field(50008; "Past Surgical History"; Text[250])
        {
        }
        field(50009; "Social History"; Text[250])
        {
        }
        field(50010; "Reviews of systems"; Text[250])
        {
        }
        field(50011; Investigations; Text[250])
        {
        }
        field(50012; "Assessment and plan"; Text[250])
        {
        }
        field(50013; "Global Dimension 1 Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
        field(50014; "Ward Room"; Code[30])
        {
            TableRelation = "HMS Ward Rooms"."Room No." where("Ward No" = field("Ward No."));
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Ward No.", "Bed No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
