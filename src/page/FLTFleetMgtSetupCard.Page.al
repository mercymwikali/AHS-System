Page 85126 "FLT Fleet Mgt Setup Card"
{
    PageType = Card;
    SourceTable = "FLT-Fleet Mgt Setup";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(TransportReqNo; Rec."Transport Req No")
                {
                    ToolTip = 'Specifies the value of the Transport Req No field.';
                }
                field(DailyWorkTicket; Rec."Daily Work Ticket")
                {
                    ToolTip = 'Specifies the value of the Daily Work Ticket field.';
                }
                field(FuelRegister; Rec."Fuel Register")
                {
                    ToolTip = 'Specifies the value of the Fuel Register field.';
                }
                field(MaintenanceRequest; Rec."Maintenance Request")
                {
                    ToolTip = 'Specifies the value of the Maintenance Request field.';
                }
                field(RotationInterval; Rec."Rotation Interval")
                {
                    ToolTip = 'Specifies the value of the Rotation Interval field.';
                }
                field(FuelPaymentBatchNo; Rec."Fuel Payment Batch No")
                {
                    ToolTip = 'Specifies the value of the Fuel Payment Batch No field.';
                }
                field("Safari Notice No."; Rec."Safari Notice No.")
                {
                    ToolTip = 'Specifies the value of the Safari Notice No. field.';
                }
            }
        }
    }

    actions
    {
    }
}
