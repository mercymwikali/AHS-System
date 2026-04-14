table 85033 "Portal Role Permissions"
{
    Caption = 'Portal Role Permissions';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Line No"; Integer)
        {
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(50001; "Role ID"; Code[30])
        {
            Caption = 'Role ID';
        }
        field(50002; "Permission Action"; Enum "Permission Actions")
        {
            Caption = 'Action';
        }
        field(50003; "Permission Subject"; Text[30])
        {
            Caption = 'Permission Subject';
            TableRelation = "Portal Permission Subjects".Subject;
        }
        field(50004; "ownDoctor"; Boolean)
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
