Page 52202810 "prTransaction Code"
{
    PageType = Card;
    SourceTable = "PR Transaction Codes";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(TransactionCode; Rec."Transaction Code")
                {
                    ToolTip = 'Specifies the value of the Transaction Code field.';
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(Frequency; Rec.Frequency)
                {
                    ToolTip = 'Specifies the value of the Frequency field.';
                }
                field(BalanceType; Rec."Balance Type")
                {
                    ToolTip = 'Specifies the value of the Balance Type field.';
                }
                field(AmountPreference; Rec."Amount Preference")
                {
                    ToolTip = 'Specifies the value of the Amount Preference field.';
                }
                field(NonCashBenefit; Rec."Non Cash Benefit")
                {
                    ToolTip = 'Specifies the value of the Non Cash Benefit field.';
                }
                field(IsCash; Rec."Is Cash")
                {
                    ToolTip = 'Specifies the value of the Is Cash field.';
                }
                field(IsFormula; Rec."Is Formula")
                {
                    ToolTip = 'Specifies the value of the Is Formula field.';
                }
                field(Taxable; Rec.Taxable)
                {
                    ToolTip = 'Specifies the value of the Taxable field.';
                }
                field(Formula; Rec.Formula)
                {
                    ToolTip = 'Specifies the value of the Formula field.';
                }
                field(formulae; 'E.g. ([0.05]+[0.20]*[24])/2268....')
                {
                    Caption = 'Formula example';
                    ToolTip = 'Specifies the value of the Formula example field.';
                }
                field(MaximumAmount; Rec."Maximum Amount")
                {
                    ToolTip = 'Specifies the value of the Maximum Amount field.';
                }
                field(IncludeEmployerDeduction; Rec."Include Employer Deduction")
                {
                    ToolTip = 'Specifies the value of the Include Employer Deduction field.';
                }
                field(EmployerDeduction; Rec."Employer Deduction")
                {
                    ToolTip = 'Specifies the value of the Employer Deduction field.';
                }
                field(IsFormulaforemployer; Rec."Is Formula for employer")
                {
                    ToolTip = 'Specifies the value of the Is Formula for employer field.';
                }
                field(EMPfORMULA; 'E.g. ([0.05]+[0.20]*[24])/2268....')
                {
                    Caption = 'Employer Formula Example';
                    ToolTip = 'Specifies the value of the Employer Formula Example field.';
                }
                field(GLAccount; Rec."GL Account")
                {
                    ToolTip = 'Specifies the value of the GL Account field.';
                }
                field(GLEmployeeAccount; Rec."GL Employee Account")
                {
                    ToolTip = 'Specifies the value of the GL Employee Account field.';
                }
                field(Pension; Rec.Pension)
                {
                    ToolTip = 'Specifies the value of the Pension field.';
                }
                field(FringeBenefit; Rec."Fringe Benefit")
                {
                    ToolTip = 'Specifies the value of the Fringe Benefit field.';
                }
                field(Control21; Rec."Interest Rate")
                {
                    Caption = 'Interest Rate (%)';
                    ToolTip = 'Specifies the value of the Interest Rate (%) field.';
                }
                field("Imprest Surrender"; Rec."Imprest Surrender")
                {
                    ToolTip = 'Specifies the value of the Imprest Surrender field.';
                }
                field(itaxGrouping; Rec."itax Grouping")
                {
                    ToolTip = 'Specifies the value of the itax Grouping field.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field(Exception; Rec.Exception)
                {
                    ToolTip = 'Specifies the value of the Exception field.';
                }
            }
            group(OtherSetups)
            {

                field(SpecialTransactions; Rec."Special Transactions")
                {
                    ToolTip = 'Specifies the value of the Special Transactions field.';
                }
                field(RepaymentMethod; Rec."Repayment Method")
                {
                    ToolTip = 'Specifies the value of the Repayment Method field.';
                }
                field(CooperateParameters; Rec."IsCoop/LnRep")
                {
                    Caption = 'Cooperate Parameters';
                    ToolTip = 'Specifies the value of the Cooperate Parameters field.';
                }
                field(coopparameters; Rec."coop parameters")
                {
                    ToolTip = 'Specifies the value of the Other Categorization field.';
                }
                field(DeductPremium; Rec."Deduct Premium")
                {
                    ToolTip = 'Specifies the value of the Deduct Premium field.';
                }
            }
            group(Grouping)
            {
                field("Transaction grouping"; Rec."Transaction grouping")
                {
                    ToolTip = 'Specifies the value of the Transaction grouping field.';
                }
                field("Grouping Name"; Rec."Grouping Name")
                {
                    ToolTip = 'Specifies the value of the Grouping Name field.';
                }
            }
        }
    }

    actions
    {
    }
}
