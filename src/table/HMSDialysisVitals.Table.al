table 85183 "HMS Dialysis Vitals"
{
    Caption = 'HMS Dialysis Vitals';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No';
        }
        field(50001; "Dialysis No"; Code[20])
        {
            Caption = 'Dialysis No';
        }
        field(50002; "Treatment No"; Code[20])
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
        field(50003; "Patient No"; Code[20])
        {
            Caption = 'Patient No';
            TableRelation = "HMS Patient";
        }
        field(50004; "Observation Date"; Date)
        {
            Caption = 'Observation Date';
        }
        field(50005; "Observation Time"; Time)
        {
            Caption = 'Observation Time';
        }
        field(50006; "Blood Pressure"; Text[30])
        {
            Caption = 'Blood Pressure';
        }
        field(50007; "Pulse Rate"; Text[30])
        {
            Caption = 'Pulse Rate';
        }
        field(50008; "P Speed"; Text[30])
        {
            Caption = 'P Speed';
        }
        field(50009; "Art P"; Text[30])
        {
            Caption = 'Art P';
        }
        field(50010; "Ven P"; Text[30])
        {
            Caption = 'Ven P';
        }
        field(50011; Temp; Text[30])
        {
            Caption = 'Temp';
        }
        field(50012; "UF Rate"; Text[30])
        {
            Caption = 'UF Rate';
        }
        field(50013; "UF Vol"; Text[30])
        {
            Caption = 'UF Vol';
        }
        field(50014; Heparin; Text[30])
        {
            Caption = 'Heparin';
        }
        field(50015; Cond; Text[30])
        {
            Caption = 'Cond';
        }
        field(50016; Remarks; Text[2000])
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
