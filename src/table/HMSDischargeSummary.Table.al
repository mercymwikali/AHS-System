Table 85184 "HMS Discharge Summary"
{

    fields
    {
        field(50000; "Discharge Code"; Code[10])
        {
        }
        field(50001; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(50002; Type; Option)
        {
            OptionMembers = "Clinical Summary",Investigation,Management,"Discharge Instructions",Recommendation,Diagnosis;
        }
        field(50003; Description; Text[250])
        {
        }
        field(50004; "Admission No"; Code[30])
        {
        }
        field(50005; PatientNo; Code[30])
        {
        }
        field(50006; "Review Date"; Date)
        {
        }
        field(50007; "Diagnosis"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Duration"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Membrane Size"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Blood Flow Rate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Dialysis Flow Rate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Heparin Used"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Maintenance Done"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "UF Achieved"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Pre Dialysis Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Post Dialysis Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Heart Rate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "SPO2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Bp"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Patient Condition"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Discharge Code", "Line No", Type)
        {
            Clustered = true;
        }
        key(Key2; "Discharge Code", Type)
        {
            Unique = true;
        }
    }

    fieldgroups
    {
    }
}
