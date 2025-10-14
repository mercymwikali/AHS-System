Page 52202771 "prTransactions Codes List"
{
    CardPageID = "prTransaction Code";
    PageType = List;
    SourceTable = "PR Transaction Codes";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(TransactionCode; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field(BalanceType; Rec."Balance Type")
                {
                    ToolTip = 'Specifies the value of the Balance Type field.';
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field(IsCash; Rec."Is Cash")
                {
                    ToolTip = 'Specifies the value of the Is Cash field.';
                }
                field(Taxable; Rec.Taxable)
                {
                    ToolTip = 'Specifies the value of the Taxable field.';
                }
                field(IsFormula; Rec."Is Formula")
                {
                    ToolTip = 'Specifies the value of the Is Formula field.';
                }
                field(Formula; Rec.Formula)
                {
                    ToolTip = 'Specifies the value of the Formula field.';
                }
                field(AmountPreference; Rec."Amount Preference")
                {
                    ToolTip = 'Specifies the value of the Amount Preference field.';
                }
                field(SpecialTransactions; Rec."Special Transactions")
                {
                    ToolTip = 'Specifies the value of the Special Transactions field.';
                }
                field(DeductPremium; Rec."Deduct Premium")
                {
                    ToolTip = 'Specifies the value of the Deduct Premium field.';
                }
                field(InterestRate; Rec."Interest Rate")
                {
                    ToolTip = 'Specifies the value of the Interest Rate field.';
                }
                field(RepaymentMethod; Rec."Repayment Method")
                {
                    ToolTip = 'Specifies the value of the Repayment Method field.';
                }
                field(FringeBenefit; Rec."Fringe Benefit")
                {
                    ToolTip = 'Specifies the value of the Fringe Benefit field.';
                }
                field(EmployerDeduction; Rec."Employer Deduction")
                {
                    ToolTip = 'Specifies the value of the Employer Deduction field.';
                }
                field(isHouseAllowance; Rec.isHouseAllowance)
                {
                    ToolTip = 'Specifies the value of the isHouseAllowance field.';
                }
                field(IncludeEmployerDeduction; Rec."Include Employer Deduction")
                {
                    ToolTip = 'Specifies the value of the Include Employer Deduction field.';
                }
                field(IsFormulaforemployer; Rec."Is Formula for employer")
                {
                    ToolTip = 'Specifies the value of the Is Formula for employer field.';
                }
                field(TransactionCodeold; Rec."Transaction Code old")
                {
                    ToolTip = 'Specifies the value of the Transaction Code old field.';
                }
                field(GLAccount; Rec."GL Account")
                {
                    ToolTip = 'Specifies the value of the GL Account field.';
                }
                field(GLEmployeeAccount; Rec."GL Employee Account")
                {
                    ToolTip = 'Specifies the value of the GL Employee Account field.';
                }
                field(coopparameters; Rec."coop parameters")
                {
                    ToolTip = 'Specifies the value of the Other Categorization field.';
                }
                field(IsCoopLnRep; Rec."IsCoop/LnRep")
                {
                    ToolTip = 'Specifies the value of the IsCoop/LnRep field.';
                }
                field(DeductMortgage; Rec."Deduct Mortgage")
                {
                    ToolTip = 'Specifies the value of the Deduct Mortgage field.';
                }
                field(Subledger; Rec.Subledger)
                {
                    ToolTip = 'Specifies the value of the Subledger field.';
                }
                field(Welfare; Rec.Welfare)
                {
                    ToolTip = 'Specifies the value of the Welfare field.';
                }
                field(CustomerPostingGroup; Rec.CustomerPostingGroup)
                {
                    ToolTip = 'Specifies the value of the CustomerPostingGroup field.';
                }
                field("Used Count"; Rec."Used Count")
                {
                    ToolTip = 'Specifies the value of the Used Count field.';
                }
            }
        }
    }

    actions
    {
    }
}
