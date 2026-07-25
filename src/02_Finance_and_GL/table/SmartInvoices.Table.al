table 85575 "Smart Invoices"
{
    fields
    {
        field(50000; EntryNo; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50001; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Patient No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Smart Invoices"."Line Amount" where("Document No" = field("Document No"), "Patient No" = field("Patient No"), Posted = filter('No')));
            FieldClass = FlowField;
        }
        field(50004; "Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Invoice Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; Stage; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Diagnosis Code Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Diagnosis Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Encounter Type"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Code Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Code Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Total Services"; Integer)
        {
            CalcFormula = Count("Smart Invoices" WHERE("Document No" = FIELD("Document No"),
                                                        "Patient No" = FIELD("Patient No"),
                                                        "Posted" = FILTER('No')));
            FieldClass = FlowField;
        }
        field(50017; "Membership No"; Code[70])
        {
            CalcFormula = Lookup("Smart Benefits"."Membership No" WHERE("Patient No" = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(50018; "Membership Plan"; Code[70])
        {
            CalcFormula = Lookup("Smart Benefits"."Membership Plan" WHERE("Patient No" = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(50019; "Membership Code"; Code[70])
        {
            CalcFormula = Lookup("Smart Benefits"."Membership Code" WHERE("Patient No" = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(50020; "Global ID"; Code[100])
        {
            CalcFormula = Lookup("Smart Benefits"."Global ID" WHERE("Patient No" = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(50021; "First Name"; Text[70])
        {
            CalcFormula = Lookup("HMS Patient".Surname WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(50022; "Middle Name"; Text[70])
        {
            CalcFormula = Lookup("HMS Patient"."Middle Name" WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(50023; "Last Name"; Text[70])
        {
            CalcFormula = Lookup("HMS Patient"."Last Name" WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(50024; Gender; Option)
        {
            CalcFormula = Lookup("HMS Patient".Gender WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(50025; DoB; Date)
        {
            CalcFormula = Lookup("HMS Patient"."Date Of Birth" WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(50026; "Pool ID"; Code[10])
        {
            CalcFormula = Lookup("Smart Benefits"."Pool No" WHERE("Patient No" = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(50027; Principal; Boolean)
        {
            CalcFormula = Lookup("HMS Patient".Principal WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
