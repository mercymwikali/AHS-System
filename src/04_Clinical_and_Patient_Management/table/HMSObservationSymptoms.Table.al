Table 85206 "HMS Observation Symptoms"
{
    fields
    {
        field(50000; "Treatment No."; Code[20])
        {
            TableRelation = "HMS Treatment Form Header"."Treatment No.";
        }
        field(50001; "Symptom Code"; Code[20])
        {
            TableRelation = "HMS Symptoms Setup"."Syptom Code";

            trigger OnValidate()
            begin
                Symp.Reset();
                Symp.SetRange(Symp."Syptom Code", "Symptom Code");
                if Symp.Find('-') then
                    Symp."Symptom Name" := "Symptom Description";
            end;
        }
        field(50002; "Symptom Description"; Text[100])
        {
            FieldClass = Normal;
        }
        field(50003; System; Code[20])
        {
            TableRelation = "HMS Systems".Code;
        }
        field(50004; Duration; Text[30])
        {
        }
        field(50005; Description; Text[200])
        {
        }
        field(50006; Characteristics; Text[100])
        {
        }
        field(50007; "Date Taken"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Symptom Code", System)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Symp: Record "HMS Symptoms Setup";
}
