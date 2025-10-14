Page 52203003 "Cash Office Setup UP"
{
    PageType = Card;
    SourceTable = "Cash Office Setup";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
                field(PaymentVoucher; Rec."Normal Payments No")
                {
                    Caption = 'Payment Voucher';
                    ToolTip = 'Specifies the value of the Payment Voucher field.';
                }
                field(ChequeRejectPeriod; Rec."Cheque Reject Period")
                {
                    ToolTip = 'Specifies the value of the Cheque Reject Period field.';
                }
                field(PettyCashPaymentsNo; Rec."Petty Cash Payments No")
                {
                    ToolTip = 'Specifies the value of the Petty Cash Payments No field.';
                }
                field(CurrentBudget; Rec."Current Budget")
                {
                    ToolTip = 'Specifies the value of the Current Budget field.';
                }
                field(CurrentBudgetStartDate; Rec."Current Budget Start Date")
                {
                    ToolTip = 'Specifies the value of the Current Budget Start Date field.';
                }
                field(CurrentBudgetEndDate; Rec."Current Budget End Date")
                {
                    ToolTip = 'Specifies the value of the Current Budget End Date field.';
                }
                field(BankDepositNo; Rec."Bank Deposit No.")
                {
                    ToolTip = 'Specifies the value of the Bank Deposit No. field.';
                }
                field(StaffClaimNo; Rec."Staff Claim No")
                {
                    ToolTip = 'Specifies the value of the Staff Claim No field.';
                }
                field(InterBankTransferNo; Rec."InterBank Transfer No.")
                {
                    ToolTip = 'Specifies the value of the InterBank Transfer No. field.';
                }
                field(SurrenderTemplate; Rec."Surrender Template")
                {
                    ToolTip = 'Specifies the value of the Surrender Template field.';
                }
                field(SurrenderBatch; Rec."Surrender  Batch")
                {
                    ToolTip = 'Specifies the value of the Surrender  Batch field.';
                }
                field(ReceiptsNo; Rec."Receipts No")
                {
                    ToolTip = 'Specifies the value of the Receipts No field.';
                }
                field(CashierTransferNos; Rec."Cashier Transfer Nos")
                {
                    ToolTip = 'Specifies the value of the Cashier Transfer Nos field.';
                }
                field(DefaultBankDepositSlipAC; Rec."Default Bank Deposit Slip A/C")
                {
                    ToolTip = 'Specifies the value of the Default Bank Deposit Slip A/C field.';
                }
                field(Control1102755003; Rec."Imprest Req No")
                {
                    Caption = 'Imprest Req No.';
                    ToolTip = 'Specifies the value of the Imprest Req No. field.';
                }
                field(ImprestSurrenderNo; Rec."Imprest Surrender No")
                {
                    ToolTip = 'Specifies the value of the Imprest Surrender No field.';
                }
                field(PVTemplate; Rec."PV Template")
                {
                    ToolTip = 'Specifies the value of the PV Template field.';
                }
                field(PVBatch; Rec."PV  Batch")
                {
                    ToolTip = 'Specifies the value of the PV  Batch field.';
                }
                field(PaymentScheduleNo; Rec."Payment Schedule No")
                {
                    ToolTip = 'Specifies the value of the Payment Schedule No field.';
                }
                field("Stores Requisition No"; Rec."Stores Requisition No")
                {
                    ToolTip = 'Specifies the value of the Stores Requisition No field.';
                }
                field("Item Cash Purchase Control Ac."; Rec."Item Cash Purchase Control Ac.")
                {
                    ToolTip = 'Specifies the value of the Item Cash Purchase Control Ac. field.';
                }
                field("Items issue Template"; Rec."Items issue Template")
                {
                    ToolTip = 'Specifies the value of the Items issue Template field.';
                }
                field("Items Issue Batch"; Rec."Items Issue Batch")
                {
                    ToolTip = 'Specifies the value of the Items Issue Batch field.';
                }
                field("Requisition Default Vendor"; Rec."Requisition Default Vendor")
                {
                    ToolTip = 'Specifies the value of the Requisition Default Vendor field.';
                }
                field("Quotation Request No"; Rec."Quotation Request No")
                {
                    ToolTip = 'Specifies the value of the Quotation Request No field.';
                }
                field("Casual Nos"; Rec."Casual Nos")
                {
                    ToolTip = 'Specifies the value of the Casual Nos field.';
                }
                field("Casual Payment Nos"; Rec."Casual Payment Nos")
                {
                    ToolTip = 'Specifies the value of the Casual Payment Nos field.';
                }
                field("Parttimers Nos"; Rec."Parttimers Nos")
                {
                    ToolTip = 'Specifies the value of the Parttimers Nos field.';
                }
                field("Invoice Dispatch Nos"; Rec."Invoice Dispatch Nos")
                {
                    ToolTip = 'Specifies the value of the Invoice Dispatch Nos field.';
                }
            }
        }
    }

    actions
    {
    }
}
