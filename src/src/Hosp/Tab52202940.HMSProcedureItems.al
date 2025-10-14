table 52202940 "HMS Procedure Items"
{
    Caption = 'HMS Procedure Items';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Procedure Code"; Code[20])
        {
            Caption = 'Procedure Code';
            TableRelation = "HMS Theatre Types".Code;
        }
        field(2; "Item No"; Code[20])
        {
            Caption = 'Item No';
            TableRelation = Item."No.";
            trigger OnValidate()
            var
                Itm: Record Item;
            begin
                if Itm.get("Item No")
                then begin
                    "Item Description" := Itm.Description;
                    "Unit Cost" := Itm."Unit Cost";
                    "Unit Price" := Itm."Unit Price";
                end;
            end;
        }
        field(3; "Item Description"; Text[250])
        {
            Caption = 'Item Description';
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            trigger OnValidate()
            begin
                "Total Amount" := "Unit Price" * Quantity;
            end;
        }
        field(5; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
        }
        field(6; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(7; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            trigger OnValidate()
            begin
                "Total Amount" := "Unit Price" * Quantity;
            end;
        }
        field(8; "Procedure Total"; Decimal)
        {
            CalcFormula = sum("HMS Procedure Items"."Total Amount" where("Procedure Code" = field("Procedure Code")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "Procedure Code", "Item No")
        {
            Clustered = true;
        }
    }
}
