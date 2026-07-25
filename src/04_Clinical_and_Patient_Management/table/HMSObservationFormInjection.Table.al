Table 85203 "HMS Observation Form Injection"
{
    fields
    {
        field(50000; "Observation No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Observation Form Header"."Observation No.";
        }
        field(50001; "Injection No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Injection".Code;

            trigger OnValidate()
            begin
                Injection.Reset();
                Injection.Get("Injection No.");
                "Item No." := Injection."Item No.";
            end;
        }
        field(50002; "Injection Name"; Text[30])
        {
            CalcFormula = lookup("HMS Setup Injection".Description where(Code = field("Injection No.")));
            FieldClass = FlowField;
        }
        field(50003; "Injection Date"; Date)
        {
        }
        field(50004; "Injection Time"; Time)
        {
        }
        field(50005; "Injection Remarks"; Text[100])
        {
        }
        field(50006; "Item No."; Code[20])
        {
            FieldClass = Normal;
            TableRelation = Item."No.";
        }
        field(50007; Location; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(50008; "Item Unit Of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(50009; Quantity; Decimal)
        {
        }
        field(50010; Posted; Boolean)
        {
        }
        field(50011; "Drug Name"; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Observation No.", "Injection No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Injection: Record "HMS Setup Injection";
}
