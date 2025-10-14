table 52202975 "Mpesa Token Entries"
{
    Caption = 'Mpesa Token Entries';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Code"; Code[100])
        {
            Caption = 'Code';
        }
        field(2; Token; Text[250])
        {
            Caption = 'Token';
        }
        field(3; "Time"; DateTime)
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
