Page 85156 "Funds Management Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Funds Management Cue";
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            cuegroup(PendingPaymentDocuments)
            {
                Caption = 'Pending Payment Documents';
                field(InterbankTransfers; Rec."Interbank Not Posted")
                {
                    Caption = 'Interbank Transfers';
                    ToolTip = 'Specifies the value of the Interbank Transfers field.';
                }
                field(PaymentVouchers; Rec."PV Not Posted")
                {
                    Caption = 'Payment Vouchers';
                    ToolTip = 'Specifies the value of the Payment Vouchers field.';
                }
                field(PettyCashVouchers; Rec."PCV Not Posted")
                {
                    Caption = 'Petty Cash Vouchers';
                    ToolTip = 'Specifies the value of the Petty Cash Vouchers field.';
                }
                field(StoreRequisitions; Rec."Store Req. Not Posted")
                {
                    Caption = 'Store Requisitions';
                    ToolTip = 'Specifies the value of the Store Requisitions field.';
                }

                actions
                {
                    action(BankCashTransfer)
                    {
                        Caption = 'Bank & Cash Transfer';
                        RunObject = Page "Interbank Transfer";
                        ToolTip = 'Executes the Bank & Cash Transfer action.';
                    }
                    action(Receipt)
                    {
                        Caption = 'Receipt';
                        RunObject = Page "Receipts List";
                        RunPageView = where(Posted = const(false));
                        ToolTip = 'Executes the Receipt action.';
                    }
                    action("Payment Voucher ")
                    {
                        Caption = 'Payment Vouchers';
                        Image = TileBrickNew;
                        RunObject = Page "Payment Vouchers List";
                        ToolTip = 'Executes the Payment Vouchers action.';
                    }
                    action("Petty Cash Vouchers")
                    {
                        RunObject = Page "Petty Cash";
                        ToolTip = 'Executes the Petty Cash Vouchers action.';
                    }
                }
            }
            cuegroup(PendingTravelDocuments)
            {
                Caption = 'Pending Travel Documents';
                field(TravelAdvance; Rec."Staff Travel Not Posted")
                {
                    Caption = 'Travel Advance';
                    ToolTip = 'Specifies the value of the Travel Advance field.';
                }
                field(TravelAccounting; Rec."Staff TA Not Posted")
                {
                    Caption = 'Travel Accounting';
                    ToolTip = 'Specifies the value of the Travel Accounting field.';
                }
                field(OtherAdvance; Rec."Other Advance Not Posted")
                {
                    Caption = 'Other Advance';
                    ToolTip = 'Specifies the value of the Other Advance field.';
                }
                field(StaffClaim; Rec."Staff Claim Not Posted")
                {
                    Caption = 'Staff Claim';
                    ToolTip = 'Specifies the value of the Staff Claim field.';
                }

                actions
                {
                    action(StaffTravelAdvance)
                    {
                        Caption = 'Staff Travel Advance';
                        RunObject = Page "Travel Advance Vouchers List";
                        ToolTip = 'Executes the Staff Travel Advance action.';
                    }
                    action(TravelAdvanceAccounting)
                    {
                        Caption = 'Travel Advance Accounting';
                        RunObject = Page "Travel Advances Acct. List";
                        ToolTip = 'Executes the Travel Advance Accounting action.';
                    }
                    action(StaffClaims)
                    {
                        Caption = 'Staff Claims';
                        RunObject = Page "Staff Claim List";
                        ToolTip = 'Executes the Staff Claims action.';
                    }
                    action(OtherAdvances)
                    {
                        Caption = 'Other Advances';
                        RunObject = Page "Staff Advance Request List";
                        ToolTip = 'Executes the Other Advances action.';
                    }
                    action(OtherAdvancesAccounting)
                    {
                        Caption = 'Other Advances Accounting';
                        RunObject = Page "Staff Advance Surrender List";
                        ToolTip = 'Executes the Other Advances Accounting action.';
                    }
                }
            }
            cuegroup(DocumentApproval)
            {
                Caption = 'Document Approval';
                field(InterbankPendingApproval; Rec."Interbank Pending Approval")
                {
                    Caption = 'Interbank Transfers';
                    ToolTip = 'Specifies the value of the Interbank Transfers field.';
                }
                field(PVPendingApproval; Rec."PV Pending Approval")
                {
                    Caption = 'Payment Vouchers';
                    ToolTip = 'Specifies the value of the Payment Vouchers field.';
                }
                field(PCVPendingApproval; Rec."PCV Pending Approval")
                {
                    Caption = 'Petty Cash Vouchers';
                    ToolTip = 'Specifies the value of the Petty Cash Vouchers field.';
                }
                field(StaffTravelPendingApproval; Rec."Staff Travel Pending Approval")
                {
                    Caption = 'Staff Travel Advance';
                    ToolTip = 'Specifies the value of the Staff Travel Advance field.';
                }
                field(StaffTravelAdvanceAccounting; Rec."Staff TA Pending Approval")
                {
                    Caption = 'Staff Travel Advance Accounting';
                    ToolTip = 'Specifies the value of the Staff Travel Advance Accounting field.';
                }
                field(ApprovalEntries; Rec."Approval Entries")
                {
                    Caption = 'Approval Entries';
                    DrillDownPageID = "Approval Entries";
                    LookupPageID = "Approval Entries";
                    ToolTip = 'Specifies the value of the Approval Entries field.';
                }
            }
            cuegroup(Control30)
            {
                field(OtherAdvancePendingApproval; Rec."Other Advance Pending Approval")
                {
                    Caption = 'Other Advance';
                    ToolTip = 'Specifies the value of the Other Advance field.';
                }
                field(StaffClaimPendingApproval; Rec."Staff Claim Pending Approval")
                {
                    Caption = 'Staff Claims';
                    ToolTip = 'Specifies the value of the Staff Claims field.';
                }
                field(PurchaseRequisitions; Rec."Requisitions Pending Approval")
                {
                    Caption = 'Purchase Requisitions';
                    ToolTip = 'Specifies the value of the Purchase Requisitions field.';
                }
                field(StoreReqPendingApproval; Rec."Store Req. Pending Approval")
                {
                    Caption = 'Store Requisitions';
                    ToolTip = 'Specifies the value of the Store Requisitions field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        Rec.SetFilter("Due Date Filter", '<=%1', WorkDate());
        Rec.SetFilter("Overdue Date Filter", '<%1', WorkDate());
    end;
}
