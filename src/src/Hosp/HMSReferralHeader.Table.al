Table 52202670 "HMS Referral Header"
{
    // LookupPageID = "WF Sport Designation List";

    fields
    {
        field(1; "Treatment no."; Code[20])
        {
        }
        field(2; "Hospital No."; Code[50])
        {
        }
        field(3; "Patient No."; Code[20])
        {
        }
        field(4; "Date Referred"; Date)
        {
        }
        field(5; "Referral Reason"; Code[30])
        {
        }
        field(6; "Referral Remarks"; Text[250])
        {
        }
        field(7; Status; Option)
        {
            OptionMembers = New,Referred,Released;
        }
        field(27; Surname; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Surname where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(28; "Middle Name"; Text[30])
        {
            CalcFormula = lookup("HMS Patient"."Middle Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(29; "Last Name"; Text[50])
        {
            CalcFormula = lookup("HMS Patient"."Last Name" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(30; "ID Number"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."ID Number" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(31; "Correspondence Address 1"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Correspondence Address 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(32; "Telephone No. 1"; Code[100])
        {
            CalcFormula = lookup("HMS Patient"."Telephone No. 1" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(33; Email; Text[100])
        {
            CalcFormula = lookup("HMS Patient".Email where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(34; "Patient Ref. No."; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Patient Ref. No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(35; Diagnosis; Text[200])
        {
            TableRelation = "HMS Setup Diagnosis".Code;
        }
        field(36; "Student No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Student No." where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(37; "ADM No"; Code[20])
        {
            CalcFormula = lookup("HMS Patient"."Current Adm No" where("Patient No." = field("Patient No.")));
            FieldClass = FlowField;
        }
        field(38; "Hospital Name"; Text[100])
        {
        }
        field(40; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(41; "Brief History"; Text[1000])
        {

        }
        field(42; "Investigation Done"; Text[1000])
        {

        }
        field(43; "Treatment"; Text[1000])
        {

        }
        field(44; "Case Urgency"; Option)
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
