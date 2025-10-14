table 52202959 "HMS Ward Rooms"
{
    Caption = 'HMS Ward Rooms';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Room No."; Code[30])
        {
            Caption = 'Room No.';
        }
        field(2; "Ward No"; Code[30])
        {
            Caption = 'Ward No';
            TableRelation = "HMS Ward Setup"."Ward Code";
        }
        field(3; "Room Name"; Code[30])
        {
            Caption = 'Room Name';
        }
        field(4; "No of Beds"; Integer)
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
