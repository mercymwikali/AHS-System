Page 52202428 "Hr Pension Payments"
{
    PageType = Card;
    SourceTable = "Hr Pension Payments";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(DatePrepared; Rec."Date Prepared")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Prepared field.';
                }
                field(Principal; Rec.Principal)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Principal field.';
                }
                field(PrincipalsNames; Rec."Principal's Names")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Principal''s Names field.';
                }
                field(EmployeeType; Rec."Employee Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Employee Type field.';
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(ChequeNo; Rec."Cheque No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field(PayMode; Rec."Pay Mode")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field(CollectedBy; Rec."Collected By")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Collected By field.';
                }
                field(OnBehalfOf; Rec."On Behalf Of")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
                }
                field(BenefitType; Rec."Benefit Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Benefit Type field.';
                }
                field(NameofInsurance; Rec."Name of Insurance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Name of Insurance field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(DateCollected; Rec."Date Collected")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Date Collected field.';
                }
            }
            part(Control1000000009; "HR Employee Beneficiary")
            {
                SubPageLink = "Employee Code" = field(Principal),
                              Type = const(Beneficiary);
            }
        }
    }

    actions
    {
    }
}
