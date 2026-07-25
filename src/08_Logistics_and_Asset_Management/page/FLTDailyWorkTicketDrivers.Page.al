Page 85122 "FLT Daily Work Ticket Drivers"
{
    PageType = ListPart;
    SourceTable = "FLT-Daily Work Ticked Drivers";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(lineNo; Rec."line No.")
                {
                    ToolTip = 'Specifies the value of the line No. field.';
                }
                field(DriverNo; Rec."Driver No.")
                {
                    ToolTip = 'Specifies the value of the Driver No. field.';
                }
                field(DriverName; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field(TotalMilleage; Rec."Total Milleage")
                {
                    ToolTip = 'Specifies the value of the Total Milleage field.';
                }
                field(TotalFuelConsumed; Rec."Total Fuel Consumed")
                {
                    ToolTip = 'Specifies the value of the Total Fuel Consumed field.';
                }
                field(TicketNo; Rec."Ticket No.")
                {
                    ToolTip = 'Specifies the value of the Ticket No. field.';
                }
            }
        }
    }

    actions
    {
    }
}
