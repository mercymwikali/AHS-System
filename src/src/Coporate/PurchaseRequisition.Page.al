page 52203024 "Purchase Requisition"
{
    ApplicationArea = all;
    CardPageID = "Internal Requisitions U";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote),
                            DocApprovalType = FILTER(Requisition),
                            Status = FILTER(<> Released));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor that you received the invoice from.';
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the vendor who you received the invoice from.';
                }
                field("Pay-to Name 2"; Rec."Pay-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Pay-to Name 2 field.';
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    ToolTip = 'Specifies the address of the vendor sending the invoice.';
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ToolTip = 'Specifies the city of the vendor sending the invoice.';
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ToolTip = 'Specifies the vendor''s reference.';
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer at the address that the items are shipped to.';
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ToolTip = 'Specifies the value of the Ship-to Name 2 field.';
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ToolTip = 'Specifies the address that you want the items in the purchase order to be shipped to.';
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ToolTip = 'Specifies the city the items in the purchase order will be shipped to.';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the address that the items are shipped to.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the order was created.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ToolTip = 'Specifies the date you expect the items to be available in your warehouse. If you leave the field blank, it will be calculated as follows: Planned Receipt Date + Safety Lead Time + Inbound Warehouse Handling Time = Expected Receipt Date.';
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ToolTip = 'Specifies additional posting information for the document. After you post the document, the description can add detail to vendor and customer ledger entries.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Vendor Posting Group"; Rec."Vendor Posting Group")
                {
                    ToolTip = 'Specifies the vendor''s market type to link business transactions to.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ToolTip = 'Specifies the code of the currency of the amounts on the purchase lines.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ToolTip = 'Specifies if the Unit Price and Line Amount fields on document lines should be shown with or without VAT.';
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    ToolTip = 'Specifies the value of the Invoice Disc. Code field.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ToolTip = 'Specifies the language to be used on printouts for this document.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                }
                field("Order Class"; Rec."Order Class")
                {
                    ToolTip = 'Specifies the value of the Order Class field.';
                }
                field(Comment; Rec.Comment)
                {
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ToolTip = 'Specifies the value of the No. Printed field.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to Doc. No."; Rec."Applies-to Doc. No.")
                {
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
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
                field("Print Posted Documents"; Rec."Print Posted Documents")
                {
                    ToolTip = 'Specifies the value of the Print Posted Documents field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the sum of the amounts in the Amount field on the associated purchase lines.';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ToolTip = 'Specifies the total of the amounts, including VAT, on all the lines on the document.';
                }
                field("Receiving No."; Rec."Receiving No.")
                {
                    ToolTip = 'Specifies the value of the Receiving No. field.';
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ToolTip = 'Specifies the value of the Posting No. field.';
                }
                field("Last Receiving No."; Rec."Last Receiving No.")
                {
                    ToolTip = 'Specifies the value of the Last Receiving No. field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Quote")
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
                        PAGE.RunModal(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'Executes the Card action.';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
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
                        ApprovalEntries.SetRecordFilters(DATABASE::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.Run();
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    /* action(Period)
                    {
                        Caption = 'Period';
                        ToolTip = 'Executes the Period action.';

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.ItemAvailability(0);
                        end;
                    } */
                    action(Variant)
                    {
                        /* Caption = 'Variant';
                        ToolTip = 'Executes the Variant action.';

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.ItemAvailability(1);
                        end; */
                    }
                    action(Location)
                    {
                        /* Caption = 'Location';
                        ToolTip = 'Executes the Location action.';

                        trigger OnAction()
                        begin
                            //CurrPage.PurchLines.PAGE.ItemAvailability(2);
                        end; */
                    }
                }
                action(Action31)
                {
                    /* Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.ShowDimensions;
                    end; */
                }
                action("Item Charge &Assignment")
                {
                    /* Caption = 'Item Charge &Assignment';
                    ToolTip = 'Executes the Item Charge &Assignment action.';

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.ItemChargeAssgnt;
                    end; */
                }
                action("Item &Tracking Lines")
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
            action("Make &Order")
            {
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the Make &Order action.';

                trigger OnAction()
                //  ApprovalMgt: Codeunit "Approvals Management";
                begin
                    if LinesCommitted() then
                        Error('All Lines should be committed');

                    //   if ApprovalMgt.PrePostApprovalCheck(SalesHeader, Rec) then
                    //     CODEUNIT.Run(CODEUNIT::"Purch.-Quote to Order (Yes/No)", Rec);
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Executes the Calculate &Invoice Discount action.';

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc();
                    end;
                }
                separator(Separator24)
                {
                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    ToolTip = 'Executes the E&xplode BOM action.';

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
                    ToolTip = 'Executes the Insert &Ext. Texts action.';

                    trigger OnAction()
                    begin
                        //CurrPage.PurchLines.PAGE.InsertExtendedText(TRUE);
                    end;
                }
                separator(Separator21)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
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
                separator(Separator19)
                {
                }
                action("Copy Document")
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
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document';
                    ToolTip = 'Executes the Archi&ve Document action.';

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.Update(false);
                    end;
                }
                separator(Separator16)
                {
                }
                action("Send A&pproval Request")
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    ToolTip = 'Executes the Send A&pproval Request action.';

                    trigger OnAction()
                    var
                    //  ApprovalMgt: Codeunit "Approvals Management";
                    begin
                        BCSetup.Get();
                        if BCSetup.Mandatory then
                            if LinesCommitted() then
                                Error('All Lines should be committed');

                        //  if ApprovalMgt.SendPurchaseApprovalRequest(Rec) then;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    ToolTip = 'Executes the Cancel Approval Re&quest action.';

                    trigger OnAction()
                    var
                    //  ApprovalMgt: Codeunit "Approvals Management";
                    begin
                        //if ApprovalMgt.CancelPurchaseApprovalRequest(Rec, true, true) then;
                    end;
                }
                separator(Separator13)
                {
                }
                action("Check Budget Availability")
                {
                    Caption = 'Check Budget Availability';
                    ToolTip = 'Executes the Check Budget Availability action.';

                    trigger OnAction()
                    var
                        BCSetup: Record "Budgetary Control Setup";
                    begin

                        BCSetup.Get();
                        if not BCSetup.Mandatory then
                            exit;

                        if Rec.Status = Rec.Status::Released then
                            Error('This document has already been released. This functionality is available for open documents only');
                        if not SomeLinesCommitted() then begin
                            if not Confirm('Some or All the Lines Are already Committed do you want to continue', true, Rec."Document Type") then
                                Error('Budget Availability Check and Commitment Aborted');
                            DeleteCommitment.Reset();
                            DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                            DeleteCommitment.SetRange(DeleteCommitment."Document No.", Rec."No.");
                            DeleteCommitment.DeleteAll();
                        end;
                        Commitment.CheckPurchase(Rec);
                        Message('Budget Availability Checking Complete');
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    Caption = 'Cancel Budget Commitment';
                    ToolTip = 'Executes the Cancel Budget Commitment action.';

                    trigger OnAction()
                    begin
                        if not Confirm('Are you sure you want to Cancel All Commitments Done for this document', true, Rec."Document Type") then
                            Error('Budget Availability Check and Commitment Aborted');

                        DeleteCommitment.Reset();
                        DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                        DeleteCommitment.SetRange(DeleteCommitment."Document No.", Rec."No.");
                        DeleteCommitment.DeleteAll();
                        //Tag all the Purchase Line entries as Uncommitted
                        PurchLine.Reset();
                        PurchLine.SetRange(PurchLine."Document Type", Rec."Document Type");
                        PurchLine.SetRange(PurchLine."Document No.", Rec."No.");
                        if PurchLine.Find('-') then
                            repeat
                                PurchLine.Committed := false;
                                PurchLine.Modify();
                            until PurchLine.Next() = 0;

                        Message('Commitments Cancelled Successfully for Doc. No %1', Rec."No.");
                    end;
                }
                separator(Separator10)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Re&lease action.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        if LinesCommitted() then
                            Error('All Lines should be committed');

                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ToolTip = 'Executes the Re&open action.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        if LinesCommitted() then
                            Error('All Lines should be committed');

                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Separator7)
                {
                }
                action("&Send BizTalk Rqst. for Purch. Quote")
                {
                    Caption = '&Send BizTalk Rqst. for Purch. Quote';
                    ToolTip = 'Executes the &Send BizTalk Rqst. for Purch. Quote action.';

                    trigger OnAction()
                    // ApprovalMgt: Codeunit "Approvals Management";
                    begin

                        //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                        //  BizTalkManagement.SendReqforPurchQuote(Rec);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Executes the &Print action.';

                trigger OnAction()
                begin
                    // BCSetup.GET;
                    // IF BCSetup.Mandatory THEN
                    // IF LinesCommitted THEN
                    //   ERROR('All Lines should be committed');

                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(70135535, true, true, Rec);
                    Rec.Reset();
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action(PurchHistoryBtn)
            {
                /* Caption = 'Purchase H&istory';
                Promoted = true;
                PromotedCategory = Process;
                Visible = PurchHistoryBtnVisible;
                ToolTip = 'Executes the Purchase H&istory action.';

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Pay-to Vendor No.",TRUE);
                end; */
            }
            action(PurchHistoryBtn1)
            {
                /* Caption = 'Purchase Histor&y';
                Promoted = true;
                PromotedCategory = Process;
                Visible = PurchHistoryBtn1Visible;
                ToolTip = 'Executes the Purchase Histor&y action.';

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Buy-from Vendor No.",FALSE);
                end; */
            }
        }
    }

    trigger OnOpenPage()
    begin
        //SETFILTER("Assigned User ID",'=%1',USERID);
        //SETFILTER("User ID",USERID);
    end;

    var
        BCSetup: Record "Budgetary Control Setup";
        DeleteCommitment: Record Committment;
        PurchLine: Record "Purchase Line";
        CopyPurchDoc: Report "Copy Purchase Document";
        ArchiveManagement: Codeunit ArchiveManagement;
        Commitment: Codeunit "Budgetary Control";
        [InDataSet]
        PurchHistoryBtn1Visible: Boolean;
        [InDataSet]
        PurchHistoryBtnVisible: Boolean;
        [InDataSet]
        PurchLinesEditable: Boolean;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        CashOfficeSetup: Record "Cash Office Setup";
    begin
        CashOfficeSetup.get();
        Rec."Buy-from Vendor No." := CashOfficeSetup."Requisition Default Vendor";
        Rec."Pay-to Vendor No." := CashOfficeSetup."Requisition Default Vendor";
    end;

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

    procedure LinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
        if BCSetup.Get() then begin
            if not BCSetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        if BCSetup.Get() then begin
            Exists := false;
            PurchLines.Reset();
            PurchLines.SetRange(PurchLines."Document Type", Rec."Document Type");
            PurchLines.SetRange(PurchLines."Document No.", Rec."No.");
            PurchLines.SetRange(PurchLines.Committed, false);
            if PurchLines.Find('-') then
                Exists := true;
        end else
            Exists := false;
    end;

    procedure SomeLinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
        if BCSetup.Get() then begin
            Exists := false;
            PurchLines.Reset();
            PurchLines.SetRange(PurchLines."Document Type", Rec."Document Type");
            PurchLines.SetRange(PurchLines."Document No.", Rec."No.");
            PurchLines.SetRange(PurchLines.Committed, true);
            if PurchLines.Find('-') then
                Exists := true;
        end else
            Exists := false;
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
