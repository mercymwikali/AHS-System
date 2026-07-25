table 85586 "Item Buffer"
{
    Caption = 'Item Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; No; Code[30])
        {
            Caption = 'No';
        }
        field(50001; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
