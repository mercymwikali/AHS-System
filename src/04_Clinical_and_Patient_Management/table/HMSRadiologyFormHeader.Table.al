Table 85230 "HMS Radiology Form Header"
{
    //LookupPageID = UnknownPage70135170;

    fields
    {
        field(50000; "Radiology No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Radiology Date"; Date)
        {
            NotBlank = true;
        }
        field(50002; "Radiology Time"; Time)
        {
            NotBlank = true;
        }
        field(50003; "Radiology Area"; Option)
        {
            NotBlank = true;
            OptionMembers = Doctor,Admission;
        }
        field(50004; "Patient No."; Code[20])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                objPat.Reset();
                objPat.SetRange(objPat."Patient No.", "Patient No.");
                if objPat.Find('-') then begin
                    Surname := objPat.Surname;
                    "Middle Name" := objPat."Middle Name";
                    "Last Name" := objPat."Last Name";
                    "Search Names" := objPat.Surname + ' ' + objPat."Middle Name" + ' ' + objPat."Last Name";
                end;
            end;
        }
        field(50005; "Student No."; Code[20])
        {
        }
        field(50006; "Employee No."; Code[20])
        {
        }
        field(50007; "Relative No."; Integer)
        {
        }
        field(50008; Status; Option)
        {
            OptionMembers = New,Cancelled,Completed,Forwarded;
        }
        field(50009; "Link No."; Code[20])
        {
        }
        field(50010; "Link Type"; Code[20])
        {
        }
        field(50011; "No. Series"; Code[20])
        {
        }
        field(50012; "Supervisor ID"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50013; Surname; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50014; "Middle Name"; Text[30])
        {
            CalcFormula = lookup("HMS Patient"."Middle Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50015; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50016; "ID Number"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."ID Number" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50017; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Correspondence Address 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50018; "Telephone No. 1"; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50019; Email; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Email where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50020; "Patient Ref. No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Patient Ref. No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50021; "Search Names"; Text[200])
        {
        }
        field(50022; "Doctor ID"; Code[50])
        {
        }
        field(50023; "Treatment No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('BRANCH'));
        }
        field(50025; "Doctor Name"; text[130])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Radiology No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        objPat: Record "HMS Patient";
}
