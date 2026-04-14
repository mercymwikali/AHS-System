Page 85155 "FLT Work Ticket Lines"
{
    PageType = ListPart;
    SourceTable = "FLT-Daily Work Ticket Lines";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DriverNo; Rec."Driver No.")
                {
                    ToolTip = 'Specifies the value of the Driver No. field.';
                }
                field(DriverName; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field(DepartureFrom; Rec."Departure From")
                {
                    ToolTip = 'Specifies the value of the Departure From field.';
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                field(WorkDate; Rec."Work Date")
                {
                    ToolTip = 'Specifies the value of the Work Date field.';
                }
                field(AuthorizingOfficerNo; Rec."Authorizing Officer No")
                {
                    ToolTip = 'Specifies the value of the Authorizing Officer No field.';
                }
                field(AuthorizingOfficerName; Rec."Authorizing Officer Name")
                {
                    ToolTip = 'Specifies the value of the Authorizing Officer Name field.';
                }
                field(TimeOut; Rec."Time Out")
                {
                    ToolTip = 'Specifies the value of the Time Out field.';
                }
                field(TimeIn; Rec."Time In")
                {
                    ToolTip = 'Specifies the value of the Time In field.';
                }
                field(StartMilleage; Rec."Start Milleage")
                {
                    ToolTip = 'Specifies the value of the Start Milleage field.';
                }
                field(EndMilleage; Rec."End Milleage")
                {
                    ToolTip = 'Specifies the value of the End Milleage field.';
                }
                field(RegNo; Rec."Reg. No.")
                {
                    ToolTip = 'Specifies the value of the Reg. No. field.';
                }
                field(VoucherNo; Rec."Voucher No.")
                {
                    ToolTip = 'Specifies the value of the Voucher No. field.';
                }
            }
        }
    }

    actions
    {
    }
}
