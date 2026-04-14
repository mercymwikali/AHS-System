table 85307 "Nurse Order Sheet"
{
    Caption = 'Nurse Order Sheet';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No."; Integer)
        {
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(50001; "Admission No"; Code[20])
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
        field(50002; "Patient No"; Code[30])
        {
            Caption = 'Patient No';
        }
        field(50003; "Patient Name"; Text[100])
        {
            Caption = 'Patient Name';
        }
        field(50004; "Drug No"; Code[20])
        {
            Caption = 'Drug No';
            TableRelation = Item."No." where("Inventory Posting Group" = filter('Drugs'));
        }
        field(50005; "Drug Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Drug No")));
        }
        field(50006; Route; Option)
        {
            Caption = 'Route';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Route where("No." = field("Drug No")));
            OptionMembers = Oral,IV,Rectal,Vaginal,Subcutaneuos,Nasal,Intrathical,Intradermal,Intramuscular,"I.M",Topical;
        }
        field(50007; "Request Date"; Date)
        {
            Caption = 'Request Date';
        }
        field(50008; "Requesting Nurse"; Code[30])
        {
            Caption = 'Requesting Nurse';
        }
        field(50009; Dosage; Text[50])
        {
            Caption = 'Dosage';
        }
        field(50010; Posted; Boolean)
        {
        }
        field(50011; "Prescription Dose"; Enum PrescriptionDoseEnum)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; Quantity; Decimal)
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
