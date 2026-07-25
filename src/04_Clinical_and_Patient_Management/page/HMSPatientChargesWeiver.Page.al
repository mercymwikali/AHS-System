Page 85375 "HMS Patient Charges Weiver"
{
    PageType = List;
    PromotedActionCategories = 'New,Processing,Report,Approval';
    SourceTable = "HMS Patient Charges Weiver";
    SourceTableView = where(Type = filter('Weiver'), Posted = filter(False));
    ApplicationArea = Basic, Suite;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Patient No"; Rec."Patient No")
                {
                    ToolTip = 'Specifies the value of the Patient No field.';
                }
                field("Patient Names"; Rec."Patient Names")
                {
                    ToolTip = 'Specifies the value of the Patient Names field.';
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
                action(PostWeiver)
                {
                    Caption = 'Post Weiver';
                    ToolTip = 'Executes the Post Weiver action.';
                    trigger OnAction()
                    var
                        USetup: Record "Cash Office User Template";
                        GenJnlLine: Record "Gen. Journal Line";
                        PatRec: Record "HMS Patient";
                        HMSPatCharges: Record "HMS Patient Charges";
                        HMSPatientsCharges: Record "HMS Patient Charges";
                        HMSSetup: Record "HMS Setup";
                        VendL: Record "Vendor Ledger Entry";
                        JBatch: code[20];
                        JTemplate: code[20];
                        LineNo: Integer;
                    begin
                        HMSSetup.get();
                        IF CONFIRM('Do you reall want to post the Weiver?', FALSE) THEN BEGIN
                            USetup.Reset();
                            USetup.SetRange(USetup.UserID, UserId);
                            if USetup.FindFirst() then begin
                                if USetup."Receipt Journal Template" = '' then
                                    Error('Please ensure that the Administrator sets you up as a cashier');
                                if USetup."Receipt Journal Batch" = '' then
                                    Error('Please ensure that the Administrator sets you up as a cashier');
                                if USetup."Default Receipts Bank" = '' then;
                                JTemplate := USetup."Receipt Journal Template";
                                JBatch := USetup."Receipt Journal Batch";
                            end
                            else
                                Error('Please ensure that the Administrator sets you up as a cashier');

                            Rec.TESTFIELD(Posted, FALSE);
                            Rec.TESTFIELD(Status, Rec.Status::Approved);
                            HMSSetup.TestField("Weiver Transaction Code");
                            HMSPatCharges.reset();
                            HMSPatCharges.setrange("Patient No.", Rec."Patient No");
                            HMSPatCharges.setrange("Visit No", Rec."Visit No");
                            HMSPatCharges.setrange("Line No", Rec."Line No");
                            if HMSPatCharges.find('-') then begin
                                // HMSPatCharges.calcfields(Reversed);
                                if (HMSPatCharges.Posted = true) and (HMSPatCharges.Reversed = false) then
                                    error('Please note that posted charges must be reversed before posting weiver');
                                if HMSPatCharges.Amount - Rec.Amount < 0 then
                                    error('Please note that weiver amount can not be more than original amount');
                                PatRec.get(HMSPatCharges."Patient No.");

                                HMSPatientsCharges.Init();
                                HMSPatientsCharges."Line No" := HMSPatCharges."Line No" + 100;
                                HMSPatientsCharges."Patient No." := Rec."Patient No";
                                HMSPatientsCharges."Link No" := Rec."Link No";
                                HMSPatientsCharges."Treatment No." := HMSPatCharges."Treatment No.";
                                HMSPatientsCharges."Appointment No." := HMSPatCharges."Appointment No.";
                                HMSPatientsCharges."Transaction Type" := HMSSetup."Weiver Transaction Code";
                                HMSPatientsCharges.Code := HMSPatCharges.Code;
                                HMSPatientsCharges.Description := HMSPatCharges.Description;
                                HMSPatientsCharges.Date := HMSPatCharges.Date;
                                HMSPatientsCharges."Shortcut Dimension 1 Code" := HMSPatCharges."Shortcut Dimension 1 Code";
                                HMSPatientsCharges."Shortcut Dimension 2 Code" := HMSPatCharges."Shortcut Dimension 2 Code";
                                HMSPatientsCharges."Bill Section" := HMSPatCharges."Bill Section";
                                HMSPatientsCharges."Doctor ID" := HMSPatCharges."Doctor ID";
                                HMSPatientsCharges."User ID" := UserId;
                                HMSPatientsCharges."Creation Date" := Today;
                                HMSPatientsCharges."Creation Time" := DT2TIME(System.CurrentDateTime);
                                HMSPatientsCharges."Admission No" := HMSPatCharges."Admission No";
                                HMSPatientsCharges."Visit No" := HMSPatCharges."Visit No";
                                HMSPatientsCharges.Amount := Rec.Amount * -1;
                                HMSPatientsCharges.Quantity := 1;
                                HMSPatientsCharges."Total Amount" := Rec.Amount * -1;
                                HMSPatientsCharges.Insert();
                            end;
                            // Reverse Posted Doctors Fee
                            VendL.reset();
                            VendL.setrange("Vendor No.", HMSPatCharges."Doctor ID");
                            VendL.setfilter("Document No.", '%1|%2', HMSPatCharges."Doctors Posting No", HMSPatCharges."Visit No");
                            if VendL.find('-') then begin
                                VendL.CalcFields(Amount);
                                LineNo := LineNo + 100;
                                GenJnlLine.Init();
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'DOCTORREV';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := today;
                                if VendL."Document No." = HMSPatCharges."Doctors Posting No" then
                                    GenJnlLine."Document No." := HMSPatCharges."Doctors Posting No"
                                else
                                    GenJnlLine."Document No." := HMSPatCharges."Visit No";
                                // GenJnlLine."Document Date":="Document Date";
                                GenJnlLine."Account Type" := GenJnlLine."account type"::Vendor;
                                GenJnlLine."Account No." := VendL."Vendor No.";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine."External Document No." := HMSPatCharges."Patient No.";
                                // GenJnlLine."Currency Code":="Currency Code";
                                GenJnlLine.Validate(GenJnlLine."Currency Code");
                                GenJnlLine.Amount := ABS(VendL.Amount);
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                GenJnlLine."Source Code" := HMSPatCharges."Visit No";
                                // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                                // GenJnlLine."Bal. Account No.":=HMSTransCode."Expense G/L Account";
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := 'Weiver - ' + Rec.No + '/' + PatRec.Names;
                                GenJnlLine."Shortcut Dimension 1 Code" := HMSPatCharges."Shortcut Dimension 1 Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := HMSPatCharges."Shortcut Dimension 2 Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, HMSPatCharges."Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, HMSPatCharges."Shortcut Dimension 4 Code");
                                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                                if VendL."Document No." = HMSPatCharges."Doctors Posting No" then
                                    GenJnlLine."Applies-to Doc. No." := HMSPatCharges."Doctors Posting No"
                                else
                                    GenJnlLine."Applies-to Doc. No." := HMSPatCharges."Visit No";
                                //GenJnlLine.validate("Applies-to Doc. No.");

                                if GenJnlLine.Amount <> 0 then
                                    GenJnlLine.Insert();
                                //Balance Account
                                LineNo := LineNo + 100;
                                GenJnlLine.Init();
                                GenJnlLine."Journal Template Name" := JTemplate;
                                GenJnlLine."Journal Batch Name" := JBatch;
                                GenJnlLine."Source Code" := 'DOCTORREV';
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := today;
                                if VendL."Document No." = HMSPatCharges."Doctors Posting No" then
                                    GenJnlLine."Document No." := HMSPatCharges."Doctors Posting No"
                                else
                                    GenJnlLine."Document No." := HMSPatCharges."Visit No";
                                // GenJnlLine."Document Date":="Document Date";
                                GenJnlLine."Account Type" := GenJnlLine."account type"::"G/L Account";
                                GenJnlLine."Account No." := HMSSetup."Doctors Expense Account";
                                GenJnlLine.Validate(GenJnlLine."Account No.");
                                GenJnlLine."External Document No." := HMSPatCharges."Patient No.";
                                GenJnlLine."Source Code" := HMSPatCharges."Visit No";
                                //  GenJnlLine."Currency Code":="Currency Code";
                                GenJnlLine.Validate(GenJnlLine."Currency Code");
                                GenJnlLine.Amount := ABS(VendL.Amount) * -1;
                                GenJnlLine.Validate(GenJnlLine.Amount);
                                // GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                                // GenJnlLine."Bal. Account No.":=HMSTransCode."Expense G/L Account";
                                GenJnlLine.Validate(GenJnlLine."Bal. Account No.");
                                GenJnlLine.Description := 'Weiver - ' + Rec.No + '/' + PatRec.Names;
                                GenJnlLine."Shortcut Dimension 1 Code" := HMSPatCharges."Shortcut Dimension 1 Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                                GenJnlLine."Shortcut Dimension 2 Code" := HMSPatCharges."Shortcut Dimension 2 Code";
                                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                                GenJnlLine.ValidateShortcutDimCode(3, HMSPatCharges."Shortcut Dimension 3 Code");
                                GenJnlLine.ValidateShortcutDimCode(4, HMSPatCharges."Shortcut Dimension 4 Code");
                                //  GenJnlLine."Applies-to Doc. No." := HMSPatCharges."Visit No";
                                //  GenJnlLine.validate("Applies-to Doc. No.");
                                if GenJnlLine.Amount <> 0 then
                                    GenJnlLine.Insert();

                                GenJnlLine.Reset();
                                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", JTemplate);
                                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", JBatch);
                                if GenJnlLine.Find('-') then
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Bill", GenJnlLine);
                            end;

                            HMSPatCharges."Weiver Amount" := Rec.Amount;
                            //  HMSPatCharges.Amount := HMSPatCharges.Amount - Amount;
                            HMSPatCharges."Weiver Code" := Rec.No;
                            HMSPatCharges.Weived := true;
                            HMSPatCharges.modify();
                            Rec.Posted := true;
                            Rec.modify();
                        end;
                    END;
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
