page 85121 "FLT Daily Work Ticket"
{
    PageType = Document;
    SourceTable = "FLT-Daily Work Ticket Header";
    SourceTableView = WHERE(Status = CONST(Open));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Ticket No."; Rec."Ticket No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Ticket No. field.';
                }
                field("Previous W.T. No."; Rec."Previous W.T. No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Previous W.T. No. field.';
                }
                field("G.K. No."; Rec."G.K. No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the G.K. No. field.';
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Make field.';
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Unit field.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(Station; Rec.Station)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Station field.';
                }
                field("Total Milleage"; Rec."Total Milleage")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Total Milleage field.';
                }
                field("Total Fuel Cost"; Rec."Total Fuel Cost")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Total Fuel Cost field.';
                }
                field(Ministry; Rec.Ministry)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Ministry field.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Department Name field.';
                }
                field("Total Fuel Consumed"; Rec."Total Fuel Consumed")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Total Fuel Consumed field.';
                }
                field("Oil Consumed"; Rec."Oil Consumed")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Oil Consumed field.';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Month field.';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Year field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
            }
            part(Control21; "FLT Work Ticket Lines")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Ticket No." = FIELD("Ticket No.");
            }
            part(Control22; "FLT Daily Work Ticket Drivers")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Ticket No." = FIELD("Ticket No.");
            }
            part("Authorizing Officers"; "FLT-Ticket Authorizing Off.")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Authorizing Officers';
                SubPageLink = "Ticket No." = FIELD("Ticket No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(WorkTicket)
            {
                Caption = 'Preview WT';
                Image = PrintChecklistReport;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Preview WT action.';

                trigger OnAction()
                begin

                    if Rec."Ticket No." = '' then
                        Error('No Record Selected.');

                    ticket.Reset();
                    ticket.SetRange(ticket."Ticket No.", Rec."Ticket No.");

                    if ticket.Find('-') then
                        REPORT.Run(70135357, true, true, ticket);
                end;
            }
        }
    }

    var
        ticket: Record "FLT-Daily Work Ticket Header";
}
