table 85277 "HMS Ward Rooms"
{
    Caption = 'HMS Ward Rooms';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "Room No."; Code[30])
        {
            Caption = 'Room No.';
        }
        field(50001; "Ward No"; Code[30])
        {
            Caption = 'Ward No';
            TableRelation = "HMS Ward Setup"."Ward Code";
        }
        field(50002; "Room Name"; Code[30])
        {
            Caption = 'Room Name';
        }
        field(50003; "No of Beds"; Integer)
        {
            Caption = 'No of Beds';
        }        
    }
    keys
    {
        key(PK; "Room No.")
        {
            Clustered = true;
        }
    }
}
