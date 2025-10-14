Page 52202980 "Purchase Quote List"
{
    CardPageID = "Purchase Quote Request Header";
    PageType = List;
    SourceTable = "Purchase Quote Header";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field(DocumentType; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(YourReference; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the value of the Your Reference field.';
                }
                field(ShiptoCode; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                }
                field(ShiptoName; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name field.';
                }
                field(ShiptoName2; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name 2 field.';
                }
                field(ShiptoAddress; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the value of the Ship-to Address field.';
                }
                field(ShiptoAddress2; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Address 2 field.';
                }
                field(ShiptoCity; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the value of the Ship-to City field.';
                }
                field(ShiptoContact; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the value of the Ship-to Contact field.';
                }
                field(ExpectedOpeningDate; Rec."Expected Opening Date")
                {
                    ToolTip = 'Specifies the value of the Expected Opening Date field.';
                }
                field(PostingDate; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(ExpectedClosingDate; Rec."Expected Closing Date")
                {
                    ToolTip = 'Specifies the value of the Expected Closing Date field.';
                }
                field(PostingDescription; Rec."Posting Description")
                {
                    ToolTip = 'Specifies the value of the Posting Description field.';
                }
                field(PaymentTermsCode; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                }
                field(DueDate; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field(PaymentDiscount; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the value of the Payment Discount % field.';
                }
                field(PmtDiscountDate; Rec."Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the value of the Pmt. Discount Date field.';
                }
                field(ShipmentMethodCode; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the value of the Shipment Method Code field.';
                }
                field(LocationCode; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field(ShortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(VendorPostingGroup; Rec."Vendor Posting Group")
                {
                    ToolTip = 'Specifies the value of the Vendor Posting Group field.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(CurrencyFactor; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field(PricesIncludingVAT; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies the value of the Prices Including VAT field.';
                }
                field(InvoiceDiscCode; Rec."Invoice Disc. Code")
                {
                    ToolTip = 'Specifies the value of the Invoice Disc. Code field.';
                }
                field(LanguageCode; Rec."Language Code")
                {
                    ToolTip = 'Specifies the value of the Language Code field.';
                }
                field(PurchaserCode; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies the value of the Purchaser Code field.';
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
                    ToolTip = 'Specifies the value of the On Hold field.';
                }
                field(AppliestoDocType; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the value of the Applies-to Doc. Type field.';
                }
                field(AppliestoDocNo; Rec."Applies-to Doc. No.")
                {
                    ToolTip = 'Specifies the value of the Applies-to Doc. No. field.';
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
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(AmountIncludingVAT; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the value of the Amount Including VAT field.';
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
                field(ReasonCode; Rec."Reason Code")
                {
                    ToolTip = 'Specifies the value of the Reason Code field.';
                }
                field(GenBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
                }
                field(TransactionType; Rec."Transaction Type")
                {
                    ToolTip = 'Specifies the value of the Transaction Type field.';
                }
                field(TransportMethod; Rec."Transport Method")
                {
                    ToolTip = 'Specifies the value of the Transport Method field.';
                }
                field(VATCountryRegionCode; Rec."VAT Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the VAT Country/Region Code field.';
                }
                field(ShiptoPostCode; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Post Code field.';
                }
                field(ShiptoCounty; Rec."Ship-to County")
                {
                    ToolTip = 'Specifies the value of the Ship-to County field.';
                }
                field(ShiptoCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the value of the Ship-to Country/Region Code field.';
                }
                field(BalAccountType; Rec."Bal. Account Type")
                {
                    ToolTip = 'Specifies the value of the Bal. Account Type field.';
                }
                field(OrderAddressCode; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the value of the Order Address Code field.';
                }
                field(EntryPoint; Rec."Entry Point")
                {
                    ToolTip = 'Specifies the value of the Entry Point field.';
                }
                field(Correction; Rec.Correction)
                {
                    ToolTip = 'Specifies the value of the Correction field.';
                }
                field(DocumentDate; Rec."Document Date")
                {
                    ToolTip = 'Specifies the value of the Document Date field.';
                }
                field("Area"; Rec.Area)
                {
                    ToolTip = 'Specifies the value of the Area field.';
                }
                field(TransactionSpecification; Rec."Transaction Specification")
                {
                    ToolTip = 'Specifies the value of the Transaction Specification field.';
                }
                field(PaymentMethodCode; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
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
                    ToolTip = 'Specifies the value of the Tax Area Code field.';
                }
                field(TaxLiable; Rec."Tax Liable")
                {
                    ToolTip = 'Specifies the value of the Tax Liable field.';
                }
                field(VATBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    ToolTip = 'Specifies the value of the VAT Bus. Posting Group field.';
                }
                field(AppliestoID; Rec."Applies-to ID")
                {
                    ToolTip = 'Specifies the value of the Applies-to ID field.';
                }
                field(VATBaseDiscount; Rec."VAT Base Discount %")
                {
                    ToolTip = 'Specifies the value of the VAT Base Discount % field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
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
                field(QuoteNo; Rec."Quote No.")
                {
                    ToolTip = 'Specifies the value of the Quote No. field.';
                }
                field(NoofArchivedVersions; Rec."No. of Archived Versions")
                {
                    ToolTip = 'Specifies the value of the No. of Archived Versions field.';
                }
                field(DocNoOccurrence; Rec."Doc. No. Occurrence")
                {
                    ToolTip = 'Specifies the value of the Doc. No. Occurrence field.';
                }
                field(CampaignNo; Rec."Campaign No.")
                {
                    ToolTip = 'Specifies the value of the Campaign No. field.';
                }
                field(BuyfromContactNo; Rec."Buy-from Contact No.")
                {
                    ToolTip = 'Specifies the value of the Buy-from Contact No. field.';
                }
                field(PaytoContactNo; Rec."Pay-to Contact No.")
                {
                    ToolTip = 'Specifies the value of the Pay-to Contact No. field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(CompletelyReceived; Rec."Completely Received")
                {
                    ToolTip = 'Specifies the value of the Completely Received field.';
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
                    ToolTip = 'Specifies the value of the Requested Receipt Date field.';
                }
                field(PromisedReceiptDate; Rec."Promised Receipt Date")
                {
                    ToolTip = 'Specifies the value of the Promised Receipt Date field.';
                }
                field(LeadTimeCalculation; Rec."Lead Time Calculation")
                {
                    ToolTip = 'Specifies the value of the Lead Time Calculation field.';
                }
                field(InboundWhseHandlingTime; Rec."Inbound Whse. Handling Time")
                {
                    ToolTip = 'Specifies the value of the Inbound Whse. Handling Time field.';
                }
                field(DateFilter; Rec."Date Filter")
                {
                    ToolTip = 'Specifies the value of the Date Filter field.';
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
                    ToolTip = 'Specifies the value of the Assigned User ID field.';
                }
                field(Copied; Rec.Copied)
                {
                    ToolTip = 'Specifies the value of the Copied field.';
                }
                field(DebitNote; Rec."Debit Note")
                {
                    ToolTip = 'Specifies the value of the Debit Note field.';
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
                field(DateReceived; Rec."Date Received")
                {
                    ToolTip = 'Specifies the value of the Date Received field.';
                }
                field(TimeReceived; Rec."Time Received")
                {
                    ToolTip = 'Specifies the value of the Time Received field.';
                }
                field(BizTalkPurchaseQuote; Rec."BizTalk Purchase Quote")
                {
                    ToolTip = 'Specifies the value of the BizTalk Purchase Quote field.';
                }
                field(BizTalkPurchOrderCnfmn; Rec."BizTalk Purch. Order Cnfmn.")
                {
                    ToolTip = 'Specifies the value of the BizTalk Purch. Order Cnfmn. field.';
                }
                field(BizTalkPurchaseInvoice; Rec."BizTalk Purchase Invoice")
                {
                    ToolTip = 'Specifies the value of the BizTalk Purchase Invoice field.';
                }
                field(BizTalkPurchaseReceipt; Rec."BizTalk Purchase Receipt")
                {
                    ToolTip = 'Specifies the value of the BizTalk Purchase Receipt field.';
                }
                field(BizTalkPurchaseCreditMemo; Rec."BizTalk Purchase Credit Memo")
                {
                    ToolTip = 'Specifies the value of the BizTalk Purchase Credit Memo field.';
                }
                field(DateSent; Rec."Date Sent")
                {
                    ToolTip = 'Specifies the value of the Date Sent field.';
                }
                field(TimeSent; Rec."Time Sent")
                {
                    ToolTip = 'Specifies the value of the Time Sent field.';
                }
                field(BizTalkRequestforPurchQte; Rec."BizTalk Request for Purch. Qte")
                {
                    ToolTip = 'Specifies the value of the BizTalk Request for Purch. Qte field.';
                }
                field(BizTalkPurchaseOrder; Rec."BizTalk Purchase Order")
                {
                    ToolTip = 'Specifies the value of the BizTalk Purchase Order field.';
                }
                field(VendorQuoteNo; Rec."Vendor Quote No.")
                {
                    ToolTip = 'Specifies the value of the Vendor Quote No. field.';
                }
                field(BizTalkDocumentSent; Rec."BizTalk Document Sent")
                {
                    ToolTip = 'Specifies the value of the BizTalk Document Sent field.';
                }
            }
        }
    }

    actions
    {
    }
}
