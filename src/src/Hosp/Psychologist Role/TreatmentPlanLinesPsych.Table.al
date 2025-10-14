table 52202961 "Treatment Plan Lines(Psych)"
{
    Caption = 'Treatment Plan Lines(Psych)';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Plan No."; Code[30])
        {
            Caption = 'Plan No.';
            TableRelation = "Treatment Plan(Psychology)"."Plan No.";
        }
        field(2; "Session No"; Code[30])
        {
            Caption = 'Session No';
            // Auto increment from Session 1
        }
        field(3; "Aim/Plan"; Text[150])
        {
            Caption = 'Aim/Plan';
        }
        field(4; "Date Done"; Date)
        {
            Caption = 'Date Done';
        }
        field(5; "Treatment No"; Code[30])
        {
            Caption = 'Treatment No';
            TableRelation = "HMS Treatment Form Header"."Treatment No.";
        }
        field(6; "Therapy Session No"; Code[30])
        {
            Caption = 'Therapy Session No';
            TableRelation = "HMS Therapy Form Header"."Treatment No.";
        }
    }
    keys
    {
        key(PK; "Plan No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Session No" = '' then
            "Session No" := 'Session 1'
        else
            "Session No" := IncStr("Session No");
    end;
}
