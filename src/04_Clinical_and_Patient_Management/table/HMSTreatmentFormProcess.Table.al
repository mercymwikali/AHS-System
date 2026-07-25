Table 85268 "HMS Treatment Form Process"
{
    fields
    {
        field(50000; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; Type; Option)
        {
            OptionCaption = 'Triage,Doctor,Laboratory,Radiology,Theatre,Inpatient,ICU,Physiotherapy';
            OptionMembers = Triage,Doctor,Laboratory,Radiology,Theatre,Inpatient,ICU,Physiotherapy;
        }
        field(50002; "Patient No."; Code[20])
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
        field(50003; "Patient Name"; Text[250])
        {
        }
        field(50004; Pain; Decimal)
        {
        }
        field(50005; "Pulse Rate"; Code[20])
        {
        }
        field(50006; "Blood Pressure"; Code[20])
        {
        }
        field(50007; Temperature; Decimal)
        {
        }
        field(50008; Height; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Height <> 0) and (Weight <> 0) then
                    BMI := Weight / (Height * Height);
            end;
        }
        field(50009; Weight; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (Height <> 0) and (Weight <> 0) then
                    BMI := Weight / (Height / 100 * Height / 100);
            end;
        }
        field(50010; BMI; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; SP02; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; UniqueId; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Date Created"; DateTime)
        {
        }
        field(50014; "Date Taken"; Date)
        {
        }
        field(50015; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50017; "Respiration Rate"; Code[20])
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
