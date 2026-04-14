table 85166 "Floor Room Setup"
{
    Caption = 'Floor Room Setup';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Floor No"; Code[30])
        {
            Caption = 'Floor No';
        }
        field(50001; "Room No"; Code[30])
        {
            Caption = 'Room No';
        }
        field(50002; "Room Name"; Code[200])
        {
            Caption = 'Room Name';
        }
        field(50003; Occupied; Boolean)
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
