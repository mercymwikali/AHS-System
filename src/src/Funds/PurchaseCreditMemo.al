page 52202563 "Purchase Credit Memos."
{
    ApplicationArea = Basic, Suite;
    Caption = 'Purchase Credit Memos';
    CardPageID = "Purchase Credit Memo";
    DataCaptionFields = "Buy-from Vendor No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Request Approval,Credit Memo,Release,Posting,Navigate';
    QueryCategory = '';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = CONST("Credit Memo"));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ToolTip = 'Specifies the order address of the related vendor.';
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies the name of the vendor who delivered the items.';
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ToolTip = 'Specifies the compensation agreement identification number, sometimes referred to as the RMA No. (Returns Materials Authorization).';
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor who delivered the items.';
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ToolTip = 'Specifies the city of the vendor who delivered the items.';
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the vendor who delivered the items.';
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ToolTip = 'Specifies the number of the vendor that you received the invoice from.';
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ToolTip = 'Specifies the name of the vendor who you received the invoice from.';
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ToolTip = 'Specifies the post code of the vendor that you received the invoice from.';
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address.';
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ToolTip = 'Specifies the name of the person to contact about an invoice from this vendor.';
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ToolTip = 'Specifies a code for an alternate shipment address if you want to ship to another address than the one that has been entered automatically. This field is also used in case of drop shipment.';
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ToolTip = 'Specifies the name of the customer at the address that the items are shipped to.';
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ToolTip = 'Specifies the postal code of the address that the items are shipped to.';
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region code of the address that the items are shipped to.';
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ToolTip = 'Specifies the name of the contact person at the address that the items are shipped to.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the code of the currency of the amounts on the purchase lines.';
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ToolTip = 'Specifies the date when the related document was created.';
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount.';
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies when the invoice is due. The program calculates the date using the Payment Terms Code and Document Date fields.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the sum of the amounts in the Amount field on the associated purchase lines.';
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                    Visible = false;
                }
                field("Applies-to Doc. Type"; Rec."Applies-to Doc. Type")
                {
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    StyleExpr = Rec."Job Queue Status" = Rec."Job Queue Status"::ERROR;
                    ToolTip = 'Specifies the status of a job queue entry that handles the posting of purchase credit memos.';
                    Visible = JobQueueActive;

                    trigger OnDrillDown()
                    var
                        JobQueueEntry: Record "Job Queue Entry";
                    begin
                        if Rec."Job Queue Status" = Rec."Job Queue Status"::" " then
                            exit;
                        JobQueueEntry.ShowStatusMsg(Rec."Job Queue Entry ID");
                    end;
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ShowFilter = false;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = FIELD("Date Filter");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Credit Memo")
            {
                Caption = '&Credit Memo';
                Image = CreditMemo;
                action(Statistics)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader();
                        Commit();
                        PAGE.RunModal(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category5;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'View or add comments for the record.';
                }
                action(Vendor)
                {
                    Caption = 'Vendor';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No."),
                                  "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    begin
                        //   WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RecordId, DATABASE::"Purchase Header", "Document Type", "No.");
                    end;
                }
            }
        }
        area(processing)
        {
            group(Action7)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

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
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = "Action";
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                        WorkflowWebhookManagement.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseBatchPostMgt: Codeunit "Purchase Batch Post Mgt.";
                    begin
                        CurrPage.SetSelectionFilter(PurchaseHeader);
                        if PurchaseHeader.Count > 1 then begin
                            PurchaseHeader.FindSet();
                            repeat
                                CheckPurchaseCheckAllLinesHaveQuantityAssigned(PurchaseHeader);
                            until PurchaseHeader.Next() = 0;
                            PurchaseBatchPostMgt.RunWithUI(PurchaseHeader, Rec.Count, ReadyToPostQst);
                        end else
                            PostDocument(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(TestReport)
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
                    Visible = NOT IsOfficeAddin;

                    trigger OnAction()
                    begin
                        PostDocument(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action(PostBatch)
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'Post several documents at once. A report request window opens where you can specify which documents to post.';

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        SelectionFilterManagement: Codeunit SelectionFilterManagement;
                    begin
                        CheckPurchaseCheckAllLinesHaveQuantityAssigned(Rec);
                        CurrPage.SetSelectionFilter(PurchaseHeader);
                        PurchaseHeader.SetFilter("No.", SelectionFilterManagement.GetSelectionFilterForPurchaseHeader(PurchaseHeader));
                        REPORT.RunModal(REPORT::"Batch Post Purch. Credit Memos", true, true, PurchaseHeader);
                        CurrPage.Update(false);
                    end;
                }
                action(RemoveFromJobQueue)
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = JobQueueActive;

                    trigger OnAction()
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
            }
        }
        area(reporting)
        {
            group(Sales)
            {
                Caption = 'Sales';
                Image = Sales;
                action("<Report Vendor - Top 10 List>")
                {
                    Caption = 'Vendor - Top 10 List';
                    Image = "Report";
                    RunObject = Report "Vendor - Top 10 List";
                    ToolTip = 'View a list of the vendors from whom you purchase the most or to whom you owe the most.';
                }
                action("<Report Vendor - Purchase List>")
                {
                    Caption = 'Vendor - Purchase List';
                    Image = "Report";
                    RunObject = Report "Vendor - Purchase List";
                    ToolTip = 'View a list of your purchases in a period, for example, to report purchase activity to customs and tax authorities.';
                }
                action("<Report Puchase Statistics>")
                {
                    Caption = 'Purchase Statistics';
                    Image = "Report";
                    RunObject = Report "Purchase Statistics";
                    ToolTip = 'View an overview of amounts for purchases, invoice discount, and payment discount in LCY for each vendor, for example, to analyze item purchases for an individual customer and trends for item purchases.';
                }
            }
            group(Finance)
            {
                Caption = 'Finance';
                Image = Sales;
                action("Vendor - Balance to Date")
                {
                    Caption = 'Vendor - Balance to Date';
                    Image = "Report";
                    RunObject = Report "Vendor - Balance to Date";
                    ToolTip = 'View, print, or save vendors'' balances on a certain date, for example, to extract your total expenses at the close of an accounting period or fiscal year.';
                }
                action("<Report Vendor - Trial Balance")
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor - Trial Balance';
                    Image = "Report";
                    RunObject = Report "Vendor - Trial Balance";
                    ToolTip = 'View the beginning and ending balance for vendors with entries within a specified period. The report can be used to verify that the balance for a vendor posting group is equal to the balance on the corresponding general ledger account on a certain date.';
                }
                action("<Report Vendor - Detail Trial ")
                {
                    Caption = 'Vendor - Detail. Trial Balance';
                    Image = "Report";
                    RunObject = Report "Vendor - Detail Trial Balance";
                    ToolTip = 'View the balance for vendors with balances on a specified date, for example, at the close of an accounting period or for an audit.';
                }
                action("<Report Vendor - Summary Aging")
                {
                    Caption = 'Vendor - Summary Aging';
                    Image = "Report";
                    RunObject = Report "Vendor - Summary Aging";
                    ToolTip = 'View, print, or save a summary of the payables owed to each vendor, divided into three time periods. The report can be used to prepare liquidity analyses.';
                }
                action("<Report Aged Accounts Payables")
                {
                    Caption = 'Aged Accounts Payables';
                    Image = "Report";
                    RunObject = Report "Aged Accounts Payable";
                    ToolTip = 'View an overview of when your payables to vendors are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                }
                action("<Report Vendor - Payment Recei")
                {
                    ApplicationArea = Suite;
                    Caption = 'Vendor - Payment Receipt';
                    Image = "Report";
                    RunObject = Report "Customer - Payment Receipt";
                    ToolTip = 'View a document showing which vendor ledger entries that a payment has been applied to.';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        OfficeMgt: Codeunit "Office Management";
    begin
        Rec.SetSecurityFilterOnRespCenter();

        JobQueueActive := PurchasesPayablesSetup.JobQueueActive();
        IsOfficeAddin := OfficeMgt.IsAvailable();

        Rec.CopyBuyFromVendorFilter();
    end;

    var
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        ReportPrint: Codeunit "Test Report-Print";
        CanCancelApprovalForFlow: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        IsOfficeAddin: Boolean;
        [InDataSet]
        JobQueueActive: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenPostedPurchCrMemoQst: Label 'The credit memo is posted as number %1 and moved to the Posted Purchase Credit Memos window.\\Do you want to open the posted credit memo?', Comment = '%1 = posted document number';
        ReadyToPostQst: Label '%1 out of %2 selected credit memos are ready for post. \Do you want to continue and post them?', Comment = '%1 - selected count, %2 - total count';

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);

        WorkflowWebhookManagement.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    local procedure CheckPurchaseCheckAllLinesHaveQuantityAssigned(PurchaseHeader: Record "Purchase Header")
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
    begin
        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
            LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(PurchaseHeader);
    end;

    local procedure PostDocument(PostingCodeunitID: Integer)
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        InstructionMgt: Codeunit "Instruction Mgt.";
        IsScheduledPosting: Boolean;
    begin
        if ApplicationAreaMgmtFacade.IsFoundationEnabled() then
            LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        Rec.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";

        if IsScheduledPosting then
            CurrPage.Close();
        CurrPage.Update(false);

        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        if IsOfficeAddin then begin
            PurchCrMemoHdr.SetRange("Pre-Assigned No.", Rec."No.");
            if PurchCrMemoHdr.FindFirst() then
                PAGE.Run(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
        end else
            if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                ShowPostedConfirmationMessage();
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        PurchCrMemoHdr.SetRange("Pre-Assigned No.", Rec."No.");
        if PurchCrMemoHdr.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchCrMemoQst, PurchCrMemoHdr."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                PAGE.Run(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
    end;
}
