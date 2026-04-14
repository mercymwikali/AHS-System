Table 85201 "HMS Observation Dressings"
{
    fields
    {
        field(50000; "Observation No."; Code[20])
        {
        }
        field(50001; "Process No."; Code[20])
        {
            TableRelation = "Store Requistion Header"."No.";
        }
        field(50002; Description; Text[30])
        {
            // CalcFormula = lookup("Store Requistion Header"."Request date" where ("No."=field("Process No.")));
            FieldClass = FlowField;
        }
        field(50003; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(50004; "Item Description"; Text[30])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
        field(50005; "Unit of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(50006; Quantity; Decimal)
        {
        }
        field(50007; Remarks; Text[200])
        {
        }
        field(50008; Posted; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Observation No.", "Process No.", "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
