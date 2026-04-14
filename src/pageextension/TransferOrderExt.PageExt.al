pageextension 85029 "Transfer Order Ext" extends "Transfer Order"
{
    layout
    {
        addbefore(Status)
        {
            field("Approval Status"; Rec."Approval Status")
            {
                ApplicationArea = Basic, Suite;
                Editable = true;
                ToolTip = 'Specifies the value of the Approval Status field.';
            }
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                // Rec.TestField("Approval Status", Rec."Approval Status"::Approved);
                // TLine.Reset();
                // TLine.SetRange(TLine."Document No.", Rec."No.");
                // TLine.SetFilter(TLine."Qty. to Ship", '>%1', 0);
                // if TLine.Find('-') then
                //     if UserSetup.Get(UserId) then begin
                //         if UserSetup."Can Ship Items" = false then
                //             Error('You do not have permission to ship items');
                //     end else
                //         Error('You do not have permission to ship items');
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()

            begin
                // Rec.TestField("Approval Status", Rec."Approval Status"::Approved);
                //  if Status <> Status::Released then begin
                // if Rec."Shipment Date" = 0D then
                //     if UserSetup.Get(UserId) then begin
                //         if UserSetup."Can Ship Items" = false then
                //             Error('You do not have permission to ship items');
                //     end else
                //         Error('You do not have permission to ship items');
            end;
        }
        addbefore(Post)
        {
            action(Approvals)
            {
                ApplicationArea = all;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                ToolTip = 'Executes the Approvals action.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                end;
            }
            action(sendApproval)
            {
                ApplicationArea = all;
                Caption = 'Send A&pproval Request';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send A&pproval Request action.';

                trigger OnAction()
                var

                begin

                    VarVariant := Rec;
                    if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                        CustomApprovals.OnSendDocForApproval(VarVariant);
                end;
            }
            action(cancellsApproval)
            {
                ApplicationArea = all;
                Caption = 'Cancel Approval Re&quest';
                Image = Cancel;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval Re&quest action.';

                trigger OnAction()
                var

                begin
                    VarVariant := Rec;
                    CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                end;
            }
        }
    }

    var
        TLine: Record "Transfer Line";
        UserSetup: Record "User Setup";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        VarVariant: Variant;
}