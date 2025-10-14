table 52202996 "Portal Sessions"
{
    Caption = 'Portal Sessions';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Session ID"; Text[200])
        {
            Caption = 'Session ID';
        }
        field(2; "User ID"; Code[30])
        {
            Caption = 'User ID';
        }
        field(3; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(4; ExpiresAt; DateTime)
        {
            Caption = 'Expires At';
        }
        field(5; "Near Expiry"; Boolean)
        {
            
        }
    }
    keys
    {
        key(PK; "Session ID")
        {
            Clustered = true;
        }
    }
}
