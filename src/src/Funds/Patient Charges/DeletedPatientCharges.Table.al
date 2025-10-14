table 52202986 "Deleted Patient Charges"
{
    Caption = 'Deleted Patient Charges';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; "Visit No"; Code[30])
        {
            Caption = 'Visit No';
        }
    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
}
