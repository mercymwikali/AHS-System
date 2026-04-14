Codeunit 85022 "Approval Management Ext"
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]

    procedure PopulateApprovalEntryArgument(RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance"; VAR ApprovalEntryArgument: Record "Approval Entry")
    var
        Customer: Record Customer;
        TransportReq: Record "FLT-Transport Requisition";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        AppCard: Record "HR Appraisal Card1";
        HRLeaveRequisition: Record "HR Leave Application";
        HRTraining: Record "HR Training Applications";
        ImprestReq: Record "Imprest Header";
        ImpSur: Record "Imprest Surrender Header";
        IncomingDocument: Record "Incoming Document";
        InterBank: Record "InterBank Transfers";
        PaymentHeader: Record "Payments Header";
        PurchaseHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        StaffAdvance: Record "Staff Advance Header";
        StaffClaim: Record "Staff Claims Header";
        StoreReq: Record "Store Requistion Header";
        ApprovalAmount: Decimal;
        ApprovalAmountLCY: Decimal;

    begin
        ApprovalEntryArgument.INIT();
        ApprovalEntryArgument."Table ID" := RecRef.NUMBER;
        ApprovalEntryArgument."Record ID to Approve" := RecRef.RECORDID;
        ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::" ";
        ApprovalEntryArgument."Approval Code" := WorkflowStepInstance."Workflow Code";
        ApprovalEntryArgument."Workflow Step Instance ID" := WorkflowStepInstance.ID;

        CASE RecRef.NUMBER OF
            DATABASE::"Purchase Header":
                BEGIN
                    RecRef.SETTABLE(PurchaseHeader);
                    // CalcPurchaseDocAmount(PurchaseHeader,ApprovalAmount,ApprovalAmountLCY);
                    ApprovalEntryArgument."Document Type" := PurchaseHeader."Document Type";
                    ApprovalEntryArgument."Document No." := PurchaseHeader."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := PurchaseHeader."Purchaser Code";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := PurchaseHeader."Currency Code";
                END;
            DATABASE::"Sales Header":
                BEGIN
                    RecRef.SETTABLE(SalesHeader);
                    // CalcSalesDocAmount(SalesHeader,ApprovalAmount,ApprovalAmountLCY);
                    ApprovalEntryArgument."Document Type" := SalesHeader."Document Type";
                    ApprovalEntryArgument."Document No." := SalesHeader."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := SalesHeader."Salesperson Code";
                    ApprovalEntryArgument.Amount := ApprovalAmount;
                    ApprovalEntryArgument."Amount (LCY)" := ApprovalAmountLCY;
                    ApprovalEntryArgument."Currency Code" := SalesHeader."Currency Code";
                    //  ApprovalEntryArgument."Available Credit Limit (LCY)" := GetAvailableCreditLimit(SalesHeader);
                END;
            DATABASE::Customer:
                BEGIN
                    RecRef.SETTABLE(Customer);
                    ApprovalEntryArgument."Salespers./Purch. Code" := Customer."Salesperson Code";
                    ApprovalEntryArgument."Currency Code" := Customer."Currency Code";
                    ApprovalEntryArgument."Available Credit Limit (LCY)" := Customer.CalcAvailableCredit();
                END;
            DATABASE::"Gen. Journal Batch":
                RecRef.SETTABLE(GenJournalBatch);
            DATABASE::"Gen. Journal Line":
                BEGIN
                    RecRef.SETTABLE(GenJournalLine);
                    ApprovalEntryArgument."Document Type" := GenJournalLine."Document Type";
                    ApprovalEntryArgument."Document No." := GenJournalLine."Document No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := GenJournalLine."Salespers./Purch. Code";
                    ApprovalEntryArgument.Amount := GenJournalLine.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := GenJournalLine."Amount (LCY)";
                    ApprovalEntryArgument."Currency Code" := GenJournalLine."Currency Code";
                END;
            DATABASE::"Incoming Document":
                BEGIN
                    RecRef.SETTABLE(IncomingDocument);
                    ApprovalEntryArgument."Document No." := FORMAT(IncomingDocument."Entry No.");
                END;
            //HR leave Requisition
            DATABASE::"HR Leave Application":
                BEGIN
                    RecRef.SETTABLE(HRLeaveRequisition);
                    ApprovalEntryArgument."Document No." := HRLeaveRequisition."No.";
                END;

            //Payment Voucher
            DATABASE::"Payments Header":
                BEGIN
                    RecRef.SETTABLE(PaymentHeader);
                    ApprovalEntryArgument."Document No." := PaymentHeader."No.";
                END;
            //Interbank Transfers
            DATABASE::"InterBank Transfers":
                BEGIN
                    RecRef.SETTABLE(InterBank);
                    ApprovalEntryArgument."Document No." := InterBank.No;
                END;
            //Staff Advance Header
            DATABASE::"Staff Advance Header":
                BEGIN
                    RecRef.SETTABLE(StaffAdvance);
                    ApprovalEntryArgument."Document No." := StaffAdvance."No.";
                END;

            // HR Training App Header
            DATABASE::"HR Training Applications":
                BEGIN
                    RecRef.SETTABLE(HRTraining);
                    ApprovalEntryArgument."Document No." := HRTraining."Application No";
                END;

            // Store Requisition
            DATABASE::"Store Requistion Header":
                BEGIN
                    RecRef.SETTABLE(StoreReq);
                    ApprovalEntryArgument."Document No." := StoreReq."No.";
                END;

            // Imprest Requisition
            DATABASE::"Imprest Header":
                BEGIN
                    RecRef.SETTABLE(ImprestReq);
                    ApprovalEntryArgument."Document No." := ImprestReq."No.";
                END;

            // Transport Requisition
            DATABASE::"FLT-Transport Requisition":
                BEGIN
                    RecRef.SETTABLE(TransportReq);
                    ApprovalEntryArgument."Document No." := TransportReq."Transport Requisition No";
                END;

            // Staff Claim
            DATABASE::"Staff Claims Header":
                BEGIN
                    RecRef.SETTABLE(StaffClaim);
                    ApprovalEntryArgument."Document No." := StaffClaim."No.";
                END;

            // Imprest Surrender Header
            DATABASE::"Imprest Surrender Header":
                BEGIN
                    RecRef.SETTABLE(ImpSur);
                    ApprovalEntryArgument."Document No." := ImpSur.No;
                END;

            // Appraisal Header
            DATABASE::"HR Appraisal Card1":
                BEGIN
                    RecRef.SETTABLE(AppCard);
                    ApprovalEntryArgument."Document No." := AppCard."Appraisal Code";
                END;
        END;
    end;
}