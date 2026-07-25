namespace PTL.HMISBC;

query 85005 "Portal User Roles"
{
    Caption = 'Portal User Roles';
    QueryType = Normal;
    
    elements
    {
        dataitem(PortalUserRoles; "Portal User Roles")
        {
            column(RoleID; "Role ID")
            {
            }
            column(UserId; "User Id")
            {
            }
        }
    }
    
    trigger OnBeforeOpen()
    begin
    
    end;
}
