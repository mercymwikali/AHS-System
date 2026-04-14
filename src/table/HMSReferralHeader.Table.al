Table 85234 "HMS Referral Header"
{
    // LookupPageID = "WF Sport Designation List";

    fields
    {
        field(50000; "Treatment no."; Code[20])
        {
        }
        field(50001; "Hospital No."; Code[50])
        {
        }
        field(50002; "Patient No."; Code[20])
        {
        }
        field(50003; "Date Referred"; Date)
        {
        }
        field(50004; "Referral Reason"; Code[30])
        {
        }
        field(50005; "Referral Remarks"; Text[250])
        {
        }
        field(50006; Status; Option)
        {
            OptionMembers = New,Referred,Released;
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
        field(50015; Diagnosis; Text[200])
        {
            TableRelation = "HMS Setup Diagnosis".Code;
        }
        field(50016; "Student No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Student No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50017; "ADM No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Current Adm No" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(50018; "Hospital Name"; Text[100])
        {
        }
        field(50019; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50020; "Brief History"; Text[1000])
        {

        }
        field(50021; "Investigation Done"; Text[1000])
        {

        }
        field(50022; "Treatment"; Text[1000])
        {

        }
        field(50023; "Case Urgency"; Option)
        {
            OptionCaption = 'Emergency,Urgent,Normal';
            OptionMembers = Emergency,Urgent,Normal;
        }

    }

    keys
    {
        key(Key1; "Treatment no.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
