Table 52202733 "HMS Discharge Summary"
{

    fields
    {
        field(1; "Discharge Code"; Code[10])
        {
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Type; Option)
        {
            OptionMembers = "Clinical Summary",Investigation,Management,"Discharge Instructions",Recommendation,Diagnosis;
        }
        field(4; Description; Text[250])
        {
        }
        field(5; "Admission No"; Code[30])
        {
        }
        field(6; PatientNo; Code[30])
        {
        }
        field(7; "Review Date"; Date)
        {
        }
        field(8; "Diagnosis"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Duration"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Membrane Size"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Blood Flow Rate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Dialysis Flow Rate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Heparin Used"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Maintenance Done"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "UF Achieved"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Pre Dialysis Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Post Dialysis Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Heart Rate"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "SPO2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Bp"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Patient Condition"; Text[2000])
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
