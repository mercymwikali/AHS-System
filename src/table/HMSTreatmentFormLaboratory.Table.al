Table 85267 "HMS Treatment Form Laboratory"
{
    DataCaptionFields = "Laboratory Test Package Code", "Laboratory Test Package Name";
    // DrillDownPageID = "HMS Pharmacy Line History";
    // LookupPageID = "HMS Pharmacy Line History";

    fields
    {
        field(50000; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Laboratory Test Package Code"; Code[50])
        {
            TableRelation = "HMS Setup Lab Test".Code;
        }
        field(50002; "Laboratory Test Package Name"; Text[250])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field("Laboratory Test Package Code")));
            FieldClass = FlowField;
        }
        field(50003; "Date Due"; Date)
        {
        }
        field(50004; Results; Text[250])
        {
        }
        field(50005; Status; Option)
        {
            FieldClass = Normal;
            OptionCaption = 'New,Forwarded,Cancelled,Completed,Recalled,Review,Interim';
            OptionMembers = New,Forwarded,Cancelled,Completed,Recalled,Review,Interim;
        }
        field(50006; Diagnosis; Code[50])
        {
            TableRelation = "HMS Setup Diagnosis".Code;
        }
        field(50007; Specimen; Code[50])
        {
            TableRelation = "HMS Setup Specimen".Code;
        }
        field(50008; Test; Text[250])
        {
        }
        field(50009; "Brief History"; Text[250])
        {
        }
        field(50010; "Date Taken"; Date)
        {
        }
        field(50011; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50012; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(50013; "Lab No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; UUID; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Laboratory Test Package Code", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
