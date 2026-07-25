table 85473 "Mpesa Token Entries"
{
    Caption = 'Mpesa Token Entries';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Code"; Code[100])
        {
            Caption = 'Code';
        }
        field(50001; Token; Text[250])
        {
            Caption = 'Token';
        }
        field(50002; "Time"; DateTime)
        {
            Caption = 'Time';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
