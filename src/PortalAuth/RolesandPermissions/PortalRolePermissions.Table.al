table 52203000 "Portal Role Permissions"
{
    Caption = 'Portal Role Permissions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(2; "Role ID"; Code[30])
        {
            Caption = 'Role ID';
        }
        field(3; "Permission Action"; Enum "Permission Actions")
        {
            Caption = 'Action';
        }
        field(4; "Permission Subject"; Text[30])
        {
            Caption = 'Permission Subject';
            TableRelation = "Portal Permission Subjects".Subject;
        }
        field(5; "ownDoctor"; Boolean)
        {
            Caption = 'Own Doctor';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Line No", "Role ID", "Permission Action", "Permission Subject")
        {
            Clustered = true;
        }
        key(Key2; "Role ID", "Permission Action", "Permission Subject")
        {
            Unique = true;
        }
    }
}
