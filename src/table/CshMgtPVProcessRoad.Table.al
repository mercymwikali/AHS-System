Table 85087 "CshMgt PV Process Road"
{
    fields
    {
        field(50000; "From Status Code"; Code[20])
        {
            TableRelation = "CshMgt PV Steps".Code;

            trigger OnValidate()
            begin
                PVSteps.Reset();
                PVSteps.Get("From Status Code");
                "From Status Description" := PVSteps.Description;
            end;
        }
        field(50001; "From Status Description"; Text[30])
        {
        }
        field(50002; "To Status Code"; Code[20])
        {
            TableRelation = "CshMgt PV Steps".Code;

            trigger OnValidate()
            begin
                PVSteps.Reset();
                PVSteps.Get("To Status Code");
                "To Status Description" := PVSteps.Description;
            end;
        }
        field(50003; "To Status Description"; Text[30])
        {
        }
        field(50004; Start; Boolean)
        {
        }
        field(50005; "End"; Boolean)
        {
        }
        field(50006; "Allow Check Preview"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "From Status Code", "To Status Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        PVSteps: Record "CshMgt PV Steps";
}
