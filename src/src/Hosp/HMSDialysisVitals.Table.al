table 52202943 "HMS Dialysis Vitals"
{
    Caption = 'HMS Dialysis Vitals';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No';
        }
        field(2; "Dialysis No"; Code[20])
        {
            Caption = 'Dialysis No';
        }
        field(3; "Treatment No"; Code[20])
        {
            Caption = 'Treatment No';
            TableRelation = "HMS Treatment Form Header";
            trigger OnValidate()
            var
                DocH: Record "HMS Treatment Form Header";
            begin
                if DocH.Get("Treatment No") then
                    Rec."Patient No" := DocH."Patient No.";
            end;
        }
        field(4; "Patient No"; Code[20])
        {
            Caption = 'Patient No';
            TableRelation = "HMS Patient";
        }
        field(5; "Observation Date"; Date)
        {
            Caption = 'Observation Date';
        }
        field(6; "Observation Time"; Time)
        {
            Caption = 'Observation Time';
        }
        field(7; "Blood Pressure"; Text[30])
        {
            Caption = 'Blood Pressure';
        }
        field(8; "Pulse Rate"; Text[30])
        {
            Caption = 'Pulse Rate';
        }
        field(9; "P Speed"; Text[30])
        {
            Caption = 'P Speed';
        }
        field(10; "Art P"; Text[30])
        {
            Caption = 'Art P';
        }
        field(11; "Ven P"; Text[30])
        {
            Caption = 'Ven P';
        }
        field(12; Temp; Text[30])
        {
            Caption = 'Temp';
        }
        field(13; "UF Rate"; Text[30])
        {
            Caption = 'UF Rate';
        }
        field(14; "UF Vol"; Text[30])
        {
            Caption = 'UF Vol';
        }
        field(15; Heparin; Text[30])
        {
            Caption = 'Heparin';
        }
        field(16; Cond; Text[30])
        {
            Caption = 'Cond';
        }
        field(17; Remarks; Text[2000])
        {
            Caption = 'Remarks';
        }
    }
    keys
    {
        key(PK; "Line No")
        {
            Clustered = true;
        }
    }
}
