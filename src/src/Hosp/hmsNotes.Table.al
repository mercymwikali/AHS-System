table 52202936 "HMS Notes"
{

    fields
    {
        field(1; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(2; TreatmentNo; Code[20])
        {
            TableRelation = "HMS Treatment Form Header"."Treatment No.";
        }
        field(3; "Patient No"; Code[20])
        {
            trigger OnValidate()
            var
                hmsPatient: Record "HMS Patient";
            begin
                hmsPatient.Reset();
                hmsPatient.SetRange("Patient No.", "Patient No");
                if hmsPatient.FindFirst() then
                    if hmsPatient.Inpatient then 
                        "Admission No." := hmsPatient."Current Adm No";
            end;

        }
        field(4; "Patient Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Treatment Date"; Date)
        {
        }
        field(6; "Treatment Time"; Time)
        {
        }
        field(7; Notes; Text[2048])
        {

        }
        field(8; "Notes Type"; Enum "Doctor Notes Types")
        {
        }
        field(9; "User ID"; Code[30])
        {
        }
        field(10; "Created Date"; Date)
        {
        }
        field(11; Clinic; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Clinics Setup".No;
        }
        field(12; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Creation DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Admission No."; Code[20])
        { // If Consultation is done on an inpatient, this field will be populated
            DataClassification = ToBeClassified;
            TableRelation = "HMS Admission Form Header"."Admission No.";
        }
        field(15; "Notes Section ID"; Code[30])
        {
            TableRelation = "Form Sections"."Section ID";

        }
        field(16; "Notes Section Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Form Sections"."Section Name" where("Section ID" = field("Notes Section ID")));
        }   
        field(17; "Encounter Notes"; Blob)
        {
            
        }
    }

    keys
    {
        key(Key1; LineNo, TreatmentNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var
        HMSPatient: Record "HMS Patient";
        HMSTreatmentFormHeader: Record "HMS Treatment Form Header";

    trigger OnInsert()
    begin
        if TreatmentNo <> '' then begin
            if HMSTreatmentFormHeader.Get(TreatmentNo) then
                "Patient No" := HMSTreatmentFormHeader."Patient No.";
            "Treatment Date" := HMSTreatmentFormHeader."Treatment Date";
            "Treatment Time" := HMSTreatmentFormHeader."Treatment Time";

            if HMSPatient.Get(HMSTreatmentFormHeader."Patient No.") then begin
                "Patient Name" := HMSPatient."Search Name";
                if HMSPatient.Inpatient then
                    "Admission No." := HMSPatient."Current Adm No";
            end;
        end;
    end;
}
