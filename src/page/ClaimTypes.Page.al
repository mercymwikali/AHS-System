Page 85108 "Claim Types"
{
    PageType = Worksheet;
    SourceTable = "Receipts and Payment Types";
    SourceTableView = where(Type = const(Claim));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(AccountType; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(VATChargeable; Rec."VAT Chargeable")
                {
                    ToolTip = 'Specifies the value of the VAT Chargeable field.';
                }
                field(WithholdingTaxChargeable; Rec."Withholding Tax Chargeable")
                {
                    ToolTip = 'Specifies the value of the Withholding Tax Chargeable field.';
                }
                field(VATCode; Rec."VAT Code")
                {
                    ToolTip = 'Specifies the value of the VAT Code field.';
                }
                field(WithholdingTaxCode; Rec."Withholding Tax Code")
                {
                    ToolTip = 'Specifies the value of the Withholding Tax Code field.';
                }
                field(DefaultGrouping; Rec."Default Grouping")
                {
                    ToolTip = 'Specifies the value of the Default Grouping field.';
                }
                field(GLAccount; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.';
                }
                field(PendingVoucher; Rec."Pending Voucher")
                {
                    ToolTip = 'Specifies the value of the Pending Voucher field.';
                }
                field(BankAccount; Rec."Bank Account")
                {
                    ToolTip = 'Specifies the value of the Bank Account field.';
                }
                field(TransationRemarks; Rec."Transation Remarks")
                {
                    ToolTip = 'Specifies the value of the Transation Remarks field.';
                }
                field(PaymentReference; Rec."Payment Reference")
                {
                    ToolTip = 'Specifies the value of the Payment Reference field.';
                }
                field(CustomerPaymentOnAccount; Rec."Customer Payment On Account")
                {
                    ToolTip = 'Specifies the value of the Customer Payment On Account field.';
                }
                field(DirectExpense; Rec."Direct Expense")
                {
                    ToolTip = 'Specifies the value of the Direct Expense field.';
                }
                field(CalculateRetention; Rec."Calculate Retention")
                {
                    ToolTip = 'Specifies the value of the Calculate Retention field.';
                }
                field(RetentionCode; Rec."Retention Code")
                {
                    ToolTip = 'Specifies the value of the Retention Code field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(RetentionFeeCode; Rec."Retention Fee Code")
                {
                    ToolTip = 'Specifies the value of the Retention Fee Code field.';
                }
                field(RetentionFeeApplicable; Rec."Retention Fee Applicable")
                {
                    ToolTip = 'Specifies the value of the Retention Fee Applicable field.';
                }
                field(Subsistence; Rec."Subsistence?")
                {
                    ToolTip = 'Specifies the value of the Subsistence? field.';
                }
            }
        }
    }

    actions
    {
    }
}
