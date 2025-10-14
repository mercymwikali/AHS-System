table 52202985 "Nurse Order Sheet"
{
    Caption = 'Nurse Order Sheet';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(2; "Admission No"; Code[20])
        {
            Caption = 'Admission No';
            trigger OnValidate()
            var
                HMSAdmissionFormHeader: Record "HMS Admission Form Header";
            begin
                if "Admission No" <> '' then
                    if HMSAdmissionFormHeader.Get("Admission No") then begin
                        "Patient No" := HMSAdmissionFormHeader."Patient No.";
                        "Patient Name" := HMSAdmissionFormHeader."Patient Name";
                    end;
            end;
        }
        field(3; "Patient No"; Code[30])
        {
            Caption = 'Patient No';
        }
        field(4; "Patient Name"; Text[100])
        {
            Caption = 'Patient Name';
        }
        field(5; "Drug No"; Code[20])
        {
            Caption = 'Drug No';
            TableRelation = Item."No." where("Inventory Posting Group" = filter('Drugs'));
        }
        field(6; "Drug Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Drug No")));
        }
        field(7; Route; Option)
        {
            Caption = 'Route';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Route where("No." = field("Drug No")));
            OptionMembers = Oral,IV,Rectal,Vaginal,Subcutaneuos,Nasal,Intrathical,Intradermal,Intramuscular,"I.M",Topical;
        }
        field(8; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(9; "Requesting Nurse"; Code[30])
        {
            Caption = 'Requesting Nurse';
        }
        field(10; Dosage; Text[50])
        {
            Caption = 'Dosage';
        }
        field(11; Posted; Boolean)
        {
        }
        field(12; "Prescription Dose"; Enum PrescriptionDoseEnum)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Quantity; Decimal)
        {
            
        }
    }
    keys
    {
        key(PK; "Line No.", "Admission No", "Drug No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "Request Date" = 0D then
            "Request Date" := Today;
    end;
}
