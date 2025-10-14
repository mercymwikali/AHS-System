pageextension 52202440 "Purchase Invoice Ext" extends "Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document Date")
        {
            field("Branch"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
            }
            field("Deparment Code"; Rec."Shortcut Dimension 2 Code")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
            }
            field(Department; Rec.Department)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Department field.';
            }
            field("Sub-Department Code"; Rec."Sub-Department Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sub-Department Code field.', Comment = '%';
            }
            field("Sub-Department Name"; Rec."Sub-Department Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sub-Department Name field.', Comment = '%';
            }

            field("Department Name"; Rec."Department Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Department Name field.';
            }
            field("Place of Delivery"; Rec."Place of Delivery")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the value of the Place of Delivery field.';
            }
        }
    }
    actions
    {
        modify(SendApprovalRequest)
        {
            ApplicationArea = all;
            Caption = 'Send A&pproval Request';
            Promoted = true;
            PromotedCategory = Category4;
            ToolTip = 'Request approval of the document.';
            trigger OnBeforeAction()
            begin

                IF NOT LinesExists() THEN
                    ERROR('There are no Lines created for this Document');

                //Ensure No Items That should be committed that are not
                IF LinesCommitmentStatus() THEN
                    ERROR('There are some lines that have not been committed');

                //Release the Imprest for Approval
                Rec.TESTFIELD(Status, Rec.Status::Open);

                //  if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                //      ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
            end;
        }
        addafter("Request Approval")
        {
            group("Check Budget")
            {
                action("Check Budget Availability")
                {
                    ApplicationArea = all;
                    Caption = 'Check Budget Availability';
                    Promoted = true;
                    PromotedCategory = Category5;
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
                            // if not Confirm('Some or All the Lines Are already Committed do you want to continue', true, "Document Type") then
                            //     Error('Budget Availability Check and Commitment Aborted');
                            DeleteCommitment.Reset();
                            //  DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                            DeleteCommitment.SetRange(DeleteCommitment."Document No.", Rec."No.");
                            DeleteCommitment.DeleteAll();
                        end;
                        Commitment.CheckPurchase(Rec);
                        Message('Budget Availability Checking Complete');
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Budget Commitment';
                    Promoted = true;
                    PromotedCategory = Category5;
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
            }
        }
    }

    var
        BCSetup: Record "Budgetary Control Setup";
        DeleteCommitment: Record Committment;
        PurchLine: Record "Purchase Line";
        Commitment: Codeunit "Budgetary Control";

    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCsetup: Record "Budgetary Control Setup";
        ImprestLine: Record "Purchase Line";
    begin
        if BCsetup.Get() then begin
            if not BCsetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        Exists := false;
        ImprestLine.Reset();
        ImprestLine.SetRange(ImprestLine."Document No.", Rec."No.");
        ImprestLine.SetRange(ImprestLine.Committed, false);
        //ImprestLineSetRange(ImprestLine."Budgetary Control A/C", true);
        if ImprestLine.Find('-') then
            Exists := true;
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

    procedure LinesExists(): Boolean
    var
        PayLines: Record "Purchase Line";
        HasLines: Boolean;
    begin
        HasLines := false;
        PayLines.Reset();
        PayLines.SetRange(PayLines."Document No.", Rec."No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;
}