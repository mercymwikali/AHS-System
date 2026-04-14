Table 85373 "Committee Board Of Directors"
{
    fields
    {
        field(50000; Committee; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Board Of Directors".Code;

            trigger OnValidate()
            begin
                if Board.Get(Code) then begin
                    SurName := Board.SurName;
                    OtherNames := Board."Other Names";
                end;
            end;
        }
        field(50002; SurName; Text[150])
        {
        }
        field(50003; OtherNames; Text[150])
        {
        }
        field(50004; Designation; Text[100])
        {
        }
        field(50005; Remarks; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; Committee, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Board: Record "Board Of Directors";
}
