table 85200 "HMS Notes"
{

    fields
    {
        field(50000; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(50001; TreatmentNo; Code[20])
        {
            TableRelation = "HMS Treatment Form Header"."Treatment No.";
        }
        field(50002; "Patient No"; Code[20])
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
        field(50003; "Patient Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Treatment Date"; Date)
        {
        }
        field(50005; "Treatment Time"; Time)
        {
        }
        field(50006; Notes; Text[2048])
        {

        }
        field(50007; "Notes Type"; Enum "Doctor Notes Types")
        {
        }
        field(50008; "User ID"; Code[30])
        {
        }
        field(50009; "Created Date"; Date)
        {
        }
        field(50010; Clinic; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMS Clinics Setup".No;
        }
        field(50011; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Creation DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Admission No."; Code[20])
        { // If Consultation is done on an inpatient, this field will be populated
            DataClassification = ToBeClassified;
            TableRelation = "HMS Admission Form Header"."Admission No.";
        }
        field(50014; "Notes Section ID"; Code[30])
        {
            TableRelation = "Form Sections"."Section ID";

        }
        field(50015; "Notes Section Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Form Sections"."Section Name" where("Section ID" = field("Notes Section ID")));
        }   
        field(50016; "Encounter Notes"; Blob)
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
