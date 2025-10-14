table 52202694 "Smart Invoices"
{
    fields
    {
        field(1; EntryNo; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Patient No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Total Amount"; Decimal)
        {
            CalcFormula = sum("Smart Invoices"."Line Amount" where("Document No" = field("Document No"), "Patient No" = field("Patient No"), Posted = filter('No')));
            FieldClass = FlowField;
        }
        field(5; "Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Invoice Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Stage; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Diagnosis Code Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Diagnosis Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Encounter Type"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Code Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Code Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Quantity; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Total Services"; Integer)
        {
            CalcFormula = Count("Smart Invoices" WHERE("Document No" = FIELD("Document No"),
                                                        "Patient No" = FIELD("Patient No"),
                                                        "Posted" = FILTER('No')));
            FieldClass = FlowField;
        }
        field(18; "Membership No"; Code[70])
        {
            CalcFormula = Lookup("Smart Benefits"."Membership No" WHERE("Patient No" = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(19; "Membership Plan"; Code[70])
        {
            CalcFormula = Lookup("Smart Benefits"."Membership Plan" WHERE("Patient No" = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(20; "Membership Code"; Code[70])
        {
            CalcFormula = Lookup("Smart Benefits"."Membership Code" WHERE("Patient No" = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(21; "Global ID"; Code[100])
        {
            CalcFormula = Lookup("Smart Benefits"."Global ID" WHERE("Patient No" = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(22; "First Name"; Text[70])
        {
            CalcFormula = Lookup("HMS Patient".Surname WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(23; "Middle Name"; Text[70])
        {
            CalcFormula = Lookup("HMS Patient"."Middle Name" WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(24; "Last Name"; Text[70])
        {
            CalcFormula = Lookup("HMS Patient"."Last Name" WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(25; Gender; Option)
        {
            CalcFormula = Lookup("HMS Patient".Gender WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(26; DoB; Date)
        {
            CalcFormula = Lookup("HMS Patient"."Date Of Birth" WHERE("Patient No." = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(27; "Pool ID"; Code[10])
        {
            CalcFormula = Lookup("Smart Benefits"."Pool No" WHERE("Patient No" = FIELD("Patient No")));
            FieldClass = FlowField;
        }
        field(28; Principal; Boolean)
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
