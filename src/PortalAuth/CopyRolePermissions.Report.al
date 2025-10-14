namespace PTL.HMISBC;

report 52202725 "Copy Role Permissions"
{
    ApplicationArea = All;
    Caption = 'Copy Role Permissions';
    UsageCategory = Administration;
    ProcessingOnly = true;

    dataset
    {
        dataitem(PortalRoles; "Portal Roles")
        {
            RequestFilterFields = "Role ID";
            column(RoleID; "Role ID")
            {
            }
            trigger OnAfterGetRecord()
            begin
                counter := 0;

                if CopyFromRole = PortalRoles."Role ID" then Error('The operation canno be done on the same table. Please Adjust your filter and try again');
                PortalRolePermissions.Reset();
                PortalRolePermissions.SetRange("Role ID", PortalRoles."Role ID");
                if PortalRolePermissions.Find('-') then
                    PortalRolePermissions.DeleteAll();

                PortalRolePermissions.Reset();
                PortalRolePermissions.SetRange("Role ID", CopyFromRole);
                if PortalRolePermissions.FindSet() then
                    repeat
                        counter += 1;
                        PortalRolePermissionsCopy.Init();
                        PortalRolePermissionsCopy."Role ID" := PortalRoles."Role ID";
                        PortalRolePermissionsCopy."Permission Action" := PortalRolePermissions."Permission Action";
                        PortalRolePermissionsCopy."Permission Subject" := PortalRolePermissions."Permission Subject";
                        PortalRolePermissionsCopy.Insert();
                    until PortalRolePermissions.Next() = 0;

                Message('Successfully Copied %1 Permissions from Role %2 to Role %3', counter, CopyFromRole, PortalRoles."Role ID");
            end;

            trigger OnPreDataItem()
            begin
                if CopyFromRole = '' then Error('You must first select the role to copy permissions from');
                if PortalRoles.GetFilter("Role ID") = '' then Error('Select Role you want to update from table filters');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(CopyRole)
                {
                    Caption = 'Copy role';
                    field(FieldCopyFromRole; CopyFromRole)
                    {
                        Caption = 'Copy From Role';
                        TableRelation = "Portal Roles"."Role ID";
                        ShowMandatory = true;
                        ToolTip = 'Specifies the value of the Copy From Role field.';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        PortalRolePermissions: Record "Portal Role Permissions";
        PortalRolePermissionsCopy: Record "Portal Role Permissions";
        CopyFromRole: Code[30];
        counter: Integer;
}
