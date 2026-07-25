Table 85263 "HMS Treatment Form Diagnosis"
{
    fields
    {
        field(50000; "Treatment No."; Code[20])
        { // use the same form for admission diagnosis?
            NotBlank = true;
        }
        field(50001; "Diagnosis No."; Code[20])
        {
            NotBlank = true;
            TableRelation = if ("Diagnosis Type" = filter('Primary Diagnosis')) "HMS Setup Diagnosis".Code
            else if ("Diagnosis Type" = filter('Provisional Diagnosis')) "HMS Setup Diagnosis".Code
            else if ("Diagnosis Type" = filter('Secondary Diagnosis')) "HMS Secondary Diagnosis Setup"."Diagnosis Code";

            trigger OnValidate()
            begin

                if "Diagnosis Type" = "Diagnosis Type"::"Primary Diagnosis" then
                    if Diagnosis.Get("Diagnosis No.") then begin
                        "Diagnosis Code" := Diagnosis.Diagnosis;
                        Description := Diagnosis.Description;
                        "Diagnosis Name" := Diagnosis.Description;
                    end;
                if "Diagnosis Type" = "Diagnosis Type"::"Provisional Diagnosis" then
                    if Diagnosis.Get("Diagnosis No.") then begin
                        "Diagnosis Code" := Diagnosis.Diagnosis;
                        Description := Diagnosis.Description;
                        "Diagnosis Name" := Diagnosis.Description;
                    end;
                if "Diagnosis Type" = "Diagnosis Type"::"Secondary Diagnosis" then
                    if SecondaryDiagnosis.Get("Diagnosis No.") then begin
                        "Diagnosis Code" := SecondaryDiagnosis."Diagnosis Code";
                        Description := SecondaryDiagnosis.Description;
                        "Diagnosis Name" := SecondaryDiagnosis.Description;
                    end;

                HMSPatient.Reset();
                HMSPatient.SetRange(HMSPatient."Patient No.", PatientNoF);
                if HMSPatient.Find('-') then begin
                    Gender := HMSPatient.Gender;
                    "Patient No" := HMSPatient."Patient No.";
                    Gender := HMSPatient.Gender;
                end;
            end;
        }
        field(50002; "Diagnosis Name"; Text[250])
        {

        }
        field(50003; Confirmed; Boolean)
        {
        }
        field(50004; Remarks; Text[100])
        {
        }
        field(50005; "Treatment Date"; Date)
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Treatment Date" where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(50006; PatientNoF; Code[20])
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Patient No." where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(50007; "Patient No"; Code[20])
        {
            DataClassification = ToBeClassified;
            
        }
        field(50008; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(50009; Age; Integer)
        {
            CalcFormula = lookup("HMS Patient"."Age in Years" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(50010; "Patient Name"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(50011; "Diagnosis Date"; Date)
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Treatment Date" where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(50012; Treatment; Text[30])
        {
            TableRelation = "HMS Pharmacy Line"."Drug Name" where("Drug Name" = const(''));
        }
        field(50013; "Patient Appointments"; Integer)
        {
        }
        field(50014; Doctor; Code[20])
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Doctor ID" where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(50015; "Diagnosis Count"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Diagnosis" where("Diagnosis No." = field("Diagnosis No."),
                                                                      "Treatment Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(50016; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50017; "Diagnosis Code"; Code[200])
        {
        }
        field(50018; Description; Text[250])
        {
        }
        field(50019; "Age in Years"; Decimal)
        {
        }
        field(50020; "Diagnosis Type"; Option)
        {
            OptionCaption = ',Provisional Diagnosis,Primary Diagnosis,Secondary Diagnosis';
            OptionMembers = ,"Provisional Diagnosis","Primary Diagnosis","Secondary Diagnosis";
        }
        field(50021; Ddate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Date OF Birth"; Date)
        {
            CalcFormula = lookup("HMS Patient"."Date Of Birth" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(50023; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50024; "Admission No."; Code[30])
        {// Blank if the patient is out patient.
            TableRelation = "HMS Admission Form Header"."Admission No." where("Patient No." = field("Patient No"));
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Diagnosis No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HMSPatient: Record "HMS Patient";
        Diagnosis: Record "HMS Setup Diagnosis";
        SecondaryDiagnosis: Record "HMS Secondary Diagnosis Setup";
}
