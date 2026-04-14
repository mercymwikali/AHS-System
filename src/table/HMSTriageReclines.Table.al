Table 85274 "HMS Triage Rec. lines"
{
    fields
    {
        field(50000; "Patient No"; Code[20])
        {
        }
        field(50001; "Test Code"; Code[30])
        {
            TableRelation = "HMS Triage Test Setup"."Test Code";
        }
        field(50002; "Test Description"; Text[250])
        {
            CalcFormula = lookup("HMS Triage Test Setup"."Test Description" where("Test Code" = field("Test Code")));
            FieldClass = FlowField;
        }
        field(50003; "Test Date"; Date)
        {
        }
        field(50004; "Test Time"; Time)
        {
        }
        field(50005; "Test By"; Text[250])
        {
        }
        field(50006; Readings; Text[140])
        {
        }
        field(50007; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Patient No", "Test Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Test Date" := Today;
        "Test Time" := Time;
        "Test By" := UserId;
    end;
}
