Table 52202648 "HMS Treatment Form Laboratory"
{
    DataCaptionFields = "Laboratory Test Package Code", "Laboratory Test Package Name";
    // DrillDownPageID = "HMS Pharmacy Line History";
    // LookupPageID = "HMS Pharmacy Line History";

    fields
    {
        field(1; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Laboratory Test Package Code"; Code[50])
        {
            TableRelation = "HMS Setup Lab Test".Code;
        }
        field(3; "Laboratory Test Package Name"; Text[250])
        {
            CalcFormula = lookup("HMS Setup Lab Test".Description where(Code = field("Laboratory Test Package Code")));
            FieldClass = FlowField;
        }
        field(4; "Date Due"; Date)
        {
        }
        field(5; Results; Text[250])
        {
        }
        field(6; Status; Option)
        {
            FieldClass = Normal;
            OptionCaption = 'New,Forwarded,Cancelled,Completed,Recalled,Review,Interim';
            OptionMembers = New,Forwarded,Cancelled,Completed,Recalled,Review,Interim;
        }
        field(7; Diagnosis; Code[50])
        {
            TableRelation = "HMS Setup Diagnosis".Code;
        }
        field(8; Specimen; Code[50])
        {
            TableRelation = "HMS Setup Specimen".Code;
        }
        field(9; Test; Text[250])
        {
        }
        field(10; "Brief History"; Text[250])
        {
        }
        field(11; "Date Taken"; Date)
        {
        }
        field(12; Branch; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(13; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(14; "Lab No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(16; UUID; Text[250])
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
