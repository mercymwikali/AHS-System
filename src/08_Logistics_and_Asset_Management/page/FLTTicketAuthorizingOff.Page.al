Page 85115 "FLT-Ticket Authorizing Off."
{
    PageType = ListPart;
    SourceTable = "FLT-Ticket Authorizing Off.";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(OfficerLineno; Rec."Officer Line no.")
                {
                    ToolTip = 'Specifies the value of the Officer Line no. field.';
                }
                field(TicketNo; Rec."Ticket No.")
                {
                    ToolTip = 'Specifies the value of the Ticket No. field.';
                }
                field(OfficerNo; Rec."Officer No.")
                {
                    ToolTip = 'Specifies the value of the Officer No. field.';
                }
                field(OfficerName; Rec."Officer Name")
                {
                    ToolTip = 'Specifies the value of the Officer Name field.';
                }
            }
        }
    }

    actions
    {
    }
}
