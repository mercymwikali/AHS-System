Page 85240 "Purchase Requisition-Approved"
{
    CardPageID = "Internal Requisitions Approved";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = where(DocApprovalType = filter(Requisition),
                            Status = filter(Released));
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(DocumentType; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field(BuyfromVendorNo; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(PaytoVendorNo; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor that you received the invoice from.';
                }
                field(PaytoName; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the vendor who you received the invoice from.';
                }
                field(PaytoName2; Rec."Pay-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Pay-to Name 2 field.';
                }
                field(PaytoAddress; Rec."Pay-to Address")
                {
                    ToolTip = 'Specifies the address of the vendor sending the invoice.';
                }
                field(PaytoAddress2; Rec."Pay-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field(PaytoCity; Rec."Pay-to City")
                {
                    ToolTip = 'Specifies the city of the vendor sending the invoice.';
                }
                field(PaytoContact; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                }
                field(YourReference; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the vendor''s reference.';
                }
                field(ShiptoCode; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                }
                field(ShiptoName; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer at the address that the items are shipped to.';
                }
                field(ShiptoName2; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name 2 field.';
                }
                field(ShiptoAddress; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the address that you want the items in the purchase order to be shipped to.';
                }
                field(ShiptoAddress2; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field(ShiptoCity; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the city the items in the purchase order will be shipped to.';
                }
                field(ShiptoContact; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the address that the items are shipped to.';
                }
                field(OrderDate; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the order was created.';
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                }
                field(ExpectedReceiptDate; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse. If you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.';
                }
                field(PostingDescription; Rec."Posting Description")
                {
                    ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
                }
                field(PaymentTermsCode; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                }
                field(DueDate; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields.';
                }
                field(PaymentDiscount; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                }
                field(PmtDiscountDate; Rec."Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field(ShipmentMethodCode; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                }
                field(LocationCode; Rec."Location Code")
                {
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field(VendorPostingGroup; Rec."Vendor Posting Group")
                {
                    ToolTip = 'Specifies the vendor''s market type to link business transactions to.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the code of the currency of the amounts on the purchase lines.';
                }
                field(CurrencyFactor; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field(PricesIncludingVAT; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';
                }
                field(InvoiceDiscCode; Rec."Invoice Disc. Code")
                {
                    ToolTip = 'Specifies the value of the Invoice Disc. Code field.';
                }
                field(LanguageCode; Rec."Language Code")
                {
                    ToolTip = 'Specifies the language to be used on printouts for this document.';
                }
                field(PurchaserCode; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                }
                field(OrderClass; Rec."Order Class")
                {
                    ToolTip = 'Specifies the value of the Order Class field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(NoPrinted; Rec."No. Printed")
                {
                    ToolTip = 'Specifies the value of the No. Printed field.';
                }
                field(OnHold; Rec."On Hold")
                {
                    ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
                }
                field(AppliestoDocType; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field(AppliestoDocNo; Rec."Applies-to Doc. No.")
                {
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field(BalAccountNo; Rec."Bal. Account No.")
                {
                    ToolTip = 'Specifies the value of the Bal. Account No. field.';
                }
                field(Receive; Rec.Receive)
                {
                    ToolTip = 'Specifies the value of the Receive field.';
                }
                field(Invoice; Rec.Invoice)
                {
                    ToolTip = 'Specifies the value of the Invoice field.';
                }
                field(PrintPostedDocuments; Rec."Print Posted Documents")
                {
                    ToolTip = 'Specifies the value of the Print Posted Documents field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the sum of the amounts in the Amount field on the associated purchase lines.';
                }
                field(AmountIncludingVAT; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the total of the amounts, including VAT, on all the lines on the document.';
                }
                field(ReceivingNo; Rec."Receiving No.")
                {
                    ToolTip = 'Specifies the value of the Receiving No. field.';
                }
                field(PostingNo; Rec."Posting No.")
                {
                    ToolTip = 'Specifies the value of the Posting No. field.';
                }
                field(LastReceivingNo; Rec."Last Receiving No.")
                {
                    ToolTip = 'Specifies the value of the Last Receiving No. field.';
                }
                field(LastPostingNo; Rec."Last Posting No.")
                {
                    ToolTip = 'Specifies the value of the Last Posting No. field.';
                }
                field(VendorOrderNo; Rec."Vendor Order No.")
                {
                    ToolTip = 'Specifies the vendor''s order number.';
                }
                field(VendorShipmentNo; Rec."Vendor Shipment No.")
                {
                    ToolTip = 'Specifies the vendor''s shipment number. It is inserted in the corresponding field on the source document during posting.';
                }
                field(VendorInvoiceNo; Rec."Vendor Invoice No.")
                {
                    ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
                }
                field(VendorCrMemoNo; Rec."Vendor Cr. Memo No.")
                {
                    ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
                }
                field(VATRegistrationNo; Rec."VAT Registration No.")
                {
                    ToolTip = 'Specifies the value of the VAT Registration No. field.';
                }
                field(SelltoCustomerNo; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the number of the customer that the items are shipped to directly from your vendor, as a drop shipment.';
                }
                field(ReasonCode; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the document.';
                }
                field(GenBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the type of transaction that the document represents, for the purpose of reporting to INTRASTAT.';
                }
                field(TransportMethod; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the transport method, for the purpose of reporting to INTRASTAT.';
                }
                field(VATCountryRegionCode; Rec."VAT Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the VAT Country/Region Code field.';
                }
                field(BuyfromVendorName; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field(BuyfromVendorName2; Rec."Buy-from Vendor Name 2")
                {
                    ToolTip = 'Specifies the value of the Buy-from Vendor Name 2 field.';
                }
                field(BuyfromAddress; Rec."Buy-from Address")
                {
                    ToolTip = 'Specifies the address of the vendor who ships the items.';
                }
                field(BuyfromAddress2; Rec."Buy-from Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field(BuyfromCity; Rec."Buy-from City")
                {
                    ToolTip = 'Specifies the city of the vendor who ships the items.';
                }
                field(BuyfromContact; Rec."Buy-from Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the vendor who delivered the items.';
                }
                field(PaytoPostCode; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor that you received the invoice from.';
                }
                field(PaytoCounty; Rec."Pay-to County")
                {
                    ToolTip = 'Specifies the state, province or county of the address.';
                }
                field(PaytoCountryRegionCode; Rec."Pay-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                }
                field(BuyfromPostCode; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor who delivered the items.';
                }
                field(BuyfromCounty; Rec."Buy-from County")
                {
                    ToolTip = 'Specifies the state, province or county of the address.';
                }
                field(BuyfromCountryRegionCode; Rec."Buy-from Country/Region Code")
                {
                    ToolTip = 'Specifies the city of the vendor who delivered the items.';
                }
                field(ShiptoPostCode; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address that the items are shipped to.';
                }
                field(ShiptoCounty; Rec."Ship-to County")
                {
                    ToolTip = 'Specifies the state, province or county of the address.';
                }
                field(ShiptoCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address that the items are shipped to.';
                }
                field(BalAccountType; Rec."Bal. Account Type")
                {
                    ToolTip = 'Specifies the value of the Bal. Account Type field.';
                }
                field(OrderAddressCode; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the order address of the related vendor.';
                }
                field(EntryPoint; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the code of the port of entry where the items pass into your country/region, for reporting to Intrastat.';
                }
                field(Correction; Rec.Correction)
                {
                    ToolTip = 'Specifies the entry as a corrective entry. You can use the field if you need to post a corrective entry to a vendor account. If you place a check mark in this field when posting a corrective entry, the system will post a negative debit instead of a credit or a negative credit instead of a debit. Correction flag does not affect how inventory reconciled with general ledger.';
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Area"; Rec.Area)
                {
                    ToolTip = 'Specifies the destination country or region for the purpose of Intrastat reporting.';
                }
                field(TransactionSpecification; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies a specification of the document''s transaction, for the purpose of reporting to INTRASTAT.';
                }
                field(PaymentMethodCode; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(PostingNoSeries; Rec."Posting No. Series")
                {
                    ToolTip = 'Specifies the value of the Posting No. Series field.';
                }
                field(ReceivingNoSeries; Rec."Receiving No. Series")
                {
                    ToolTip = 'Specifies the value of the Receiving No. Series field.';
                }
                field(TaxAreaCode; Rec."Tax Area Code")
                {
                    ToolTip = 'Specifies the tax area code used for this purchase to calculate and post sales tax.';
                }
                field(TaxLiable; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies if this vendor charges you sales tax for purchases.';
                }
                field(VATBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                }
                field(AppliestoID; Rec."Applies-to ID")
                {
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                }
                field(VATBaseDiscount; Rec."VAT Base Discount %")
                {
                    ToolTip = 'Specifies the value of the VAT Base Discount % field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                field(InvoiceDiscountCalculation; Rec."Invoice Discount Calculation")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Calculation field.';
                }
                field(InvoiceDiscountValue; Rec."Invoice Discount Value")
                {
                    ToolTip = 'Specifies the value of the Invoice Discount Value field.';
                }
                field(SendICDocument; Rec."Send IC Document")
                {
                    ToolTip = 'Specifies the value of the Send IC Document field.';
                }
                field(ICStatus; Rec."IC Status")
                {
                    ToolTip = 'Specifies the value of the IC Status field.';
                }
                field(BuyfromICPartnerCode; Rec."Buy-from IC Partner Code")
                {
                    ToolTip = 'Specifies the value of the Buy-from IC Partner Code field.';
                }
                field(PaytoICPartnerCode; Rec."Pay-to IC Partner Code")
                {
                    ToolTip = 'Specifies the value of the Pay-to IC Partner Code field.';
                }
                field(ICDirection; Rec."IC Direction")
                {
                    ToolTip = 'Specifies the value of the IC Direction field.';
                }
                field(PrepaymentNo; Rec."Prepayment No.")
                {
                    ToolTip = 'Specifies the value of the Prepayment No. field.';
                }
                field(LastPrepaymentNo; Rec."Last Prepayment No.")
                {
                    ToolTip = 'Specifies the value of the Last Prepayment No. field.';
                }
                field(PrepmtCrMemoNo; Rec."Prepmt. Cr. Memo No.")
                {
                    ToolTip = 'Specifies the value of the Prepmt. Cr. Memo No. field.';
                }
                field(LastPrepmtCrMemoNo; Rec."Last Prepmt. Cr. Memo No.")
                {
                    ToolTip = 'Specifies the value of the Last Prepmt. Cr. Memo No. field.';
                }
                field(Prepayment; Rec."Prepayment %")
                {
                    ToolTip = 'Specifies the prepayment percentage to use to calculate the prepayment for sales.';
                }
                field(PrepaymentNoSeries; Rec."Prepayment No. Series")
                {
                    ToolTip = 'Specifies the value of the Prepayment No. Series field.';
                }
                field(CompressPrepayment; Rec."Compress Prepayment")
                {
                    ToolTip = 'Specifies that prepayments on the purchase order are combined if they have the same general ledger account for prepayments or the same dimensions.';
                }
                field(PrepaymentDueDate; Rec."Prepayment Due Date")
                {
                    ToolTip = 'Specifies when the prepayment invoice for this purchase order is due.';
                }
                field(PrepmtCrMemoNoSeries; Rec."Prepmt. Cr. Memo No. Series")
                {
                    ToolTip = 'Specifies the value of the Prepmt. Cr. Memo No. Series field.';
                }
                field(PrepmtPostingDescription; Rec."Prepmt. Posting Description")
                {
                    ToolTip = 'Specifies the value of the Prepmt. Posting Description field.';
                }
                field(PrepmtPmtDiscountDate; Rec."Prepmt. Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the last date the vendor can pay the prepayment invoice and still receive a payment discount on the prepayment amount.';
                }
                field(PrepmtPaymentTermsCode; Rec."Prepmt. Payment Terms Code")
                {
                    ToolTip = 'Specifies the code that represents the payment terms for prepayment invoices related to the purchase document.';
                }
                field(PrepmtPaymentDiscount; Rec."Prepmt. Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted on the prepayment if the vendor pays on or before the date entered in the Prepmt. Pmt. Discount Date field.';
                }
                field(QuoteNo; Rec."Quote No.")
                {
                    ToolTip = 'Specifies the quote number for the purchase order.';
                }
                field(JobQueueStatus; Rec."Job Queue Status")
                {
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase credit memos.';
                }
                field(JobQueueEntryID; Rec."Job Queue Entry ID")
                {
                    ToolTip = 'Specifies the value of the Job Queue Entry ID field.';
                }
                field(DimensionSetID; Rec."Dimension Set ID")
                {
                    ToolTip = 'Specifies the value of the Dimension Set ID field.';
                }
                field(NoofArchivedVersions; Rec."No. of Archived Versions")
                {
                    ToolTip = 'Specifies the number of archived versions for this document.';
                }
                field(DocNoOccurrence; Rec."Doc. No. Occurrence")
                {
                    ToolTip = 'Specifies the value of the Doc. No. Occurrence field.';
                }
                field(CampaignNo; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the number of the campaign that the document is linked to.';
                }
                field(BuyfromContactNo; Rec."Buy-from Contact No.")
                {
                    ToolTip = 'Specifies the number of your contact at the vendor.';
                }
                field(PaytoContactNo; Rec."Pay-to Contact No.")
                {
                    ToolTip = 'Specifies the number of the contact who sends the invoice.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the code of the responsibility center, such as a distribution hub, that is associated with the involved user, company, customer, or vendor.';
                }
                field(CompletelyReceived; Rec."Completely Received")
                {
                    ToolTip = 'Specifies if all the items on the order have been shipped or, in the case of inbound items, completely received.';
                }
                field(PostingfromWhseRef; Rec."Posting from Whse. Ref.")
                {
                    ToolTip = 'Specifies the value of the Posting from Whse. Ref. field.';
                }
                field(LocationFilter; Rec."Location Filter")
                {
                    ToolTip = 'Specifies the value of the Location Filter field.';
                }
                field(RequestedReceiptDate; Rec."Requested Receipt Date")
                {
                    ToolTip = 'Specifies the date that you want the vendor to deliver your order. The field is used to calculate the latest date you can order, as follows: requested receipt date - lead time calculation = order date. If you do not need delivery on a specific date, you can leave the field blank.';
                }
                field(PromisedReceiptDate; Rec."Promised Receipt Date")
                {
                    ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
                }
                field(LeadTimeCalculation; Rec."Lead Time Calculation")
                {
                    ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
                }
                field(InboundWhseHandlingTime; Rec."Inbound Whse. Handling Time")
                {
                    ToolTip = 'Specifies the time it takes to make items part of available inventory, after the items have been posted as received.';
                }
                field(DateFilter; Rec."Date Filter")
                {
                    ToolTip = 'Specifies the value of the Date Filter field.';
                }
                field(VendorAuthorizationNo; Rec."Vendor Authorization No.")
                {
                    ToolTip = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).';
                }
                field(ReturnShipmentNo; Rec."Return Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Return Shipment No. field.';
                }
                field(ReturnShipmentNoSeries; Rec."Return Shipment No. Series")
                {
                    ToolTip = 'Specifies the value of the Return Shipment No. Series field.';
                }
                field(Ship; Rec.Ship)
                {
                    ToolTip = 'Specifies the value of the Ship field.';
                }
                field(LastReturnShipmentNo; Rec."Last Return Shipment No.")
                {
                    ToolTip = 'Specifies the value of the Last Return Shipment No. field.';
                }
                field(AssignedUserID; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field(Copied; Rec.Copied)
                {
                    ToolTip = 'Specifies the value of the Copied field.';
                }
                field(DebitNote; Rec."Debit Note")
                {
                    ToolTip = 'Specifies the value of the Debit Note field.';
                }
                field(ProcurementRequestNo; Rec."Procurement Request No.")
                {
                    ToolTip = 'Specifies the value of the Procurement Request No. field.';
                }
                field(InvoiceAmount; Rec."Invoice Amount")
                {
                    ToolTip = 'Specifies the value of the Invoice Amount field.';
                }
                field(RequestNo; Rec."Request No")
                {
                    ToolTip = 'Specifies the value of the Request No field.';
                }
                field(Commited; Rec.Commited)
                {
                    ToolTip = 'Specifies the value of the Commited field.';
                }
                field(Department; Rec.Department)
                {
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field(DeliveryNo; Rec."Delivery No")
                {
                    ToolTip = 'Specifies the value of the Delivery No field.';
                }
                field(LedgerCardNo; Rec."Ledger Card No")
                {
                    ToolTip = 'Specifies the value of the Ledger Card No field.';
                }
                field(PRNNo; Rec."PRN No")
                {
                    ToolTip = 'Specifies the value of the PRN No field.';
                }
                field(ApprovalStatus; Rec."Approval Status")
                {
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
                field(POStatus; Rec."PO Status")
                {
                    ToolTip = 'Specifies the value of the PO Status field.';
                }
                field(FinanceStatus; Rec."Finance Status")
                {
                    ToolTip = 'Specifies the value of the Finance Status field.';
                }
                field(AdminStatus; Rec."Admin Status")
                {
                    ToolTip = 'Specifies the value of the Admin Status field.';
                }
                field(POName; Rec."P.O Name")
                {
                    ToolTip = 'Specifies the value of the P.O Name field.';
                }
                field(POApprovalDate; Rec."P.O Approval Date")
                {
                    ToolTip = 'Specifies the value of the P.O Approval Date field.';
                }
                field(FinanceApprovedBy; Rec."Finance Approved By")
                {
                    ToolTip = 'Specifies the value of the Finance Approved By field.';
                }
                field(FinanceApprovalDate; Rec."Finance Approval Date")
                {
                    ToolTip = 'Specifies the value of the Finance Approval Date field.';
                }
                field(AdminApprovedBy; Rec."Admin Approved By")
                {
                    ToolTip = 'Specifies the value of the Admin Approved By field.';
                }
                field(AdminApprovedDate; Rec."Admin Approved Date")
                {
                    ToolTip = 'Specifies the value of the Admin Approved Date field.';
                }
                field(ContractNo; Rec."Contract No.")
                {
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field(QuotationNo; Rec."Quotation No.")
                {
                    ToolTip = 'Specifies the value of the Quotation No. field.';
                }
                field(RequestforQuoteNo; Rec."Request for Quote No.")
                {
                    ToolTip = 'Specifies the value of the Request for Quote No. field.';
                }
                field(DocumentType2; Rec."Document Type 2")
                {
                    ToolTip = 'Specifies the value of the Document Type 2 field.';
                }
                field(TendorNumber; Rec."Tendor Number")
                {
                    ToolTip = 'Specifies the value of the Tendor Number field.';
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ToolTip = 'Specifies the value of the Cancelled field.';
                }
                field(CancelledBy; Rec."Cancelled By")
                {
                    ToolTip = 'Specifies the value of the Cancelled By field.';
                }
                field(CancelledDate; Rec."Cancelled Date")
                {
                    ToolTip = 'Specifies the value of the Cancelled Date field.';
                }
                field(DocApprovalType; Rec.DocApprovalType)
                {
                    ToolTip = 'Specifies the value of the DocApprovalType field.';
                }
                field(ProcurementTypeCode; Rec."Procurement Type Code")
                {
                    ToolTip = 'Specifies the value of the Procurement Type Code field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Quote)
            {
                Caption = '&Quote';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';
                    ToolTip = 'Executes the Statistics action.';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader();
                        Commit();
                        Page.RunModal(Page::"Purchase Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = field("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
                }
                action(Comments)
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                    ToolTip = 'Executes the Co&mments action.';
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'Executes the Approvals action.';

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.SetRecordFilters(Database::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.Run();
                    end;
                }
            }
            group(Line)
            {
                Caption = '&Line';
                group(ItemAvailabilityby)
                {
                    Caption = 'Item Availability by';
                    action(Period)
                    {
                        Caption = 'Period';
                        ToolTip = 'Executes the Period action.';

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.ItemAvailability(0);
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        ToolTip = 'Executes the Variant action.';

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.ItemAvailability(1);
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        ToolTip = 'Executes the Location action.';

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.ItemAvailability(2);
                        end;
                    }
                }
                action(Action31)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.ShowDimensions;
                    end;
                }
                action(ItemChargeAssignment)
                {
                    Caption = 'Item Charge &Assignment';
                    ToolTip = 'Executes the Item Charge &Assignment action.';

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.ItemChargeAssgnt;
                    end;
                }
                action(ItemTrackingLines)
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Executes the Item &Tracking Lines action.';

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.OpenItemTrackingLines;
                    end;
                }
            }
        }
        area(processing)
        {
            group(Functions)
            {
                Caption = 'F&unctions';
                action(CalculateInvoiceDiscount)
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Executes the Calculate &Invoice Discount action.';

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc();
                    end;
                }
                separator(Action24)
                {
                }
                action(ExplodeBOM)
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ToolTip = 'Executes the E&xplode BOM action.';

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.ExplodeBOM;
                    end;
                }
                action(InsertExtTexts)
                {
                    Caption = 'Insert &Ext. Texts';
                    ToolTip = 'Executes the Insert &Ext. Texts action.';

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.InsertExtendedText(TRUE);
                    end;
                }
                separator(Action21)
                {
                }
                action(GetStdVendPurchaseCodes)
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    ToolTip = 'Executes the Get St&d. Vend. Purchase Codes action.';

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Action19)
                {
                }
                action(CopyDocument)
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ToolTip = 'Executes the Copy Document action.';

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RunModal();
                        Clear(CopyPurchDoc);
                    end;
                }
                action(ArchiveDocument)
                {
                    Caption = 'Archi&ve Document';
                    ToolTip = 'Executes the Archi&ve Document action.';

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.Update(false);
                    end;
                }
                separator(Action16)
                {
                }
                separator(Action13)
                {
                }
                separator(Action10)
                {
                }
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = false;
                    ToolTip = 'Executes the Re&lease action.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin

                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Visible = false;
                    ToolTip = 'Executes the Re&open action.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin

                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Action7)
                {
                }
            }
            action(Print)
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Print action.';

                trigger OnAction()
                begin

                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(70134835, true, true, Rec);
                    Rec.Reset();
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action(PurchHistoryBtn)
            {
                Caption = 'Purchase H&istory';
                Promoted = true;
                PromotedCategory = Process;
                Visible = PurchHistoryBtnVisible;
                ToolTip = 'Executes the Purchase H&istory action.';

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Pay-to Vendor No.",TRUE);
                end;
            }
            action(PurchHistoryBtn1)
            {
                Caption = 'Purchase Histor&y';
                Promoted = true;
                PromotedCategory = Process;
                Visible = PurchHistoryBtn1Visible;
                ToolTip = 'Executes the Purchase Histor&y action.';

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Buy-from Vendor No.",FALSE);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //SETFILTER("Assigned User ID",'=%1',USERID);
        //SETFILTER("User ID",USERID);
    end;

    var
        CopyPurchDoc: Report "Copy Purchase Document";

        ArchiveManagement: Codeunit ArchiveManagement;
        [InDataSet]
        PurchHistoryBtn1Visible: Boolean;
        [InDataSet]
        PurchHistoryBtnVisible: Boolean;
        [InDataSet]
        PurchLinesEditable: Boolean;

    local procedure ApproveCalcInvDisc()
    begin
        //CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure UpdateInfoPanel()
    begin
        /*
        DifferBuyFromPayTo := "Buy-from Vendor No." <> "Pay-to Vendor No.";
        PurchHistoryBtnVisible := DifferBuyFromPayTo;
        PayToCommentPictVisible := DifferBuyFromPayTo;
        PayToCommentBtnVisible := DifferBuyFromPayTo;
        PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec,"Buy-from Vendor No.");
        IF DifferBuyFromPayTo THEN
          PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec,"Pay-to Vendor No.")
        */
    end;

    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Open then
            PurchLinesEditable := false
        else
            PurchLinesEditable := true;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        //CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        UpdateControls();
    end;
}
