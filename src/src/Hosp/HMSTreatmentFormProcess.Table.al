Table 52202644 "HMS Treatment Form Process"
{
    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; Type; Option)
        {
            OptionCaption = 'Triage,Doctor,Laboratory,Radiology,Theatre,Inpatient,ICU,Physiotherapy';
            OptionMembers = Triage,Doctor,Laboratory,Radiology,Theatre,Inpatient,ICU,Physiotherapy;
        }
        field(3; "Patient No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Patient"."Patient No.";

            trigger OnValidate()
            begin
                HMSPat.Reset();
                HMSPat.SetRange(HMSPat."Patient No.", "Patient No.");
                if HMSPat.Find('-') then
                    "Patient Name" := HMSPat."Search Name";
            end;
        }
        field(4; "Patient Name"; Text[250])
        {
        }
        field(5; Pain; Decimal)
        {
        }
        field(6; "Pulse Rate"; Code[20])
        {
        }
        field(7; "Blood Pressure"; Code[20])
        {
        }
        field(8; Temperature; Decimal)
        {
        }
        field(9; Height; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Height <> 0) and (Weight <> 0) then
                    BMI := Weight / (Height * Height);
            end;
        }
        field(10; Weight; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Height <> 0) and (Weight <> 0) then
                    BMI := Weight / (Height / 100 * Height / 100);
            end;
        }
        field(11; BMI; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; SP02; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; UniqueId; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Date Created"; DateTime)
        {
        }
        field(16; "Date Taken"; Date)
        {
        }
        field(17; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(19; "Respiration Rate"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Line No", "Patient No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        HMSPat: Record "HMS Patient";
}
