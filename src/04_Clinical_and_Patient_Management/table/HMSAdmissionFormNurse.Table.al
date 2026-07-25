Table 85174 "HMS Admission Form Nurse"
{
    fields
    {
        field(50000; "Admission No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Nurse ID"; Code[30])
        {
        }
        field(50002; "Notes Date"; Date)
        {
        }
        field(50003; "Notes Time"; Time)
        {
        }
        field(50004; Notes; Text[2000])
        {
        }
        field(50005; Type; Option)
        {
            OptionCaption = ' ,Drug Given';
            OptionMembers = " ","Drug Given";
        }
        field(50006; Drugs; Code[30])
        {
            TableRelation = "HMS Treatment Form Drug"."Drug No.";
        }
        field(50007; Dose; Code[30])
        {
        }
        field(50008; Routine; Code[30])
        {
        }
        field(50009; "Prescription Dose"; Enum PrescriptionDoseEnum)
        {
        }
        field(50010; "Drug Name"; Text[150])
        {
            //FieldClass = FlowField;
        }
        field(50011; "Patient No"; Code[20])
        {
            CalcFormula = lookup("HMS Admission Form Header"."Patient No." where("Patient No." = field("Admission No.")));
            FieldClass = FlowField;
        }
        field(50012; LineNo; Integer)
        {
            AutoIncrement = true;
        }
        field(50013; "Nurse Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Triage,Inpatient,Theatre,Maternity,ICU,Physiotherapist,Nutritionist';
            OptionMembers = ,Triage,Inpatient,Theatre,Maternity,ICU,Physiotherapist,Nutritionist;
        }
        field(50014; "Doctors Prescription"; Code[30])
        {
            TableRelation = "HMS Admission Drug Prescribe"."Drug No.";
        }
    }

    keys
    {
        key(Key1; "Admission No.", "Nurse ID", "Notes Date", "Notes Time", LineNo)
        {
            Clustered = true;
        }
        key(Key2; "Notes Date", "Notes Time", LineNo)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Nurse ID" = '' then
            "Nurse ID" := UserId;
            
        "Notes Date" := Today;
        "Notes Time" := "Notes Time";
    end;
}
