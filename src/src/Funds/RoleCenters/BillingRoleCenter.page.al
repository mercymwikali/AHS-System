namespace PTL.Hospital;
using Microsoft.RoleCenters;
using Microsoft.Sales.Document;

page 52203203 "Billing RoleCenter"
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
            action("Active OutPatients")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Active Patient OutPatients";
                ToolTip = 'Executes the Active OutPatients action.';
            }            
            action("Active InPatients")
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "HMS Active Patient InPatients";
                ToolTip = 'Executes the Active InPatients action.';
            }
        }
        area(Sections)
        {
            group(Billing)
            {
                Caption = 'Hospital Billing';
                Image = Intrastat;
                action(Receipts)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Receipts';
                    Image = Insurance;
                    Promoted = true;
                    RunObject = Page "Receipts List";
                    ToolTip = 'Executes the Receipts action.';
                }
                action("Sales Invoice List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Invoice List';
                    RunObject = Page "Sales Invoice List";
                    ToolTip = 'Executes the Invoice List action.';
                }
            }
        }
    }
}
