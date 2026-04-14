namespace PTL.HMISBC;
using System.Automation;
using PTL.Hospital;
using Microsoft.Foundation.NoSeries;

page 85729 "Petty Cash Replenishement Card"
{
    ApplicationArea = All;
    Caption = 'Petty Cash Requisition Page';
    PageType = Card;
    SourceTable = "Petty Cash Replenishment";
    PromotedActionCategories = 'New,Process,Report,Approvals';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Requisition No"; Rec."Replenishement No")
                {
                    ToolTip = 'Specifies the value of the Requisition No field.', Comment = '%';
                    Editable = false;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ToolTip = 'Specifies the value of the Requisition Date field.', Comment = '%';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.', Comment = '%';
                    Editable = false;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ToolTip = 'Specifies the value of the Bank Code field.', Comment = '%';
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Specifies the value of the Bank Name field.', Comment = '%';
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Rep Start Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the Rep End Date field.', Comment = '%';
                }
                field("Total Amount "; Rec."Total Amount ")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Total Amount  field.', Comment = '%';
                }
                field("Request Amount"; Rec."Request Amount")
                {
                    ToolTip = 'Specifies the value of the Request Amount field.', Comment = '%';
                }
                field("Max Cashier Holding"; Rec."Max Cashier Holding")
                {
                    ToolTip = 'Specifies the value of the Max Cashier Holding field.', Comment = '%';
                    Editable = false;
                }
                field("Bank Balance"; Rec."Bank Balance")
                {
                    Editable = false;

                    ToolTip = 'Specifies the value of the Bank Balance field.', Comment = '%';
                }
                field("Get Voucher "; Rec."Get Voucher ")
                {
                    ToolTip = 'Specifies the value of the Get Voucher  field.', Comment = '%';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ToolTip = 'Specifies the value of the Approval Status field.', Comment = '%';
                }
                field("Requesting User"; Rec."Requesting User")
                {
                    ToolTip = 'Specifies the value of the Requesting User field.', Comment = '%';
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ToolTip = 'Specifies the value of the Posted field.', Comment = '%';
                    Editable = false;
                }
                field("Posted InterBank Transfer No"; Rec."Posted InterBank Transfer No")
                {
                    ToolTip = 'Specifies the value of the Posted InterBank Transfer No field.', Comment = '%';
                }
                field("Posted By"; Rec."Posted By")
                {
                    ToolTip = 'Specifies the value of the Posted By field.', Comment = '%';
                    Editable = false;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ToolTip = 'Specifies the value of the Posted Date field.', Comment = '%';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("Petty Vouchers")
            {
                ApplicationArea = Basic, Suite;
                Image = Invoice;
                Promoted = true;
                RunObject = Page "Replenshment Line";
                RunPageLink = "Replinshment No" = field("Replenishement No");
                ToolTip = 'Executes the Petty Vouchers action.';
            }
            action(Post)
            {
                Caption = 'Initiate Transfer';
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Post action.';

                trigger OnAction()
                var
                    InterBankTransfers: Record "InterBank Transfers";
                    CashOfficeSetup: Record "Cash Office Setup";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                    BankCashTransferRequesUP: Page "Bank & Cash Transfer Reques UP";
                    PostSuccessLbl: Label 'Inter Bank Transfer %1 has been creatd Successfully. Do you wish to open the record now?', Comment = '%1 = Interbank Transfer No';
                    PostingNo: Code[20];
                begin
                    Rec.TestField("Approval Status", Rec."Approval Status"::Approved);
                    PostingNo := '';
                    if confirm('Are You sure you want to Post this record?', false) then begin
                        CashOfficeSetup.Get();
                        CashOfficeSetup.TestField(CashOfficeSetup."InterBank Transfer No.");

                        PostingNo := NoSeriesMgt.GetNextNo(CashOfficeSetup."InterBank Transfer No.", 0D, true);
                        InterBankTransfers.Init();
                        InterBankTransfers.No := PostingNo;
                        InterBankTransfers.Date := Today;
                        InterBankTransfers."Receiving Depot Code" := Rec."Global Dimension 1 Code";
                        InterBankTransfers.Validate("Receiving Depot Code");
                        InterBankTransfers."Receiving Account" := Rec."Bank Code";
                        InterBankTransfers.Validate("Receiving Account");
                        InterBankTransfers.Amount := Rec."Request Amount";
                        InterBankTransfers.Validate(Amount);
                        InterBankTransfers."Transactions Type" := InterBankTransfers."Transactions Type"::Cash;
                        InterBankTransfers."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        InterBankTransfers.Validate("Global Dimension 1 Code");
                        InterBankTransfers.Insert();

                        Rec."Posted InterBank Transfer No" := PostingNo;
                        Rec.Modify();
                        Commit();

                        if confirm(StrSubstNo(PostSuccessLbl, Rec."Posted InterBank Transfer No"), false) then begin
                            InterBankTransfers.Reset();
                            InterBankTransfers.SetRange(No, PostingNo);
                            if InterBankTransfers.FindFirst() then begin
                                BankCashTransferRequesUP.SetTableView(InterBankTransfers);
                                BankCashTransferRequesUP.RunModal();
                            end;
                        end;

                    end;
                end;
            }
            // TODO: Pending Custom Approval workflow.
            group(Functions)
            {
                Caption = 'Functions';

                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'Executes the Approvals action.';
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        Rec.TestField("Request Amount");
                        Rec.TestField("Bank Code");
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId)
                    end;
                }
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    ToolTip = 'Executes the Send Approval Request action.';
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //Release the ImprestSurrender for Approval
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(cancellsApproval)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Cancel Approval Re&quest action.';

                    trigger OnAction()
                    begin

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
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
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
}
