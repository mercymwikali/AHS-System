Page 85777 "prList TransCode"
{
    PageType = List;
    SourceTable = "PR Transaction Codes";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Enabled = true;
                field(TransactionCode; Rec."Transaction Code")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
                field(IsCoopLnRep; Rec."IsCoop/LnRep")
                {
                    ToolTip = 'Specifies the value of the IsCoop/LnRep field.';
                }
                field(coopparameters; Rec."coop parameters")
                {
                    ToolTip = 'Specifies the value of the Other Categorization field.';
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(BalanceType; Rec."Balance Type")
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Balance Type field.';
                }
                field(Frequency; Rec.Frequency)
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field(IsCash; Rec."Is Cash")
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Is Cash field.';
                }
                field(Taxable; Rec.Taxable)
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Taxable field.';
                }
                field(IsFormula; Rec."Is Formula")
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Is Formula field.';
                }
                field(Subledger; Rec.Subledger)
                {
                    ToolTip = 'Specifies the value of the Subledger field.';
                }
                field(Formula; Rec.Formula)
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Formula field.';
                }
                field(AmountPreference; Rec."Amount Preference")
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Amount Preference field.';
                }
                field(SpecialTransactions; Rec."Special Transactions")
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Special Transactions field.';
                }
                field(DeductPremium; Rec."Deduct Premium")
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Deduct Premium field.';
                }
                field(InterestRate; Rec."Interest Rate")
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Interest Rate field.';
                }
                field(GLAccount; Rec."GL Account")
                {
                    ToolTip = 'Specifies the value of the GL Account field.';
                }
                field(RepaymentMethod; Rec."Repayment Method")
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Repayment Method field.';
                }
                field(FringeBenefit; Rec."Fringe Benefit")
                {
                    Editable = false;
                    Enabled = true;
                    ToolTip = 'Specifies the value of the Fringe Benefit field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(View)
            {
                Caption = 'View';
                action(SetUpCard)
                {
                    Caption = 'SetUp Card';
                    RunObject = Page "prTransaction Code";
                    RunPageLink = "Transaction Code" = field("Transaction Code");
                    RunPageView = sorting("Transaction Code");
                    ToolTip = 'Executes the SetUp Card action.';
                }
            }
        }
    }
}
