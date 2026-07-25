Table 85266 "HMS Treatment Form Injection"
{
    fields
    {
        field(50000; "Treatment No."; Code[20])
        {
            NotBlank = true;
        }
        field(50001; "Injection No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "HMS Setup Injection".Code;

            trigger OnValidate()
            begin
                Injection.Reset();
                if Injection.Get("Injection No.") then begin
                    "Injection Name" := "Injection Name";
                    Item.Reset();
                    Item.Get(Injection."Item No.");
                    "Item No." := Item."No.";
                end;
            end;
        }
        field(50002; "Injection Name"; Text[100])
        {
            CalcFormula = lookup("HMS Setup Injection".Description where(Code = field("Injection No.")));
            FieldClass = FlowField;
        }
        field(50003; "Injection Given"; Boolean)
        {
        }
        field(50004; "Injection Remarks"; Text[100])
        {
        }
        field(50005; "Injection Unit of Measure"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(50006; "Injection Quantity"; Decimal)
        {
        }
        field(50007; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(50008; Location; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(50009; Posted; Boolean)
        {
        }
        field(50010; Duration; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Treatment No.", "Injection No.", "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Injection: Record "HMS Setup Injection";
        Item: Record Item;
}
