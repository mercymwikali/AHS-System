page 85105 "Cash Office Setup UP"
{
    PageType = Card;
    SourceTable = "Cash Office Setup";

    ApplicationArea = All;
    UsageCategory = Administration;

    Caption = 'Cash Office Setup';

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';

                field(PaymentVoucher; Rec."Normal Payments No") { }
                field(ChequeRejectPeriod; Rec."Cheque Reject Period") { }
                field(PettyCashPaymentsNo; Rec."Petty Cash Payments No") { }
                field(CurrentBudget; Rec."Current Budget") { }
                field(CurrentBudgetStartDate; Rec."Current Budget Start Date") { }
                field(CurrentBudgetEndDate; Rec."Current Budget End Date") { }
                field(BankDepositNo; Rec."Bank Deposit No.") { }
                field(StaffClaimNo; Rec."Staff Claim No") { }
                field(InterBankTransferNo; Rec."InterBank Transfer No.") { }
                field(SurrenderTemplate; Rec."Surrender Template") { }
                field(SurrenderBatch; Rec."Surrender  Batch") { }
                field(ReceiptsNo; Rec."Receipts No") { }
                field(CashierTransferNos; Rec."Cashier Transfer Nos") { }
                field(DefaultBankDepositSlipAC; Rec."Default Bank Deposit Slip A/C") { }
                field(ImprestReqNo; Rec."Imprest Req No") { Caption = 'Imprest Req No.'; }
                field(ImprestSurrenderNo; Rec."Imprest Surrender No") { }
                field(PVTemplate; Rec."PV Template") { }
                field(PVBatch; Rec."PV  Batch") { }
                field(PaymentScheduleNo; Rec."Payment Schedule No") { }
                field(StoresRequisitionNo; Rec."Stores Requisition No") { }
                field(ItemCashPurchaseControlAc; Rec."Item Cash Purchase Control Ac.") { }
                field(ItemsIssueTemplate; Rec."Items issue Template") { }
                field(ItemsIssueBatch; Rec."Items Issue Batch") { }
                field(RequisitionDefaultVendor; Rec."Requisition Default Vendor") { }
                field(QuotationRequestNo; Rec."Quotation Request No") { }
                field(CasualNos; Rec."Casual Nos") { }
                field(CasualPaymentNos; Rec."Casual Payment Nos") { }
                field(ParttimersNos; Rec."Parttimers Nos") { }
                field(InvoiceDispatchNos; Rec."Invoice Dispatch Nos") { }
            }
        }
    }
}