table 52202999 "Portal Roles"
{
    Caption = 'Portal Roles';
    DataClassification = ToBeClassified;

    fields
    {
        field(2; "Role ID";  Code[30])
        {
            Caption = 'Role ID';
        }
        field(3; isAdmin; Boolean)
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
