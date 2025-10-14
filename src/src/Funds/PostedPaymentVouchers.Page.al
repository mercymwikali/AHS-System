Page 52203026 "Posted Payment Vouchers"
{
    CardPageID = "Posted Payment Header UP";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Payments Header";
    ApplicationArea = Basic, Suite;
    // SourceTableView = where(Status = filter(Posted),
    //                        "Payment Type" = const(Normal));

    layout
    {

        area(content)
        {

            repeater(Group)
            {

                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(CurrencyFactor; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field(CurrencyCode; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field(Payee; Rec.Payee)
                {
                    ToolTip = 'Specifies the value of the Payee field.';
                }
                field(OnBehalfOf; Rec."On Behalf Of")
                {
                    ToolTip = 'Specifies the value of the On Behalf Of field.';
                }
                field(Cashier; Rec.Cashier)
                {
                    ToolTip = 'Specifies the value of the Cashier field.';
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
                field(TotalPaymentAmount; Rec."Total Payment Amount")
                {
                    ToolTip = 'Specifies the value of the Total Payment Amount field.';
                }
                field(PayingBankAccount; Rec."Paying Bank Account")
                {
                    ToolTip = 'Specifies the value of the Paying Bank Account field.';
                }
                field(GlobalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(PaymentType; Rec."Payment Type")
                {
                    ToolTip = 'Specifies the value of the Payment Type field.';
                }
                field(ShortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(FunctionName; Rec."Function Name")
                {
                    ToolTip = 'Specifies the value of the Function Name field.';
                }
                field(BudgetCenterName; Rec."Budget Center Name")
                {
                    ToolTip = 'Specifies the value of the Budget Center Name field.';
                }
                field(BankName; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.';
                }
                field(NoSeries; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(Select; Rec.Select)
                {
                    ToolTip = 'Specifies the value of the Select field.';
                }
                field(TotalVATAmount; Rec."Total VAT Amount")
                {
                    ToolTip = 'Specifies the value of the Total VAT Amount field.';
                }
                field(TotalWitholdingTaxAmount; Rec."Total Witholding Tax Amount")
                {
                    ToolTip = 'Specifies the value of the Total Witholding Tax Amount field.';
                }
                field(TotalNetAmount; Rec."Total Net Amount")
                {
                    ToolTip = 'Specifies the value of the Total Net Amount field.';
                }
                field(CurrentStatus; Rec."Current Status")
                {
                    ToolTip = 'Specifies the value of the Current Status field.';
                }
                field(ChequeNo; Rec."Cheque No.")
                {
                    ToolTip = 'Specifies the value of the Cheque No. field.';
                }
                field(PayMode; Rec."Pay Mode")
                {
                    ToolTip = 'Specifies the value of the Pay Mode field.';
                }
                field(PaymentReleaseDate; Rec."Payment Release Date")
                {
                    ToolTip = 'Specifies the value of the Payment Release Date field.';
                }
                field(NoPrinted; Rec."No. Printed")
                {
                    ToolTip = 'Specifies the value of the No. Printed field.';
                }
                field(VATBaseAmount; Rec."VAT Base Amount")
                {
                    ToolTip = 'Specifies the value of the VAT Base Amount field.';
                }
                field(ExchangeRate; Rec."Exchange Rate")
                {
                    ToolTip = 'Specifies the value of the Exchange Rate field.';
                }
                field(CurrencyReciprical; Rec."Currency Reciprical")
                {
                    ToolTip = 'Specifies the value of the Currency Reciprical field.';
                }
                field(CurrentSourceACBal; Rec."Current Source A/C Bal.")
                {
                    ToolTip = 'Specifies the value of the Current Source A/C Bal. field.';
                }
                field(CancellationRemarks; Rec."Cancellation Remarks")
                {
                    ToolTip = 'Specifies the value of the Cancellation Remarks field.';
                }
                field(RegisterNumber; Rec."Register Number")
                {
                    ToolTip = 'Specifies the value of the Register Number field.';
                }
                field(FromEntryNo; Rec."From Entry No.")
                {
                    ToolTip = 'Specifies the value of the From Entry No. field.';
                }
                field(ToEntryNo; Rec."To Entry No.")
                {
                    ToolTip = 'Specifies the value of the To Entry No. field.';
                }
                field(InvoiceCurrencyCode; Rec."Invoice Currency Code")
                {
                    ToolTip = 'Specifies the value of the Invoice Currency Code field.';
                }
                field(TotalPaymentAmountLCY; Rec."Total Payment Amount LCY")
                {
                    ToolTip = 'Specifies the value of the Total Payment Amount LCY field.';
                }
                field(DocumentType; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field(ShortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                }
                field(ShortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field(Dim3; Rec.Dim3)
                {
                    ToolTip = 'Specifies the value of the Dim3 field.';
                }
                field(Dim4; Rec.Dim4)
                {
                    ToolTip = 'Specifies the value of the Dim4 field.';
                }
                field(ResponsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                }
                field(ChequeType; Rec."Cheque Type")
                {
                    ToolTip = 'Specifies the value of the Cheque Type field.';
                }
                field(TotalRetentionAmount; Rec."Total Retention Amount")
                {
                    ToolTip = 'Specifies the value of the Total Retention Amount field.';
                }
                field(PaymentNarration; Rec."Payment Narration")
                {
                    ToolTip = 'Specifies the value of the Payment Narration field.';
                }
                field(TotalPAYEAmount; Rec."Total PAYE Amount")
                {
                    ToolTip = 'Specifies the value of the Total PAYE Amount field.';
                }
                field(ReferenceNo; Rec."Reference No.")
                {
                    ToolTip = 'Specifies the value of the Reference No. field.';
                }
                field(ChequePrinted; Rec."Cheque Printed")
                {
                    ToolTip = 'Specifies the value of the Cheque Printed field.';
                }
                field(ApplytoDocumentType; Rec."Apply to Document Type")
                {
                    ToolTip = 'Specifies the value of the Apply to Document Type field.';
                }
                field(ApplytoDocumentNo; Rec."Apply to Document No")
                {
                    ToolTip = 'Specifies the value of the Apply to Document No field.';
                }
                field(ImprestNo; Rec."Imprest No.")
                {
                    ToolTip = 'Specifies the value of the Imprest No. field.';
                }
                field(ClaimNo; Rec."Claim No.")
                {
                    ToolTip = 'Specifies the value of the Claim No. field.';
                }
                field(PFNo; Rec."PF No")
                {
                    ToolTip = 'Specifies the value of the PF No field.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PrintPreview)
            {
                Caption = 'Print/Preview';
                Image = PreviewChecks;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Print/Preview action.';

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Pending then
                        //ERROR('You cannot Print until the document is released for approval');
                        Rec.Reset();
                    Rec.SetFilter("No.", Rec."No.");
                    Report.Run(70134999, true, true, Rec);
                    Rec.Reset();
                end;
            }
            action("Print Applied Invoice")
            {
                Image = PaymentHistory;
                ToolTip = 'Executes the Print Applied Invoice action.';
                trigger OnAction()
                var
                    PatVisit: Record "HMS Patient Visit Nos";
                    rcpt: Record "Payments Header";
                begin
                    IF Rec."Doctors Batch No" = '' THEN BEGIN
                        rcpt.RESET();
                        rcpt.SETRANGE(rcpt."No.", Rec."No.");
                        IF rcpt.FIND('-') THEN
                            REPORT.RUN(70135206, TRUE, TRUE, rcpt);

                    END ELSE BEGIN
                        PatVisit.RESET();
                        PatVisit.SETRANGE("Batch No", Rec."Doctors Batch No");
                        PatVisit.SETRANGE("Doctor ID", Rec."Vendor No.");
                        IF PatVisit.FIND('-') THEN
                            REPORT.RUN(51929, TRUE, TRUE, PatVisit);
                    END;
                end;
            }
        }
        area(Reporting)
        {
            action(PettyCashSummary)
            {
                Caption = 'Petty Cash Summary';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = Report "Petty Cash Summary.";
                ToolTip = 'Print Petty Cash Summary Per Period. Filters Can be applied to get Petty Cash Posted Between dates.';
            }

            action(PettyCashRequisition)
            {
                Caption = 'Petty Requisition Voucher';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = Report "Petty Cash Req  Voucher.";
                ToolTip = 'Print Petty Requisition Voucher Per Period. Filters Can be applied to get Petty Cash Posted Between dates.';
            }
        }
    }
    trigger OnOpenPage()
    begin
        if (UserId <> 'J.NGEI') OR (UserId <> 'JENNIFER') OR (UserId <> 'T.NJOKI') then
            SetRange(Cashier, UserId);

    end;
}
