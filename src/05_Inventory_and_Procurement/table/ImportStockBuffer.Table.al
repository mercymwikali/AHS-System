table 85578 "Import Stock Buffer"
{
    Caption = 'Import Stock Buffer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Line No "; Integer)
        {
            Caption = 'Line No ';
            AutoIncrement = true;
        }
        field(50001; "Item No"; Code[30])
        {
            Caption = 'Item No';
            TableRelation = Item."No.";
        }
        field(50002; "Item Name"; Code[30])
        {
            Caption = 'Item Name';
            FieldClass = FlowField;
            calcformula = lookup(Item.Description where("No." = field("Item No")));
        }
        field(50003; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(50004; Synched; Boolean)
        {
            Caption = 'Synched';
        }
        field(50005; "Stock Date"; Date)
        {
            Caption = 'Stock Date';
        }
        field(50006; "Location Code"; Code[30])
        {
            Caption = 'Location Code';
            TableRelation = Location.Code;
        }
        field(50007; "Document No"; Code[20])
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
