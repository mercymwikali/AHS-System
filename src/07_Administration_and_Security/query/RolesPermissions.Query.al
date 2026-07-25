namespace PTL.HMISBC;

query 85006 RolesPermissions
{
    Caption = 'RolesPermissions';
    QueryType = Normal;
    
    elements
    {
        dataitem(PortalRolePermissions; "Portal Role Permissions")
        {
            column(RoleID; "Role ID")
            {
            }
            column(PermissionAction; "Permission Action")
            {
            }
            column(PermissionSubject; "Permission Subject")
            {
            }
            column(OwnDoctor; "ownDoctor")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
