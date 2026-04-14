table 85034 "Portal Roles"
{
    Caption = 'Portal Roles';
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; "Role ID";  Code[30])
        {
            Caption = 'Role ID';
        }
        field(50001; isAdmin; Boolean)
        {
            Caption = 'isAdmin';
        }
    }
    keys
    {
        key(PK; "Role ID")
        {
            Clustered = true;
        }
    }
}
