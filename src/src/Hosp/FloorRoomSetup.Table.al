table 52202972 "Floor Room Setup"
{
    Caption = 'Floor Room Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Floor No"; Code[30])
        {
            Caption = 'Floor No';
        }
        field(2; "Room No"; Code[30])
        {
            Caption = 'Room No';
        }
        field(3; "Room Name"; Code[200])
        {
            Caption = 'Room Name';
        }
        field(4; Occupied; Boolean)
        {
            Caption = 'Occupied';
        }
    }
    keys
    {
        key(PK; "Floor No", "Room No")
        {
            Clustered = true;
        }
    }
}
