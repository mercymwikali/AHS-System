table 85035 "Portal User Roles"
{
    Caption = 'Portal User Roles';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000; "User Id"; Code[30])
        {
            Caption = 'User Id';
            TableRelation = "Portal User"."User ID";
        }
        field(50001; "Role ID"; Code[30])
        {
            Caption = 'Role ID';
            TableRelation = "Portal Roles"."Role ID";
        }
    }
    keys
    {
        key(PK; "User Id","Role ID")
        {
            Clustered = true;
        }
    }
}
