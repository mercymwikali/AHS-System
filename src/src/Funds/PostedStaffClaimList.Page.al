Page 52203049 "Posted Staff Claim List"
{
    CardPageID = "Posted Staff Claims";
    Editable = false;
    PageType = List;
    SourceTable = "Staff Claims Header";
    SourceTableView = where(Status = const(Posted),
                            Posted = const(true));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Payee; Rec.Payee)
                {
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(ChequeNo; Rec."Cheque No.")
                {
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field(PayMode; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field(PaymentReleaseDate; Rec."Payment Release Date")
                {
                    ToolTip = 'Specifies the value of the Payment Release Date field.';
                }
                field(NoPrinted; Rec."No. Printed")
                {
                    ToolTip = 'Specifies the value of the No. Printed field.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(Amount; Rec."Total Net Amount")
                {
                    Caption = 'Amount';
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(AmountLCY; Rec."Total Net Amount LCY")
                {
                    Caption = 'Amount LCY';
                    ToolTip = 'Specifies the value of the Amount LCY field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(Purpose; Rec.Purpose)
                {
                    ToolTip = 'Specifies the value of the Purpose field.';
                }
            }
        }
    }

    actions
    {
    }
}
