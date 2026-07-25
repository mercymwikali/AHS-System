Page 85214 "Payment Types"
{
    PageType = Worksheet;
    SourceTable = "Receipts and Payment Types";
    SourceTableView = where(Type = const(Payment));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(AccountType; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Not Vatable"; Rec."Not Vatable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Not Vatable field.', Comment = '%';
                }
                field(VATChargeable; Rec."VAT Chargeable")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the VAT Chargeable field.';
                }
                field(WithholdingTaxChargeable; Rec."Withholding Tax Chargeable")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Withholding Tax Chargeable field.';
                }
                field(PAYETaxChargeable; Rec."PAYE Tax Chargeable")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the PAYE Tax Chargeable field.';
                }
                field(VATCode; Rec."VAT Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the VAT Code field.';
                }
                field(WithholdingTaxCode; Rec."Withholding Tax Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Withholding Tax Code field.';
                }
                field(VATWithheldCode; Rec."VAT Withheld Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the VAT Withheld Code field.';
                }
                field(PAYETaxCode; Rec."PAYE Tax Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the PAYE Tax Code field.';
                }
                field(UsePAYETable; Rec."Use PAYE Table")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Use PAYE Table field.';
                }
                field(DefaultGrouping; Rec."Default Grouping")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Default Grouping field.';
                }
                field(GLAccount; Rec."G/L Account")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the G/L Account field.';
                }
                field(PendingVoucher; Rec."Pending Voucher")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Pending Voucher field.';
                }
                field(BankAccount; Rec."Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Bank Account field.';
                }
                field(TransationRemarks; Rec."Transation Remarks")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Transation Remarks field.';
                }
                field(PaymentReference; Rec."Payment Reference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Payment Reference field.';
                }
                field(CustomerPaymentOnAccount; Rec."Customer Payment On Account")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Customer Payment On Account field.';
                }
                field(DirectExpense; Rec."Direct Expense")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Direct Expense field.';
                }
                field(CalculateRetention; Rec."Calculate Retention")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Calculate Retention field.';
                }
                field(RetentionCode; Rec."Retention Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Retention Code field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(RetentionFeeCode; Rec."Retention Fee Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Retention Fee Code field.';
                }
                field(RetentionFeeApplicable; Rec."Retention Fee Applicable")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Retention Fee Applicable field.';
                }
                field(Subsistence; Rec."Subsistence?")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Subsistence? field.';
                }
                field(CouncilClaim; Rec."Council Claim?")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Council Claim? field.';
                }
                field(TelephoneAllowance; Rec."Telephone Allowance?")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Telephone Allowance? field.';
                }
            }
        }
    }

    actions
    {
    }
}
