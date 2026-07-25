table 85030 "Portal Sessions"
{
    Caption = 'Portal Sessions';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Session ID"; Text[200])
        {
            Caption = 'Session ID';
        }
        field(50001; "User ID"; Code[30])
        {
            Caption = 'User ID';
        }
        field(50002; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(50003; ExpiresAt; DateTime)
        {
            Caption = 'Expires At';
        }
        field(50004; "Near Expiry"; Boolean)
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
