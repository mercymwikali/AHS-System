Page 52202981 "Payments List"
{
    PageType = List;
    SourceTable = "Payment Line";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(PayMode; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field(ChequeNo; Rec."Cheque No")
                {
                    ToolTip = 'Specifies the value of the Cheque No field.';
                }
                field(ChequeDate; Rec."Cheque Date")
                {
                    ToolTip = 'Specifies the value of the Cheque Date field.';
                }
                field(ChequeType; Rec."Cheque Type")
                {
                    ToolTip = 'Specifies the value of the Cheque Type field.';
                }
                field(BankCode; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.';
                }
                field(ReceivedFrom; Rec."Received From")
                {
                    ToolTip = 'Specifies the value of the Received From field.';
                }
                field(OnBehalfOf; Rec."On Behalf Of")
                {
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ToolTip = 'Specifies the value of the Cashier field.';
                }
                field(AccountType; Rec."Account Type")
                {
                    ToolTip = 'Specifies the value of the Account Type field.';
                }
                field(AccountNo; Rec."Account No.")
                {
                    ToolTip = 'Specifies the value of the Account No. field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(AccountName; Rec."Account Name")
                {
                    ToolTip = 'Specifies the value of the Account Name field.';
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.';
                }
                field(DatePosted; Rec."Date Posted")
                {
                    ToolTip = 'Specifies the value of the Date Posted field.';
                }
                field(TimePosted; Rec."Time Posted")
                {
                    ToolTip = 'Specifies the value of the Time Posted field.';
                }
                field(PostedBy; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field(TransactionName; Rec."Transaction Name")
                {
                    ToolTip = 'Specifies the value of the Transaction Name field.';
                }
                field(VATCode; Rec."VAT Code")
                {
                    ToolTip = 'Specifies the value of the VAT Code field.';
                }
                field(WithholdingTaxCode; Rec."Withholding Tax Code")
                {
                    ToolTip = 'Specifies the value of the Withholding Tax Code field.';
                }
                field(VATAmount; Rec."VAT Amount")
                {
                    ToolTip = 'Specifies the value of the VAT Amount field.';
                }
                field(WithholdingTaxAmount; Rec."Withholding Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Withholding Tax Amount field.';
                }
                field(NetAmount; Rec."Net Amount")
                {
                    ToolTip = 'Specifies the value of the Net Amount field.';
                }
                field(PayingBankAccount; Rec."Paying Bank Account")
                {
                    ToolTip = 'Specifies the value of the Paying Bank Account field.';
                }
                field(Payee; Rec.Payee)
                {
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(BranchCode; Rec."Branch Code")
                {
                    ToolTip = 'Specifies the value of the Branch Code field.';
                }
                field(POINVNo; Rec."PO/INV No")
                {
                    ToolTip = 'Specifies the value of the PO/INV No field.';
                }
                field(BankAccountNo; Rec."Bank Account No")
                {
                    ToolTip = 'Specifies the value of the Bank Account No field.';
                }
                field(CashierBankAccount; Rec."Cashier Bank Account")
                {
                    ToolTip = 'Specifies the value of the Cashier Bank Account field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Select; Rec.Select)
                {
                    ToolTip = 'Specifies the value of the Select field.';
                }
                field(Grouping; Rec.Grouping)
                {
                    ToolTip = 'Specifies the value of the Grouping field.';
                }
                field(PaymentType; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field(BankType; Rec."Bank Type")
                {
                    ToolTip = 'Specifies the value of the Bank Type field.';
                }
                field(PVType; Rec."PV Type")
                {
                    ToolTip = 'Specifies the value of the PV Type field.';
                }
                field(Applyto; Rec."Apply to")
                {
                    ToolTip = 'Specifies the value of the Apply to field.';
                }
                field(ApplytoID; Rec."Apply to ID")
                {
                    ToolTip = 'Specifies the value of the Apply to ID field.';
                }
                field(NoofUnits; Rec."No of Units")
                {
                    ToolTip = 'Specifies the value of the No of Units field.';
                }
                field(SurrenderDate; Rec."Surrender Date")
                {
                    ToolTip = 'Specifies the value of the Surrender Date field.';
                }
                field(Surrendered; Rec.Surrendered)
                {
                    ToolTip = 'Specifies the value of the Surrendered field.';
                }
                field(SurrenderDocNo; Rec."Surrender Doc. No")
                {
                    ToolTip = 'Specifies the value of the Surrender Doc. No field.';
                }
                field(VoteBook; Rec."Vote Book")
                {
                    ToolTip = 'Specifies the value of the Vote Book field.';
                }
                field(TotalAllocation; Rec."Total Allocation")
                {
                    ToolTip = 'Specifies the value of the Total Allocation field.';
                }
                field(TotalExpenditure; Rec."Total Expenditure")
                {
                    ToolTip = 'Specifies the value of the Total Expenditure field.';
                }
                field(TotalCommitments; Rec."Total Commitments")
                {
                    ToolTip = 'Specifies the value of the Total Commitments field.';
                }
                field(Balance; Rec.Balance)
                {
                    ToolTip = 'Specifies the value of the Balance field.';
                }
                field(BalanceLessthisEntry; Rec."Balance Less this Entry")
                {
                    ToolTip = 'Specifies the value of the Balance Less this Entry field.';
                }
                field(ApplicantDesignation; Rec."Applicant Designation")
                {
                    ToolTip = 'Specifies the value of the Applicant Designation field.';
                }
                field(PettyCash; Rec."Petty Cash")
                {
                    ToolTip = 'Specifies the value of the Petty Cash field.';
                }
                field(SupplierInvoiceNo; Rec."Supplier Invoice No.")
                {
                    ToolTip = 'Specifies the value of the Supplier Invoice No. field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(ImprestRequestNo; Rec."Imprest Request No")
                {
                    ToolTip = 'Specifies the value of the Imprest Request No field.';
                }
                field(BatchedImprestTot; Rec."Batched Imprest Tot")
                {
                    ToolTip = 'Specifies the value of the Batched Imprest Tot field.';
                }
                field(FunctionName; Rec."Function Name")
                {
                    ToolTip = 'Specifies the value of the Function Name field.';
                }
                field(BudgetCenterName; Rec."Budget Center Name")
                {
                    ToolTip = 'Specifies the value of the Budget Center Name field.';
                }
                field(FarmerPurchaseNo; Rec."Farmer Purchase No")
                {
                    ToolTip = 'Specifies the value of the Farmer Purchase No field.';
                }
                field(TransporterAnanlysisNo; Rec."Transporter Ananlysis No")
                {
                    ToolTip = 'Specifies the value of the Transporter Ananlysis No field.';
                }
                field(UserID; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field(JournalTemplate; Rec."Journal Template")
                {
                    ToolTip = 'Specifies the value of the Journal Template field.';
                }
                field(JournalBatch; Rec."Journal Batch")
                {
                    ToolTip = 'Specifies the value of the Journal Batch field.';
                }
                field(LineNo; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field(RequireSurrender; Rec."Require Surrender")
                {
                    ToolTip = 'Specifies the value of the Require Surrender field.';
                }
                field(CommitedAmmount; Rec."Commited Ammount")
                {
                    ToolTip = 'Specifies the value of the Commited Ammount field.';
                }
                field(SelecttoSurrender; Rec."Select to Surrender")
                {
                    ToolTip = 'Specifies the value of the Select to Surrender field.';
                }
                field(PaymentReference; Rec."Payment Reference")
                {
                    ToolTip = 'Specifies the value of the Payment Reference field.';
                }
                field(IDNumber; Rec."ID Number")
                {
                    ToolTip = 'Specifies the value of the ID Number field.';
                }
                field(VATRate; Rec."VAT Rate")
                {
                    ToolTip = 'Specifies the value of the VAT Rate field.';
                }
                field(AmountWithVAT; Rec."Amount With VAT")
                {
                    ToolTip = 'Specifies the value of the Amount With VAT field.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(ExchangeRate; Rec."Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field(CurrencyReciprical; Rec."Currency Reciprical")
                {
                    ToolTip = 'Specifies the value of the Currency Reciprical field.';
                }
                field(VATProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Prod. Posting Group field.';
                }
                field(BudgetaryControlAC; Rec."Budgetary Control A/C")
                {
                    ToolTip = 'Specifies the value of the Budgetary Control A/C field.';
                }
                field(ShortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field(ShortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field(Committed; Rec.Committed)
                {
                    ToolTip = 'Specifies the value of the Committed field.';
                }
                field(CurrencyFactor; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field(NetAmountLCY; Rec."NetAmount LCY")
                {
                    ToolTip = 'Specifies the value of the NetAmount LCY field.';
                }
                field(AppliestoDocType; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field.';
                }
                field(AppliestoDocNo; Rec."Applies-to Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field.';
                }
                field(AppliestoID; Rec."Applies-to ID")
                {
                    ToolTip = 'Specifies the value of the Applies-to ID field.';
                }
                field(RetentionCode; Rec."Retention Code")
                {
                    ToolTip = 'Specifies the value of the Retention Code field.';
                }
                field(RetentionAmount; Rec."Retention  Amount")
                {
                    ToolTip = 'Specifies the value of the Retention  Amount field.';
                }
                field(RetentionRate; Rec."Retention Rate")
                {
                    ToolTip = 'Specifies the value of the Retention Rate field.';
                }
                field(WTaxRate; Rec."W/Tax Rate")
                {
                    ToolTip = 'Specifies the value of the W/Tax Rate field.';
                }
                field(VendorBankAccount; Rec."Vendor Bank Account")
                {
                    ToolTip = 'Specifies the value of the Vendor Bank Account field.';
                }
                field(EFTBankAccountNo; Rec."EFT Bank Account No")
                {
                    ToolTip = 'Specifies the value of the EFT Bank Account No field.';
                }
                field(EFTBankCode; Rec."EFT Bank Code")
                {
                    ToolTip = 'Specifies the value of the EFT Bank Code field.';
                }
                field(EFTAccountName; Rec."EFT Account Name")
                {
                    ToolTip = 'Specifies the value of the EFT Account Name field.';
                }
                field(EFTBranchNo; Rec."EFT Branch No.")
                {
                    ToolTip = 'Specifies the value of the EFT Branch No. field.';
                }
                field(DocumentType; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field(DocumentNo; Rec."Document No")
                {
                    ToolTip = 'Specifies the value of the Document No field.';
                }
                field(DocumentLine; Rec."Document Line")
                {
                    ToolTip = 'Specifies the value of the Document Line field.';
                }
            }
        }
    }

    actions
    {
    }
}
