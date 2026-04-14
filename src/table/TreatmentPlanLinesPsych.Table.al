table 85338 "Treatment Plan Lines(Psych)"
{
    Caption = 'Treatment Plan Lines(Psych)';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Plan No."; Code[30])
        {
            Caption = 'Plan No.';
            TableRelation = "Treatment Plan(Psychology)"."Plan No.";
        }
        field(50001; "Session No"; Code[30])
        {
            Caption = 'Session No';
            // Auto increment from Session 1
        }
        field(50002; "Aim/Plan"; Text[150])
        {
            Caption = 'Aim/Plan';
        }
        field(50003; "Date Done"; Date)
        {
            Caption = 'Date Done';
        }
        field(50004; "Treatment No"; Code[30])
        {
            Caption = 'Treatment No';
            TableRelation = "HMS Treatment Form Header"."Treatment No.";
        }
        field(50005; "Therapy Session No"; Code[30])
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
