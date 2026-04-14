Table 85190 "HMS Drug Interaction"
{
    fields
    {
        field(50000; "Drug No."; Code[20])
        {
            Description = 'Stores the code reference to the drug in the database';
            NotBlank = true;
        }
        field(50001; "Drug Name"; Text[100])
        {
            Description = 'Stores the name of the drug in the database';
        }
        field(50002; "Drug No. 1"; Code[20])
        {
            Description = 'Stores the code reference of the next drug in the database';
            NotBlank = true;
            TableRelation = Item."No.";
        }
        field(50003; "Drug Name 1"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Drug No. 1")));
            Description = 'Stores the name of the drug in the database';
            FieldClass = FlowField;
        }
        field(50004; "Not Compatible"; Boolean)
        {
            Description = 'Stores the state of the drug wether it is compatible or not';
        }
        field(50005; "Alert Remarks"; Text[200])
        {
            Description = 'Stores any remarks that the user might make in relation to the drug drug interaction';
        }
        field(50006; "Code"; Code[20])
        {
            Description = 'Stores the code of record in the database';
        }
    }

    keys
    {
        key(Key1; "Drug No.", "Drug No. 1")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
