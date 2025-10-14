table 52202984 "Item Buffer"
{
    Caption = 'Item Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[30])
        {
            Caption = 'No';
        }
        field(2; "Unit Cost"; Decimal)
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
