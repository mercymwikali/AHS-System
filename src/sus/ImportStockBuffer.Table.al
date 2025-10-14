table 52203002 "Import Stock Buffer"
{
    Caption = 'Import Stock Buffer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Line No "; Integer)
        {
            Caption = 'Line No ';
            AutoIncrement = true;
        }
        field(2; "Item No"; Code[30])
        {
            Caption = 'Item No';
            TableRelation = Item."No.";
        }
        field(3; "Item Name"; Code[30])
        {
            Caption = 'Item Name';
            FieldClass = FlowField;
            calcformula = lookup(Item.Description where("No." = field("Item No")));
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(5; Synched; Boolean)
        {
            Caption = 'Synched';
        }
        field(6; "Stock Date"; Date)
        {
            Caption = 'Stock Date';
        }
        field(7; "Location Code"; Code[30])
        {
            Caption = 'Location Code';
            TableRelation = Location.Code;
        }
        field(8; "Document No"; Code[20])
        {
            Caption = 'Document No';
        }
    }
    keys
    {
        key(PK; "Line No ")
        {
            Clustered = true;
        }
    }
}
