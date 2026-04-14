table 85117 "Deleted Patient Charges"
{
    Caption = 'Deleted Patient Charges';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(50001; "Visit No"; Code[30])
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
