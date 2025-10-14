Page 52202652 "HMS Patient Charges Discount"
{
    PageType = List;
    PromotedActionCategories = 'New,Processing,Report,Approval';
    SourceTable = "HMS Patient Charges Weiver";
    SourceTableView = where(Type = filter(Discount), Posted = filter(False));
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    editable = false;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(InitialAmount; Rec."Initial Amount")
                {
                    ToolTip = 'Specifies the value of the Initial Amount field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
                field("Dimension1 Code"; Rec."Dimension1 Code")
                {
                    ToolTip = 'Specifies the value of the Dimension1 Code field.';
                }
                field("Dimension2 Code"; Rec."Dimension2 Code")
                {
                    ToolTip = 'Specifies the value of the Dimension2 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(ApprovalRemarks; Rec."Approval Remarks")
                {
                    ToolTip = 'Specifies the value of the Approval Remarks field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(sendApproval)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Executes the Send A&pproval Request action.';

                    trigger OnAction()
                    begin

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
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ToolTip = 'Executes the Approve action.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ToolTip = 'Executes the Reject action.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ToolTip = 'Executes the Delegate action.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ToolTip = 'Executes the Comments action.';
                }
            }
            group(Post)
            {
                action(PostDiscount)
                {
                    Caption = 'Post Discount';
                    ToolTip = 'Executes the Post Discount action.';
                    trigger OnAction()
                    var
                        HMSPatCharges: Record "HMS Patient Charges";
                        HMSSetup: Record "HMS Setup";
                        HMSCu: Codeunit "HMS Patient-integration";
                    begin
                        IF CONFIRM('Do you really want to post the Discount?', FALSE) THEN BEGIN
                            Rec.TESTFIELD(Posted, FALSE);
                            HMSSetup.get();
                            HMSSetup.TESTFIELD("Discount Exp. Account");
                            Rec.TESTFIELD(Status, Rec.Status::Approved);
                            HMSCu.PostChargesDiscount(Rec."Patient No", Rec."Visit No", Rec.Amount);
                            HMSPatCharges.INIT();
                            HMSPatCharges."Line No" := 100;
                            HMSPatCharges.Date := Today;
                            HMSPatCharges."Link No" := Rec.No;
                            HMSPatCharges."Patient No." := Rec."Patient No";
                            HMSPatCharges.Validate("Patient No.");
                            HMSPatCharges.Code := 'Discount';
                            HMSPatCharges."Visit No" := Rec."Visit No";
                            HMSPatCharges.Amount := Rec.Amount * -1;
                            HMSPatCharges."Transaction Type" := 'ZReceipt';
                            HMSPatCharges.Description := CopyStr('Discount- ' + Rec.Description, 1, MaxStrLen(HMSPatCharges.Description));
                            HMSPatCharges."G/L Account No" := HMSSetup."Cash Control Account";
                            HMSPatCharges.INSERT();
                            
                            Rec.Posted := TRUE;
                            Rec.MODIFY();
                        END;
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.setfilter("User ID", '%1|%2', '', Database.UserId);
    end;

    var
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        VarVariant: Variant;
}
