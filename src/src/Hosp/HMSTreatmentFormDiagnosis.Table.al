Table 52202650 "HMS Treatment Form Diagnosis"
{
    fields
    {
        field(1; "Treatment No."; Code[20])
        { // use the same form for admission diagnosis?
            NotBlank = true;
        }
        field(2; "Diagnosis No."; Code[20])
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
        field(3; "Diagnosis Name"; Text[250])
        {

        }
        field(4; Confirmed; Boolean)
        {
        }
        field(5; Remarks; Text[100])
        {
        }
        field(6; "Treatment Date"; Date)
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Treatment Date" where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(7; PatientNoF; Code[20])
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Patient No." where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(8; "Patient No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(10; Age; Integer)
        {
            CalcFormula = lookup("HMS Patient"."Age in Years" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(11; "Patient Name"; Text[100])
        {
            CalcFormula = lookup("HMS Patient"."Search Name" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(12; "Diagnosis Date"; Date)
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Treatment Date" where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(13; Treatment; Text[30])
        {
            TableRelation = "HMS Pharmacy Line"."Drug Name" where("Drug Name" = const(''));
        }
        field(14; "Patient Appointments"; Integer)
        {
        }
        field(15; Doctor; Code[20])
        {
            CalcFormula = lookup("HMS Treatment Form Header"."Doctor ID" where("Treatment No." = field("Treatment No.")));
            FieldClass = FlowField;
        }
        field(16; "Diagnosis Count"; Integer)
        {
            CalcFormula = count("HMS Treatment Form Diagnosis" where("Diagnosis No." = field("Diagnosis No."),
                                                                      "Treatment Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(17; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(18; "Diagnosis Code"; Code[200])
        {
        }
        field(19; Description; Text[250])
        {
        }
        field(20; "Age in Years"; Decimal)
        {
        }
        field(21; "Diagnosis Type"; Option)
        {
            OptionCaption = ',Provisional Diagnosis,Primary Diagnosis,Secondary Diagnosis';
            OptionMembers = ,"Provisional Diagnosis","Primary Diagnosis","Secondary Diagnosis";
        }
        field(22; Ddate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Date OF Birth"; Date)
        {
            CalcFormula = lookup("HMS Patient"."Date Of Birth" where("Patient No." = field("Patient No")));
            FieldClass = FlowField;
        }
        field(24; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(26; "Admission No."; Code[30])
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
