page 85728 "Petty Cash"
{
    ApplicationArea = Basic, Suite;
    CardPageID = "Cash Payment Header UP";
    PageType = List;
    SourceTable = "Payments Header";
    SourceTableView = WHERE("Payment Type" = FILTER("Petty Cash"),
                            Status = FILTER(Pending | "Pending Approval" | Approved),
                            Posted = CONST(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(Payee; Rec.Payee)
                {
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field("Total Payment Amount"; Rec."Total Payment Amount")
                {
                    ToolTip = 'Specifies the value of the Total Payment Amount field.';
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ToolTip = 'Specifies the value of the Paying Bank Account field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("Function Name"; Rec."Function Name")
                {
                    ToolTip = 'Specifies the value of the Function Name field.';
                }
                field("Budget Center Name"; Rec."Budget Center Name")
                {
                    ToolTip = 'Specifies the value of the Budget Center Name field.';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(Select; Rec.Select)
                {
                    ToolTip = 'Specifies the value of the Select field.';
                }
                field("Total VAT Amount"; Rec."Total VAT Amount")
                {
                    ToolTip = 'Specifies the value of the Total VAT Amount field.';
                }
                field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Total Witholding Tax Amount field.';
                }
                field("Total Net Amount"; Rec."Total Net Amount")
                {
                    ToolTip = 'Specifies the value of the Total Net Amount field.';
                }
                field("Current Status"; Rec."Current Status")
                {
                    ToolTip = 'Specifies the value of the Current Status field.';
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    ToolTip = 'Specifies the value of the Payment Release Date field.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies the value of the No. Printed field.';
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ToolTip = 'Specifies the value of the VAT Base Amount field.';
                }
                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field("Currency Reciprical"; Rec."Currency Reciprical")
                {
                    ToolTip = 'Specifies the value of the Currency Reciprical field.';
                }
                field("Current Source A/C Bal."; Rec."Current Source A/C Bal.")
                {
                    ToolTip = 'Specifies the value of the Current Source A/C Bal. field.';
                }
                field("Cancellation Remarks"; Rec."Cancellation Remarks")
                {
                    ToolTip = 'Specifies the value of the Cancellation Remarks field.';
                }
                field("Register Number"; Rec."Register Number")
                {
                    ToolTip = 'Specifies the value of the Register Number field.';
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    ToolTip = 'Specifies the value of the From Entry No. field.';
                }
                field("To Entry No."; Rec."To Entry No.")
                {
                    ToolTip = 'Specifies the value of the To Entry No. field.';
                }
                field("Invoice Currency Code"; Rec."Invoice Currency Code")
                {
                    ToolTip = 'Specifies the value of the Invoice Currency Code field.';
                }
                field("Total Payment Amount LCY"; Rec."Total Payment Amount LCY")
                {
                    ToolTip = 'Specifies the value of the Total Payment Amount LCY field.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field(Dim3; Rec.Dim3)
                {
                    ToolTip = 'Specifies the value of the Dim3 field.';
                }
                field(Dim4; Rec.Dim4)
                {
                    ToolTip = 'Specifies the value of the Dim4 field.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field("Cheque Type"; Rec."Cheque Type")
                {
                    ToolTip = 'Specifies the value of the Cheque Type field.';
                }
                field("Total Retention Amount"; Rec."Total Retention Amount")
                {
                    ToolTip = 'Specifies the value of the Total Retention Amount field.';
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    ToolTip = 'Specifies the value of the Payment Narration field.';
                }
                field("Total PAYE Amount"; Rec."Total PAYE Amount")
                {
                    ToolTip = 'Specifies the value of the Total PAYE Amount field.';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                }
                field("Cheque Printed"; Rec."Cheque Printed")
                {
                    ToolTip = 'Specifies the value of the Cheque Printed field.';
                }
                field("Apply to Document Type"; Rec."Apply to Document Type")
                {
                    ToolTip = 'Specifies the value of the Apply to Document Type field.';
                }
                field("Apply to Document No"; Rec."Apply to Document No")
                {
                    ToolTip = 'Specifies the value of the Apply to Document No field.';
                }
                field("Imprest No."; Rec."Imprest No.")
                {
                    ToolTip = 'Specifies the value of the Imprest No. field.';
                }
                field("Claim No."; Rec."Claim No.")
                {
                    ToolTip = 'Specifies the value of the Claim No. field.';
                }
                field("PF No"; Rec."PF No")
                {
                    ToolTip = 'Specifies the value of the PF No field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;
    trigger OnOpenPage()
    begin
        SetRange(Cashier, UserId);
    end;
}
