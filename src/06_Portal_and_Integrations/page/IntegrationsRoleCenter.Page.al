namespace PTL.HMIS;
using Microsoft.RoleCenters;
using PTL.HMISBC;

page 85742 "Integrations Role Center"
{
    ApplicationArea = All;
    Caption = 'Integrations Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control60; "Headline RC General Mgt.")
            {
                ApplicationArea = RelationshipMgmt;
            }

            group(Control1900724808)
            {
                ShowCaption = false;

                part(Control8; "HMS Cue")
                {
                    Caption = 'HMS CUE';
                }
                part(Control16; "Team Member Activities")
                {
                    ApplicationArea = RelationshipMgmt;
                }
            }

        }
    }
    actions
    {
        area(Embedding)
        {
            action("Mpesa Setup")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Mpesa Setup';
                RunObject = Page "Mpesa Integration Setup";
                ToolTip = 'Executes the Mpesa Setup action.';
            }
        }
        area(Sections)
        {
            group(PortalManagment)
            {
                action(PortalUsers)
                {
                    ApplicationArea = all;
                    Caption = 'Portal Users';
                    RunObject = page "Portal Users";
                }
                action(PortalSessions)
                {
                    ApplicationArea = all;
                    Caption = 'Portal Sessions';
                    RunObject = page "Portal Sessions";
                }
                group("Roles&Permissions")
                {
                    Caption = 'Roles and Permissions Setup';
                    action(Roles)
                    {
                        ApplicationArea = all;
                        Caption = 'Portal Roles';
                        RunObject = page "Portal Roles";
                    }
                    action(Permissions)
                    {
                        ApplicationArea = all;
                        Caption = 'Portal Permissions';
                        RunObject = page "Portal Permissions";
                    }
                }
            }
        }
    }
}
