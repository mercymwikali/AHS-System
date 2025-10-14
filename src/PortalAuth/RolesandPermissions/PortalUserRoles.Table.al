table 52203001 "Portal User Roles"
{
    Caption = 'Portal User Roles';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "User Id"; Code[30])
        {
            Caption = 'User Id';
            TableRelation = "Portal User"."User ID";
        }
        field(2; "Role ID"; Code[30])
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
