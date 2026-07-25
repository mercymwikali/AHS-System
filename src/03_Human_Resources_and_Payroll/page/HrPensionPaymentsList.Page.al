Page 85681 "Hr Pension Payments List"
{
    CardPageID = "Hr Pension Payments";
    Editable = false;
    PageType = List;
    SourceTable = "Hr Pension Payments";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(DateCollected; Rec."Date Collected")
                {
                    ToolTip = 'Specifies the value of the Date Collected field.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
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
                field(CollectedBy; Rec."Collected By")
                {
                    ToolTip = 'Specifies the value of the Collected By field.';
                }
                field(OnBehalfOf; Rec."On Behalf Of")
                {
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
                }
                field(BenefitType; Rec."Benefit Type")
                {
                    ToolTip = 'Specifies the value of the Benefit Type field.';
                }
                field(NameofInsurance; Rec."Name of Insurance")
                {
                    ToolTip = 'Specifies the value of the Name of Insurance field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Principal; Rec.Principal)
                {
                    ToolTip = 'Specifies the value of the Principal field.';
                }
                field(PrincipalsNames; Rec."Principal's Names")
                {
                    ToolTip = 'Specifies the value of the Principal''s Names field.';
                }
                field(EmployeeType; Rec."Employee Type")
                {
                    ToolTip = 'Specifies the value of the Employee Type field.';
                }
            }
        }
    }

    actions
    {
    }
}
